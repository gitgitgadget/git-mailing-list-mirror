From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 14:04:10 +0000
Message-ID: <AANLkTi=otZ-mxoaPJ3Mg9EFb5+jy1A=DS3w73weB5EJ=@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
	<AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
	<AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
	<20100829204519.GB1890@burratino>
	<AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
	<20100830134136.GA2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4yD-0000em-9e
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab0H3OEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:04:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0H3OEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:04:12 -0400
Received: by fxm13 with SMTP id 13so3216208fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+noqoA8zkZsZpwl2HGj6p4tUn2Dfh+VBvO1ahEUDLD8=;
        b=Tr1dBqivs/Dyff+OyEqVYDTzaoLezG9UQ8cEtw/kHtm0ZTWhx280qVUFVrr42Y2eW2
         Sab0PJwJLwbU1zQNFwiBY0Rs6o3YT5RkorrCFhNxh9DGZEwDOjBYyLojEzHaAfM49V0L
         FQbfo70PJnUROvPCyPbkpb9W45JwmYkBGQDSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lH98K7Cc2w/V6ffQUPSJHoDFYS5MeuWa224DtIzWjn4ipBhgZ88w6TufzorQZ+/jLB
         hsrGqCvVlbLJkmNCqR39BF1yhGrrUA5l8syquZBTuvtIlhonDFKFMYl1rK7WGw42GUKF
         KuTp9g88UTPE75bRcbnE8MrKGbj8f4guGGAQE=
Received: by 10.223.122.211 with SMTP id m19mr2536274far.72.1283177050627;
 Mon, 30 Aug 2010 07:04:10 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 07:04:10 -0700 (PDT)
In-Reply-To: <20100830134136.GA2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154806>

On Mon, Aug 30, 2010 at 13:41, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> We can even keep the "Content-Type: text/plain; charset=3DUTF-8\n" a=
nd
>> *not* use LC_CTYPE if we add a bind_textdomain_codeset("git", "UTF-8=
")
>> call to gettext.
>
> Oh! =C2=A0I'd personally prefer to do that for now. :) =C2=A0(Not bec=
ause of the
> known printf problem but because I like to reduce possible unknowns.)

By now I want to do that too. I've been experimenting with including
*printf*.c from OpenBSD, NetBSD or FreeBSD and the uClibc and in all
those cases it's a major PITA to wade through the OS-specific code
that deep in the libc.

Even if I could get that sorted it'll be non-trivial to audit all the
code whose semantics will change with LC_CTYPE, and there's a good
chance I'll miss something and cause an embarrasing bug in some
unrelated component.

Better to just document this limitation for now and decree that
gettext users must have a UTF-8 locale.
