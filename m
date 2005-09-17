From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Newbie falls at first hurdle
Date: Sat, 17 Sep 2005 17:30:18 +0100
Message-ID: <200509171730.19055.alan@chandlerfamily.org.uk>
References: <200509171309.46893.alan@chandlerfamily.org.uk> <7vek7nbrk7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 17 18:31:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGfa1-0004rT-BT
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 18:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVIQQaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVIQQaR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 12:30:17 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:48027
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751139AbVIQQaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 12:30:16 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EGfZt-0000oJ-NU
	for git@vger.kernel.org; Sat, 17 Sep 2005 17:30:13 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vek7nbrk7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8766>

On Saturday 17 Sep 2005 17:13, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:

> We do not track 'directories'.  ...

>
>     $ find * ! -type d -print0 | xargs -0 git add

I did actually manage to create content with

find . -wholename './.git' -prune -o -wholename './.deployables' -prune -o 
\( -type f -print \) | xargs git-update-cache --add 

and then commited it (with git commit)

The editor file that came up with this listed all the files it was going to 
commit INCLUDING some .files from the root directory (I am using eclipse, so 
I had files like .project and .classpath there).  It says in the 
Documentation that git ignores those - has it done?


I then blew away (ie deleted) a couple of directories in my working tree and 
loaded them from an earlier backup and git diff HEAD showed the differences 
of the content of these new directories against the committed ones just fine.  
I then deleted these directories again and then attempted to check them out 
from the repository with

git checkout master

None of these directories has been created in my working directory.

Does this mean that I have to manually create the directory structure for the 
files to be checked into?


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
