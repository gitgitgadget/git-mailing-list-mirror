From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: gitosis asking for password
Date: Wed, 1 Jun 2011 01:42:37 +1000
Message-ID: <20110531154218.GA4483@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 17:42:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRR5k-0000Mb-AG
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 17:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab1EaPmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 11:42:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39929 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab1EaPmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 11:42:43 -0400
Received: by pwi15 with SMTP id 15so2107264pwi.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=BU1Gjfm+jx6tIm9HwiKlbf8uhOIL2IFFwSJNIAKnP60=;
        b=lki4tyRlLZNz86qcYVuUIDyQKowptuH4UzxjUGiokVD1czh1nUO8OYtns7J5nQZbzs
         0vW/ndvf+qKKKCGZ3kGTgDNVMS44dS6nF09UB97dN+67/EsUq1qKjgbohYeRsCVWgav0
         I+nwk8jjjzzxHgty4NAnQzf7EPkwd1I/aYluQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=bh4xbARC5UpcmqAx/Q9vLIl0BduuSrNFayN/U30srxKKA3ViI9CXTZqOtAVNvcJzri
         RoQk8uw0BcOIq6EzmQzxuLnV+jHLZZeKQmUJ1NRigJXvSko150KpIAxIMeQ19nnhUYPW
         pnC02PE9aZ6JIjl7SBcMtXgSHqZlAnr5GgHHQ=
Received: by 10.142.120.40 with SMTP id s40mr960521wfc.193.1306856562684;
        Tue, 31 May 2011 08:42:42 -0700 (PDT)
Received: from overlord.imperial.fleet (27-32-25-138.static.tpgi.com.au [27.32.25.138])
        by mx.google.com with ESMTPS id w2sm124359pbg.69.2011.05.31.08.42.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 08:42:41 -0700 (PDT)
Received: from tim by overlord.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-ssd-overlord>)
	id 1QRR5Z-0004JQ-Os
	for git@vger.kernel.org; Wed, 01 Jun 2011 01:42:37 +1000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174806>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi List,

I've been trying to sort this out for a couple of days now, but have
gotten absolutely nowhere.

For some reason, a few days ago, gitosis just stopped liking me, and I
was unable to push or fetch from my gitosis server, getting the error
message 'fatal: x does not appear to be a git repo'.

So, I decided to remove gitosis and start again.  Following this [1]
guide, this is what I did/got:

$ sudo adduser --system --shell /bin/sh --gecos 'git version control' --gro=
up --disabled-password --home /home/gitosis gitosis
Adding system user `gitosis' (UID 119) ...
Adding new group `gitosis' (GID 128) ...
Adding new user `gitosis' (UID 119) with group `gitosis' ...
Creating home directory `/home/gitosis' ...

$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/tim/.ssh/id_rsa):=20
Created directory '/home/tim/.ssh'.
Enter passphrase (empty for no passphrase):=20
Enter same passphrase again:=20
Your identification has been saved in /home/tim/.ssh/id_rsa.
Your public key has been saved in /home/tim/.ssh/id_rsa.pub.
The key fingerprint is:
bb:04:a6:f0:68:e8:4f:89:0b:60:6e:35:5b:29:50:58 tim@overlord.imperial.fleet

$ sudo -H -u gitosis gitosis-init < /home/tim/.ssh/id_rsa.pub=20
Initialized empty Git repository in
/home/gitosis/repositories/gitosis-admin.git/
Reinitialized existing Git repository in
/home/gitosis/repositories/gitosis-admin.git/

$ git clone gitosis@overlord.imperial.fleet:gitosis-admin
Cloning into gitosis-admin...
gitosis@localhost's password:=20

But of course, it shouldn't be asking me for a password, and nothing I
type will work anyway, as it's a disabled password.

I've tried it a few times, completely purging the gitosis user and its
home directory, but with the same results.  Has anybody had similar
experiences?  Or does somebody know some magic trick to get gitosis
working?  Did I miss a step?


Tim


[1] http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-sec=
ure-way

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN5QxoAAoJEGNoa2q+dzQWnjIQAJx3xK0IfuzOm54JckENhR8s
36+i82QZ6I4Cq2uAUdbxJzvWScexHxtQ79DqdUxDIiwg8iSLdBiYZoB1xELc/9sP
bkwiU/CVE13745mdz5WChYz6IqEL621MB7Fg4pR8yXJvr2QRGv4Ux+BswuYfDPOC
qM33a7jTPtfUQNWW5pjgPayxVC7jtEkcqmkuCNMor63dLvxUUulqLOVjILSwyHuK
MCd/Q1GDcvGhz5D1LlyUgsz5kFPueo3TUZrW2iMGhetq7xl/2ufV5K35UfEbbBfZ
aWMeciB5EWnUkNCASqnmRbg4bA2tv9HZGUgfHYZGJhcOiT/YiZLkV2WfDVmLi4Nt
RrQtOcbiCQdxE8JR7xZ0zfLESO6Ip4PEhEsA7h+XonGhmPHo10zrRiqXhkbyG9DR
6NAUOKfbzDvJTiNU9NJLT/geAOqwzJ/M8pYZT/YDa1qBH4CySvPFfNq8JNotdCeD
nRNTLl/WIILK5ml06ft+1Ue9tSW7keMmYPenMsLjQ8H0SlFJsnAiGEUkM+mo4Icm
FWAAyUoJf50HbztkGW/C/dbwhf8djiUtLoPFLE5jx+nnlqeWvDyKWvhzhLvIfVQ0
ff9CaxgldsVCvbHgjt907BxyLc46Vr8oy7vsh8hbbXy31N+VpsLvBQD9T+NR3DYd
yqmBDvuh/+fB1nB+lCNZ
=Wb7U
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
