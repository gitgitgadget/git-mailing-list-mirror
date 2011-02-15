From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 15 Feb 2011 03:00:09 -0600
Message-ID: <20110215090009.GA22498@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <4D5A3964.9090209@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGll-0004Eb-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab1BOJAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:00:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54072 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1BOJAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 04:00:18 -0500
Received: by ywo7 with SMTP id 7so2446839ywo.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R6jdAGtksBhvugj53fdmkzNM1DCovcREAoldIn91hkY=;
        b=KWn3C3XRuom7ReIVr/1CXsXgQYMzgzvxxtWmLhKklGHPDlwdilzCaJfSh0apcHnRcd
         knhrsPMjlDIAW2tPCXTq9vozzzv43t04O4Dh1/xJhvNQxLlLgfOcjORpDI27MZrU5mgY
         kgNZct0MbgRJl/PlymVWPzR6Bmz1dDPI0hj1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UC0V+w/UjcslT5h3cpglf4rBvtK+NyAsQ5yGg6730kZckXF9fMRJUxeJcvlPEXJRdO
         tBylDkdR3KIpDpcVtZNyVkYwCPdotJkiiJhxxVWxNp4pguzK+LW5BCzmbH6DCLQ6MKHz
         kuzcinQseTMhBXtRy9qnWfHQ+5zHQT/Im1O8Y=
Received: by 10.90.74.17 with SMTP id w17mr5803454aga.166.1297760416840;
        Tue, 15 Feb 2011 01:00:16 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id a50sm2207563yhd.0.2011.02.15.01.00.14
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 01:00:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5A3964.9090209@pcharlan.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166828>

Hi Pete,

Pete Harlan wrote:

> Part of the issue could be that one intimately familiar with Git's
> internals may find a process oriented interface irritating ("Why must
> it say 'staging area' when it's just updating the index?")

No, no.  I agree there's a problem to solve here.  The current
documentation for git (e.g., the user manual) has a nice, coherent,
user-oriented narrative about trees, commits, and blobs, and meanwhile
it is hard to find a clear story about the index.

Such a story would have to describe the conflict resolution process.
When you encounter a merge conflict, how do you resolve it?  The best
I can do for now is to point to the user manual[1].

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#conflict-resolution

I even think it is okay to say "The index is a sort of staging area
for your next commit".  Because that is true.  But it is not the full
story, so if one wants to give the index a new name --- which is a
costly thing to do, anyway --- then I do not think "the staging area"
works.

I feel bad to only be presenting complications instead of an alternate
solution.  I do consider workflow oriented explanations very useful.
I've been giving technical explanations in this thread as background
for future storytelling, in the hope that someone more talented than I
am can digest it into a good narrative.

Jonathan

[1] Maybe the process is overdesigned.  After all, what would we lose
by saying

 - an unmerged path justs gets an "unmerged" flag set, meaning that
   flag is not ready for commit yet
 - to get the copy from the common ancestor, use
	git show $(git merge-base HEAD MERGE_HEAD):path/to/file
 - to get the copy from HEAD, use
	git show HEAD:path/to/file
 - likewise to get the copy from MERGE_HEAD

And while I can give answers about why that is a bad interface
(recomputing the merge base is a waste of time; in a recursive merge
the merge base is not a real commit; if there were renames, the copy
from HEAD could be HEAD:other/path and it is hard to find what
other/path is), are those answers enough to justify learning this new
trick?

So we need a better story.
