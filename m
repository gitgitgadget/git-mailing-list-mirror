From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/9] icase match on non-ascii
Date: Thu, 9 Jul 2015 06:28:40 +0700
Message-ID: <CACsJy8CMm-iHAeV9OUCY7B_F=gikDg9QqftG29aqM0W_q3yF7Q@mail.gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com> <CAPc5daWG7=tBm_G+G6Qkmd7bd=5Dd-8bimj1p+KW_FSTOFfRaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 01:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCymC-0004X7-0x
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 01:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbbGHX3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 19:29:12 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35239 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbbGHX3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 19:29:11 -0400
Received: by igcqs7 with SMTP id qs7so68012678igc.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6yryMSodSGde4gMER5ePSqQssERgMSa2T88jJLdQbqY=;
        b=o8TiN61dNSt8uov7bki41fpE95Yt7a2VvsznAjbLaENBDfGRv1S4s9grQVaNHFWL4W
         HnGY7HfJFDjoBAxrVlGsziovegOnf8oO4d1UmhDIxLFPt2BzbiVbWkaPyr2SPfAIXeC8
         BuOC0eEmz1l6uSHiUYEjuQV5ydN9LCqLmSiDw7nQLPDURTDW4+7aESs7smagyD+DyWUi
         5NadKEwUi75wI771AUuzq33xIAlJ3vDYzjS9omDknK8aznrJlOl+jDpb6tFQq4H6zGr9
         4apbARe/mdhnVE/N/+o2m+rMfyV0YiOjlyks3IGnkacUdRfv/Rdh5llQFhHYATIRGRee
         y2kw==
X-Received: by 10.107.128.72 with SMTP id b69mr20743701iod.84.1436398150127;
 Wed, 08 Jul 2015 16:29:10 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 8 Jul 2015 16:28:40 -0700 (PDT)
In-Reply-To: <CAPc5daWG7=tBm_G+G6Qkmd7bd=5Dd-8bimj1p+KW_FSTOFfRaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273718>

On Wed, Jul 8, 2015 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Patch 5 is "funny". The patch itself is in iso-8859-1, but my name in
>> the commit message is in utf-8.
>
> As an e-mail message is a single file, by definition that is not merely
> "funny" but just "broken", no matter what encoding your MUA
> declares the contents are in, no?

Yes. But if your MUA is not so strict and does not reject invalid byte
sequences, git-am might be able to process it. What are the options we
have? Teach git-format-patch to generate patches with non-ascii chars
as binary (utf-8 may be treated specially and kept as-is after
validation)?
-- 
Duy
