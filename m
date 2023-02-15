Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A9C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 16:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBOQ07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBOQ05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 11:26:57 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0E43B0F2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676478410; i=tboegi@web.de;
        bh=aFHO78Nt2T/yipMdxOCoE+pwoaEKPC8ozPvT7PbnJao=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KXrw5Mt88sb5fzwp+E3b5TxwvyZq6I3w6JjcGkKFFLNlj5zwb5ZmRlOM5c4gJrQsg
         8H2SFtyYpAkZe10sXNxf6SXySjVOo5WMfwMuC0dKgVZADV2VcwMwR/R01vBbtKB4u6
         pZeYr/8tAn0gLkGMQcEj4jym2YagUZ9s5zyehZUi7gyqkilrOHsJ8JaavtnxUTJVni
         j3FzK8XHDDLRZhPX/rwi9Uh8AVGb1rTHE63hz1JfS5j3Z2uIUmaHld7q/xkVvbYKtz
         9DOAMhEPevKvFRH9C4Ja1LddEYrV5i7d2Re0fOQialtgWd48P7HkMe5fwMpHiPaLGe
         a9Z02kVg1tfaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1pV6Zf3gpm-007ApV; Wed, 15
 Feb 2023 17:26:49 +0100
Date:   Wed, 15 Feb 2023 17:26:49 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
Message-ID: <20230215162648.py7diaasrymezntl@tb-raspi4>
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:zPvRhfCWhfht9XSINawNWAVnREk+WT5XuclzciJyEg8ubdWSRIO
 ohkub1PWcX2qwrNwRRqTgCXTyR6oeRGLsb3zHjyd7EoyGUycwSxnmAwwwzBOgtiAUzXmyIJ
 wbeFsHl9b2xfwbWvD8ZfcSar38TOzFS8yRNbdGAxjJtSGLLtuNFJdyXa4aOvZiUfFH3698j
 VAiHLZmtQPa7uTvFHTYbQ==
UI-OutboundReport: notjunk:1;M01:P0:DHMYuJpfwGU=;i8Hz4X70IV9m+WrH049K6CaPeKo
 P52HQFPS+etvpX4HjualT/tOTEj39yQw5Jr6j4nyWSnbEyuKbkxWqh4oaqlpsjiK3ophWgrA+
 YhWUffkfUcW/gIj/yYWqK44BeuMt7mZHu0I1HlQaLFAudwyRfXeOazYReEIF+yLcSG+P/Lj8f
 /zp55Ven+Z31k3jULbBO2oV5j5vNs5l8sCMRegqfPdgMLvzl7BX5WE839zMmp8kTES8iJrkYC
 A5c0gMFsP65kWdvvVTMjypmJ8r+9CqQGgTEURJYLgUZdtUMMUthuL9kJsFt0TYnGNIQbuAWvE
 Bus9wmhUJ5thi8lEC4mHeRcggYZNfwD7mEwfnxRaZLrMNYqKI1+D6lTi1YTcz/pZn3qRoMQLr
 XZDGoMQqgms/5TeYouMjOPl57XJc0NWiaHCIsqZCOei0Sv166vOSuzT3CvCpcY6v8v9a9/dbu
 Qe56WhHGDozjbdUe86XC5BdqaaedsWLQkct/yEgKfKYkAraGJMYgUHSb595Q8gEWhw1JciaYX
 yv/aATUu+M2cYmzSq0YKGuMXinlT4PFY74XZFLZM1AsLZ0aPfroBr8njsTp9vjCwLut7Y6Cii
 SBO7CAdIMd/ho7tFmiuVUqygmOpx+VU4IaDiJh2tMTpYgJUPRG+Y6SZ9UrkRVWpjYg6CiZSh6
 ng7fK/JmZqC/HGw9KvQH0tIkhSLavDGbDT87LG7O3IxZJxXZlwp6a3AE1X6jh2weCwobmJJkc
 LDHOtpeDIhruSgkUiTSiucfYj5CeGWXzG7we2I7OI4RN4KZKpOL28WkNC8S+eMXA6vRpjf765
 XKaXAtvZUmNkcLexzrCErEshx0Qb/pJJCQhKNsDuI435Z6l8w/BfGN649jPR0QFHBuoPVpIXw
 wHkiIft2EFrlJYU0YjnpzysF9vgxXnvjLNw1tVo9NizZhDlYngJsItPFn1cMpBgyKJsnUMs+H
 tnuuVw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 03:18:28PM -0500, Jeff King wrote:
> On Mon, Feb 13, 2023 at 02:38:08PM +0800, =E5=AD=9F=E5=AD=90=E6=98=93 wr=
ote:
>
> > System: Mac Os (Ventura 13.2)
> > Language: Chinese simplified
> > Preconditions:
> > # git checkout -b =E6=B5=8B=E8=AF=95-=E5=8A=A0-=E5=A2=9E=E5=8A=A0-=E5=
=8A=A0-=E5=A2=9E=E5=8A=A0
> > # git symbolic-ref --short HEAD
> > Wrong Echo (Current Echo):
> > =E6=B5=8B=E8=AF=95-=EF=BF=BD
> > Correct Echo:
> > // I Don't know, may be "=E6=B5=8B=E8=AF=95-=E5=8A=A0" ?
>
> Hmm, I can't reproduce here on Linux:
>
>   $ git init
>   $ git commit --allow-empty -m foo
>   $ git checkout -b =E6=B5=8B=E8=AF=95-=E5=8A=A0-=E5=A2=9E=E5=8A=A0-=E5=
=8A=A0-=E5=A2=9E=E5=8A=A0
>   $ git symbolic-ref --short HEAD
>   =E6=B5=8B=E8=AF=95-=E5=8A=A0-=E5=A2=9E=E5=8A=A0-=E5=8A=A0-=E5=A2=9E=E5=
=8A=A0

Neither can I - MacOs pre-Ventura ;-)

>
> I wonder if it is related to using macOS. The refs are stored as
> individual files in the filesystem, and HFS+ will do some unicode
> normalization. So I get:
>
>   $ ls .git/refs/heads/ | xxd
>   00000000: 6d61 696e 0ae6 b58b e8af 952d e58a a02d  main.......-...-
>   00000010: e5a2 9ee5 8aa0 2de5 8aa0 2de5 a29e e58a  ......-...-.....
>   00000020: a00a
>
> Are your on-disk bytes different?

In my case there are the same.
Trying to convert from UTF-8 into UTF-8-MAC didn't change anything here.
Side note:
MacOs Ventura is probably not using HFS+, but apfs, which doesn't do
the unicode decomposition on file system level.

It would be helpful, to pipe the result into xxd:
git symbolic-ref --short HEAD | xxd
And then see, if there is any garbling inside or outside of Git ?

>
> My instinct was that this might be related to the shortening code
> treating the names as bytes, rather than characters. But looking at
> shorten_unambiguous_ref(), it is really operating at the level of path
> components, and should never split a partial string.
>
> Another possibility: the shortening is done by applying our usual
> ref-resolving rules one by one via scanf(). There's an assumption in the
> code that the resulting string can never be longer than the input:
>
> 	/* buffer for scanf result, at most refname must fit */
> 	short_name =3D xstrdup(refname);
>
> 	...
>         for (i =3D nr_rules - 1; i > 0 ; --i) {
> 		...
>                 if (1 !=3D sscanf(refname, scanf_fmts[i], short_name))
>                         continue;
>
> Is it possible that this assumption is violated based on some particular
> combination of unicode normalization and locale? That seems unlikely to
> me, but it wouldn't be the first time I've been surprised by subtle
> unicode implications.
>
> Is it possible for you to run Git in a debugger and check the
> intermediate steps happening in refs_shorten_unambiguous_ref()?
>
> -Peff
