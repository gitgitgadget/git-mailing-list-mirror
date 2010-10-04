From: Christopher Snapp <snappca@gmail.com>
Subject: git svn project shuffle
Date: Mon, 4 Oct 2010 14:36:36 -0400
Message-ID: <AANLkTimL18WHOrLjA5iWNcsgd6H8Eeq19LfJNjkKu_b-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 20:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pu0-0008KP-VK
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770Ab0JDSgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:36:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58569 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab0JDSgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:36:39 -0400
Received: by iwn5 with SMTP id 5so7228009iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=xN7fUXs/pb75cd7CJHsYxnjcFSFJkJV+nR0gAu1eprk=;
        b=mN1Ox4nRj/HRjNSJ3p6KC7ZigNgqeY705zEIScZWfWEMwzS7FPJqAIG1yrkkf2QNJi
         Rl3dAFG5ZkPf3PhHbUIo6J1phKHD2XCyHs+8tBCajPtNYxnjp/OIr2jQnUmSbYZqUJPJ
         +KCM7LQr71DPDS1V6j1yfGTVFR1S+MJvbpN/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=czAPFWWXrcVFK6KZQI9p1x/RmfjdtLxa1SvXDfZlRhiL/Rd641RKhVtMgTHiG1RLsR
         PIHQFwDlKkgb4ZDt+kltQl2hA2FtFehZ6j7clzuh5JW4Elmyha4iWe31drrlx/6kqLkP
         6/yvQmFLib7oUas8KCN/z/otEGewrTuzJntys=
Received: by 10.231.19.74 with SMTP id z10mr10608055iba.120.1286217396327;
 Mon, 04 Oct 2010 11:36:36 -0700 (PDT)
Received: by 10.231.11.137 with HTTP; Mon, 4 Oct 2010 11:36:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158087>

I have used git to interface with an svn repo for some time quite
successfully, but today I've run into a scenario that I'm not sure how
to solve.

The situation is this:
* I have a project (let's call it "oldproj") that has its own
branches, tags, and trunk svn structure
* oldproj is checked out using git svn clone --stdlayout and all has been swell
* due to a CM shuffle oldproj's svn trunk has been copied to a new svn
project (let's call it newproj), so oldproj/trunk has been copied to
newproj/trunk/oldproj
* oldproj's branches and tags directories have been "archived",
meaning it isn't CM guy's intention to bring them over to the newproj
structure.  I don't mind losing the contents of the oldproj's branches
and tags, but I'm not sure how to transition to newproj using my
already checked out git svn clone

My questions are:
# If I try to start from scratch by using git svn clone --stdlayout
the "newproj" location I lose all of the revision history associated
with "oldproj/trunk" that has been copied to newproj/trunk/oldproj.
How can I have git understand the history for the
newproj/trunk/oldproj location?

# An alternative would be if I could somehow reconfigure my already
checked out oldproj git repo so I retain all of the version history
and my local branches and can move forward checking code into the
newproj/trunk/oldproj location?

Regarding the second question, I'd be concerned that the loss of the
branches and tags from the oldproj would confuse things in the future
as the newproj branches and tags are new.

This is probably a simple scenario that many have bumped into but my
searches have so far come up blank.

Thanks very much for any guidance or pointers to previous discussions
regarding this scenario.

--
Chris
