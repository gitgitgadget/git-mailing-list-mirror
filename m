From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-svnimport -- http/dav authentication notes
Date: Mon, 20 Feb 2006 20:24:17 +1300
Message-ID: <46a038f90602192324v7193f154od4ff6952a68c799d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 20 08:24:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB5PB-0001Ak-ST
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 08:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWBTHYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 02:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWBTHYS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 02:24:18 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:35942 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932681AbWBTHYS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 02:24:18 -0500
Received: by wproxy.gmail.com with SMTP id i21so823120wra
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 23:24:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EvkWmSTKPinZedUiZGI98Dnm2NqrDdEYkF/+cTzobwEpQpgXnAg3B27uhYS/eOpnQYFRb94MIlPaayPqg9ZZhiZj+vYs7SZV3st8bvVpMsMAd9dl2AgoqyM88yxPOVXYfMZxNZeQ1LBhFmkd4rzBdFk+957S90e0YsdwXFRbNho=
Received: by 10.54.122.6 with SMTP id u6mr3720702wrc;
        Sun, 19 Feb 2006 23:24:17 -0800 (PST)
Received: by 10.54.127.12 with HTTP; Sun, 19 Feb 2006 23:24:17 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16468>

After a lot of trial and error against a server I don't control (so I
can't log things on) I've managed to use svn-import on it and it
mostly seems to work. Kind of. It's slowly grinding through the
commits.

To make it short, I seem to be doing well with:

   git-svnimport -t tags -T trunk -b branches -o svntrunk -v
         'http://martin%40catalyst.net.nz:password@nameless.server.org/svn/someproject'

The repo has LDAP authentication, and the username is my email
address, so I guessed that url-encoding would work, and it did.

svnimport is a bit of a mistery actually. I often know if it's really
doing the import or the files are going to be there but empty. SVN is
so flexible in its "everything is a directory" way of thinking that if
I mess up -t or -b I get the commits alright... but no files.

Strange world, svn ;-)


martin
