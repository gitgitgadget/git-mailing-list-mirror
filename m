From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Explicitly adding ignored files in subdirectories not working
Date: Tue, 23 Feb 2010 22:07:52 +0100
Message-ID: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:08:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1zO-0004OM-4s
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab0BWVIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:08:13 -0500
Received: from mail-px0-f177.google.com ([209.85.216.177]:49600 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0BWVIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:08:13 -0500
Received: by pxi8 with SMTP id 8so2282326pxi.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=HsusDkGVWWkDcUy9PzTwAijDnE0lfCTw4MF9yzDfetY=;
        b=YpKRbk5B7RE6Dy+O46CXkcW1D5/AWXjlSakX7Swu4KXu5g5WrtqQI3KapMeAiFeyYD
         aseTlwSz4R9pYQ/eZac505B/BGcgPdJ+lbUQ6xsczVuH/gdkx+uRTAmtDdDSjmZfUvIw
         CFxLA8xMOMRPLjj//tuJ3J33t84RTjWDPf/78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=fYi9X2bq5OzApBp3+escwqL5PCP043jFaLLoWA9BmIoJLPlYPBO4HNtfzUJEXV8Q9i
         EAUrqQhImCJA7isFKYi57FRNwVWBY1a+RrpmODbT0ug7ACQr6Kj1O4CDdrJJ0cewuLH+
         Ng9jxa+7dNtmDwn0kkcPGpBlEl0c0UCeCGwD8=
Received: by 10.142.118.24 with SMTP id q24mr2216262wfc.238.1266959292384; 
	Tue, 23 Feb 2010 13:08:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140839>

Heya,

I've been bitten by this before, is this behavior intentional? We
don't even warn that the user's action was ignored; at the very least
we should do that. The current behavior is just frustrating.

sverre@laptop-sverre:~/code$ git init ignoretest
Initialized empty Git repository in /home/sverre/code/ignoretest/.git/
sverre@laptop-sverre:~/code$ cd ignoretest/
sverre@laptop-sverre:~/code/ignoretest$ mkdir subdir
sverre@laptop-sverre:~/code/ignoretest$ echo "hi" >> subdir/a.txt
sverre@laptop-sverre:~/code/ignoretest$ echo "subdir" >> .gitignore
sverre@laptop-sverre:~/code/ignoretest$ git add .gitignore
sverre@laptop-sverre:~/code/ignoretest$ git commit -m "set up ignore"
[master (root-commit) 5a5a614] set up ignore
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
sverre@laptop-sverre:~/code/ignoretest$ git add subdir/a.txt
sverre@laptop-sverre:~/code/ignoretest$ git status
# On branch master
nothing to commit (working directory clean)


-- 
Cheers,

Sverre Rabbelier
