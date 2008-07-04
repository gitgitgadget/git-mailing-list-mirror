From: "Michael P. Soulier" <msoulier@digitaltorque.ca>
Subject: dumb protocol problems
Date: Fri, 4 Jul 2008 15:00:07 -0400
Message-ID: <20080704190007.GU28001@tigger.digitaltorque.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2uzDqHpccQJpqF2n"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 21:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEqX0-0007Dl-Mr
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 21:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYGDTAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbYGDTAU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 15:00:20 -0400
Received: from mail.storm.ca ([209.87.239.66]:64437 "EHLO mail.storm.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbYGDTAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 15:00:19 -0400
Received: from kanga.digitaltorque.ca (hs-216-106-102-70.storm.ca [216.106.102.70])
	by mail.storm.ca (8.14.2+Sun/8.14.2) with ESMTP id m64J0D4M008608
	for <git@vger.kernel.org>; Fri, 4 Jul 2008 15:00:18 -0400 (EDT)
Received: from tigger.digitaltorque.ca (tigger.digitaltorque.ca [192.168.1.3])
	by kanga.digitaltorque.ca (Postfix) with ESMTP id 330076
	for <git@vger.kernel.org>; Fri,  4 Jul 2008 15:03:51 -0400 (EDT)
Received: by tigger.digitaltorque.ca (Postfix, from userid 500)
	id A8A8023F8A; Fri,  4 Jul 2008 15:00:07 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87409>


--2uzDqHpccQJpqF2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm in a situation where sharing via http is my simplest method, although I
will migrate to use git-daemon in the near future.=20

I'm on CentOS 4.6, Apache works fine, the bare repository is viewable and
there's a info/refs file like there should be.=20

msoulier@espresso:~/temp$ cat /var/www/git/cqr.git/info/refs
0a27e2807d8d3c32aa8912d01c939bd1cdd0df68        refs/heads/master

But cloning fails.=20

git clone http://espresso.nssg.mitel.com/gitdir/cqr.git
Initialize cqr/.git
Initialized empty Git repository in /usr/home/msoulier/temp/cqr/.git/
Getting alternates list for http://espresso.nssg.mitel.com/gitdir/cqr.git
Getting pack list for http://espresso.nssg.mitel.com/gitdir/cqr.git
Getting index for pack d22362ff6cdd729015f787a7eae057e079fcee39
Getting pack d22362ff6cdd729015f787a7eae057e079fcee39
 which contains 0a27e2807d8d3c32aa8912d01c939bd1cdd0df68
error: packfile
/usr/home/msoulier/temp/cqr/.git/objects/pack/pack-d22362ff6cdd729015f787a7=
eae057e079fcee39.pack
size changed
fatal: packfile
/usr/home/msoulier/temp/cqr/.git/objects/pack/pack-d22362ff6cdd729015f787a7=
eae057e079fcee39.pack
cannot be accessed

This is not on NFS, it's an LVM filesystem on a local disk.=20

msoulier@espresso:~/temp$ df -h .
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00
                       36G   22G   13G  64% /

I'm not sure what the issue could be.=20

git --version
git version 1.5.6.rc0

I'll start by picking up the latest.=20

Thanks,
Mike
--=20
Michael P. Soulier <msoulier@digitaltorque.ca>
"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction." --Albert Einstein

--2uzDqHpccQJpqF2n
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFIbnM3KGqCc1vIvggRAvLaAJ0UcvjgAFHw1lkD7qnpZ75nc+bztgCeJkzJ
2LFLHWGlHBp4P2HWucdreS4=
=/Oli
-----END PGP SIGNATURE-----

--2uzDqHpccQJpqF2n--
