From: Gary Yang <garyyang6@yahoo.com>
Subject: Cannot git pull using http from my git.mycompany.com
Date: Thu, 20 Nov 2008 17:13:06 -0800 (PST)
Message-ID: <562019.27220.qm@web37908.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 02:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3KbV-0006Hl-Us
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 02:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872AbYKUBNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 20:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYKUBNK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 20:13:10 -0500
Received: from web37908.mail.mud.yahoo.com ([209.191.91.170]:37588 "HELO
	web37908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753137AbYKUBNJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 20:13:09 -0500
Received: (qmail 27979 invoked by uid 60001); 21 Nov 2008 01:13:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=5HEhLKSo9dvIw2FbN8LHto3T6V1vYjcDY+hNmGQxWw57MRxQrWNiLr4rTLEMh/ZB9rmE2obRPWG03C1QaY+dKP+Eu/UF0daGKq8Peu0cDFxiWgsajlJOEmDdFj90Waor7A+P9FBCBRi3HPo4tdWy7vyrG29b5L3mSUbJgPMY/nA=;
X-YMail-OSG: 4rR9Q7wVM1nba44JSbBIHlNYZYAmWfq3FSCcvWq9vPOnc6DVNCI1sl39CXpDLneF_Y3aHTUrF.pD1TUcy.GYz2935oVF5Ax_ufrWefumzjDZDv9NAGxVKnVB0Ru1RmERl1VYvCBobFDYSFvG0CM5.5zF_9fvaf9QBcha3q2XRTA3H8.LNc7lh3G9UI79
Received: from [76.195.33.70] by web37908.mail.mud.yahoo.com via HTTP; Thu, 20 Nov 2008 17:13:06 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101491>


git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?

Below are related gitweb configs. What did I do wrong?


httpd.confg

<VirtualHost 10.66.4.168>
    ServerName svdcgit01
     DocumentRoot /pub/git
     <Directory /var/www/cgi-bin>
          Allow from all
          AllowOverride all
          Order allow,deny
          Options ExecCGI
          <Files gitweb.cgi>
               SetHandler cgi-script
          </Files>
     </Directory>
     DirectoryIndex /cgi-bin/gitweb.cgi
     SetEnv  GITWEB_CONFIG  /etc/gitweb.conf
#       RewriteEngine on
#       RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]


cat /etc/gitweb.conf
# path to git projects (<project>.git)
$projectroot = "/pub/git";

# directory to use for temp files
$git_temp = "/tmp";

# target of the home link on top of all pages
$home_link = $my_uri;

# html text to include at home page
$home_text = "indextext.html";

# file with project list; by default, simply scan the projectroot dir.
$projects_list = $projectroot;

# stylesheet to use
$stylesheet = "/gitweb/gitweb.css";

# logo to use
#$logo = "/git-logo.png";
$logo = "/gitweb/git-logo.png";

# the 'favicon'
$favicon = "/gitweb/git-favicon.png";

$projects_list_description_width = 60;
#$feature{'pathinfo'}{'default'} = [1];






      
