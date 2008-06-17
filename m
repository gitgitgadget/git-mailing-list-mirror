From: =?ISO-8859-1?Q?Martin_R=F6hricht?= <public@felicis.org>
Subject: bare init and gitweb
Date: Tue, 17 Jun 2008 19:43:37 +0200
Message-ID: <g38t49$lgr$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8h3h-000295-LD
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 21:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbYFQTkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 15:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756765AbYFQTkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 15:40:09 -0400
Received: from main.gmane.org ([80.91.229.2]:56214 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbYFQTkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 15:40:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K8h2A-00023I-4E
	for git@vger.kernel.org; Tue, 17 Jun 2008 19:40:02 +0000
Received: from i72archimedes.tm.uni-karlsruhe.de ([141.3.71.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 19:40:02 +0000
Received: from public by i72archimedes.tm.uni-karlsruhe.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 19:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: i72archimedes.tm.uni-karlsruhe.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85318>

Hi,

in order to use git for some projects via WebDAV I followed the 
instructions given in 
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

So what I basically did is to create a bare repository on the server:

-------------------------8<------------------------
$ mkdir ~/gitrepo.git
$ cd gitrepo.git
$ git --bare init
$ sudo chown -R www-data:www-data .
-------------------------8<------------------------

On the client's side I set up a (local) repository and push changes to 
the server:

-------------------------8<------------------------
$ mkdir git-test
$ cd git-test
$ git init
$ touch README
$ git add .
$ git commit -m "Initial commit"
$ git-config remote.upload.url http://user@server/gitrepo/
$ git push upload master
Fetching remote heads...
   refs/
   refs/heads/
   refs/tags/
updating 'refs/heads/master'
   from 0000000000000000000000000000000000000000
   to   a0bb58fcd20c31d5575dbd6bdab55c9b28970429
     sending 3 objects
     done
-------------------------8<------------------------

Whenever I clone the server's repository somewhere else, I get the 
README file as expected. But when I use gitweb to show me the contents 
of the repository, all I get is this:

-------------------------8<------------------------
projects /

403 Forbidden - No projects found
-------------------------8<------------------------

The projectroot variable within /etc/gitweb.conf points to my 
~/gitrepo.git, and whenever I use "git init", add and commit some files 
locally on the server I see the contents as expected by using gitweb, 
but never by using a repository created with "git --bare init".

Can someone help me out? I would really appreciate any help.

Martin
