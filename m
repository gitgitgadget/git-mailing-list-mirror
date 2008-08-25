From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support
Date: Mon, 25 Aug 2008 20:52:11 +0700
Message-ID: <fcaeb9bf0808250652p3d0f483dt714cd68d3122d7c9@mail.gmail.com>
References: <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
	 <20080824220854.GA27299@coredump.intra.peff.net>
	 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	 <20080824231343.GC27619@coredump.intra.peff.net>
	 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
	 <20080824235124.GA28248@coredump.intra.peff.net>
	 <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
	 <20080825020054.GP23800@genesis.frugalware.org>
	 <7v1w0dkd5s.fsf@gitster.siamese.dyndns.org>
	 <20080825125205.GB23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Karl Chen" <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXcVS-0002uN-32
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 15:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbYHYNwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 09:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbYHYNwO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:52:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:32534 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbYHYNwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:52:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so980374fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ziw9jyhMjog0a/ijM3XR5J6tW/hpEAZwPJEkd8E6aNE=;
        b=JjsSptWpmJm50wLxUpvMLZdKAfb/xx0E4O4SG7e7l3dYUGR3oh8RcwiWU7qiDGpgck
         UWv1cdmFDxw0ja8Pgf8PqBA7kvPCG2RJnFwrwpribXbztHm/3W9w5xq0bjzQGSv5g7mJ
         dZLViCQnK3mHt6Ur6ylmdI6DB9OqrgwqqLm+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I0mngrBt2QFRR+aX9MMlLAS+ueoWonRJKAheE5JRrNAXCcQ9uQ9jpYacz49wo5MXQm
         Y/x9esT041pbIOLHbl/FrYWVR1VC7YdGvAdy4Rmtx1OPBNSE1INwTb0omRhJX9DHtXQ9
         itXbRCaP/bR4ptXhRpO1ie+EJt0V7eJ9f7GX0=
Received: by 10.86.92.7 with SMTP id p7mr3355801fgb.72.1219672331560;
        Mon, 25 Aug 2008 06:52:11 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Mon, 25 Aug 2008 06:52:11 -0700 (PDT)
In-Reply-To: <20080825125205.GB23800@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93624>

On 8/25/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Aug 24, 2008 at 08:05:03PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>  > > Does this include removing of --work-tree as well?
>  > >
>  > > The git backend of Pootle (http://translate.sourceforge.net/wiki/) uses
>  > > it.
>  >
>  > Interesting.  Does it use it because it can (meaning, --work-tree is
>  > supposed to work), or because --work-tree is the cleanest way to do what
>  > it wants to do (if the feature worked properly, that is, which is not the
>  > case)?
>
>
> It's like:
>
>  The current working directory is like
>  /usr/lib/python2.5/site-packages/Pootle. The git repository is under
>  /some/other/path/outside/usr.
>
>  Then Pootle has two possibilities:
>
>  1) save the current directory, change to /some/other, execute git, and
>  change the directory back
>
>  2) use git --work-tree / --git-dir
>
>  I guess the second form is more elegant. Of course if it is decided that
>  this option will be removed then the old form can be still used, but I
>  think that would be a step back.
>
>
>  > > Also, here is a question:
>  > >
>  > > $ git --git-dir git/.git --work-tree git diff --stat|tail -n 1
>  > >  1443 files changed, 0 insertions(+), 299668 deletions(-)
>  > >
>  > > So, it's like it thinks every file is removed.
>  > >
>  > > But then:
>  > >
>  > > $ cd git
>  > > $ git diff --stat|wc -l
>  > > 0
>  > >
>  > > is this a bug, or a user error?
>  >
>  > I  think it is among the many other things that falls into "the two
>  > attempts still haven't resolved" category.
>
>
> I'm unfamiliar with this part of the codebase, so in case somebody other
>  could look at it, that would be great, but I'm happy with write a
>  testcase for it. (Or in case nobody cares, I can try to fix it, but that
>  may take a bit more time.)

Because "git diff" did not call setup_work_tree(). The same happens
for "git diff-index" that someone reported recently. IIRC "git
diff-files" has the same problem.
-- 
Duy
