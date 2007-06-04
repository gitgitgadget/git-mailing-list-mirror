From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Tue, 5 Jun 2007 00:03:08 +0200
Message-ID: <20070604220308.GJ6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvKeT-0005cu-Rw
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbXFDWDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbXFDWDK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:03:10 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39846 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbXFDWDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 18:03:09 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 10C0673B7;
	Tue,  5 Jun 2007 00:03:06 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 50E241F158; Tue,  5 Jun 2007 00:03:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603151921.GB30347@artemis>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49132>

Another aspect that I have not seen discussed yet is the handling of
testcases that expose a bug, and which are usually integrated as
non-reg tests afterwards.

If we're going the way of using git-note's, we can easily link the
commit which adds the testcase to the non-reg testsuite.

But we could be interested in running the testcase against an
arbitrary commit, thus allowing some sort of automated bisect (modulo
applicability of the testcase to other commits, which may cause false
negatives, but also false positives, and thus may need to be
hand-driven or at least hand-reviewed).

For this, however, would it be sufficient to have the testcase
committed somewhere in the history tree ?  Our hypothetic automatic
bisect tool could cherry-pick that commit and run the testcase, but at
would place an arbitrary restriction of "one testcase per commit",
which would probably a bad idea.

And having the annotation point to the blob does not seem a good idea
either, at least because currently in git tools we have test scripts
that excercise several testcases each.

Even an annotation to both a commit and a blob changed by that commit
would not be sufficiently accurate, when several testcases are added
to the same script in a single commit.


Another options would be to embed the testcase in an annotation: I
can't really see that being used, since that would duplicate the
testcase.  That makes me wonder whether it would not be required to
have testcases described in seperate files ?

Best regards,
-- 
Yann.
