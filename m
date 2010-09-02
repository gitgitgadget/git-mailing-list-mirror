From: "J. Bakshi" <joydeep@infoservices.in>
Subject: newbie problem - gitweb  and git over http
Date: Thu, 2 Sep 2010 11:02:42 +0530
Message-ID: <20100902110242.2da0c81d@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 07:43:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or2a0-000617-S6
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 07:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab0IBFnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 01:43:14 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:57453
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab0IBFnN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 01:43:13 -0400
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2010 01:43:13 EDT
Received: from debian (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 4480D62C43D
	for <git@vger.kernel.org>; Thu,  2 Sep 2010 07:32:33 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155104>

Hello,

I am a newbie in git technology, please bear with me. I am interested to implement git over http along with  gitweb.

At first I have already created a demo git repository in the server

``````````````
$ cd (project-directory)
$ git init
$ (add some files)
$ git add .
$ git commit -m 'Initial commit'
````````````````

Then I have set gitweb in apache

```````````````
 Alias /gitweb  /var/gitdir/
RewriteEngine On
RewriteRule ^gitweb$ gitweb/ [R]
SetEnv GITWEB_CONFIG /etc/gitweb.conf

<Directory "/var/gitdir/">
AllowOverride AuthConfig
Options +ExecCGI +Indexes
Order allow,deny
Allow from all
DirectoryIndex gitweb.cgi
SetEnv GITWEB_CONFIG "/etc/gitweb.conf"
AddHandler cgi-script .cgi
</Directory>
``````````````````````````

After restating apache I can see gitweb at http://192.168.1.1/gitweb ; but clicking on the demo project, which I have created;  just gives an error as

``````````````
The requested URL /index.php was not found on this server
```````````````````

webdav is already running in this server for some other project. I have setup webdav for git like

`````````
<IfModule mod_dav_svn.c>
<Location /myproject.git>
Dav on
AuthType Basic
AuthName "My repo with git"
AuthUserFile /home/svn/PASSWORD
<Limitexcept GET HEAD PROPFIND OPTIONS REPORT>
Require valid-user
</Limitexcept>
</Location>
</IfModule>
```````````````

Now testing with cadaver

`````````````````
cadaver https://192.168.1.1/gitweb/test.git

Authentication required for Write access requires a password on server `192.168.1.1':
Username: svnadmin
Password:
Could not open collection:
404 Not Found

``````````````````````

I think for both the cases there are some configuration problem which can't find the correct location/path. Could anyone kindly enlighten me, actually where the problem is ?

Thanks for your time
