From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Problem with template location
Date: Wed, 9 Nov 2005 20:45:55 +0000
Message-ID: <200511092045.55300.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 09 21:46:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZwpS-0002ck-QO
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 21:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVKIUp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKIUp4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 15:45:56 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:23937
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1750766AbVKIUpz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 15:45:55 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EZwpO-0001rC-LK
	for git@vger.kernel.org; Wed, 09 Nov 2005 20:45:54 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11412>

I am trying to set up a public repository on my server to which I can push 
stuff

I have just downloaded the git-core-0.99f-tar.bz2 file and untarred it as me 
(alan) on account on the server.  My home directory is at /home/alan

Went in as me into the git-core-0.99f directory and did a make

Then became ROOT and did 

make prefix=/usr/local install

(I also built the documentation but I don't think that is relevent)


Separately AS ROOT I have gone into the directory where I am going to build my 
repositories (/var/lib/git) and tried to build the repository as per the 
tutorial.


roo:/var/lib/git# mkdir famtree.git
roo:/var/lib/git# GIT_DIR=famtree.git git-init-db
warning: templates not found /home/alan/share/git-core/templates/
roo:/var/lib/git#

git-init-db seems to have got the wrong place for the templates - ie the 
account where I originally built the code.

(NOTE: the templates have actually been installed 
in /usr/local/share/git-core/templates)

I had to do a make clean, but following that I did

make prefix=/usr/local 

for the first part,  and then re-installed (also with the prefix) and it 
solves the problem

I don't know whether this is something that can be fixed at install time, or 
whether the README should be changed to make it clear that you need the 
prefix on the first stage of the process as well as the second.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
