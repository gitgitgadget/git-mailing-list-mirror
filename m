From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 27 Nov 2012 16:10:10 -0500
Message-ID: <CAJELnLHbNDCq1QecA9osxmKKNCaSghm9ADSt5tOrcdm=NF33og@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
	<CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSQI-0001cx-5x
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab2K0VKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:10:12 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40704 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab2K0VKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:10:10 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so9313533iay.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N7A28ft6eThfY6BnhkwQ1R+whOzk+0TQVzBM+f9bDY4=;
        b=BsUB7jU5XL2krRJvb1aBniAa7St1CsS0xTGqRZLQkUWe8Z2oKgsm0fEa1T4cymJIE7
         yKw7p+CtgqDsyktm6c5Lj4nt2GH/UxEVaXS6cnJtWVzen5eoGMNUfgU1XdiiI1dG9L5P
         xuuQ0qLX05iip/lMTABlhSGIyuzgiyspgItLAWTM2jb10EUMNmU6KFtwDYDZkXDmDC1R
         Bbyl/A2Gt3n8QNowQ7TOA3c4ZsmuPwJl4gNo3q6hyXX8XjtZFAhxVmIQSSp+wCtKqPLl
         ISSCwzSuctF1ftsJeeW+bVXiekNjPNh1hWjr8cNvXYx3/qBv9u/leIs+AdyReXK74nnk
         17ZA==
Received: by 10.50.159.229 with SMTP id xf5mr17125778igb.0.1354050610090; Tue,
 27 Nov 2012 13:10:10 -0800 (PST)
Received: by 10.50.57.167 with HTTP; Tue, 27 Nov 2012 13:10:10 -0800 (PST)
In-Reply-To: <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210597>

On Tuesday, November 27, 2012, David Aguilar wrote:
> It seems that there is an edge case here that we are not
> accounting for: unmodified worktree paths, when checked out
> into the temporary directory, can be edited by the tool when
> comparing against older commits.  These edits will be lost.

Yes. That is exactly my desired use case. I want to make edits while
I'm reviewing the diff.

>
> When we can do that then we avoid needing to have a temporary
> directory altogether for any dir-diffs that involve the worktree.

I think the temporary directory is still a good thing. Without it, the
directory diff tool would have no way to distinguish a file added in
the diff from a file that was preexisting and unmodified.

--
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
