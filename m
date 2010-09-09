From: Sensei <senseiwa@gmail.com>
Subject: Git with http and no Dav?
Date: Thu, 9 Sep 2010 10:59:51 +0200
Message-ID: <4F28769D-A026-4DA0-9BD4-094EA61EAF92@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 11:00:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtczE-0002xc-EK
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 11:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab0III77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 04:59:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52290 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab0III75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 04:59:57 -0400
Received: by wwb34 with SMTP id 34so157320wwb.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=U4OL/zhF6MgcchRHYyARRXwIxb9A3YqaZF2wUXqR5kI=;
        b=CK87kikjX1Pomn8y2vlLtlMo8zIk3ExmHuA1OAv3ll0y10/OKjyQ9rRpQ/q/P/uAYP
         adg+QCsDIhkz0qLHoi4J2tGPYGuGA1gk7Gs57OpziUFugAJUy7MwBG6HWjnCoXgdP/fl
         VoNEQoNSp96+hr3oyEjcTpsFueMRupTYpkcPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=CVCFwQzIrbst8Nyk5XrR1t1R4dtPPhA1YnR0pZgDRL6IJPQH4PSV8veUqXxTvzSYTl
         9Vge3TkoDrOqsB3E61JtE5F6rgGjJetaZDvQzrKhrjUHcAHqJ+Km5K0L2bfqg5cbb5Ms
         xnXTtIbrRtBl7c8aghR8AoqAmu1Q3J0T6/nbs=
Received: by 10.216.23.78 with SMTP id u56mr14568weu.56.1284022796440;
        Thu, 09 Sep 2010 01:59:56 -0700 (PDT)
Received: from quantum-imac.dia.uniroma3.it ([193.205.142.127])
        by mx.google.com with ESMTPS id o49sm679731wej.19.2010.09.09.01.59.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 01:59:54 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155852>

Hi all!

I am starting to make some public repositories available, although I am struggling with the HTTP backend! 

My setup is currently this: authorized users make use of ssh in order to clone/push, and this works like a charm. A public view (only view!) of repositories can be obtained by gitweb, and this also works flawlessly. 

On my debian server though, I don't know how to enable public cloning via http, since I don't really want to use WebDAV, as explained on the "setup-git-server-over-http.txt" howto. 

As suggested, I issued the "git update-server-info" command in the repository location, however, this has no effect on the repository:

# git update-server-info

# ls refs/
heads  tags

My apache configuration regarding git is this:

(...)
	<Directory /var/www/site/git>
		Allow from all
		AllowOverride all
		Order allow,deny
		Options ExecCGI
		<Files gitweb.cgi>
			SetHandler cgi-script
		</Files>
		DirectoryIndex gitweb.cgi
	</Directory>
	SetEnv  GITWEB_CONFIG  /etc/gitweb.conf

	<Directory /home/git>
		Order allow,deny
		Allow from all
	</Directory>
(...)


Anyway, I keep having the very same error (I tried also with different paths with no luck and the same error):

$ git clone http://my.site/home/git/repo
Cloning into repo...
fatal: http://my.site/home/git/repo/info/refs not found: did you run git update-server-info on the server?


There's something terribly naive that I'm missing here, I know!

Can you give me a hint?

Thanks & Cheers!
