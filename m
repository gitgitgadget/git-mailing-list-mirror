From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone',
 but not a single file present
Date: Mon, 11 Jun 2012 23:46:08 +0100
Message-ID: <4FD67530.1090002@diamand.org>
References: <4FD5C263.9010307@nokia.com> <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com> <4FD6440C.7090900@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Ilya Dogolazky <ilya.dogolazky@nokia.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeDNk-0004iX-F5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab2FKWqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 18:46:40 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63426 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2FKWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:46:40 -0400
Received: by wibhm6 with SMTP id hm6so3827512wib.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 15:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=gPx0+1LsExPmUrn9Iyr8Z4JTMw0ZJHq0C2f6W6gf3P0=;
        b=KgRgyW3DEmqXsbXtubwL4XJtFUE7g9CaBDGnSsuJ4QDc62QghMFy3TxplcepZFlMaS
         XQBDVV6+vboAkojITu5IJqNm3VRALG3DctH9lQEB8kJn1hZBKwPKknMtnTubooRFjXxm
         Z2P+cEg+B7PAHWn7vvGOL1vMdSJr8ovXvetA2FnhxPwe7xfpf/fCu7W4W31ZgSM8fa4T
         01PBoZZcf7Q1HAh/+HGUo+S2/GTa7k76w/9QwZHrWlBp8yPA/m/oHgVNONhtTqkrr8DE
         mABOvxHHFiHiqL3OewiFFuTLIqcT4jNs9IGUP4lsrsEfpO9nlv96kvbCW4qzCLU3HAbG
         2jwg==
Received: by 10.180.78.233 with SMTP id e9mr24219909wix.5.1339454798846;
        Mon, 11 Jun 2012 15:46:38 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id k8sm2315494wia.6.2012.06.11.15.46.38
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 15:46:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <4FD6440C.7090900@nokia.com>
X-Gm-Message-State: ALoCoQm3n8cIQTrY9wqRtDYnqPQ1sEnoM1OjROnVqRyBh5hLOCsyQBNpIti03DNDkjzQHdZAKSm2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199750>

On 11/06/12 20:16, Ilya Dogolazky wrote:
> Hi Luke!
>=20
> 06/11/2012 06:28 PM, ext Luke Diamand =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
>> If you do something like "p4 describe 17473" what does that show?
> First I see a line containing the change number, my colleague's name =
and=20
> date, then the commit title (identical to one printed by "git log"),=20
> then a list of files [every line begins with "... //xxx/yyy/"], then =
the=20
> word "Differences" and then something looking very much like output o=
f=20
> 'diff' command (the actual commit differences).
>=20
>> Are the files changed all contained with //kalma/xxx/yyy?
> Yes, they are.
>=20
>> It could be that there's a p4 version problem going on - which versi=
on
>> of p4 are you
>> using?
> The output of 'p4 -V' contains "Rev. P4/LINUX26X86/2012.1/459601=20
> (2012/05/11)". That's probably the version of my command line client.
>=20
> The output of "p4 info" contains "P4D/LINUX26X86_64/2011.1/428451=20
> (2012/03/08)" --- that's probably the version of the server.
>=20
> The version of git installation (by debian package) is 1:1.7.10-1 (as=
=20
> reported by "dpkg -l git"). The package contains the file=20
> "/usr/share/doc/git/contrib/fast-import/git-p4" which I copied to=20
> $HOME/bin/git-p4 in order to have in $PATH and with executable bit.=20
> Could it be, that I did something wrong here by making this manually?

That version of git-p4 seems different to the one in the repo. I think =
it's just a bit older.

>=20
>  > And which platform are you using?
> Debian GNU/Linux.
>=20
> I hope I provided all the needed information, of not please ask for m=
ore.

Can you try an experiment please. Try running the following commands. W=
hen I run them I get out a file that looks correct.

#!/bin/sh
export P4PORT=3Dlocalhost:1234
mkdir db cli
(cd db && p4d &)
sleep 2
(cd cli && EDITOR=3D: p4 client && date >foo.c && p4 add foo.c && p4 su=
bmit -d 'x')
git-p4 clone //depot@all

I've been trying out Debian's 1.7.10.1 and it seems fine, other than ha=
ving a slightly old version of git-p4 and it not being installed proper=
ly.


>=20
> Cheers,
>=20
> Ilya
