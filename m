From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 21:32:02 +0100
Message-ID: <8c5c35580711031332y4018dba6y5d24965ebf2fbefb@mail.gmail.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com>
	 <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr>
	 <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com>
	 <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: "Luke Lu" <git@vicaya.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 21:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoPfI-0000l4-7P
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 21:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbXKCUcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 16:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbXKCUcG
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 16:32:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:58255 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbXKCUcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 16:32:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1390151wah
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7ftPk1QOZbRK084fVgesP3RqZRPCRB0bP1eB64IL0rE=;
        b=djemf8dkZX8vX/P+IGC84lqbGw6XcekndIEeU30MnuSCjyGF8VKszkidsMmj4tAjZnXZwoLq7GZfitlgpAGl4QeMJAzXGVwoEXSPNnMVxffruTIVnGQ8Hzk69L7x25GmS+ymSjaD135tGTwmsrBUiVJhzSD0yn01WYdLWozIu8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XCNUG3EPUqi43qKMFYqAaodtVdMecI1TFWABQtnB5Imh6kd2cgezDgOnDbwR1koFl5ivgHDPPWBeDCTGJXIZTJzBE4lGxvBXs+3cbwCHc2SAeTmWHqIz0uLwAWZ3P5GMlWkTVfryDfoy/5K7oEk/4DRjnN4q9d50VcvLf0C9f7w=
Received: by 10.114.79.1 with SMTP id c1mr2624034wab.1194121922348;
        Sat, 03 Nov 2007 13:32:02 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 3 Nov 2007 13:32:02 -0700 (PDT)
In-Reply-To: <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63309>

On Nov 3, 2007 9:01 PM, Luke Lu <git@vicaya.com> wrote:
> On Nov 3, 2007, at 6:59 AM, Lars Hjemli wrote:
> > On Nov 3, 2007 11:56 AM, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> >> On Nov 3, 2007, at 9:19 AM, Luke Lu wrote:
> >>> 2. Is there a way to add a new svn branch like that (say production
> >>> or some_branch) to an existing git-svn repository that has trunk
> >>> cloned?
> >>
> >> I don't know, but that'd be great indeed.
> >>
> >
> > You can simply add "fetch" lines to  the relevant "svn-remote" section
> > in .git/config.
>
> I did try to add a "fetch" line for the production branch like this:
>
> [svn-remote "svn"]
>          url = svn+ssh://host/svn/project
>          fetch = production:refs/remotes/svn-prod
>          fetch = trunk:refs/remotes/git-svn
>
> which is modeled after http://lists-archives.org/git/420712-git-svn-
> remote-tracking-branch-question.html
>
> But when I try to checkout the production branch like this:
>
> git checkout -b prod remotes/svn-prod
>
> I got this:
> git checkout: updating paths is incompatible with switching branches/
> forcing
> Did you intend to checkout 'remotes/svn-prod' which can not be
> resolved as commit?

Did you forget to run 'git svn fetch' after modifying your .git/config?

--
larsh
