From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC] git-publish
Date: Mon, 14 Aug 2006 11:01:22 +0200
Message-ID: <81b0412b0608140201x364ec92ifdd3bfa71baa4f4e@mail.gmail.com>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
	 <20060813191346.GA21487@mars.ravnborg.org>
	 <Pine.LNX.4.64.0608131536590.9789@iabervon.org>
	 <20060813204118.GA21956@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 14 11:01:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCYKG-0004y2-TZ
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 11:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWHNJBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWHNJBY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 05:01:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:39749 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751936AbWHNJBY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 05:01:24 -0400
Received: by nf-out-0910.google.com with SMTP id a4so2276nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 02:01:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KB17okDTzN2hnHHO8YDL6MHmYLczHCjLPCglWDZ9K19LNwBCS3KXtRrK2jqLxJpBXpmIk6YK03keu/4bFIbX7Q4IX80+7Dtus6PorbzqTAX0IoSsWrBaSjB4OD/I/DhBnhTl/oZ59JSW8nFRkKk4jJq05az/gd0Qx4S7Cqbwb1U=
Received: by 10.78.151.15 with SMTP id y15mr3159314hud;
        Mon, 14 Aug 2006 02:01:22 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Mon, 14 Aug 2006 02:01:22 -0700 (PDT)
To: "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <20060813204118.GA21956@mars.ravnborg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25334>

On 8/13/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Aug 13, 2006 at 04:11:32PM -0400, Daniel Barkalow wrote:
> > On Sun, 13 Aug 2006, Sam Ravnborg wrote:
> >
> > > But important note is that publishing is something I defer until some
> > > limited test has been done. And when I omit that I have always ended u
> > > pushing some crappy stuff that needs to be dealt with.
> >
> > I also test before publishing. But I test before committing, too, because
> > I never get anything right (or even logically complete) the first time. My
> > cycle is edit/build/test, and if the test is successful, I commit and
> > push.
>
> It happens that I discover bugs while working on next issue.
> And sometime I get my light moments after commiting a patch.

In such a case I usually run git log or gitk to find the commit where a fix
is best applied, git checkout -b tmp <commit-sha1>, edit/commit,
git checkout <test-branch> (if needed), git pull . tmp, find out that
I made a typo, fix it, test, "git checkout -m tmp" and "git commit" and
finally merge the tmp branch or cherry-pick the changes somewhere
safe. Then remove the tmp branch (it's such a special branch to me).
Sometimes I clone the current repo somewhere just to create the
temporary branch there, work in the cloned repo, and pull fixes to test
back in the first repo (it helps to avoid recompilations, while only
fixed files will be updated and recompile)
