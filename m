From: Tyrone Lucero <tyrone.lucero@gmail.com>
Subject: gitweb, How to script alias to a directory? for cloning over http
Date: Wed, 7 Aug 2013 18:41:52 -0430
Message-ID: <CAOxYNk+R97KQc0G-=_KPT==gmpKn=Yv9Awpzfq29kx=A7Zv+Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Cta-0000e3-IW
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933704Ab3HGXLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 19:11:54 -0400
Received: from mail-vb0-f66.google.com ([209.85.212.66]:39591 "EHLO
	mail-vb0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540Ab3HGXLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Aug 2013 19:11:53 -0400
Received: by mail-vb0-f66.google.com with SMTP id w16so642485vbb.5
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=NB2R2nIeJae1efxWHJ4SoXk1masua4NaRA5I07qVAXU=;
        b=aCw+amT8jtRxb2I78Ah3ViUIXhxFOsr6KyQupjOfxpxdIDgBwbuU15J2xZ5zqeC0qI
         ctXtKyLkRsoeAXegbXkv5YdGE3jc9C+z83p06Mux9CZU2ES4n8Oma2m/3wp4WCx73ghQ
         Fk07yTnBegHWGebTqm+t2iIZFF9FuDelMiTEcYJz+9QOgZCsWnMUD/vnRrjRI2n415I3
         2465cRADMRp951BvW5QcOyLwVckTHpFH8049quvHTjeX9h0Pm0lubvNmf3vkxNFbZS2i
         SPUsZU12PkFS1fV8Jp9qkvm4tgabh0Zf76KyMPFkqDcWEQMEpk2pFREh1b9Gg2pCmm46
         zfYg==
X-Received: by 10.58.97.199 with SMTP id ec7mr1712603veb.72.1375917112973;
 Wed, 07 Aug 2013 16:11:52 -0700 (PDT)
Received: by 10.52.32.67 with HTTP; Wed, 7 Aug 2013 16:11:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231846>

Hello, I need some guide that can  explain me the following:

I wish to know the correct rule to make work cloning over http with my
configuration, without taking all the web server to server only as
github

I setup  gitweb to it can show in a directory
by example, localhost/gitweb or 192.168.1.20/gitweb ; and works fine,
including rewrite rule



Config file under conf.d from apache config files:


Alias /gitweb /usr/share/gitweb

SetEnv GITWEB_CONFIG /etc/gitweb.conf
SetEnv GIT_PROJECT_ROOT /var/git
SetEnv GIT_HTTP_EXPORT_ALL

<Directory /usr/share/gitweb>
  Options ExecCGI FollowSymLinks Indexes
  AddHandler cgi-script .cgi
  Allow from all
  Order allow,deny
  DirectoryIndex index.cgi
  # Pretty gitweb URLs need rewrite engine on an enabled
  RewriteEngine on
  # rule condition indicates get filenames
  RewriteCond %{REQUEST_FILENAME} !-f
  # rule condition indicates get listing directories
  RewriteCond %{REQUEST_FILENAME} !-d
  # rule condition to show pretty short urls
  RewriteRule ^.* /gitweb/gitweb.cgi/$0 [L,PT]
</Directory>

--
=46=E9nix
