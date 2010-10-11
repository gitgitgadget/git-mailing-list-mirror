From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 10:39:58 +0200
Message-ID: <201010111039.59779.jnareb@gmail.com>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net> <AANLkTikGSj-x4hk7NFysWETuR80=REZ81Qy8Zu3Pks-L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 10:40:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Dvr-0004U6-0V
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 10:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab0JKIkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 04:40:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57953 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab0JKIkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 04:40:15 -0400
Received: by fxm4 with SMTP id 4so309512fxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ccAmeFiwMy/Ppr9n2nGyFTkvk7Tb6qfYtkc2YHRDwkQ=;
        b=NKUggO0eiy0V0xlGmmJ2oHx42TEy/TnnZq++VvloySL8BzKKTvzoUAy9hCVYUxX+af
         Wu9ExPRXnOCsRd8BQ83Df4zz1tLvhf7XypZuiaZD/XYsFc+2mOMp3YUiP2vFMvZrq1Y8
         Ip+bSefd6ImdnwPJVm3wftpKkexdfN/NTCBvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=E3pMikGKqgi9UP70iKrUYp5HdQxtX+1LyElILSyHikLmIn7asfpelVPGHakHdZJdDM
         tEHi4YCMBaCQNqF0YEuQd5PeI45COJgCHn2f7gpqLgWfOdYwApXFTCutEb9+v8QfVDkJ
         j4BcxTFVmRQzvAAPjtRNcwKij2STCbSClE0O4=
Received: by 10.223.123.212 with SMTP id q20mr1683193far.28.1286786414214;
        Mon, 11 Oct 2010 01:40:14 -0700 (PDT)
Received: from [192.168.1.13] (abvy23.neoplus.adsl.tpnet.pl [83.8.222.23])
        by mx.google.com with ESMTPS id a16sm2565558fak.19.2010.10.11.01.40.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 01:40:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikGSj-x4hk7NFysWETuR80=REZ81Qy8Zu3Pks-L@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158754>

On Mon, 11 Oct 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Oct 11, 2010 at 07:47, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>=20
> (CC-ing Jakub Narebski, who maintains configure.ac)

I wouldn't say that I maintain it.  I was one of people who started it,
and I try to keep it from being too bitrotten, by asking to provide
configure test when adding new configure knob to main Makefile.

I am certainly not an expert on autoconf.

> I don't like it. For one this would break build scripts that use `mak=
e
> configure && ./configure && ...`. It's also annoying to have to set
> some variable to *really* invoke a target that I just indicated I
> *really* wanted by invoking it in the first place.
>=20
> Perhaps a @echo from the configure script itself indicating that it's
> complimentary would be better.
>=20
> > For most software packages, untar-autoconf/make configure-configure=
-make
> > is the preferred way to build the package; not so for Git. But the
> > presence of the make target makes people believe so.
>=20
> Unlike in most packages autoconf is strictly complimentary for Git,
> but it usually gives you much better results. Instead of the Makefile
> guessing based on `uname -s` we actually check for features and set
> the config.mak.autogen variables accordingly.

That's why we have it, to be able to check for features, rather than
guess based on operating system and its version.
=20
> So it's less likely to break on odd systems, and given that (as you
> point out) mostly everyone has autoconf already recommending it as th=
e
> default would make more sense than the other way around.

But thanks to having ./configure optional step, we can build git also
on platforms that doesn't have autoconf installed (though the same coul=
d
be achieved by bundling ./configure script with release tarballs).

> > =C2=A0 =C2=A0On an annecdotical note: When I decided to switch to a=
 dvcs, I failed building
> > =C2=A0 =C2=A0Git (with configure) and tried out hg instead. Imagine=
!
>=20
> What sort of failure? Has it been fixed since then?


--=20
Jakub Narebski
Poland
