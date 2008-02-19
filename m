From: Jon Loeliger <jdl@freescale.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 14:05:37 -0600
Message-ID: <47BB3691.9040809@freescale.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>	 <20080219063937.GB3819@glandium.org>	 <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>	 <alpine.LSU.1.00.0802191115440.30505@racer.site>	 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>	 <47BB1EC0.601@freescale.com>	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>	 <alpine.LSU.1.00.0802191916020.7797@racer.site>	 <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>	 <alpine.LSU.1.00.0802191940260.7826@racer.site> <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:07:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRYjt-0002mv-Vq
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 21:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbYBSUGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 15:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYBSUGQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 15:06:16 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:43322 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYBSUGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 15:06:15 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m1JK5erb004985;
	Tue, 19 Feb 2008 13:05:41 -0700 (MST)
Received: from [10.214.72.212] (mvp-10-214-72-212.am.freescale.net [10.214.72.212])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1JK5b2X002084;
	Tue, 19 Feb 2008 14:05:40 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74452>

Anatoly Yakovenko wrote:
>
> $ git-clone ssh://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/repo/repo/.git/
> aeyakovenko@localhost's password:
> Receiving objects: 100% (3/3), done.
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> 
> but for the life of me i cant do this:
> 
> $ git-clone http://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

Ponder the Doc Root for an HTTP request.  Remember that your httpd
will likely be striping or rewriting that base directory path and
so it won't be needed on your git http:// requests.

Since my repository was outside of the basic Doc Root, and I wanted
to present similar path names to both git: and http: protocols, I
ended up rewriting some URL paths.  Also, if you have some form of
virtual hosting going on, you might need to do a virtualization
rewriting using --interpolated-path=pathtemplate.

HTH,
jdl
