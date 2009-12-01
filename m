From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Newbie "svn update" question
Date: Tue, 1 Dec 2009 17:49:59 +0800
Message-ID: <be6fef0d0912010149o5b5d0557xfb8c57e4a29e4d7e@mail.gmail.com>
References: <loom.20091201T101313-496@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mikko Oksalahti <mikko@azila.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFPMz-0006HJ-AM
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbZLAJty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbZLAJty
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:49:54 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55311 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbZLAJtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 04:49:53 -0500
Received: by iwn1 with SMTP id 1so2956743iwn.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 01:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=md0iRy6zBHFzZKwAWt1/pnirS4nbsLrsB7rSYxgExec=;
        b=vXf0zFCqw34aGivHaqZg8/BCCLKl1n7W0gx3WPjKY36Xol03DPeJJs5VYRe8TztkTG
         cjBy4Gp0AozwyLczjllwLx71LC2lqGCJ7mps4d6p2DstP9MJcIxUwoBIB+9NqrKvDTF9
         lF2Q49vbjHGCRQ1U/YW43RpWpRfXrUZmG63cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aCL3JQxyot6R/bNmvUulWdzEuISbcGMuBKJcxRS+UMQq4k+5GANWfr1MhmwxV/2AB4
         8BryiKx2xV22fyPz2niswEFdvOUxg7Ivo1WJY73/oJ1omVG6vNbz/pMkWJ9mj3ZRh6NX
         IG77TxFYUzJxcjHKJIYfMDg9vr7RgY0sUShSE=
Received: by 10.231.10.16 with SMTP id n16mr953616ibn.24.1259660999497; Tue, 
	01 Dec 2009 01:49:59 -0800 (PST)
In-Reply-To: <loom.20091201T101313-496@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134190>

Hi

On Tue, Dec 1, 2009 at 5:25 PM, Mikko Oksalahti <mikko@azila.fi> wrote:
> How do I now get the accidentally deleted files back from the repository without
> losing local changes made to 10 files?
>
> I've tried using: "git checkout HEAD ." but my local changes after last commit
> will be lost.
>
> I've tried using: "git pull ." but the deleted files are not restored.
>
> So I'm looking for an "svn update" equivalent command that would semantically do
> this: "Get the latest version of all files from the repository and merge them
> with any local changes I've made to files."

Are you looking for a command that

  "Restore deleted files, without reverting local changes",

or

  "Get the latest version of all files from the repository and merge
them with any local changes I've made to files."?

I would suggest adding the changed files, then doing a checkout.

  git add changed.file1
  git add changed.file2
  git add -p #alternatively, select hunks/changes to add interactively
  git checkout HEAD #although using . (current directory) should give
the same result

Note that your changes have only been added to the index, and you need
to commit them. The index/stage is a concept not in svn. See the user
manual for more on this.

I also suspect you are still thinking in svn mode when you said
getting the latest version from the repository. You already have a
repository locally. It is more an issue of syncing your local
repository with the one that you're following. Unlike svn, every time
you commit, your local repository is updated, not the remote one, and
vice-versa.

-- 
Cheers,
Ray Chuan
