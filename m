From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/5] My set of stgit companion scripts.
Date: Tue, 9 Jan 2007 10:21:30 +0000
Message-ID: <b0943d9e0701090221o6437fc0ana17bb190eb1eae0b@mail.gmail.com>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 11:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4E6t-0007Se-Bt
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbXAIKVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXAIKVc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:21:32 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:15190 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXAIKVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:21:31 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3956199nze
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 02:21:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hKH+ZtyKBpjBBCXwhW+tf2wWELzoC0pF8+mzhboRHFSyWRV6qPcv5bTdR2OiNMWZZQiMungMUlnGL8zwry3g1tlCS9kkaGj7JZ0Z8dvIOHVZP8UohfQELKM9daAci+qY9W++yhrQxB/983OuLhqWzcgZhJdPDmI+jxHJkCh4qCI=
Received: by 10.65.213.4 with SMTP id p4mr474140qbq.1168338090397;
        Tue, 09 Jan 2007 02:21:30 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Tue, 9 Jan 2007 02:21:30 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36338>

On 04/01/07, Yann Dirson <ydirson@altern.org> wrote:
> The following series adds to contrib/ a set of bash scripts I find useful
> for my daily use of stgit.  They are probably closely tied to my workflow,
> but others may find them useful as well.  Some of them may be useful to
> pythonize and integrate in some form or another.

Yes, indeed. I'll try this week (now that the holidays are finished)
to add TODO and wishlist pages on the wiki so that people can extend
them.

> stg-show-old is a trivial thing, but since I often need that functionnality,
> it is much less comfortable than forging the same command-line over and over
> again.  It is also used by some of the other scripts.

Since we have some kind of patch history support, I'd rather extend
the git_id() function to parse patch names appended with ^ or ~x as in
GIT. This way you can access the full history and not only the
previous version of the patch.

You can currently do 'stg show [<patch>]//top.old'

> stg-fold-files-from and stg-swallow are invaluable when shuffing changes
> between patches.

The first one is indeed useful and might not be easy to implement in a
python-only script. The latter is useful as a shortcut but I would
rather have a python command (or --swallow option to 'pick' in
addition to --fold) to automate this.

> stg-what-changed is invaluable when shuffling patches in the stack.

It's interesting to see the diff of diffs but it takes some time to
get used to it :-). There is 'stg log (--patch|--graphical)' which
shows the diff of every refresh you did on the patch. What it doesn't
show is the diff of a push since this creates a new patch version
every time. Maybe this could be extended so that for push with
conflicts, it first stores a version with conflict markers and another
version after fixing them and refreshing.

> stg-cvs is a very young script, and probably very fragile.  It allows a
> lightweight way of preparing changes with stgit before committing them into
> a CVS tree.

I'm OK with this (but I won't use it much).

Thanks.

-- 
Catalin
