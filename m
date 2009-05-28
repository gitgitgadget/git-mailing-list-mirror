From: Deskin Miller <deskinm@umich.edu>
Subject: Re: git-svn clone problem
Date: Wed, 27 May 2009 19:11:01 -0700
Message-ID: <86d4c5e00905271911g58cccc1bwd4b881541db6f7a5@mail.gmail.com>
References: <20090527221601.GA12914@mail.oracle.com>
Reply-To: deskinm@umich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Thu May 28 04:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9V5n-0008QJ-2r
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 04:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZE1CLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 22:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026AbZE1CLB
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 22:11:01 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:9119 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbZE1CLA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 22:11:00 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2861890ywb.1
        for <git@vger.kernel.org>; Wed, 27 May 2009 19:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=AhSpz5VZ/sleBFkOGZJmTIy1tfwwZrcwO+0xNKBDvlE=;
        b=iaXT7vwrKWkDMqy/66/A/GMrWApvJOakoacAXQtc9hciWxwEYtOTzub2gqYDekIEka
         0vcG0ng1dfo5cxG2XjfCF/mjhy9FjKWZ6VeZd7Y9EoGrmEAMf8yFGymsch2YhAVn1vbb
         3EkMd9dvT7YG3sfA5DINv/LKfGmfY6yI3Udqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Q8w3klsPcckJpcNaY77RhmH3U4YaKOVWWBBAHrSBN9TllcP5sbpprUEUdSrd7DGyV6
         Q5xjOV6rAwyQcgj//Tmdz3Ygmr5HpUfyjBIW1QuQ+aWz1GS0eMnr4BJMaGPjs5QF00RS
         CtoSqlR74iNK36rM5lb6SiJVsIhxbDAayQ8VQ=
Received: by 10.151.143.6 with SMTP id v6mr1573288ybn.80.1243476661538; Wed, 
	27 May 2009 19:11:01 -0700 (PDT)
In-Reply-To: <20090527221601.GA12914@mail.oracle.com>
X-Google-Sender-Auth: 3e796beb205a42d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120133>

On Wed, May 27, 2009 at 15:16, Joel Becker <Joel.Becker@oracle.com> wro=
te:
> Hello everyone,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I've got a fun git-svn bug I can't seem to=
 track down. =C2=A0The
> google is no help. =C2=A0I'm just trying to clone a full repo. =C2=A0=
I'm not
> looking to push changes back, and I've done this before, yet now (1.6=
=2E3
> and 1.6.3.1) it's not working.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The clone command and error is:
>
> $ git svn clone --stdlayout --no-metadata -Aauthors =C2=A0http://oss.=
oracle.com/projects/oracleasm/src/ driver-git
> Initialized empty Git repository in
> /build/jlbec/oracleasm/driver-git/.git/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 kernel/osm.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 Configure
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 include/osmprivate.=
h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 include/arch-i386/o=
smstructures.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 include/osmlib.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 include/osmerror.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 libosm/osmlib.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 Makefile
> r1 =3D d855bc271ef7dcf70a58ae35fde5dc49f28d3e8e (trunk)
> missing UUID at the end of .git/svn/trunk/.rev_db.????????-????-????-=
????-???????????? at /usr/lib/git-core/git-svn line 4488
>
> You can drop the --no-metadata if you like - it doesn't help. =C2=A0C=
learly
> it's tripping on the first revision. =C2=A0I'm not sure what UUID it'=
s
> looking for. =C2=A0The manpage speaks of UUIDs in regards to svk/svns=
ync, and
> I'm not using those.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I suspect the last time I did this was in =
the 1.5 range (my
> distribution has obviously moved on). =C2=A0But I would think this wa=
s tested
> :-)
>
> Joel
>
> --
>
> "Behind every successful man there's a lot of unsuccessful years."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Bob Brown
>
> Joel Becker
> Principal Software Developer
> Oracle
> E-mail: joel.becker@oracle.com
> Phone: (650) 506-8127

The problem here isn't with git-svn; rather, it is with the svn
repository at oss.oracle.com claiming a nonsensical UUID.  svn uses
UUIDs behind the scenes to identify each repository, and git-svn does
the same thing.  When doing git svn init (or clone, which is just init
&& fetch) the svn server sends back a UUID which identifies it.  When
I use wireshark and expand the first HTTP packet back from a good svn
server, I see something like the following embedded in the xml tree:

<lp3:repository-uuid>
612f8ebc-c883-4be0-9ee0-a4e9ef946e3a
</lp3:repository-uuid>

However when I do the same with oss.oracle.com I see

<lp2:repository-uuid>
????????-????-????-????-????????????
</lp2:repository-uuid>

git-svn tries to play along for a while, but the bottom line is that a
string of question marks isn't a UUID.

There's more about svn's use of UUIDs in the svn book.  Perhaps the
admin of oss.oracle.com can correct this UUID problem so one can use
git-svn with this repository.

Deskin Miller
