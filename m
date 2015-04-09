From: Perry Rajnovic <perry.rajnovic@gmail.com>
Subject: Re: git-completion.tcsh
Date: Thu, 9 Apr 2015 14:41:13 +1000
Message-ID: <481BCBD7-457B-4AFB-B878-1417C8C5940C@gmail.com>
References: <20150401115519.Horde.JM0TEyhacRn5LYAEffMggQ1@webmail.informatik.kit.edu>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marc Khouzam <marc.khouzam@gmail.com>
To: =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 06:41:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg4HO-0004cE-6E
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 06:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbbDIElV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2015 00:41:21 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33993 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbDIElU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 00:41:20 -0400
Received: by pdbqa5 with SMTP id qa5so82221247pdb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T24P+VaJQYKO9NIcq2cGTjWHH0VvPMRyGKVUTTRNtn0=;
        b=CeulAag5h1ch2cTtKhlEM+zT32LL431kL37t2a8EBbkfZPuflkzqrYBr5A0/Zuj5FF
         /2oaXBtcfRh2xg3MamjySDz9Qe0rKFZb7ecFalN2D8/TyEDwWtpFeTa86/2agSYkzw7U
         u5YtOI2KjixzR+zW6GRTNBTA9QOxbUDwv9JWwqdquPsNI+rOmO3MdZ7QHtcE+JM3C7sY
         FGkVwTmiwybjdDgCOtI6tFt1GFFXP2jXOYEBpD18a69qiJsfjonP2RZitbi9rETkq+iM
         PDYn8r+TpLT1qGAtm8q9sMAqFNWCg38yrnfY+CSZSiykct0fsEfwz1+2afnaYgnfSpFV
         WtEw==
X-Received: by 10.70.50.199 with SMTP id e7mr22044658pdo.124.1428554480177;
        Wed, 08 Apr 2015 21:41:20 -0700 (PDT)
Received: from nomad.bigpond (27-33-165-186.static.tpgi.com.au. [27.33.165.186])
        by mx.google.com with ESMTPSA id zt9sm13090705pac.9.2015.04.08.21.41.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Apr 2015 21:41:19 -0700 (PDT)
In-Reply-To: <20150401115519.Horde.JM0TEyhacRn5LYAEffMggQ1@webmail.informatik.kit.edu>
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266985>

G=C3=A1bor,

I updated git to include the macports install with bash completion.  un=
der bash it does not exhibit the problem as I described it. To be sure =
that the completion scripts installed via macports weren=E2=80=99t newe=
r/different (the .bash completion file had a few minor diffs from what =
I had been using), i reinstalled the tcsh completion using those files,=
 but the same behavior happened.

So i=E2=80=99m seeing what you=E2=80=99re seeing, bash completion works=
 fine, it=E2=80=99s likely to be something in the wrapper handling.

(updated) environment
Darwin 14.3.0 Darwin Kernel Version 14.3.0: Mon Mar 23 11:59:05 PDT 201=
5; root:xnu-2782.20.48~5/RELEASE_X86_64 x86_64 (OS X 10.10.3)
Apple Terminal Version 2.5.3 (343.7)
git 2.3.4 (+bash_completion, via MacPorts)
tcsh 6.17.00 (Astron) 2009-07-10 (x86_64-apple-darwin) options wide,nls=
,dl,al,kan,sm,rh,color,filec
GNU bash, version 4.3.33(1)-release (x86_64-apple-darwin14.0.0)

Thanks!

Perry

> On Apr 1, 2015, at 20:55, SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote=
:
>=20
>=20
> Quoting Perry Rajnovic <perry.rajnovic@gmail.com>:
>=20
>> When using the auto-completion included with git for tcsh, several
>> commands do directly completion with an additional space appended to
>> the end, which defeats the ability to complete to a deeper
>> sub-directory.
>>=20
>> For example, if I have a git repository including the following:
>> basedir/foo/bar/somefile.c
>>=20
>> (works as expected, git add)
>> $ cd basedir
>> $ git add f<tab>
>> $ git add foo/
>> $ git add foo/b<tab>
>> $ git add foo/bar/
>> $ git add foo/bar/s<tab>
>> $ git add foo/bar/somefile.c
>>=20
>> (works not as expected, git rm)
>> $ cd basedir
>> $ git rm f<tab>
>> $ git rm foo
>> $ git rm foo<backspace>/b<tab>
>> $ git rm foo/bar
>> there=E2=80=99s a trailing space after foo and bar in the above line=
s, which
>> means it=E2=80=99s not possible to initiate completion or immediatel=
y start
>> typing, i must back-space before continuing.
>>=20
>> I=E2=80=99m fairly certain i=E2=80=99ve seen this for other commands=
 as  well, but
>> i=E2=80=99m not sure to what extent this occurs throughout the comma=
nds.
>>=20
>> Environment info:
>> OS: Darwin 14.1.0 Darwin Kernel Version 14.1.0: Thu Feb 26 19:26:47
>> PST  2015; root:xnu-2782.10.73~1/RELEASE_X86_64 x86_64 (OSX 10.10.2)
>> Apple Terminal Version 2.5.1 (343.6)
>> git version 2.3.2 (via MacPorts)
>> tcsh 6.17.00 (Astron) 2009-07-10 (x86_64-apple-darwin) options
>> wide,nls,dl,al,kan,sm,rh,color,filec
>=20
> The tcsh completion script is just a wrapper, it relies on the bash
> completion script to do the heavy lifting and tunnels its output int
> tcsh's completion infrastructure.
> Could you try bash completion in your environment first to see,
> whether it's a bash completion issue that I can't reproduce or an
> issue with the tcsh wrapper?
>=20
> Cc'ing Marc, author of the tcsh wrapper.
>=20
>=20
> G=C3=A1bor
