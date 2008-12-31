From: "aaron smith" <beingthexemplarylists@gmail.com>
Subject: git push question.. error: Unable to lock remote branch refs/heads/master
Date: Wed, 31 Dec 2008 00:17:35 -0800
Message-ID: <d7ac1a680812310017o4316b719qae5af166a95d9940@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 09:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHwI7-0000M0-El
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 09:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYLaIRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 03:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYLaIRi
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 03:17:38 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:14974 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYLaIRh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 03:17:37 -0500
Received: by wf-out-1314.google.com with SMTP id 27so5709493wfd.4
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=tZvcF5xDcUtH8X/lyWTmkozBZBuLk8dpqWHlMS+yEl0=;
        b=tXP4OVvZEAWkM3i16pf23ht0ayJLQAkr0wioSOwHV6jW7x64U026oiEp8QjR5ZUnTx
         Yp7hWGncPsEfdYyk89wmKseij392ieqVsAVCQLb9os5w6gio0M0bwqw3ELWWpOkOOd+H
         ITr188ooTfxGiq/OhKuqJ+2X3LvDrzn9dr0e4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=U6DfzYdHElJRHMc21UtwVZpoFMYoQYI74Eg3LRICwoi5pgZRasAGJ6gJvhp1QrCLO3
         yZk6NS9cfZQGlr6NLcXjX2AjP6bB3W2YqNA66lNm1vpmm/t1dj1ynVEVAppGKLzXEcNW
         8KzklsMSp8giF0KtyoXfp8G8oFjsyQPqZpz9g=
Received: by 10.142.177.7 with SMTP id z7mr6456190wfe.25.1230711455811;
        Wed, 31 Dec 2008 00:17:35 -0800 (PST)
Received: by 10.143.115.3 with HTTP; Wed, 31 Dec 2008 00:17:35 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104256>

Hey All,

First, i've looked all over for a solution to this, and can't seem to
get it figured out. Here's my setup:

centeos
apache 2
webdav
git 1.6.1

I went through most of the git config over http text file instructions
(http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt),
just for the quick and dirty. Here's what I have in my http conf:

<VirtualHost *:80>
    ServerName www.codeendeavor.com
    DocumentRoot /var/www/vhosts/codeendeavor/
    DavLockDB /var/logs/httpd/webdav/davlock
    <Location "/guttershark.git/">
      DAV on
    </Location>
</VirtualHost>

So, I have a bare git repo here:
/var/www/vhosts/codeendeavor/guttershark.git/ (I used: mkdir
guttershark.git; cd guttershark.git; git --bare init). And I've turned
on webdav for that location.

I created the DavLockDB directory: mkdir /var/logs/httpd/webdav/davlock

And I've updated permissions on the git repo, and the webdav lock to
apache:apache. And when it still didn't work, I updated the
permissions on the git repo to 777, and on the davlock.

I'm not sure what would be going on. I searched through the servers'
empty git, and my local git repo for a lock file. But don't see
anything.

I don't have authentication on it yet so if you want to try and push
to it, feel free.

After all that. here is how I interact with it:

$git push origin master
Unable to lock remote branch refs/heads/master
error: failed to push some refs to 'http://codeendeavor.com/guttershark.git/'

Anyone have any idea?

Thanks a bunch!
