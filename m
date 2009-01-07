From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Tue, 06 Jan 2009 23:41:39 -0800
Organization: Slide, Inc.
Message-ID: <1231314099.8870.415.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5ykSoqtUHfInAULGSH88"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKT4K-0008PS-Pt
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 08:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbZAGHlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 02:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbZAGHlt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 02:41:49 -0500
Received: from mx0.slide.com ([208.76.68.7]:33572 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbZAGHls (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 02:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=m
	+HT3X9wfxvhnCCeoctjnqL8n6L4B5KOLMSgmnEWSDQ=; b=eFwrn757F4v2ZG4ir
	AukU/tbPq/iLkxbc1ITLsn7hN8uvRHFNHBIWQe+iApuYMZzXz9NrkShjf2eUQKtG
	Ru+Fo4tXPq6NFXfrXrQ/DVYbHkad0AT0eHs1qmmBD6rDIgl8fVcwCO2L8dy/r5G4
	+/rMyI1J9d4uAyDJBUkg2OvIJ0=
Received: from nat3.slide.com ([208.76.69.126]:43787 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKT2q-0005En-4v; Tue, 06 Jan 2009 23:41:40 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 20F37A6F0002;
	Tue,  6 Jan 2009 23:41:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -1.878
X-Spam-Level: 
X-Spam-Status: No, score=-1.878 tagged_above=-10 required=6.6
	tests=[AWL=-0.775, BAYES_00=-2.599, MIME_QP_LONG_LINE=1.396,
	RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOCn5UtK3vRW; Tue,  6 Jan 2009 23:41:39 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 8486DA6F0001;
	Tue,  6 Jan 2009 23:41:39 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104769>


--=-5ykSoqtUHfInAULGSH88
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-06 at 20:54 -0800, Linus Torvalds wrote:
>=20
> On Tue, 6 Jan 2009, R. Tyler Ballance wrote:
> >=20
> > I'll back the patch out and redeploy, it's worth mentioning that a
> > coworker of mine just got the issue as well (on 1.6.1). He was able to
> > `git pull` and the error went away, but I doubt that it "magically fixe=
d
> > itself"
>=20
> Quite frankly, that behaviour sounds like a disk _cache_ corruption issue=
.=20
> The fact that some corruption "comes and goes" and sometimes magically=20
> heals itself sounds very much like some disk cache problem, and then that=
=20
> particular part of the cache gets replaced and then when re-populated it=20
> is magically correct.
>=20
> We had that in one case with a Linux NFS client, where a rename across=20
> directories caused problems.
>=20
> This was a networked filesystem on OS X, right? File caching is much more=
=20
> "interesting" in networked filesystems than it is in normal private=20
> on-disk ones.

Not quite, what I meant was that some users (not all) who've experienced
this issue are using Samba to copy files over directly into the Git
repository. I was mentioning this in case somewhere between Finder,
Samba, ext3 and Git, some file system change events were pissing Git off
and causing it. I don't think this is the case as the coworker that I
mentioned earlier doesn't use Samba and neither do I (we both experience
the issue today, mine disappeared by upgrading to 1.6.1, his by `git
pull`).


>=20
> > I've tarred one of the repositories that had it in a reproducible state
> > so I can create a build and extract the tar and run against that to
> > verify any patches anybody might have, but unfortunately at 7GB of
> > company code and assets, I can't exactly share ;)
>=20
> The thing to do is
>=20
>  - untar it on some trusted machine with a local disk and a known-good=20
>    filesystem.
>=20
>    IOW, not that networked samba share.
>=20
>  - verify that it really does happen on that machine, with that untarred=20
>    image. Because maybe it doesn't.=20

Unfortunately it doesn't, what I did notice was this when I did a `git
status` in the directory right after untarring:
        tyler@grapefruit:~/jburgess_main> git status
        #
        # ---impressive amount of file names fly by---
        # ----snip---
        #
        # Untracked files:
        #   (use "git add <file>..." to include in what will be
        committed)
        #
        #       artwork/
        #       bt/
        #       flash/
        tyler@grapefruit:~/jburgess_main>

Basically, somehow Git thinks that *every* file in the repository is
deleted at this point. I went ahead and performed a `git reset --hard`
to see if the issue would manifest itself thereafter, but it did not.

I did try to do a git-fsck(1), and this is what I got:
        tyler@grapefruit:~/jburgess_main> /usr/local/bin/git fsck --full
        [1]    19381 segmentation fault  /usr/local/bin/git fsck --full
        tyler@grapefruit:~/jburgess_main>=20
>=20
>    The hope is that you caught the corruption in the cache, and it=20
>    actually got written out to the tar-file. But if it _is_ a disk cache=20
>    (well, network cache) issue, maybe the IO required to tar everything u=
p=20
>    was enough to flush it, and the tar-file actually _works_ because it=20
>    got repopulated correctly.

When I was working through this with Jan, one of the things that we did
was move the actual object file in .git/objects, they existed so maybe I
could look into those to check?

>=20
>    So that's why you should double-check that it really ends up being=20
>    corrupt after being untarred again.
>=20
>  - go back and test the original git repo on the network share, preferabl=
y=20
>    on another client. See if the error has gone away.

Unfortunately the repository is being used by the original developer I
tarred from with our 1.6.1 build, he hasn't reported any issues, but I
can't exactly steal it back (that's why I made the tar)

> The fact that you seem to get a _lot_ of these errors really does make
> it=20
> sound like something in your environment. It's actually really hard to ge=
t=20
> git to corrupt anything. Especially objects that got packed. They've been=
=20
> quiescent for a long time, they got repacked in a very simple way, they=20
> are totally read-only.

I checked with our operations team, and contrary to my suspicion (your
NFS comment piqued my curiosity), these disks that are actually on the
machines are not NFS mounts but rather local disk arrays.
       =20
        --> is it NFSd? or all local storage
        <=3D=3D all local
        <=3D=3D df -h
        <=3D=3D mount
        <=3D=3D /dev/sda5             705G  247G  423G  37% /nail
        --> hm, there goes that theory
        <=3D=3D git corruption?
        --> yeah, looking into it
        <=3D=3D sucks
        --> Linus had a theory about NFS/etc corruption of the disk
        cache
        <=3D=3D when the company folds we can all blame you...  and your
        silly git games
        <=3D=3D (think positive, joel)
        --> thanks=20
       =20
;)


Any thing else I can do to help debug this? :-/

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-5ykSoqtUHfInAULGSH88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklkXLMACgkQFCbH3D9R4W+ZVwCaAu3kMprxcHw9AA1r5eRX0hID
LskAoJX8Z2Jfii1d3vfYY0Z7SG56yeib
=MmAj
-----END PGP SIGNATURE-----

--=-5ykSoqtUHfInAULGSH88--
