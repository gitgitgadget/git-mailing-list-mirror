From: Carl Baldwin <cnb@fc.hp.com>
Subject: Command to list commits that point to a given tree.
Date: Mon, 8 May 2006 10:34:37 -0600
Organization: Hewlett Packard
Message-ID: <20060508163437.GA17390@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 08 18:35:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd8hj-0004rB-RN
	for gcvg-git@gmane.org; Mon, 08 May 2006 18:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWEHQfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWEHQfX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 12:35:23 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:37524 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932409AbWEHQfV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 12:35:21 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel8.hp.com (Postfix) with ESMTP id 46F00350F9
	for <git@vger.kernel.org>; Mon,  8 May 2006 12:35:19 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id D71F2F702
	for <git@vger.kernel.org>; Mon,  8 May 2006 16:34:38 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 8EA535BA3; Mon,  8 May 2006 10:34:37 -0600 (MDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19771>

Hi,

Normally, the natural thing to do is to dereference objects in the
following directions:

commit -> tree
tag    -> commit
tag    -> other object

However, sometimes it is convenient to look in the other direction.  The
command git-name-rev satisfies this need partially by listing symbolic
names for given commits.

Is there a command that can do this more generally?  In particular, I am
looking for a command that will return a list of commits that point to a
particular tree.

Right now I plan to brute force it.  Basically, I will call git-rev-list
to list the commits and, for each commit, map it to a tree.  Then, I
will reverse the map in order to be able to look up a commit based on
the tree.

I was thinking, though, that it might be somewhat useful in general to,
at least, provide a command for the following:

- Given a blob, list the tree and/or tag objects that reference that
  blob.

- Given a tree, list the tree, commit and/or tag objects that reference
  it.

- Given a commit, list the commit and/or tag objects that reference it.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
