From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Question regarding: git pull --no-commit origin
Date: Mon, 26 Mar 2007 10:46:09 +0930
Message-ID: <93c3eada0703251816lc430e03l71ee2ffaa3d8796@mail.gmail.com>
References: <93c3eada0703251632s3be48b60na03728ce72b8ab8c@mail.gmail.com>
	 <20070325233823.GA13247@spearce.org>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 03:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVdol-0007aU-Ja
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 03:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307AbXCZBQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 21:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933298AbXCZBQM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 21:16:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12233 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933307AbXCZBQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 21:16:11 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2741781nfa
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 18:16:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TpBevftPtH2b5b+OKfc3p2IF2DjVcvXzbG/5VjDKjdv+D17bvKrzElVpd55g0T5zvs3C6jU4IhU+6xaSxqwcNtG5xMVD0UV5mM1RWEUU0Mu+llhjHhGz97n3czZVdHKapsdpa0bNaD9bokA8+uNuZl5kuRijLdR56RmxMNL6720=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QGs3xG5N/Gomaz5PjYNiwKABJ1zIKla9tc84QNMn8rSn+ZrU3vxPiPqwZ2cNrovik8/I5xhhT71PFdYZkbZmHWSnb5dRniAyHjPb00z/90TJ+3cYYx/06A/q9HT2274I9oo5k6NkZlMrVNm0eVKc5H+6Q7JBzSQ9UlbQPl3oDeI=
Received: by 10.82.165.1 with SMTP id n1mr12564133bue.1174871769591;
        Sun, 25 Mar 2007 18:16:09 -0700 (PDT)
Received: by 10.82.111.16 with HTTP; Sun, 25 Mar 2007 18:16:09 -0700 (PDT)
In-Reply-To: <20070325233823.GA13247@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43102>

On 3/26/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Geoff Russell <geoffrey.russell@gmail.com> wrote:
> > I do: git pull --no-commit origin
> >
> > Receive messages ending in:
> >
> >        ...
> >       Updating 6a29cdd..b7ba33d
> >       Fast forward
> >       interface/testfile |    1 +
> >       1 files changed, 1 insertions(+), 0 deletions(-)
> >       create mode 100644 interface/testfile
> ...
> > However when I do: git commit -a
> >
> > I'm told: nothing to commit (working directory clean)
> >
> > Am I misunderstanding something?
>
> The pull was strictly a fast-forward.  No merge commit was necessary
> to record the merge, so we didn't actually honor the --no-commit
> argument.
>
> In other words, your current branch did not contain any commits
> that were not in the origin branch you were pulling from.  So
> a real merge wasn't required here.

Thanks Shawn, but my situation is I have the MASTER repository and I'm
pulling from a TEST repository. I want to double
check the updates other people have done
on the TEST repository, and if they are okay, then commit them.

If --no-commit won't let me do this then perhaps I need something like:

          git pull origin:testing
          git checkout testing
           .... test
          git checkout master ; git pull . testing

i.e., make a branch for the test changes and then merge this branch.

Cheers,
Geoff
>
> --
> Shawn.
>
