From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Sat, 6 Feb 2016 20:41:48 -0800
Message-ID: <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 05:42:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSHB2-0002kr-3e
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 05:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbcBGEmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 23:42:09 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35561 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbcBGEmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 23:42:08 -0500
Received: by mail-ig0-f169.google.com with SMTP id hb3so37732837igb.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 20:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H+j+e3q06Nm49UyfAxKbn0d7bSbsE2dRudRGOQcSL98=;
        b=iRfpvQ477w1KsVCppHSig+ZfGjVT4RnLIIuAdbtQu7JRf/sihik4U94r2pl7ty+6jX
         VPX/nIF7YebIBQ6AywkKR42huXNa4+/jOph5kSsdbgqfH5sbC8fXy2alZIJERI8SdcZT
         nKuhVZohDWtC0tUOOVizzeiMOAeYWJlxfBoExF0wLQ0WREAZqcFxShRgoxgzEZ1DZzPg
         Lennq3awfF2cmY0JkWarDxj8YUr73b01FM6fy1ZjYVHN2BfR3lg58IVqaGgHp5M0n7Uj
         tYzKTTavNQe72/lqMSMBCM0ZGF8QMhDSjCV4M+QDODkCtd4KeTdQmyMj4LRdM4ysyipt
         eDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=H+j+e3q06Nm49UyfAxKbn0d7bSbsE2dRudRGOQcSL98=;
        b=TUsjQLc3krzbh8wk+FpZeWGCWvszWyMlPUZTXzmYeJmm+kO/ttyuG4ojT95aKJs3Ra
         vkDSjE4P8nBcQHaZrB8pdAtw7BbJU/gFpfH0r6caygNWYuYpbsV7QCFqZmmR/H1tv9Am
         E76WWRXU+R2E/iqonYXTKKKdLbX2Tfa4cr2BS50JHfjIsAvarT+hEkJxkSVdH5wPcNBN
         X5oU6xIcFjXYPdY/Nf/CQs+EuZB/1pF7eVnXnBcDbPPuNj1uy7CtQZZPupJGvcDFvkhz
         5/ZXXzJclI2ebiXLTyjzL69We+RNNQN03UXBk5TSB9QOrXyAxXhq3nJN2AtpXp9Ra6+4
         qaqA==
X-Gm-Message-State: AG10YOR77WG3tW+6znidTA3X+nukOl2dG7ZAxjPZ6tM59ErUHCEsVKMm5ifnuMoS/frxI+IKkKsQJJ1UUrnd8A==
X-Received: by 10.50.64.178 with SMTP id p18mr23765341igs.35.1454820127498;
 Sat, 06 Feb 2016 20:42:07 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Sat, 6 Feb 2016 20:41:48 -0800 (PST)
In-Reply-To: <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285710>

On Wed, Feb 3, 2016 at 3:44 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Ok so I am not sure we even really need to use "-c" option in
> git-clone considering that we can just use the same flow we do for
> setting core.worktree values. I'll propose a patch with you two Cc'ed,
> which I think fixes the issue. There may actually be a set of
> configuration we want to include though, and the main issue I see is
> that it won't get updated correctly whenever the parent configuration
> changes.
>
> Thanks,
> Jake

I tried adding the config as part of module_clone in
submodule--helper.c but it didn't pass the test I added. I haven't had
time to look at this in the last few days, but I am stuck as to why
submodule--helper.c appeared to not use module_clone as I thought.

Regards,
Jake
