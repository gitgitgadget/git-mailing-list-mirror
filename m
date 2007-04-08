From: "Wink Saville" <wink@saville.com>
Subject: Best practices for developing multiple related branches simultaneously
Date: Sat, 7 Apr 2007 19:57:29 -0700
Message-ID: <d4cf37a60704071957r7bb907eg84180097a4594f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 04:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaNbJ-00080f-T3
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 04:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933652AbXDHC5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 22:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933636AbXDHC5b
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 22:57:31 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:18786 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933660AbXDHC5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 22:57:30 -0400
Received: by nz-out-0506.google.com with SMTP id s1so794452nze
        for <git@vger.kernel.org>; Sat, 07 Apr 2007 19:57:29 -0700 (PDT)
Received: by 10.114.14.1 with SMTP id 1mr1799286wan.1176001049520;
        Sat, 07 Apr 2007 19:57:29 -0700 (PDT)
Received: by 10.115.92.20 with HTTP; Sat, 7 Apr 2007 19:57:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43995>

Hello,

A couple of questions on how to manage a series of
hierarchically related branches.

I've created something like this:

----> master
    \----> branchA
         \----> branchB
              \----> branchC

With the intent to be able to create three separate
patches that others can make to master and also continue
development on all three branches simultaneously.

What I'm doing at the moment is to "git-checkout"
one of the three branches A, B or C and make changes.
Note; I don't make changes to master as it represents the
upstream code and will be pulling from it periodically.

If the branch is a parent to a child and I want the
new changes in the parent to be seen by the children I
recursively check out the immediate child do a git-rebase.

For example:

*) git-checkout branchA
*) change some files on branchA
*) git-commit -a
*) git-checkout branchB
*) git-rebase branchA
*) git-checkout branchC
*) git-rebase branchB

This seems to work, but is somewhat arduous and I
was wondering if there is a better way?

Also, I'd like to checkout and work on all three branches
simultaneously. As is implied above, what I do at the moment is
use one repository and to switch branches I use git-checkout, so
as not to lose work when switching I need to commit before switching.
Sometimes I'd rather not commit as I may just want to look at what was
in another branch, possibly unrelated to this series. What is a good
way of handling this situation?

Regards,

Wink Saville
