From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 09:20:42 +1000
Message-ID: <2cfc403205051016205d722f23@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <Pine.LNX.4.21.0505101743520.30848-100000@iabervon.org>
	 <2cfc40320505101605721420@mail.gmail.com>
	 <2cfc4032050510160578b81fa7@mail.gmail.com>
	 <20050510230844.GG26384@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 01:14:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdv0-0003Dy-Iz
	for gcvg-git@gmane.org; Wed, 11 May 2005 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEJXUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 19:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEJXUx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 19:20:53 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:22002 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261806AbVEJXUm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 19:20:42 -0400
Received: by rproxy.gmail.com with SMTP id j1so15411rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 16:20:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q2QHlE4aC3k5aAmWsys1VZLrfvQwPLiGQwKugIrUIVqyo22eA07XUgIOZMs5r0UrdUArjfdUHQWkQxKRI1XwluytmzPD/ppA/3tlcgv5loVyH3osBuuEgAiFW/3XGcxVMm8A0ZUCWqC8UET+6RQzqJP4/DyvSO/RA6WaSjXssN8=
Received: by 10.38.75.74 with SMTP id x74mr62297rna;
        Tue, 10 May 2005 16:20:42 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 16:20:42 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510230844.GG26384@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Wed, May 11, 2005 at 01:05:55AM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> >
> > I guess I agree it is somewhat nonsensical if one considers the
> > current git toolset as a collection of programs - the exercise now
> > might simply reduce to classifying git tools as
> > index-using/non-index-using and nothing more. However, it might be
> > worth keeping in mind when/if the "libification" of git happens so
> > that there is a clean separation of layers in the API between the
> > repository API and index/cache/workspace API.
> 
> In that case the repository API's input/output is data structure
> equivalent to the index, and workspace API's input/output is the index
> too. That is what it really is - and it is kept on the disk only since
> the commands are invoked separately so it needs to keep the state around
> somewhere.
> 

Not sure I agree...

The repository API would contain functionality equivalent to cat-file,
ls-tree, most of fsck-cache, rev-list, rev-tree, diff-tree, most of
the transport code - things that don't involve use of the index.

The workspace API would contain read-tree, write-tree, commit-tree,
etc - things that do involve use of the the index.

jon.
