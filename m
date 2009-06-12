From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: use git-daemon by git://IP/path?
Date: Fri, 12 Jun 2009 15:54:08 +0200
Message-ID: <4A325E00.6050504@dirk.my1.cc>
References: <200906121213.13365.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Ka-rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 15:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF7EX-0002VM-OH
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 15:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbZFLNyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbZFLNyJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 09:54:09 -0400
Received: from smtprelay08.ispgateway.de ([80.67.31.31]:49720 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbZFLNyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 09:54:09 -0400
Received: from [84.176.67.51] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MF7Cq-0006qP-V0; Fri, 12 Jun 2009 15:54:09 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200906121213.13365.Karlis.Repsons@gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121421>

Am 12.06.2009 14:13 schrieb Ka-rlis Repsons:
> Hello git users and writers!
> 
> I am new to git, but, having read manuals and grasping the concepts of it, I 
> would like to first say thanks to all those, who created it!
> 
> Things would be fine, but I am having really bad ssh permission problems in 
> here: for example, if there is an empty, initialised git archive and it is 
> pulled to over ssh, the created files have permissions only u=rwX, no more. 
> Then subsequently git pulling doesn't work. Maybe you know how to solve it?

Probably your umask is doing this? When you locally create a file (e.g. 
"touch foo"), does it then only have "-rwx------" as well?

> Also, in general, how can it be set up, that >1 people have a write access to 
> the same repository? Only by using the same login? 

Have a look at the "--shared" option of "git init". That's supposed to 
create shared repositories, i.e. all users of the same group have write 
access. I'm not exactly sure how to make an existing repo "shared" after 
it's been created, but

$ git config core.sharedrepository 1

(which modifies .git/config) and a reasonable chown/chmod -R afterwards 
should work.

Hope this helps,
     Dirk
