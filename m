From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Folder level Acces in git
Date: Thu, 3 Nov 2011 08:17:01 +0100
Message-ID: <20111103071701.GA22412@jpl.local>
References: <1320300655224-6958047.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: redhat1981 <redhat1981@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 08:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLrrQ-00060m-KM
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 08:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab1KCHhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 03:37:12 -0400
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:60859 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1KCHhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 03:37:11 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Nov 2011 03:37:10 EDT
Received: from iph5.telenor.se (iph5.telenor.se [195.54.127.136])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 9FA89D128
	for <git@vger.kernel.org>; Thu,  3 Nov 2011 08:17:03 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ag8PAJ4/sk5T46eEPGdsb2JhbABEmX2OW4EeGQEBAQE3MoFyAQEEATIBIyMFCws0EhQNCwEMChoTiAICBrUOiD1hBJ5Rhys
X-IronPort-AV: E=Sophos;i="4.69,448,1315173600"; 
   d="scan'208";a="65042831"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by iph5.telenor.se with ESMTP; 03 Nov 2011 08:17:03 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 16A28423AE; Thu,  3 Nov 2011 08:17:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320300655224-6958047.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184708>

On Thursday, November 03, 2011 at 07:10 CET,
     redhat1981 <redhat1981@gmail.com> wrote:

> I am using Gitosis, Adding the gitosis conf file
>=20
> [group testabc]
> writable =3D testabc
> members =3D   shrii Abhijeet premkumar
> add cgit =3D yes
> gitweb =3D yes
>=20
>=20
> [group testabc-readonly]
> readonly =3D testabc
> members =3D  Ganesh Shweta
> add cgit =3D yes
> gitweb =3D yes
>=20
> Inside the repository, testabc let us say there are folders folder1,
> folder 2 etc, I want some users to have read/write, read or no access
> to the folder1 or folder2, Is this possible in Git, I have done it in
> SVN, Please help!!

Given Git's nature, you can't have read access restrictions on a sub-gi=
t
level (i.e. file/directory level). For basically the same reason, you
can never prevent users from making (local) commits that modify certain
paths (but you can encourage people to have local hooks to enforce such
policies). What you *can* do is install a server-side update hook that
rejects attempts to push commits that modify certain paths. If you're
willing to trade Gitosis for Gitolite, you get that feature for free.

http://book.git-scm.com/5_git_hooks.html
http://progit.org/book/ch4-8.html

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
