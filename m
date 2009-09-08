From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Improving merge failure message
Date: Tue, 08 Sep 2009 15:31:01 +0900
Message-ID: <20090908153101.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 08:34:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkuHJ-0004GY-6Y
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbZIHGd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbZIHGd7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:33:59 -0400
Received: from karen.lavabit.com ([72.249.41.33]:34543 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbZIHGd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:33:58 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 5E02011B838
	for <git@vger.kernel.org>; Tue,  8 Sep 2009 01:34:01 -0500 (CDT)
Received: from 7054.lavabit.com (212.116.219.112)
	by lavabit.com with ESMTP id GQGHJK7GPGGZ
	for <git@vger.kernel.org>; Tue, 08 Sep 2009 01:34:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=zHO7EgQGBn3G0bcgh5XN8X5trVBIen0gx6oXR5DFhMLuS4Elm46ZEYXZO+Qhj/sKtldLqmNZ75Hqn8gyVOp3lMBwGnPhs7e2ACpr2ZF6tbuOBGaIU52vOW9eGDT5yR+BjpqlWhgFuMPND0rzQzvA6d3NcPvgrxadWEPdFDJBGnk=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127972>

I often see my students confused after a failed merge and they can't
figure out what to do next. Two typical error messages they get are

[1]% git merge master
Auto-merging cool
CONFLICT (content): Merge conflict in cool
Automatic merge failed; fix conflicts and then commit the result.

[2]% git merge feature
error: Entry 'cool' not uptodate. Cannot merge.
fatal: merging of trees 8ec1d96451ff05451720e4e8968812c46b35e5e4 and aad8d5cef3915ab78b3227abaaac99b62db9eb54 failed

In the former case, the merge command gives a helpful message that
automatic merge failed because it found a conflict and tells enough
instruction to the user.

But in the latter case, the messages look unnecessarily scary, with two
"error" and "fatal" comments, and long sha1 commit names.

Those of us who used git for some time can tell what it wants to say.
The merge checked the files in the working tree before doing anything,
found that the user has uncommitted change to a file that is involved in
the merge, and it stopped. And it didn't change anything. It may be "fatal"
but the user has much less reason to be scared about this failure than
the conflicting case.

It would be nice if the message in the latter case can be toned down.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
