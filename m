From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 16:15:37 +1200
Message-ID: <46a038f90508252115415acc04@mail.gmail.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	 <46a038f905082518306e9d7d2a@mail.gmail.com>
	 <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 08:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8VdR-0002JL-Vc
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 06:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbVHZEPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 00:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVHZEPn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 00:15:43 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:51608 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751495AbVHZEPm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 00:15:42 -0400
Received: by rproxy.gmail.com with SMTP id i8so495445rne
        for <git@vger.kernel.org>; Thu, 25 Aug 2005 21:15:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yr0EZ59JZoT4mIzT3h6Xb2PM6mGbY7wpTiP97ZDkWJ7VxXBFkPcN4COk61+N+cSbddhqcqnvsTB3NAtEqwQuUhE7g8BsCvxG1Vn+SdmRzEoiXyB/6br1VSOXjKpOohlHDuMUG47SiBmgvIXI6oO9Bl0sfdJxKuf27Cm1byTSbtw=
Received: by 10.38.89.9 with SMTP id m9mr1527172rnb;
        Thu, 25 Aug 2005 21:15:37 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 25 Aug 2005 21:15:37 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7793>

On 8/26/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > OTOH, storing the metadata in a branch will allow us to run the import
> > in alternating repositories. But as Junio points out, unless I can
> > guarantee that the metadata and the tree are in sync, I cannot
> > trivially resume the import cycle from a new repo.
> 
> But you can.
> 
> Remember: the metadata is the pointers to the original git conversion, and
> objects are immutable.
> 
> In other words, if you just have a "last commit" pointer in your
> meta-data, then git is _by_definition_ in sync. There's never anything to
> get out of sync, because objects aren't going to change.

Hmmm. That repo is in sync, but there are no guarantees that they will
travel together to a different repo. In fact, the push/pull
infrastructure wants to push/pull one head at a time.

And if they are not in sync, I have no way of knowing. Hmpf. I lie:
the arch metadata could keep track of what it expects the last head
commits to be, and complain bitterly if something smells rotten.

let me think about it ;)


martin
