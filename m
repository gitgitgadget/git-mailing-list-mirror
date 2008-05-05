From: "Zack Brown" <zacharyb@gmail.com>
Subject: Associating tags with changelogs
Date: Sun, 4 May 2008 23:40:23 -0400
Message-ID: <218b69370805042040h66d02979jac6bd64456a9d304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 05:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsrZi-0007QR-4x
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 05:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYEEDkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 23:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbYEEDkZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 23:40:25 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:54973 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbYEEDkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 23:40:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so506454and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 20:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vBmOGul9jGWNYwsG1Erl4yGGys7evUkbquEMmX2Khrg=;
        b=mK0LrhgiBDVLjpzAwPNNfQeGr07Qq8XQHaeidMLtfDL5VIuWTI9ZEocgHfPEkcj4E0CoxlfgTnzu8lDqnFOoSL3UxHzWcbOO05vogGjYgiExhDOkupF0F4AksC5+mG4re8R99NAhsmutvKpq09qg3Q8aeUo/vZ8Edc63gb7CsDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ib/o38IAu/z7k7DujX31bdXGVz2QCvV/xXSWZfIkSKbCH/lLbwOysyYNb47T3W2Vzexa2tcMCoIOsys8EyORz9mBhMC1Be8ShSHlfZR4IvMVVC9bDbkhChjwS4Z1aXLbVZB7wJE9bEnAS+SI6yRw1NIEMOSB4DcRPXMp9R7vO9E=
Received: by 10.100.5.16 with SMTP id 16mr7040094ane.139.1209958823679;
        Sun, 04 May 2008 20:40:23 -0700 (PDT)
Received: by 10.100.172.4 with HTTP; Sun, 4 May 2008 20:40:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81220>

Hi folks,

I'm using git to extract changelog entries into a MySQL database, and
I want to be able to associate each changelog with the official
release in which it first appears. I can use "git-tag -l" to see a
list of the tags, and I can use "git-log tag1..tag2" to view all the
changelogs between two tags, but neither of these are exactly what I
want.

My script keeps track of the most recent changelog entry that it has
processed into the MySQL database, so the next time it runs, it picks
up from that entry, using "`git-log sha1string.. --pretty=fuller", and
inserts only the changelogs since that entry into the database.

What I'd like is to still be able to get only the entries since that
sha1 string, while somehow identifying the tag of the release
encompassing each entry listed in that set. Then when I input the
changelog into my database, I can associate it with the proper
official release (or -rc candidate).

Is there a command to do that? I don't see anything in the man pages for it.

Thanks!
Zack

-- 
Zack Brown
