From: llandre <r&d2@dave-tech.it>
Subject: Re: Can't import Xenomai svn repo
Date: Wed, 05 Jul 2006 12:04:54 +0200
Message-ID: <44AB8EC6.10501@dave-tech.it>
References: <44AA2B50.4060403@dave-tech.it> <20060704101704.G3a844991@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 12:03:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy4Dr-0002bU-M7
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 12:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWGEKDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 06:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWGEKDD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 06:03:03 -0400
Received: from host46-203-static.38-85-b.business.telecomitalia.it ([85.38.203.46]:19466
	"HELO dave-tech.it") by vger.kernel.org with SMTP id S964785AbWGEKDB
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 06:03:01 -0400
Received: (qmail 16659 invoked by uid 0); 5 Jul 2006 10:02:56 -0000
Received: from unknown (HELO ?192.168.0.6?) (192.168.2.253)
  by 192.168.2.1 with SMTP; 5 Jul 2006 10:02:56 -0000
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060704101704.G3a844991@leonov.stosberg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23346>

Dennis,

thanks a lot for your help.
This command starts fine but ...

git-svnimport -C xenomai2.git svn://svn.gna.org/xenomai

... after a while it fails:

Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committing initial tree 77c387d69d2880a9c3f25764b952e821af919755
Network connection closed unexpectedly: Connection closed unexpectedly 
at /usr/bin/git-svnimport line 348

-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2@dave-tech.it


>> I tried to import Xenomai svn repo but the script failed:
>>
>> git-svnimport -v -C xenomai.git http://svn.gna.org/xenomai/trunk
>> RA layer request failed: PROPFIND request failed on '/xenomai/trunk': 
>> PROPFIND of '/xenomai/trunk': 405 Method Not Allowed (http://svn.gna.org) at 
>> /usr/bin/git-svnimport line 135
> 
> Looks like the repository is simply not accessible by http.
> 
>     $ svn co http://svn.gna.org/xenomai/trunk
>     svn: PROPFIND request failed on '/xenomai/trunk'
>     svn: PROPFIND of '/xenomai/trunk': 405 Method Not Allowed (http://svn.gna.org)
> 
> git-svnimport imports a complete svn repository including its
> branches and tags (as long as the svn repo follows the official
> layout).  So you would run it against the repository's root:
> 
>     git svnimport svn://svn.gna.org/xenomai/
> 
> If you want to import/track the trunk only (and maybe commit to it),
> git-svn from git's contrib is probably what you want.
> 
> Regards,
> Dennis
> 
> 
