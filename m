From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Forcing git to pack objects
Date: Fri, 18 Dec 2015 19:03:39 -0600
Message-ID: <CAOc6etZePL=yvy=fVt9e=RmwdStJy6Kf621icYbYOER-NyMvXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 02:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA5w7-00036h-3D
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 02:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbbLSBDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 20:03:40 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32821 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbLSBDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 20:03:39 -0500
Received: by mail-pf0-f176.google.com with SMTP id n128so39375539pfn.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=J0neZWHBYBmOoh2A6M/ojGb3f9AmMwWBCEDITynOOM4=;
        b=Y0Ni1/MAbxCEMeNB+O57sCnwfUnjGOp6fuCIOB2y4NNudxVcGjy0WEYWWGUvNFTsB4
         eXFJnCQguuHu9AqD2mRtmore6pvxdoSdumwRcAQtJUnyWZbj23VjgUI4o0w2AfIrxxpX
         /jclNEfzX6CtW1ApBDJmquRRlABo7ctxJXyF7mk9AUFmKbxdeZOUTT9V9fUJe6gVF96f
         J3Wuk5LDds1AFvjXA5wGI3ERSCqtS2N2QDI6M3cmp1I5zvFge83STj30laqGcuK9ILWz
         sN3IaJbG6GNZcp71HE8YortYD+5TuaoJ2zVVP+EJSlPmRClOqP3cWB+Dc9X2+tgupfV1
         9Yfw==
X-Received: by 10.98.74.10 with SMTP id x10mr9595209pfa.163.1450487019278;
 Fri, 18 Dec 2015 17:03:39 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Fri, 18 Dec 2015 17:03:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282725>

Hi!

Recently I was running manually a git gc --prune command (wanted to
shrink my 2.8G .git directory by getting rid of loose objects) and I
ended up running out of space on my HD. After freaking out a little
bit (didn't know if the repo would end up in a 'stable' state), I
ended up freeing up some space and I again have a working repo...
_but_ I noticed that basically _all_ objects on my repo are laying
around in directories .git/objects/00 to ff (and taking a whole lot of
space... like the .git directory is now like 5 GBs). After running git
gc manually again it ended up taking a lot of time and the objects are
still there. Also git svn sometimes gcs after fetching and it took to
run cause of the gc execution (ended up killing it) and the files are
still there. Is it possible to ask git to put all those objects in
.pack files? Or did I mess something on my repo?

Just in case, that's a repo I use at work that's working on a windows
box (git for windows 2.6.3).

Thanks in advance.
