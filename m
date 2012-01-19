From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT
 defined
Date: Wed, 18 Jan 2012 18:15:48 -0600
Message-ID: <20120119001548.GA13926@burratino>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:16:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnffi-0005CK-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 01:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284Ab2ASAQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 19:16:01 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60018 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab2ASAQA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 19:16:00 -0500
Received: by ghbg16 with SMTP id g16so3301268ghb.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RYcFbHKT5oZSpeCLLVwWX6AW7g7b6wYrrNylgEyzrf4=;
        b=ZC77jetMpVsn22stwLR3FgpDiHubsZtCN6ZGgU78YA+jKOjGGyz9yMemn7LAiAJN25
         poXM1fHLrIwEObpi0Hrad/pm4a81vdpY04ZuWJNzBEbyUCBn3za9glaT3edUIeaxkccF
         OUTGv+ZbypAuqGDfIR4hiF2sHRxx3TA0FK2yo=
Received: by 10.236.156.67 with SMTP id l43mr6816163yhk.73.1326932159953;
        Wed, 18 Jan 2012 16:15:59 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i12sm5147182anm.6.2012.01.18.16.15.59
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 16:15:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188780>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> That's not what NO_GETTEXT means, and not what it *should* mean. It
> means that your output won't be translated, but we might still make
> use of a locally installed library to provide the gettext() and
> eval_gettext() functions.
>
> This approach has worked everywhere so far (Linux, OSX, *BSD etc.),
> and you want to change *everywhere* because you have some completely
> broken Cygwin install.

I thought NO_GETTEXT meant either "I'm aware that there is this new
translation feature, and it may or may not be useful to me some day,
but no thanks for now, since I cannot tolerate the possibility of
regressions" (i.e., opting out of a new feature) or "my platform does
not have suitable gettext infrastructure so please do not use it"
(i.e., reducing build-time dependencies by making some optional).

"I don't want localized messages" is spelled as "LC_MESSAGES=3DC; expor=
t
LC_MESSAGES", not as "make NO_GETTEXT=3DYesPlease".

I guess I am wondering, does the approach in Alex's patch have the
potential to cause actual problems?  If it doesn't, I don't see what
there is to complain about.

Hope that helps,
Jonathan
