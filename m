From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git-archive and core.eol
Date: Mon, 10 Jan 2011 14:00:51 +0100
Message-ID: <AANLkTi=WyzVzPkhOAMC2A8Dd=Zj_P-7YMVP-GaUz0-Qm@mail.gmail.com>
References: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com>
 <4D28683B.4020400@lsrfire.ath.cx> <AANLkTi==eqwrwq-P6czDvOH5GDEi6WgvRUuZ2dMoiK7e@mail.gmail.com>
 <4D29AF80.5060008@lsrfire.ath.cx> <AANLkTinxVCQuTMeKHQ9mLbs=94fck90rwJwa1DhzGPmX@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, eyvind.bernhardsen@gmail.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 10 14:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcHN8-0007me-KG
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 14:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab1AJNBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 08:01:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61801 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1AJNBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 08:01:13 -0500
Received: by fxm20 with SMTP id 20so18806147fxm.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=+/Dvjd11c4AhzEsggE3AIRQPXXnydRL+iQnB7LzF9H0=;
        b=Vz0VcHEn3b64c3YpgaMPyfUXR4aMhCU1i6Xb3cumZboeYjWxRcm8oyuvFK3K0LOpuU
         ZGrucJySqBTG4FfJxdXVA3zN5odZb7t5xg6peI5iNsEu58u6v2n7CdPHgLI/cRwfWVwn
         oashx83Dz6EV8JymBpJwbrUNHrwD5/0UhVVrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=uVMbNru1KLfyA4R1ZNSVY/NajWrTRMSHWww8CXbZZE9OTPMgQ3LyXEVJc6XGmrbmLW
         Sp5jMPaKCS5p4VemigL2JOyyu+N9ayK0fpkfWYjFgOSOqklDKZqVCgjmzgv8jQ2vb/6q
         B3e9mfU3awECAyzzFgAE30Zn46JAXUB/XgnE4=
Received: by 10.223.79.7 with SMTP id n7mr5620564fak.71.1294664471686; Mon, 10
 Jan 2011 05:01:11 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Mon, 10 Jan 2011 05:00:51 -0800 (PST)
In-Reply-To: <AANLkTinxVCQuTMeKHQ9mLbs=94fck90rwJwa1DhzGPmX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164875>

On Mon, Jan 10, 2011 at 1:11 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> test. So now I've got to figure out what is different between your
> test and mine. Perhaps I misdiagnosed to begin with?
>

No, it doesn't quite seem like I misdiagnosed, but your test had
different expectations than I have after reading the documentation. I
expected core.autocrlf=true + core.eol=lf to pretty much be identical
to core.autocrlf=false, but only because LF->LF conversion is a NOP.

'core.autocrlf' is documented as meaning the same as setting the
'text' attribute to 'auto' for all files, plus "files that contain
CRLF in the repository will not be touched". I figured that last part
shouldn't affect me as I only had LFs in the repository.

If I disable core.autocrlf, I get what I want (no matter what I set
core.eol to, it seems). But I still don't understand WHY
core.autocrlf=true + core.eol=lf outputs CRLF.

It seems to me that there's a big gap between what the documentation
claims and what actually happens here.
