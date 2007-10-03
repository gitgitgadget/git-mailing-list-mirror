From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn merge helper
Date: Tue, 2 Oct 2007 20:42:52 -0400
Message-ID: <20071003004252.GA28495@dervierte>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet> <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr> <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com> <20071002211400.GA992@atjola.homenet> <20071002220458.GA21038@dervierte> <20071002223813.GA3152@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 02:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcsL3-0004M3-Pf
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 02:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbXJCAnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 20:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbXJCAnd
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 20:43:33 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:60210 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbXJCAnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 20:43:32 -0400
Received: by nz-out-0506.google.com with SMTP id s18so3103212nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 17:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=8iQd3TAGRAZRwNBJKKYG/azg7MgM/RphwFL2donN3P4=;
        b=MFUKFN1wCTrR12nD3nDXbACeEQ1eKCxJ7gS0M0WqPZQtFkXO79mf73om8tCUOIc9RNoBzzEmf3AOOFFZWWCDKcp5zVSTPChGYalrpNDmaILhzOCFoM+T6zHnQWT9Pj2665Ldm48AJ6sW5VAWmbCvZ4+bk7HkLzcfSTPSQuLwYT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=DC4oJlc1j/dKE6HqI7Yy9EjQJ48XT1QTESfggCHB8K/uxf666UAa7NP8187bf4k63TA83bYYlfLQ79QpZI2G5VVbnWYOKzD4t/JiH+ggYWwZSqUbCcohtLtvvitX8OpjKiWHotv/bRkiNxRwu/enwNdAQQ/+ma9d3cwPz0rd/Z8=
Received: by 10.115.93.16 with SMTP id v16mr6880418wal.1191372210831;
        Tue, 02 Oct 2007 17:43:30 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 5sm4041924nzk.2007.10.02.17.43.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2007 17:43:28 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 818EAD84F84; Tue,  2 Oct 2007 20:42:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071002223813.GA3152@atjola.homenet>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59762>

On Wed, Oct 03, 2007 at 12:38:13AM +0200, Bj=F6rn Steinbrink wrote:
> > The other option is to have a "build" branch.  By example:
> >=20
> > git checkout build
> > git reset --hard master
> > git merge mybranch
> > make
> >=20
> > In that way, I have branch with the latest changes from head and th=
e
> > changes from mybranch together.  The downside to this method is tha=
t you
> > may have to repeated resolve merges.  Despite the downsides, I find
> > these two methods to work quite well.
>=20
> Thanks, but it makes no difference here, it stil results in a fast
> forward. This is a small test case which exhibits the behaviour and
> matches my current workflow with git-svn (except for the dcommits):
>=20
> git init
> echo Hi > file1; git add file1; git commit -m file1
> git checkout -b branch
> echo Hi > file2; git add file2; git commit -m file2
> git checkout master
> echo Hi > file3; git add file3; git commit -m file3
> git checkout branch
> git merge master
>=20
> # Then I'd normally do the following which causes a fast forward
> #git checkout master
> #git merge branch
>=20
> # Now I tried this, which also results in a fast-forward:
> git checkout -b merge
> git reset --hard master
> git merge branch

I believe you misunderstood my suggestion.  In using a "build" branch,
you would not merge master into branch, as you did above.  Instead, you
would create a third, unpublished branch to hold the merge.

At the same time, I have a slightly better understanding of what it is
you're trying to do.  If you are trying to keep up an SVN-like workflow
(namely pulling changes from trunk into a branch from time to time),
then my solution probably isn't suitable for you.  However, you might
consider why you actually /need/ to do that, outside of SVN convention.
--=20
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
