From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 39/45] parse_pathspec: make sure the prefix part is wildcard-free
Date: Wed, 20 Mar 2013 17:54:41 +0700
Message-ID: <CACsJy8C_vDZPh9C2zFxnS+rz+YJdAPhk6F9wvt+=ge3j=t9txw@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-40-git-send-email-pclouds@gmail.com> <7vli9ji6gu.fsf@alter.siamese.dyndns.org>
 <CACsJy8DjrB45kDRiOs9b=VS5Z5=_sdh37Z3Q20sT6iDacLmM+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 11:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIGgK-0007QN-T9
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 11:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab3CTKzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 06:55:13 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58677 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab3CTKzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 06:55:12 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so1461712obb.9
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GY42V3yoEkfIN0TtkWG1/LJvSoClNJ17NsWckJbnPdQ=;
        b=cC3X7kPrhzdtF8D2Pp7K4RoRp3RW3vz2t2h2mu5AmsQbvR9RpRA0VjMtb0hInafIHM
         5T6qUbz9/qoA+oacPzkWgYYFiGHJshjD6Mk/kC8qByeRTjWAdHsjuChpuVwzavqhDD++
         4vSAQZCukG2bSXwWsBdw1B/39V0W9TiHwL9LO8ISdU6brfTKyaZztAqdV3iRbUB4JHyg
         itgWD+82TaphvI8AKuGjgSCvc4bHrRIsYkn3UxC94620Rfj5CoSBRoYRx/pjtrkdjy4k
         0nkjiTr/SkdNXdK6Fo3YmSizlpXtKpvgR8fqWUVAD0cGX+gbWFriXz4Um88jQmPeh2mM
         NN5A==
X-Received: by 10.182.235.49 with SMTP id uj17mr3709068obc.18.1363776911866;
 Wed, 20 Mar 2013 03:55:11 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Wed, 20 Mar 2013 03:54:41 -0700 (PDT)
In-Reply-To: <CACsJy8DjrB45kDRiOs9b=VS5Z5=_sdh37Z3Q20sT6iDacLmM+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218584>

On Wed, Mar 20, 2013 at 8:32 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 20, 2013 at 1:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> This seems to break t7300-clean.sh #8
>
> Repeatedly? I saw some t7300-clean.sh failures when running tests in
> parallel, but never been able to reproduce it alone.

Never mind. There is a codepath that does not initialize the new field
"prefix" properly. Fixing it now..
-- 
Duy
