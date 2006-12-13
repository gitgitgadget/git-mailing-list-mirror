X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 17:18:41 -0500
Message-ID: <20061213221841.GB4928@fieldses.org>
References: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 22:18:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612132200.41420.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34240>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucR5-0007rD-2C for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751659AbWLMWSo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWLMWSo
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:18:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:42543 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751617AbWLMWSn (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 17:18:43 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GucQz-0004xM-Vr; Wed, 13 Dec 2006
 17:18:41 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, Dec 13, 2006 at 10:00:37PM +0000, Andy Parkins wrote:
> svn add::
> Put files and directories under version control, scheduling them for
> addition to repository.  They will be added in next commit.  This
> doesn't really add anything, it just schedules.
> git add::
> Add files to the index file.  This command does not simply schedule.  It
> takes the current contents of the file and copies it to the git staging
> area.
> 
> The git index makes this command more complicated for git; however git
> is using the verb "add" more correctly.  In the subversion case, nothing
> is actually added to a repository, it is merely scheduled for addition.

Well, you could argue whether adding something to the index is really
adding it to "a repository".

> svn cat::
> Output the contents of specified files or URLs.  Optionally at a
> specific revision.
> git cat-file -p $(git-ls-tree $REV $file | cut -d " " -f 3 | cut -f 1)::
> git-ls-tree lists the object ID for $file in revision $REV, this is cut
> out of the output and used as an argument to git-cat-file, which should
> really be called git-cat-object, and simply dumps that object to stdout.
> 
> Subversion wins.  This is a distinctly non-user friendly way of reading
> a file.

Still, unfriendly, but not quite as bad:

	git -p cat-file -p revision:path

> svn diff::
> Display the differences between two paths.  Defaults to showing the
> differences between HEAD and the working copy.
> git diff::
> As for svn;

though note slightly different default.  (Diffs against index, not
HEAD).

