From: Gelonida N <gelonida@gmail.com>
Subject: two branches: keep one difference but  merge others forth and back
Date: Sun, 27 Nov 2011 18:31:42 +0100
Message-ID: <jats5v$r7c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 18:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUiaH-0001kv-Q2
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 18:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662Ab1K0RcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 12:32:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:35312 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab1K0Rb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 12:31:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RUia6-0001gU-4V
	for git@vger.kernel.org; Sun, 27 Nov 2011 18:31:58 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 18:31:58 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 18:31:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185989>

Hi,


Is this possible.


I'd like to have two branches.

If possible I would be able to merge forth and back between both of them.

However I would like, that certain differences will be kept between both
branches.

Is there any way to tell git to permanently ignoring certain commits
from merging?


Example:
---------
   Normally shell scripts would have a first line of
'#!/bin/bash',
but in a certain branch I would like that the first lines would be

'#!/usr/local/bin/bash'

All from then on however I'd like to be able to commit on both branches
and to merge from the other branches (and always keep this difference)

What I tried:
-------------
My first naive approach was:
- create shell scripts in master,
- create then a branch named 'my_shell'
- modify first lines of shell scripts in this branch and commit
- checkout master
- merge my_shell to master with merge strategy 'ours'
  git pull my_shell -s ours
- now I changed something else in master
- when I try to merge back to branch my_shell I will not only get
  the most recent changes done in master, but I will also undo the
changes in line 1 of my shell scripts.

So it seems I am not doing things as one should.


Potential other strategies:
----------------------------
- never commit anything on branch my_shell and just pull regularly
  from master to keep it synced.

- commit changes / bug fixes also on branch my_shell, but NEVER merge
back to master. If a change grom my_shell is really needed on master,
then just cherry-pick.


Thanks in advance for suggestions how you would deal with such 'situations'
