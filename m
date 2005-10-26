From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack extension
Date: Wed, 26 Oct 2005 08:46:11 +0200
Message-ID: <81b0412b0510252346t3806892dx71f9c0dc1efe4073@mail.gmail.com>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051025204754.GA8030@steel.home>
	 <Pine.LNX.4.63.0510252300290.15756@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 08:47:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUf3A-00071F-Ut
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 08:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVJZGqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 02:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJZGqN
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 02:46:13 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:22283 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932558AbVJZGqN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 02:46:13 -0400
Received: by nproxy.gmail.com with SMTP id q29so13936nfc
        for <git@vger.kernel.org>; Tue, 25 Oct 2005 23:46:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rOY5bk07eUuNxlnCbg+RyydjStUpi4FDTgv2Nb+75C+h4ztTrn26sulSlHtrU31MEDwNv30t++Gj2Fx/3KEOj1PK3+5sCGsOHtU9HycaOhE3QqhaC56SembY+EwaehGmULxgEvuhJnba5wXhUiZ3Aq9/hDjtXeB+FeKXUpsVtN0=
Received: by 10.48.247.7 with SMTP id u7mr133254nfh;
        Tue, 25 Oct 2005 23:46:11 -0700 (PDT)
Received: by 10.48.49.13 with HTTP; Tue, 25 Oct 2005 23:46:11 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510252300290.15756@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10649>

On 10/25/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > This patch concludes the series, which makes
> > > git-fetch-pack/git-upload-pack negotiate a potentially better set of
> > > common revs. It should make a difference when fetching from a repository
> > > with a few branches.
> >
> > This broke git-pull for me (the local one):
> >
> >     /d/e/f.git$ git-pull
> >     fatal: bad pack file
> >     fatal: git-unpack-objects died with error code 128
> >     Fetch failure: /a/b/c/.git
> >
> > > applies-to: 6b4b7d9acf60aa99d961b599f37d0c824be79e27
> > > 9adb6b3971e7daa79221d7dbe05b66327b266b86
> > ...
> > > diff --git a/fetch-pack.c b/fetch-pack.c
> > > index 3a903c4..57602b9 100644
> > > --- a/fetch-pack.c
> > > +++ b/fetch-pack.c
> >
> > Reverting just fetch-pack.c part of the patch helps.
>
> Could you please try the patch I sent with the subject "[PATCH]
> fetch/upload: Fix corner case with few revs"? Your output looks exactly
> like what I fixed with that patch.
>

I couldn't at the moment. Do you still need a test?
