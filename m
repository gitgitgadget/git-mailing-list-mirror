From: Thomas Schwinge <thomas@schwinge.name>
Subject: Removing alternates -- but how?
Date: Tue, 13 Apr 2010 14:57:04 +0200
Message-ID: <20100413125704.GA29552@dirichlet.schwinge.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 15:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1fp7-00038T-K2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 15:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab0DMNFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 09:05:22 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:55585 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab0DMNFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 09:05:13 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2010 09:05:13 EDT
Received: from [79.210.73.32] (helo=stokes.schwinge.homeip.net)
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@schwinge.name>)
	id 1O1fgM-00036D-3G
	for git@vger.kernel.org; Tue, 13 Apr 2010 14:57:34 +0200
Received: (qmail 17763 invoked from network); 13 Apr 2010 12:57:05 -0000
Received: from dirichlet.schwinge.homeip.net (192.168.111.252)
  by stokes.schwinge.homeip.net with QMQP; 13 Apr 2010 12:57:05 -0000
Received: (nullmailer pid 29603 invoked by uid 1000);
	Tue, 13 Apr 2010 12:57:04 -0000
Content-Disposition: inline
X-Homepage: http://www.thomas.schwinge.homeip.net/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Df-Sender: thomas@schwinge.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144816>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

According to ``information on the web'', it should be fine to do ``git
repack -a && rm .git/objects/info/alternates'', however that doesn't work
for me:

    $ cat .git/objects/info/alternates
    ../../../glibc/.git/objects
    ../../../../O/work.new/.git/objects
    $ git repack -a
    Counting objects: 18670, done.
    Compressing objects: 100% (7655/7655), done.
    Writing objects: 100% (18670/18670), done.
    Total 18670 (delta 10218), reused 18670 (delta 10218)
    $ mv .git/objects/info/alternates{,.DEFUNCT}
    $ git branch
    error: refs/remotes/grubber/master does not point to a valid object!
    error: refs/remotes/sourceware/cvs/fedora-2_3-branch does not point to a valid object!
    error: refs/remotes/sourceware/cvs/fedora-2_5-branch does not point to a valid object!
    [...]
    error: refs/tags/cvs/sparc-980522-merge does not point to a valid object!
    error: refs/tags/cvs/start does not point to a valid object!
    error: refs/tags/master-2008-11-27 does not point to a valid object!
    error: refs/tags/master-2009-02-10 does not point to a valid object!
    error: refs/tags/master-2009-07-10 does not point to a valid object!
    error: refs/top-bases/t/IOCTL_decode_argument does not point to a valid object!
    error: refs/top-bases/t/IOCTL_types does not point to a valid object!
    error: refs/top-bases/t/____longjmp_chk_cleanup_linux_x86_64 does not point to a valid object!
    error: refs/top-bases/t/bits_posix_opt.h__POSIX_THREADS does not point to a valid object!
    error: refs/top-bases/t/bits_pthreadtypes.h does not point to a valid object!
      baseline
      posix/regex_internal.c/MAX_undefined
      t/IOCTL_decode_argument
      t/IOCTL_types
      t/____longjmp_chk
      t/____longjmp_chk_cleanup_linux_x86_64
      t/__rtld_lock_recursive_t
    [...]
      t/verify.h
    * tschwinge/Roger_Whittaker

What am I doing wrong?


Regards,
 Thomas

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvEahsACgkQC9ZuxbdEiFhWFgCghQnyMl4xrVk7mfmaMmNtD23O
nj4AniE6jAwTbXKoZ7nTBuDTKeTwGj4E
=UXWu
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
