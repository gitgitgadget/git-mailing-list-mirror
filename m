From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 05:34:51 +0000
Message-ID: <1356327291-ner-6552@calvin>
References: <20121224035825.GA17203@zuhnb712>
	<201212240409.qBO49wkV020768@no.baka.org>
	<CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 06:35:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn0h8-0005vM-CG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 06:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab2LXFe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 00:34:57 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:50743 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2LXFez (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 00:34:55 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2796832eaa.33
        for <git@vger.kernel.org>; Sun, 23 Dec 2012 21:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:cc:references:in-reply-to:mime-version
         :date:message-id:content-type;
        bh=SniYYwc4hxUQmrzUUR7JZ75EhAAe45RnFBduZB1OAfM=;
        b=cIZRswAZNvjIj3qKokStxIKC1a0yeBIT7AJlo/RjM65U+JhsD0GBH8wAgIhMwVKnjm
         QMOQFyU+4QF3BFYFqeIJPOfRP8nz4eaVB2opaO4creNdlfNxJ/3hzBtQ/Trn4yvkLHFs
         J22rWiEpQ9JfLmlbFb75vZOS74EhHn45zCv44GM6NaXBL79pkStg7PdTOhjGXUyUJD0B
         cgXgJl1w1VQc4QE9HXg8EnwOVfpH1mPvUJ/a4acnFLliAqAvcKjTyZW4A76JUN8P3B6D
         UhJWWXbRTlfcKv0Rs2GrdZI98zxQv0PhvvAKjh7GnopaMo3hhcPTV3idSWzNeruMjfWC
         O6Qg==
X-Received: by 10.14.218.69 with SMTP id j45mr52930364eep.35.1356327294463;
        Sun, 23 Dec 2012 21:34:54 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id z8sm39105195eeo.11.2012.12.23.21.34.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Dec 2012 21:34:53 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 2B7201424D5; Mon, 24 Dec 2012 05:34:51 +0000 (UTC)
In-Reply-To: <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212098>

On Mon, 24 Dec 2012 12:28:45 +0700, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, Dec 24, 2012 at 11:09 AM, Seth Robertson <in-gitvger@baka.org> wrote:
> >
> > In message <20121224035825.GA17203@zuhnb712>, Woody Wu writes:
> >
> >     How can I find out what's the staring reference point (a commit number
> >     or tag name) of a locally created branch? I can use gitk to find out it
> >     but this method is slow, I think there might be a command line to do it
> >     quickly.
> >
> > The answer is more complex than you probably suspected.
> >
> > Technically, `git log --oneline mybranch | tail -n 1` will tell you
> > the starting point of any branch.  But...I'm sure that isn't what you
> > want to know.
> >
> > You want to know "what commit was I at when I typed `git branch
> > mybranch`"?  The problem is git doesn't record this information and
> > doesn't have the slightest clue.
> 
> Maybe we should store this information. reflog is a perfect place for
> this, I think. If this information is reliably available, git rebase
> can be told to "rebase my whole branch" instead of my choosing the
> base commit for it.

What's the starting point of the branch if I type: git branch foo <commit-ish>?
