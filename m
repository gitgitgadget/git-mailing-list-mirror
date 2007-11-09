From: "Yossi Leybovich" <sleybo@mellanox.co.il>
Subject: RE: corrupt object on git-gc
Date: Fri, 9 Nov 2007 14:23:11 +0200
Message-ID: <6C2C79E72C305246B504CBA17B5500C9029A36F2@mtlexch01.mtl.com>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com> <458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com> <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com> <20071109081035.GA2794@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 13:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqStY-0005dy-4T
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 13:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbXKIMXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 07:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbXKIMXR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 07:23:17 -0500
Received: from mail.mellanox.co.il ([194.90.237.44]:42890 "EHLO mellanox.co.il"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752088AbXKIMXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 07:23:16 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sleybo@mellanox.co.il)
	with SMTP; 9 Nov 2007 14:23:14 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20071109081035.GA2794@steel.home>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: corrupt object on git-gc
Thread-Index: AcgiqAXKtN4fN90MRcqyH/1Y6I9BqgAIvXrQ
x-pineapp-mail-mail-from: sleybo@mellanox.co.il
x-pineapp-mail-rcpt-to: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64171>

Hi

 I know its loose but still I think there are references in the
repository to this object.
How I can remove it from the repository ?


sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
$ mv .git/objects/4b ..

sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
$ git-fsck --full
broken link from    tree ca8022a21a064d075d71a342744e584024fd2782
              to    blob 4b920d658a05a66a9d18dd34b51d6e3a9f229ce1
broken link from  commit 2ca27acf05f1631586718b68ce43f0a0400e1f9b
              to  commit 4b1aabfe3ecc12007535369a2ba17bcee776df64
dangling commit 0d43a63623237385e432572bf61171713dcd8e98
dangling tree b303c073c5d6c30de761a5ecce39ab30da81e98a
dangling tree f3c333f9756e824e6b51e585d734e410790e7dc5
dangling tree 10a4688d94ab6b1fb1bb3aee7e77255a0e41ae94
broken link from    tree eea47bf0788a38ac0988de26eddafa8d60caaa58
              to    blob 4b920d658a05a66a9d18dd34b51d6e3a9f229ce1
broken link from  commit 06858a6c8d5a6b1ffbc203057d023c48567dd83e
              to    tree 4b89da873ce6e1b36a818d70d4665b3074f2354c
dangling commit 4fc6b1127e4a7f4ff5b65a2dd8a90779b5aff3e0
dangling commit 7da607374fe2b1ae09228d2035dd608c73dad7c8
missing tree 4b89da873ce6e1b36a818d70d4665b3074f2354c
broken link from    tree 380b2b78d10136cc2b6e1578f4906fccb3e432b1
              to    blob 4b920d658a05a66a9d18dd34b51d6e3a9f229ce1>
-----Original Message-----



Thanks
Yossi 




> From: Alex Riesen [mailto:raa.lkml@gmail.com]
> Sent: Friday, November 09, 2007 3:11 AM
> To: Yossi Leybovich
> Cc: git@vger.kernel.org
> Subject: Re: corrupt object on git-gc
> 
> Yossi Leybovich, Fri, Nov 09, 2007 00:59:47 +0100:
> > I wonder if someone can help in this error
> > I tried to do git-gc and got error on corrupted object.
> >
> > I do the following:
> >
> > $ git-gc
> > Generating pack...
> > Done counting 3037 objects.
> > Deltifying 3037 objects...
> > error: corrupt loose object
> '4b9458b3786228369c63936db65827de3cc06200'
> 
> It is loose. Nothing uses it in this repository. What do you need to
> repair it for?
> 
> > fatal: object 4b9458b3786228369c63936db65827de3cc06200 cannot be
read
> > error: failed to run repack
> >
> > sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
> > $ cd .git/objects/4b/
> >
> > sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib/.git/objects/4b
> > $ git-fsck-objects.exe 9458b3786228369c63936db65827de3cc06200
> > error: corrupt loose object
> '4b9458b3786228369c63936db65827de3cc06200'
> > error: 4b9458b3786228369c63936db65827de3cc06200: object corrupt or
> > missing
> > error: invalid parameter: expected sha1, got
> > '9458b3786228369c63936db65827de3cc06200'
> > missing blob 4b9458b3786228369c63936db65827de3cc06200
> 
> the directories directly under .git/objects contain the first bytes of
> sha1, to use filesystem in a more efficient way. git-fsck expects an
> sha1 (or a reference).
> 
> Try running moving the corrupt object (with its *whole* name) some
> place else and run git-fsck --all.
