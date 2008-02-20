From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: cant get git to work over http
Date: Wed, 20 Feb 2008 10:39:19 +0000
Message-ID: <D5916873-1703-41A2-BDE8-97B3D9038194@manchester.ac.uk>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com> <20080219063937.GB3819@glandium.org> <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com> <alpine.LSU.1.00.0802191115440.30505@racer.site> <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com> <47BB1EC0.601@freescale.com> <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com> <alpine.LSU.1.00.0802191916020.7797@racer.site> <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com> <alpine.LSU.1.00.0802191940260.7826@racer.site> <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jon Loeliger" <jdl@freescale.com>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 11:40:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRmNJ-0005eb-Uj
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 11:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbYBTKjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 05:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYBTKjY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 05:39:24 -0500
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:49861 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbYBTKjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 05:39:22 -0500
Received: from gerhayn.mcc.ac.uk ([10.2.18.1])
	by tranquility.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JRmM9-0008tV-Pm; Wed, 20 Feb 2008 10:39:17 +0000
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:50865)
	by gerhayn.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JRmM9-000GJc-MZ; Wed, 20 Feb 2008 10:39:17 +0000
In-Reply-To: <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:50865
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74507>

> i can do this:
>
> $ git-clone /var/www/localhost/htdocs/git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/ 
> repo/.git/
> 1 block
>
> and i can do this:
>
> $ git-clone ssh://aeyakovenko@localhost/var/www/localhost/htdocs/ 
> git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/repo/ 
> repo/.git/
> aeyakovenko@localhost's password:
> Receiving objects: 100% (3/3), done.
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
>
> but for the life of me i cant do this:
>
> $ git-clone http://aeyakovenko@localhost/var/www/localhost/htdocs/ 
> git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/ 
> repo/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

What is the document root set to on your web server? It shouldn't be  
'/'! When doing git over ssh you need the whole path, but when over  
http you just need the path from the document root...

So I would expect that your http clone should be:
$ git-clone http://aeyakovenko@localhost/git/repo/ repo

What happens when you point a web browser at either http:// 
aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ or http:// 
aeyakovenko@localhost/git/repo/ ?

Cheers,
Rob
