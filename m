From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 14:07:15 +1000
Message-ID: <2cfc40320506182107755d1b3e@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <2cfc403205061817181e4d6d5e@mail.gmail.com>
	 <20050619033821.GB24982@delft.aura.cs.cmu.edu>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jun 19 06:02:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djr0V-0008DO-Uu
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 06:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVFSEHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 00:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFSEHX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 00:07:23 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:21832 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261820AbVFSEHP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 00:07:15 -0400
Received: by rproxy.gmail.com with SMTP id i8so297299rne
        for <git@vger.kernel.org>; Sat, 18 Jun 2005 21:07:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q8o/VrTwuwZqJbeMaDlwEsEGjT5DxBLs/7PUsW51XTcl4zKntsOKvgE7+eg8MrKBJeAy9vaoj/GAbCUBOMUW+8o/Bn/PBNpULmN7RMH2X4V9dJAWZRMGrLnHJZ9pzFpXF1/yFAPiVKG0ScM61Qcp8UlPF2IiwbjbRA9w1RXe7YY=
Received: by 10.38.88.69 with SMTP id l69mr702846rnb;
        Sat, 18 Jun 2005 21:07:15 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 18 Jun 2005 21:07:15 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050619033821.GB24982@delft.aura.cs.cmu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/19/05, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Sun, Jun 19, 2005 at 10:18:45AM +1000, Jon Seymour wr
> A was known good, parallel development for commits B and C, finally
> merged into D. A bug got introduced in B, which we discover by the time
> we have a checked out copy of D.
> 
>      .--- B ---.
>     /           \
>    A             D
>     \           /
>      `--- C ---'
> 
> git-rev-list E ^A shows this as BCD. Pick the halfway point C, and this

I assume you mean git-rev-list D ^A

> one checks out ok. So at this point we would decide that the bug got
> introduced by the C->D change.

I think you misunderstood the intent of my original question which was
implicitly referring to the implementation of the bisection algorithm,
not to the bug blatt algorithm that makes use of the bisection
algorithm.

My actual question was: "Why is the bisection algorithm itself the way it is? "

A simple bisection algorithm which simply chooses the middle of the
git-rev-list output chooses a point which one could in principle argue
is as good as the one chosen by the current bisection algorithm.
However, I must admit that I don't quite understand the subtleties of
Linus' bisection algorithm, hence the question - why is his bisection
algorithm better than simply choosing the literal middle?

I'll post a patch that I have already sent to Linus which demonstrates
an implementation of --bisect that chooses the literal middle. This
patch also includes a demonstration of Linus' binary bug blatting
technique (see t/t6001-rev-list-merge-order.sh)

jon.
