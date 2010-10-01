From: cdossantos <claudia.dossantos@ricoh-europe.com>
Subject: Someone using GIT and Maven?
Date: Thu, 30 Sep 2010 23:11:30 -0700 (PDT)
Message-ID: <1285913490619-5590307.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 08:11:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1YqH-0006du-PV
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 08:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab0JAGLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 02:11:32 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33123 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab0JAGLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 02:11:32 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <claudia.dossantos@ricoh-europe.com>)
	id 1P1YqA-0001rm-KC
	for git@vger.kernel.org; Thu, 30 Sep 2010 23:11:30 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157734>


Hello,

I'm evaluating GIT in a Linux environment (Ubuntu 10.04) and one of our
requirements is compliance with Maven 2.0. 
I tested the maven release plugin (mvn
org.apache.maven.plugins:maven-release-plugin:2.0:prepare) but got this
error:

...
[INFO] Checking in modified POMs...
[INFO] Executing: /bin/sh -c cd /root/git-repos4/project2 && git add --
pom.xml moduleA/pom.xml moduleB/pom.xml
[INFO] Working directory: /root/git-repos4/project2
[INFO] Executing: /bin/sh -c cd /root/git-repos4/project2 && git status
[INFO] Working directory: /root/git-repos4/project2
[INFO] Executing: /bin/sh -c cd /root/git-repos4/project2 && git commit
--verbose -F /tmp/maven-scm-845822206.commit pom.xml moduleA/pom.xml
moduleB/pom.xml
[INFO] Working directory: /root/git-repos4/project2
[INFO] Executing: /bin/sh -c cd /root/git-repos4/project2 && git
symbolic-ref HEAD
[INFO] Working directory: /root/git-repos4/project2
[INFO] Executing: /bin/sh -c cd /root/git-repos4/project2 && git push
http://172.17.27.218/project2 master:master
[INFO] Working directory: /root/git-repos4/project2
[INFO]
------------------------------------------------------------------------
[ERROR] BUILD FAILURE
[INFO]
------------------------------------------------------------------------
[INFO] Unable to commit files
Provider message:
The git-push command failed.
Command output:
error: Cannot access URL http://172.17.27.218/project2/, return code 22
fatal: git-http-push failed

But if i use the git command push i don't have any problems:

~/git-repos4/project2# git push origin master
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from 44728f87a5a6f90a0c8e131ad7749811ac133681
  to   8a451fc775478c144686744a0b4c0490be23b0b9
    sending 6 objects
    done
Updating remote server info
To http://localhost/project2/
   44728f8..8a451fc  master -> master

Could be an authentication problem?
I tried as well the command with username and password (mvn
-Dusername="admin" -Dpassword="admin"
org.apache.maven.plugins:maven-release-plugin:2.0:prepare), but got the same
error.
Then I tried to change the scm connection in the POM file, but got the same
error:
<scm>
   
<connection>scm:git:http://admin:admin@172.17.27.218/project2</connection>
</scm>


I have the file .netrc configured with host, username and password. Does
Maven use this file?

Any ideas?

regards,

Santos 
-- 
View this message in context: http://git.661346.n2.nabble.com/Someone-using-GIT-and-Maven-tp5590307p5590307.html
Sent from the git mailing list archive at Nabble.com.
