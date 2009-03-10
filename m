From: Caleb Cushing <xenoterracide@gmail.com>
Subject: BUG: git can't handle certain kinds of renames in merges
Date: Tue, 10 Mar 2009 10:45:25 -0400
Message-ID: <81bfc67a0903100745m3a425337h3f4f7cdbde6b5cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 15:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3ES-00023J-H2
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 15:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbZCJOpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbZCJOpa
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 10:45:30 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:12223 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZCJOpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 10:45:30 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1995062qwi.37
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Z8/KAByWIx31PJ9HUUBugzcooiEL2ueM8uOnxPDecnI=;
        b=VW549gMDax6qiyH3yuC55t37B2VqNtkGqMfUtEpBjbcshDX5nM0+SZiGR4B/E+S/6a
         dkG0xqPqlKfdw87xBSfWCTx2ymx/cUrQ6WBYdqovJSLagGvzKXYVQ/1bmNvd30g6ANEZ
         xo+OfI5LEpOEJZeaaXoFRZIboozHoLfwNo+no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YvADq4OBZVBFSrHT+fu9y2tog6Qjbp7p2ywGz3pPU16+jB/Z8P4Eczb9b6EMzWcqjH
         5oYbSIHiQgBR851Gr4EIeZH5CWApwrItcJk/y/6NPi5kN1hYr3RqnflrBGZiVJ+LdUur
         LqClhc005+Zkdcjj3uqC/brgaCy5aR9/UEKJc=
Received: by 10.229.79.7 with SMTP id n7mr3858198qck.87.1236696325620; Tue, 10 
	Mar 2009 07:45:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112820>

git actually sucks at some merges 101 :P. I'm going to have to play
with my test repository further because eventually I should be able to
get git-write-tree failures making any kind of 'merge' impossible.

git://github.com/xenoterracide/git-test-case.git

clone that. checkout branch 1. then git merge master to see my end failure.

steps to create

add a file in a branch with a line (or more).
create a new branch based on this branch and check it out.
in the new branch mv the file into a directory with the same name as
the file was. add -u and add the file so git sees the rename.
checkout the original branch add some lines. checkout the new branch
merge. the merge will go fine.
remove a line from the new branches file.
checkout master. add another line to that file.
checkout new branch and attempt to merge.

you should now see the point that may test case is at.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
