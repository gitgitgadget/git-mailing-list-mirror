From: Andy Parkins <andyparkins@gmail.com>
Subject: Strange cogito behaviour
Date: Tue, 1 Aug 2006 10:53:24 +0100
Message-ID: <200608011053.25112.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2275377.A1xPqiS5kR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 01 11:53:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7qwO-0004sY-R6
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 11:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWHAJx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 05:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWHAJx3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 05:53:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37239 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932594AbWHAJx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 05:53:28 -0400
Received: by nf-out-0910.google.com with SMTP id o25so216180nfa
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 02:53:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=BNCTQTy8R7aCGvXFaG5k93fsplxvStF2//3zW3p/IuUcYv/cP1eVrMTRWZ+bhyi51TWXApXI/xftAHsDstBrQw8Eq5zfMTILZVCFRxRiYz0UiDcMzdaqfFakiz6pKMS/5ugsX0Dh0YmQwpTqEcYuOsZq/EBAbtrHxJsGJzEE2NQ=
Received: by 10.49.91.6 with SMTP id t6mr415467nfl;
        Tue, 01 Aug 2006 02:53:27 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.gmail.com with ESMTP id z73sm721287nfb.2006.08.01.02.53.26;
        Tue, 01 Aug 2006 02:53:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24589>

--nextPart2275377.A1xPqiS5kR
Content-Type: multipart/mixed;
  boundary="Boundary-01=_VSyzErtvOi8flhX"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_VSyzErtvOi8flhX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Hope this is the correct list for this report.

Attached is a script that demonstrates (I think) strange cogito behaviour. =
=20
Run it in a temporary directory.

It does the following:
 * Create a repository, repo1, add a file to it
 * Create a branch inside repo1 and change the file in it
 * Switches repo1 to master branch
 * Clones repo1 to repo2
 * Switches repo1 to alternate branch
 * Updates repo2

The odd behaviour is that repo2 changes in the update to show the branch=20
contents in the working copy.  The only actions that has happened in repo1 =
is=20
a switch of the working directory to a different branch.  It could easily b=
e=20
that I've misunderstood what switch is doing, but the same operations using=
=20
git seem to work as I'd expect (script available if required).

The script then continues with
 * Switch repo1 back to master branch
 * Update repo2

This time repo2 doesn't change.  So I'm more confused :-)

In case you don't want to run the script, sample output follows:
=2D-------------------------------------------------------------
=2D-- Make a project
=2D-- Turn it into a repository, repo1
defaulting to local storage area
Adding file file
Committing initial tree ef18611ce9f2693e47a1b2df5e76613f53a9173c
Committed as f59933a07af5f12618deae8d33335621184ccc7c
=2D-- Create a branch and change it's content
Creating new branch branch: f59933a07af5f12618deae8d33335621184ccc7c
Switching to branch branch...
M file
Committed as 88bc51f62dfa3d71fbc0140fdd48aa150215a632
=2D-- Switch repo1 back to master
Switching to branch master...
=2D-- Clone repo1 to repo2: repo2 is now the repo1#master
defaulting to local storage area
Using hard links
=46etching head...
`/home/andyp/src/git-test/repo1/.git/HEAD' ->=20
`.git/refs/heads/./.origin-fetching'
`/home/andyp/src/git-test/repo1/.git/refs/heads/master' ->=20
`.git/refs/heads/./.origin-fetching'
=46etching objects...
progress: 3 objects, 239 bytes
=46etching tags...
New branch: f59933a07af5f12618deae8d33335621184ccc7c
Cloned to repo2/ (origin /home/andyp/src/git-test/repo1 available as=20
branch "origin")
=2D-- file now contains master contents
initial contents goes in master branch
=2D-- Switch repo1 to branch again
Switching to branch branch...
=2D-- Update repo2
Using hard links
=46etching head...
`/home/andyp/src/git-test/repo1/.git/HEAD' ->=20
`.git/refs/heads/./.origin-fetching'
`/home/andyp/src/git-test/repo1/.git/refs/heads/branch' ->=20
`.git/refs/heads/./.origin-fetching'
=46etching objects...
progress: 3 objects, 290 bytes
=46etching tags...
Tree change:=20
f59933a07af5f12618deae8d33335621184ccc7c:88bc51f62dfa3d71fbc0140fdd48aa1502=
15a632

Applying changes...
=46ast-forwarding f59933a07af5f12618deae8d33335621184ccc7c ->=20
88bc51f62dfa3d71fbc0140fdd48aa150215a632
        on top of f59933a07af5f12618deae8d33335621184ccc7c ...
=2D-- Show contents of both repositories
repo1/file:initial contents goes in master branch
repo1/file:added in branch - not in master
repo2/file:initial contents goes in master branch
repo2/file:added in branch - not in master
=2D--
Why has repo2 changed? repo1 had its working copy switched
repo2 shouldn't care about what's in the local copy of repo1.
What exactly is repo2#master tracking?  It's certainly not
repo1#master.
=2D-- Switching repo1 back to master
Switching to branch master...
=2D-- Updating repo2 again
Using hard links
=46etching head...
`/home/andyp/src/git-test/repo1/.git/HEAD' ->=20
`.git/refs/heads/./.origin-fetching'
`/home/andyp/src/git-test/repo1/.git/refs/heads/master' ->=20
`.git/refs/heads/./.origin-fetching'
=46etching objects...

=46etching tags...
Tree change:=20
88bc51f62dfa3d71fbc0140fdd48aa150215a632:f59933a07af5f12618deae8d3333562118=
4ccc7c

Applying changes...
Branch already fully merged.
=2D-- Show contents of both repositories
repo1/file:initial contents goes in master branch
repo2/file:initial contents goes in master branch
repo2/file:added in branch - not in master
=2D--
Even more strange, switching repo1 back to "master" and
updating repo2, hasn't changed repo2.  The first test showed that
repo2 is not tracking #master; but this test shows that repo2
is not tracking repo1 HEAD either.  What is repo2 tracking?
(it seems that it's repo1#branch)
=2D-------------------------------------------------------------


Andy
=2D-=20
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

--Boundary-01=_VSyzErtvOi8flhX
Content-Type: application/x-shellscript;
  name="weird-cogito.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="weird-cogito.sh"

#!/bin/sh

echo "--- Make a project"
mkdir repo1
echo "initial contents goes in master branch" > repo1/file
echo "--- Turn it into a repository, repo1"
cd repo1
cg init -m "Initial commit"
echo "--- Create a branch and change it's content"
cg switch -r HEAD branch
echo "added in branch - not in master" >> file
cg commit -m "altered branch"
echo "--- Switch repo1 back to master"
cg switch master

echo "--- Clone repo1 to repo2: repo2 is now the repo1#master"
cd ..
cg clone repo1 repo2
echo "--- file now contains master contents"
grep "" repo2/file

echo "--- Switch repo1 to branch again"
cd repo1
cg switch branch

echo "--- Update repo2"
cd ../repo2
cg update

echo "--- Show contents of both repositories"
cd ..
grep "" repo{1,2}/file
echo "---"
echo "Why has repo2 changed? repo1 had its working copy switched"
echo "repo2 shouldn't care about what's in the local copy of repo1."
echo "What exactly is repo2#master tracking?  It's certainly not"
echo "repo1#master."

echo "--- Switching repo1 back to master"
cd repo1
cg switch master
echo "--- Updating repo2 again"
cd ../repo2
cg update
echo "--- Show contents of both repositories"
cd ..
grep "" repo{1,2}/file

echo "---"
echo "Even more strange, switching repo1 back to \"master\" and"
echo "updating repo2, hasn't changed repo2.  The first test showed that"
echo "repo2 is not tracking #master; but this test shows that repo2"
echo "is not tracking repo1 HEAD either.  What is repo2 tracking?"
echo "(it seems that it's repo1#branch)"
rm -rf repo{1,2}

--Boundary-01=_VSyzErtvOi8flhX--

--nextPart2275377.A1xPqiS5kR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEzySVwQJ9gE9xL20RApXJAKCYba7HQFv402bCUbqtulLtljbZegCfdA3K
8R/p90+zNEJRxmnzvntNd7w=
=03Tn
-----END PGP SIGNATURE-----

--nextPart2275377.A1xPqiS5kR--
