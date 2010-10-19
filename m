From: Tyson Whitehead <twhitehead@gmail.com>
Subject: revision range required for git-svn problem with 1.7.3.1
Date: Tue, 19 Oct 2010 17:05:33 -0400
Message-ID: <201010191705.51978.twhitehead@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6505109.O507E8BoAU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 23:06:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8JNh-0005TB-Ox
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 23:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab0JSVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 17:05:56 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53550 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0JSVFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 17:05:55 -0400
Received: by qyk9 with SMTP id 9so828098qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=3a5qAXolcFIfuw5I7M9s+S8/Zpc5YvEELHD8unNlsVI=;
        b=lA4pMJnKc577LK6mZrWM4PFmrYYrUlAPmmzBg6+XOVj9ALfiTLYcv3B6t4WkOHgZ/G
         PrFYP0pgdEVTw+88QOqbAlPohQWcp+NbQhLn3WaAg0n/2ExYN1Q7i7p0EFxjas6VQ2Nj
         wix8LNkwfa871Dik00kv+d5zTCLHVHz6WAXhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=yGohsWcndelihpOT2B7CX2x+IR7zNeNkCK491vmKb2UofdVRe//4eSmEA9YAw/fg7Y
         zjjdqR2mDvA0h6MTiz1rp6TyvO55dHXAgbnyZUfIqlxUSgyEhTBadXEvvIvK9kvmSmSr
         SRKnxqBho5cjMQZxDaTWNFuahlw4A0atJY8aM=
Received: by 10.229.91.77 with SMTP id l13mr5588440qcm.282.1287522354663;
        Tue, 19 Oct 2010 14:05:54 -0700 (PDT)
Received: from whitehead2.localnet (whitehead.beowulf.uwo.ca [129.100.171.100])
        by mx.google.com with ESMTPS id nb14sm15134091qcb.0.2010.10.19.14.05.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 14:05:53 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-5-amd64; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159365>

--nextPart6505109.O507E8BoAU
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I asked about this on the IRC channel the other day and was advised to subm=
it=20
a bug report to the mailing list.  My problem is this with our internal repo

$ svn co svn+ssh://svn@devel.sharcnet.ca/data/svn/sharcware

works as you would expect

$ git svn clone svn+ssh://svn@devel.sharcnet.ca/data/svn/sharcware
Initialized empty Git repository in .git/

checks out nothing.  However, if I do

$ svn log svn+ssh://svn@devel.sharcnet.ca/data/svn/sharcware -r HEAD
=2D-----------------------------------------------------------------------
r1576 | network | 2010-10-19 13:39:29 -0400 (Tue, 19 Oct 2010) | 1 line

Automated network config update.
=2D-----------------------------------------------------------------------

$ git svn clone svn+ssh://svn@devel.sharcnet.ca/data/svn/sharcware -r 1:r15=
76
=2E..<whole bunch of cloning output removed>...

then I get everything as I should.  I would then think this should also work

$ git svn clone svn+ssh://svn@devel.sharcnet.ca/data/svn/sharcware -r 1:HEAD
Initialized empty Git repository in .git/

but it does not.

Thanks!  -Tyson

PS:  The repo is not organized according to the standard format at all.  It=
 is=20
just a single trunk rooted at /data/svn/sharcware.


--nextPart6505109.O507E8BoAU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAky+CB4ACgkQp7ZNUfdma/9tuQCdGBeQAtDLDK+wJtmsbEU3KYag
SdwAniZSco/nliVOKDdU20jDbtDBravo
=WuR1
-----END PGP SIGNATURE-----

--nextPart6505109.O507E8BoAU--
