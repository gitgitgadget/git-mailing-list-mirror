X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 06:34:04 -0600
Message-ID: <89b129c60612130434q18c69c7bxd96b7db0c423d8ea@mail.gmail.com>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
	 <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1166001019.19098.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 12:34:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OdofTpuLrZm26CxMulHVGKuXcpTClRx/HLnF+VSvcN8/qinl7xhELC+Hu/Yi7Jww2m3F7Hm4xOOAbyq6eucbQANg0geLfCK6Ax7un7K9Hpv6AlTqRSQFokhZ1MJH8qiLmoPMA4uExPiMca68YJPXZTL6urpmWZq1AhzkGiePMfs=
In-Reply-To: <1166001019.19098.4.camel@localhost.localdomain>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34215>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuTJL-0004Rt-L9 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 13:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964910AbWLMMeI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 07:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWLMMeH
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 07:34:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:43640 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964910AbWLMMeG (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 07:34:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so157256uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 04:34:05 -0800 (PST)
Received: by 10.78.97.7 with SMTP id u7mr598997hub.1166013244997; Wed, 13 Dec
 2006 04:34:04 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Wed, 13 Dec 2006 04:34:04 -0800 (PST)
To: "Matthias Kestenholz" <lists@spinlock.ch>
Sender: git-owner@vger.kernel.org

Hi,

On 12/13/06, Matthias Kestenholz <lists@spinlock.ch> wrote:
> Hi,
>
> On Tue, 2006-12-12 at 23:54 +0100, Johannes Schindelin wrote:
> > Hi,
> >
> > On Tue, 12 Dec 2006, Sean Kelley wrote:
> >
> > > I was wondering if anyone could share ideas on how best to use GIT to
> > > handle releases for those working with a remote GIT repository?  Do you
> > > create a branch and push it to the remote?  Thus you have a new branch
> > > referencing the particular release?
> >
> > Why not just tag the release, and push the tag?
>
> I am doing both in my web SDK project.
>
> I currently have two branches, master and maint/v1. Over time, if
> necessary, I'll open new branches named maint/v2, maint/v3 etc.
>
> New development happens on master, bugfixes go to maint/v1 and get
> merged into master. If I do bugfix releases (2.0.x), I tag the tip of
> the maint/v1 branch.


That seems to match my use case.  So if I follow your description:

  git checkout -b maint/v0.1
  git pull . <remote project repo>
  git push origin maint/v0.1:maint/v0.1

Now the initial branch release is on the remote repo.  So that my team
can start hacking on the release branch.  When we are ready, we need
to create a release tag.

   git tag -a -m "Release 0.1.0" rel-v0.1.0

How do I push that tag that I created to the maint/v0.1 branch on the
remote repository?

Thanks,

Sean


>
> I need a full branch, because I need the ability to do bugfixes for the
> already-released version.
>
> Matthias
>
>


-- 
