From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Git glossary: 'branch' and 'head' description
Date: Wed, 17 May 2006 13:37:19 +0200
Organization: At home
Message-ID: <e4f1ta$e07$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 13:37:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgKLY-00059W-DI
	for gcvg-git@gmane.org; Wed, 17 May 2006 13:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWEQLhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 07:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWEQLhm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 07:37:42 -0400
Received: from main.gmane.org ([80.91.229.2]:11181 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932535AbWEQLhl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 07:37:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgKLL-00057H-S0
	for git@vger.kernel.org; Wed, 17 May 2006 13:37:31 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 13:37:31 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 13:37:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20192>

In #git channel somebody asked about 'branches' and 'heads' and was referred
to the glossary. I had taken then a look at appropriate glossary entries.

In 'Documentation/glossary.txt' we have:
----  
branch::
        A non-cyclical graph of revisions, i.e. the complete history of
        a particular revision, which is called the branch head. The
        branch heads are stored in `$GIT_DIR/refs/heads/`.

head::
        The top of a branch. It contains a ref to the corresponding
        commit object.

head ref::
        A ref pointing to a head. Often, this is abbreviated to "head".
        Head refs are stored in `$GIT_DIR/refs/heads/`.

revision::
        A particular state of files and directories which was stored in
        the object database. It is referenced by a commit object.
---- 

It is just me or the glossary entry for `branch` is unnecessary 
complicated? 

Let's take a look at other definitions:

  In software engineering, 'branch' is a separate line of development, which 
  among others allows development on a project to diverge in two directions, 
  such as a stable and a development version. (WikiPedia:Branch)

  In the CVS team development environment, a separate line of development 
  where changes can be isolated. When a programmer changes files on 
  a branch, those changes do not appear on the main trunk 
  or other branches. (cvs.info)

So from the user's point of view, 'branch' is simply _named line of
development_. Refer to topic and tracking branches.

>From the point of view of commit, current branch (or rather branch
head/branch tip) is the place where we attach current development line
(current commit has current head as parent, and head is advanced to the
current commit), something akin to 'top' pointer for stack implemented as
linked list.

ONLY from the point of view of HISTORY, branch define "non-cyclical graph of
revisions, i.e. the complete history of a particular revision, which is
called the branch head." Merges somewhat obscure the branches (as history),
unless for example we assume that first parent is on the same branch, or
use note header to mark appropriate parent/commit. Also git does not record
where branch started... New branch commit logging proposal, and per-branch
configuration should help with these issues.


No concrete proposal for git glossary update...

-- 
Jakub Narebski
Warsaw, Poland
