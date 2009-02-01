From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sun, 01 Feb 2009 15:13:51 +0100
Message-ID: <87eiyib5y8.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
	<87vdrwbofv.fsf@gigli.quasi.internal>
	<slrngo771p.b1i.sitaramc@sitaramc.homelinux.net>
	<87myd7bo8f.fsf@gigli.quasi.internal>
	<20090201064543.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 15:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTdAs-0005iL-Hx
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 15:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZBAON7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 09:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZBAON6
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 09:13:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:10465 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZBAON5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 09:13:57 -0500
Received: by fg-out-1718.google.com with SMTP id 16so383118fgg.17
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 06:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=mENm1XyJAdggA2vRjqnwX1dYQUSKWdDoFT4l/PKBh3M=;
        b=lupAM35vxob+FHbpmVjzKz2J7s49BhGssb8QvgFQ/8qvVRCRCbHYCOBrcgqQSMNv0H
         t4jIqcSGsbx5Ip1Zj+08d0Ww9kAfLruHSEB7ILT5MvrTopA8ooHIF2ftqIkSgbZ5LCmH
         od+astBZg+FP0F/KQURMbqJQIryrD7/Hge7lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=Sjx6w/+u2/PGEL95++UH4xdEPNCM7HkJoBnOCkVVaLjgREVvKkV21xJuluINHTISvI
         zETIGm+UcWN1tQjKqnmdcA1wDuyG3vDvzgbaHcBZjqHqibe9xhUfGIdNwQkUcOV8VfY/
         wnjtYYSf83xYJXgYKPseulOc9UyxPiHWiShZI=
Received: by 10.103.221.5 with SMTP id y5mr1432039muq.66.1233497634386;
        Sun, 01 Feb 2009 06:13:54 -0800 (PST)
Received: from gigli.quasi.internal (p5DC32176.dip.t-dialin.net [93.195.33.118])
        by mx.google.com with ESMTPS id w5sm3704886mue.25.2009.02.01.06.13.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Feb 2009 06:13:53 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20090201064543.6117@nanako3.lavabit.com> (Nanako Shiraishi's
	message of "Sun, 01 Feb 2009 06:45:43 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107981>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting "Raimund Berger" <raimund.berger@gmail.com> writes:
>
>> I'm myself, especially since a conflicting rebase leaves the index in an
>> "unmerged" state. Much like a regular merge does. It's still all
>> assumptions though, or maybe I'm missing documentation .... (?)
>
> The rebase command you run with neither -m nor -i option replays
> your work on top of the upstream by running git-am with the --3way
> option.
>
> This commit introduced the feature.
>
> commit 7f59dbbb8f8d479c1d31453eac06ec765436a780
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Mon Nov 14 00:41:53 2005 -0800
>
>     Rewrite rebase to use git-format-patch piped to git-am.
>     
>     The current rebase implementation finds commits in our tree but
>     not in the upstream tree using git-cherry, and tries to apply
>     them using git-cherry-pick (i.e. always use 3-way) one by one.
>     
>     Which is fine, but when some of the changes do not apply
>     cleanly, it punts, and punts badly.
>
>     [omitting the rest]
>
> The message talks about what was wrong with the original, what
> benefit it gives the users, and how to use it, but it doesn't
> discuss how the magic works in detail.
>
> Junio much later describes how it works, taking a real-world example
> in this message:
>
> http://thread.gmane.org/gmane.comp.version-control.git/46569/focus=46609
>
> In short, it works by applying your changes as patches but when a
> patch doesn't apply it falls back to a simplified three-way merge.
>
> http://thread.gmane.org/gmane.comp.version-control.git/100579/focus=100602
>
> I think Junio misremembered the history in his last message in the thread.
> He says that rebase was originally a format-patch piped to am, but
> before the commit 7f59dbbb8f8d479c1d31453eac06ec765436a780 it was
> done by a series of cherry-pick.


Ugh. OK, that really explains a lot alright. Especially that fundamental
change in rebase behavior makes it quite clear that the various
techniques for "merging" content might not be as consistent as I had
hoped. In my ideal world they'd only differ in how they map out commit
history, but obviously that's not the case.

To me, this really leaves questions open regarding a hassle free
workflow. Since one apparently can't be confident that conflict
resolutions obtained in some testing or early integration branch will
easily carry over to stable it looks like special measures need to be
taken, like strict observation of merge order/technique and employment
of replay tools.

So serialization apparently can't entirely be lost, and where e.g. CVS
kind of enforces it at an early stage through expensive branching it
seems git still requires some of the same coordination just at a
different level resp. point in time.

Hey, thanks a bunch for taking the time carrying those links
together. They've been very informative.
