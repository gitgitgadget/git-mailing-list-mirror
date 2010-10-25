From: Aleksey Egorov <alekseyandni@mail.ru>
Subject: git via http problem
Date: Mon, 25 Oct 2010 10:34:07 +0000 (UTC)
Message-ID: <loom.20101025T123323-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 12:40:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAKTP-0007G1-PJ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970Ab0JYKkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:40:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:43670 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab0JYKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 06:40:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PAKTE-0007BI-GL
	for git@vger.kernel.org; Mon, 25 Oct 2010 12:40:04 +0200
Received: from 226.246.241.77.artnet.su ([77.241.246.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 12:40:04 +0200
Received: from alekseyandni by 226.246.241.77.artnet.su with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 12:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.241.246.226 (Mozilla/5.0 (X11; U; Linux i686; ru; rv:1.9.0.19) Gecko/2010091807 Iceweasel/3.0.6 (Debian-3.0.6-3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159942>

Good day
I have installed apache2, Webdav and git-core on my Debian.
I added next information to the apache conf
        Alias /linter.git /var/www/linter.git
<Location /linter.git>
DAV On
AuthType Basic
Authname "localhost"
AuthUserFile /etc/apache2/users/pwd
Require valid-user
</Location>
pwd file was created by htpasswd, wich contain user test and password test.
my home/.netrc file contains
       machine localhost
       login test
       password test
And then when I type
       git push upload master
I see next errors
      error: Cannot access URL http://localhost/linter.git/, return code 22
      error: failed to push some refs to 'http://localhost/linter.git/'
In browaser all is ok, when I type http://localhost/linter.git/, user test and
password test, it shows directory on the server.
If I change apache conf to
      Alias /linter.git /var/www/linter.git
<Location /linter.git>
DAV On
AuthType Basic
Authname "localhost"
</Location>
git starts normal:
     git push upload master
     Fetching remote heads...
     refs/
     refs/heads/
     refs/tags/
     updating 'refs/heads/master'
     from 0000000000000000000000000000000000000000
     to aa36be4c3e46e619f73faa0cea071688cb380d25

What is the problem can be?
