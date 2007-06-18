From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: how to move with history?
Date: Mon, 18 Jun 2007 20:16:07 +0100
Message-ID: <20070618191607.GK3037@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 21:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Mqz-0003gj-8a
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 21:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761126AbXFRTZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761331AbXFRTZb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 15:25:31 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:39695 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761126AbXFRTZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 15:25:30 -0400
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2007 15:25:30 EDT
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.66)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1I0MUU-0004WY-5J; Mon, 18 Jun 2007 20:02:18 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 1820E454F5;
	Mon, 18 Jun 2007 20:02:18 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 7C755741B2; Mon, 18 Jun 2007 20:16:07 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50403>

Hello,

I try to understand "git mv"; here is
how far I got:

1. Suppose I have "file" (under git control).

2. I issue "git mv file new_file".

3. Then I have to commit the renaming.
I can't find anything on how to do this
(neither in the git-mv- nor in the
git-commit-documentation).
So a hack is to use "git commit -a".
Apparently this works.

4. Now I have "new_file" in the repository, but
without history (except of the renaming operation),
and I have still "file" in this history, but
I can no longer get access to the history of
"file" via "gitk file" ?


This looks a bit strange to me (the renamed file has
no history, the old file still lurking around, but not
easily accessible).

But perhaps this is as it is (since other solutions might be
even stranger under certain circumstances)?

Is it then possible to complete the move, that is, to really
"move" the history of "file" to the history of "new_file", so
that after that except of some moving-information there is
no trace left of "file", while "new_file" has taken over the
old history?

(The motivation is as follows: I want to make the library I've 
developed available as a clone, but I have the problem that
there are special files which I do not want to make available.
So I hope that in the future with "git-submodule" I can filter
out the special files, creating a (sub-)repository
without the special files which then can be freely cloned.
Now the special files yet are spread around, and to solve this
I want to introduce a special naming-pattern for the special
files (so that it becomes easy to separate the special files from
the rest). But in order to do so I need the ability to fully
move the special files to their renamed versions, completely
with history (otherwise by browsing the history of the clone
the special files would be revealed).)

I would be glad for any help!

Oliver
