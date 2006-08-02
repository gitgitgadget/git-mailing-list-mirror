From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: kompare won't parse git diffs
Date: Wed, 2 Aug 2006 19:18:58 +0100
Message-ID: <200608021919.02511.andyparkins@gmail.com>
References: <200608021107.43485.andyparkins@gmail.com> <Pine.LNX.4.64.0608021006150.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2327781.0XGk3nTCoT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 02 20:21:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8LLL-0003hC-GK
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 20:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWHBSVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWHBSVR
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 14:21:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:5010 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932127AbWHBSVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 14:21:16 -0400
Received: by ug-out-1314.google.com with SMTP id m3so393441ugc
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 11:21:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=uJIDUg5osuoyN5hwy/QwHFDxn2dbT+rAI9G0JufJqj97SLMmQQe50DGFJoHCJh2HJ6SxoUs8QWAHKbUk63gbmds/Ge/Vxe8dfJq2DvfU9eGFe+MJlrqH5+VoCJ7R/2g3N/KabSAJNuBjAlHcMuIOpCWa0KaGPsSB7uZAj8twR2Y=
Received: by 10.66.216.6 with SMTP id o6mr1484474ugg;
        Wed, 02 Aug 2006 11:21:15 -0700 (PDT)
Received: from ?192.168.182.2? ( [84.201.153.164])
        by mx.gmail.com with ESMTP id q40sm8101054ugc.2006.08.02.11.21.13;
        Wed, 02 Aug 2006 11:21:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0608021006150.4168@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24664>

--nextPart2327781.0XGk3nTCoT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2006, August 02 18:19, Linus Torvalds wrote:

> I'd definitely call this a pure kompare bug.

Me too, but it seemed such a small thing change to git that I thought I'd=20
mention it.

> Not only is the git patch format perfectly standard and accepted by other
> tools, it's much better designed than the brain-damaged syntax that GNU
> patch uses (which adds a tab and a timestamp after the filenames). In
> particular, with git patches it is easy to get filenames that have spaces
> and tabs in them right.

The only three things I checked were diff, git and subversion.  git is the=
=20
only one of the three that didn't include anything after the filenames. =20
Subversion uses the space to write (working copy) and (revision XXX), so it=
's=20
clear that these fields are simply being treated as commentary.  That only=
=20
adds weight to the argument that it is a kompare bug, as surely <nil> is a=
=20
perfectly acceptable comment?

> Now, if the kompare people can show that every single other patch
> generator adds the stupid tab + date format, I guess we could do it too,
> but

As it seems to be acceptable to put something other than a date, perhaps th=
e=20
hash of the object being compared would be more useful than the unavailable=
=20
date?

>  (b) I'm pretty sure that the kompare people only ever actually tested
>      with GNU patch or other very modern patches, because when I did the

I'm sure that that is true.  I certainly don't think that there is a fight=
=20
here, I've not seen any feedback on the kompare bug yet, but I'd be very=20
surprised if the response is "git is stupid - WONTFIX".

> I'm hoping that people will some day just wake up and notice that the git
> extended patches are really worth doing even for other projects. I was

I think in the cases I've been testing, the extended format hasn't shown it=
s=20
face.  I used git-svnimport to duplicate an svn repository then copied the=
=20
same changes into both an svn working directory and a git working directory=
=2E =20
I then ran "git diff" and "svn diff", and diffed the two outputs.  Apart fr=
om=20
some differences in how many lines where added and deleted (and the=20
difference that started this thread of course) the two diffs were equivalen=
t.


Andy

=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart2327781.0XGk3nTCoT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE0OyWwQJ9gE9xL20RAhLlAKCvdrUOi/NC96cTh7z5Ae2MA0N3kQCfbat1
B7/CYU4qhinqhIcC8PDgfPE=
=zfaJ
-----END PGP SIGNATURE-----

--nextPart2327781.0XGk3nTCoT--
