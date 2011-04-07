From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Thu, 7 Apr 2011 20:23:21 +0700
Message-ID: <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com> <1302138996-10006-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 15:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7pBm-0006CI-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 15:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1DGNXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 09:23:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60193 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab1DGNXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 09:23:52 -0400
Received: by bwz15 with SMTP id 15so1994323bwz.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2o/DP56Ju/RTXrbzbKe269ewqi17NGi+jssagJDMrhY=;
        b=uf2GXmEZJe8T9cA7xF4XSo9ZOE0S/k46JHr84cXwv9X9hqZ2iAiUpUByboyn533Ta8
         JDTqkryAlLevPk6DLtY1D2W1jxm08twRjza4Lp14mPcSqMuBLbtzn3O6WGeEAYCntTEP
         +LGOPR0QuJih0GI1lz60ZW9RjuTBuscb2DvcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WaMuexaMQeQLGCSCMial/XlxGwaiC1HzY8j+43rD4zEs0//24yJHPo8eFn/FxwNJaJ
         3cnmwqJniV36F9zXUOtZtsMAdUnO5v7o+W5Q33DYuQYcU/IB5nUz8Z0whXS2gdhSOFGn
         elf5hqUkVSnD3uxtp35WsXLIchHnCImwUeQEM=
Received: by 10.204.16.209 with SMTP id p17mr192730bka.17.1302182631161; Thu,
 07 Apr 2011 06:23:51 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Thu, 7 Apr 2011 06:23:21 -0700 (PDT)
In-Reply-To: <1302138996-10006-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171058>

On Thu, Apr 7, 2011 at 8:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> +The "magic signature" consists of an ASCII symbol that is not
> +alphanumeric.

Except dot, as Michael pointed out in another email, so we can write
":/.foo" instead of ":/:.foo". I'm tempted to rule out wildcards as
well (star, backslash, question mark and square brackets)

Also the patch does not catch this (ie. not die() on unrecognized signature).
-- 
Duy
