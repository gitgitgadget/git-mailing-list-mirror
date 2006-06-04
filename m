From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 15:57:25 +0200
Message-ID: <e5bfff550606040657p5c1a3dceq3eef254ab64f0e3a@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	 <7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
	 <7v3belcicq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 15:57:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmt6l-0000CO-PE
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 15:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWFDN51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 09:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWFDN51
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 09:57:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:13353 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751472AbWFDN50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 09:57:26 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1179697wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 06:57:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LMCUztNlAEnMRx+K5DJkmj2Gko+d+HEjaxEzxPO6KTENTjDBlTma7/llYuL5oi/vIwageLGQOTuycosasWWQjTuccIdd/oPyC+ow3Udx2JfVhaok28lU/A2HFK9dDxgI/3pw0EZ6ADBQVKaz/m1sZ7sYSNby6FiGSqRZPGapOW8=
Received: by 10.64.233.12 with SMTP id f12mr2859336qbh;
        Sun, 04 Jun 2006 06:57:25 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 06:57:25 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v3belcicq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21265>

On 6/4/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> >> Sorry, in the example time flows from left to right.  If you
> >> exclude g then you are excluding everything that is reachable
> >> from g so you would not see "f".
> >>
> > From today git:
> >
> > tag list is:
> >
> > v1.3.3 1b9bc5a7b7434d771726011613a00cb202bd9f44
> > v1.3.2 7abd7117ec57b8c3c2a469db62c7811fdac5c655
> > v1.3.1 7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
> > v1.3.0 4baff50551545e2b6825973ec37bcaf03edb95fe
> >
> > selected sha is ccb365047a1081455b767867f0887e7b4334f9d8
> > (Allow "git repack" users to specify repacking window/depth)
> >
> > $ git-rev-list --topo-order ccb365047a1081455b767867f0887e7b4334f9d8
> > ^1b9bc5a7b7434d771726011613a00cb202bd9f44
> > ^7abd7117ec57b8c3c2a469db62c7811fdac5c655
> > ^7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
> > ^4baff50551545e2b6825973ec37bcaf03edb95fe
> >
> > ccb365047a1081455b767867f0887e7b4334f9d8
> > ...
> > cd2bdc5309461034e5cc58e1d3e87535ed9e093b
> >
> > Parent of cd2bdc5309461034e5cc58e1d3e87535ed9e093b is
> >
> > 4baff50551545e2b6825973ec37bcaf03edb95fe
> >
> > aka tag v1.3.0
> >
> > Am I missing something?
>
> No, just that I am not getting what you are trying to prove
> here.  The tags are all older than your chosen commit.
>
> $ git-rev-list --topo-order ^v1.3.0 ^v1.3.1 ^v1.3.2 ^v1.3.3 e923eff
>
> would show nothing -- and you propose to find out that commit is
> between v1.3.1 and v1.3.2 by using the information that the
> command gives an empty result but I do not know how?
>

OK. Now I understand.

I was erroneously thinking that in

$ git-rev-list --topo-order e923eff ^v1.3.0 ^v1.3.1 ^v1.3.2 ^v1.3.3

the listing (and searching) was _starting_ from e923eff, i.e. all the
previous stuff, in our case v1.3.2 and v1.3.3 was never seen neither
filtered out.

Following an extract from git-rev-list documentation.

DESCRIPTION
-----------
Lists commit objects in reverse chronological order *starting at the
given commit(s)*, taking ancestry relationship into account.  This is
useful to produce human-readable log output.

Commits which are stated with a preceding '{caret}' *cause listing to stop at
that point*. Their parents are implied. "git-rev-list foo bar {caret}baz" thus
means "list all the commits which are included in 'foo' and 'bar', but
not in 'baz'".



Perhaps it's me, but I really don't found clear from documentation
that git-rev-list anySha ^HEAD gives _always_ an empty result.

What I understand is that git-rev-list lists _first_ the given commit,
then his parents, then his grandparents and so on _until_ a commit
which is stated with a preceding '{caret}'  is found.
So everything that is between the given commit and HEAD is never found
and ignored.

Is it a problem to change the git-rev-list behaviour to reflect (my
understanding of) documentation or it breaks something?

If I have understood correctly with this change the above proposed
algorithm should work.

    Marco
