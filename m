From: Paul Vincent Craven <paul@cravenfamily.com>
Subject: git over http not re-authenticating after 301 redirect?
Date: Mon, 6 Apr 2009 21:14:42 -0500
Message-ID: <5591393c0904061914y5ea26812kcfc0d14b52ed4300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 04:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr0sE-0006Dp-78
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 04:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759448AbZDGCOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 22:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbZDGCOp
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 22:14:45 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:47514 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759974AbZDGCOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 22:14:44 -0400
Received: by gxk4 with SMTP id 4so5385801gxk.13
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 19:14:42 -0700 (PDT)
Received: by 10.231.15.74 with SMTP id j10mr1090144iba.30.1239070482398; Mon, 
	06 Apr 2009 19:14:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115900>

When I do a git-push from a repository I set up, I get:

craven@craven-desktop:~/docs$ git push
Unable to create branch path
http://username:password@server.simpson.edu/my_repo.git/info
Error: cannot lock existing info/refs
error: failed to push some refs to
'http://username:password@server.simpson.edu/my_repo.git/'

The web log shows:
10.1.21.232 - username [06/Apr/2009:21:24:04 -0500] "PROPFIND
/my_repo.git/ HTTP/1.1" 207 559 "-" "git/1.5.6.3"
10.1.21.232 - username [06/Apr/2009:21:24:04 -0500] "HEAD
/my_repo.git/info/refs HTTP/1.1" 200 - "-" "git/1.5.6.3"
10.1.21.232 - username [06/Apr/2009:21:24:04 -0500] "HEAD
/my_repo.git/objects/info/packs HTTP/1.1" 200 - "-" "git/1.5.6.3"
10.1.21.232 - username [06/Apr/2009:21:24:04 -0500] "MKCOL
/my_repo.git/info HTTP/1.1" 301 383 "-" "git/1.5.6.3"
10.1.21.232 - - [06/Apr/2009:21:24:04 -0500] "MKCOL /my_repo.git/info/
HTTP/1.1" 401 536 "-" "git/1.5.6.3"

Note that after the 301 redirect, I don't seem to have a username sent
anymore. I'm not sure this is the issue, but is seems like a
possibility.

I have the same issue on other computers that have cloned the repository.

The /my_repo.git/info/ directory does exist.

I thought I had this working the first day I set it up, but now it no
longer does. If someone could point me in the correct direction, I'd
appreciate it.

-- 
Paul Vincent Craven
