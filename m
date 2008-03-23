From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 08:06:57 -0600
Message-ID: <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
References: <47E64F71.3020204@jwatt.org>
	 <alpine.LSU.1.00.0803231401340.4353@racer.site>
	 <47E658D3.1060104@jwatt.org>
	 <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>
	 <47E6612A.5020408@jwatt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jonathan Watt" <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQrL-00068p-9f
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbYCWOG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439AbYCWOG6
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:06:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:41703 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbYCWOG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:06:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2857700wah.23
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YM5RiswHeltgpwNwgGMKrPXqcQscUUe4Xy3kquOu7Vg=;
        b=t30wd3aDGTo6oziVoujPqtSoXMmr4xDmd2LavSQsi8D0x3llDuj9iGX1MbYXPKfepPUOwK1mmdKF55O0RzTgjHV3Slbc7jteWiTDWsnxPzUPvjgM1SVsSNnF6wcFuspPrYdSDCSHF+dIIz64DhyZduaMBNhlHe6luATPOLQHiOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KaOLfFewgZegjaueqyfaDBOXiU0NN2AJlow9yceDkUcbWhGdqVhDM/fn/anhToHUix19hByhklIyGwO1QoPpySZvWJm+WQONeo1eDnzGs/D6dx78lwyBkPUjRl6HHgAWnsWvaQh9I1MqCEpSi+C87X40e+Ze2Im/JIGMa0A9xv8=
Received: by 10.114.134.20 with SMTP id h20mr9699029wad.91.1206281217392;
        Sun, 23 Mar 2008 07:06:57 -0700 (PDT)
Received: by 10.114.205.19 with HTTP; Sun, 23 Mar 2008 07:06:57 -0700 (PDT)
In-Reply-To: <47E6612A.5020408@jwatt.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77900>

On Sun, Mar 23, 2008 at 7:54 AM, Jonathan Watt <jwatt@jwatt.org> wrote:
> Elijah Newren wrote:
>  > On Sun, Mar 23, 2008 at 7:19 AM, Jonathan Watt <jwatt@jwatt.org> wrote:
>  >> Johannes Schindelin wrote:
>  >>  > Hi,
>  >>  >
>  >>  > On Sun, 23 Mar 2008, Jonathan Watt wrote:
>  >>  >
>  >>  >> There seems to be a problem with git-push when the working copy of the
>  >>  >> directory being pushed to came from the magic revision HEAD, but not
>  >>  >> when the working copy came from some other revision.
>  >>  >
>  >>  > http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
>  >>  >
>  >>  > Sidenote: I am constantly amazed how people have no problem accepting that
>  >>  > a CVS-Server has no working directory, but all of a sudden think that a
>  >>  > Git-server should have one, and auto-update it.
>  >>
>  >>  Hi Dscho. I think you've misread my email. (Or not read it. ;-)) I do not expect
>  >>  git-push to update the working copy of the repository being pushed to. In fact
>  >>  my complaint would be more that it *does* appear to modify the working copy
>  >>  (well, not so much modify the working copy as get confused about which revision
>  >>  the working copy came from) when the working copy came from HEAD.
>  >
>  > Ah, I hadn't thought of it that way before.  I think you are
>  > suggesting that pushing to the active branch of a repository with an
>  > associated working copy should cause the HEAD to become detached.  Is
>  > that right?
>
>  To be honest, I'm not sure what you mean by "HEAD to become detached". If you
>  mean that the git-push should, if necessary, stop associating the working copy
>  with HEAD if it's going to change HEAD, then absolutely. It wasn't the same
>  solution as I was thinking of (stop associating the working copy with HEAD and
>  instead associate it with the sha1 HEAD currently points to), but I guess it's
>  the same result. :-)
>
>  Jonathan

In git, HEAD always refers to the currently active branch...if there
is one.  (Also note that each branch tracks its most recent commit.)
If there is no currently active branch because you checked out a tag
or some arbitrary commit, then HEAD is said to be detached, and HEAD
will track the particular commit you checked out.  The end result is
that HEAD is always the most recent commit to which your working copy
is relative to.  See also
http://www.kernel.org/pub/software/scm/git/docs/glossary.html

So, it sounds like we're both saying that in your case, you'd like the
HEAD become detached and track the sha1 that it previously pointed to
before your push rather than continuing to track the updated branch.
