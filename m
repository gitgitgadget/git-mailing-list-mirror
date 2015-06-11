From: Ed Avis <eda@waniasset.com>
Subject: Re: [PATCH] git-checkout.txt: Document
Date: Thu, 11 Jun 2015 10:24:50 +0000 (UTC)
Message-ID: <loom.20150611T121345-144@post.gmane.org>
References: <5575F948.4060400@web.de> <xmqqioavob7n.fsf@gitster.dls.corp.google.com> <loom.20150610T170737-586@post.gmane.org> <xmqq7frbmsce.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zfc-0000kw-7r
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbbFKKZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:25:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:59023 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbbFKKZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:25:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z2zfT-0000gF-P8
	for git@vger.kernel.org; Thu, 11 Jun 2015 12:25:04 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 12:25:03 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 12:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271401>

>
I agree, the word 'revert' is already taken for the operation of creating
a new commit which undoes some earlier commit.  So 'revert' cannot be used
for the operation of overwriting a working tree file with its contents from
the repository.

But just because 'revert' is not a good choice, doesn't mean that 'restore'
is either.

>Git is about "contents", not "files".  You modify a file, and
>restore its contents to its pristine state.  It is not "restore the
>file", as Git is not about "files".

'Restore to its pristine state' does convey the flavour of what happens.
Plain 'restore' by itself doesn't, really.

>I think "overwrite is better" is primarily coming from not thinking
>in terms of "Git tracks contents, not files".

But 'git checkout .' is primarily an operation on the local filesystem.  As
far as I know, it does not change the git repository, nor the index, stashes
and so on.  Its only effect is to create and overwrite local files, much the
same as 'tar x'.  So the appropriate language to describe it should be based
more in common usage rather than git-specific terms - if indeed 'restore' is
the git-specific term for replacing a file in the working tree.  (In which
case why not call the command 'git restore'?)

If indeed it did work by tracking contents, there wouldn't be a problem.
The old contents of the file could be saved as a stash and then the file's
contents replaced with the version from the current commit.

% git checkout .
The following files have been restored to their pristine state:
   foo
The previous contents have been saved and can be got back with:
   git stash apply checkout_backup_abcde

Then there would be no need for agonizing over the documentation to make it
clear that 'git checkout PATH' can be a dangerous operation, because it
would no longer be dangerous.

-- 
Ed Avis <eda@waniasset.com>
