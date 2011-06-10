From: NAKAMURA Takumi <geek4civic@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 10 Jun 2011 12:59:47 +0900
Message-ID: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
	<BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
	<BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
	<4DF0EC32.40001@gmail.com>
	<BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
	<20110609162604.GC25885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 05:59:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUst0-0001QW-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 05:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab1FJD7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 23:59:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44667 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1FJD7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 23:59:49 -0400
Received: by wya21 with SMTP id 21so1576840wya.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZYFVMQl0mJjl9Y+PIdODTIxIhaxVmDMzGWKsmi2aFtg=;
        b=xjGPDPayPLsnSvOB/fBvn286bulGUwYBDAjEKuicM60tZn2T5wT8xM1lWWysKFOwqB
         qSZ2nGBGiKSZLNHfsnSsk2jEiksGmGBE/iie13Ual4N4Ts2LUJUROnKXb679LePmjcZh
         cSDNMolGs5URAiZy+2AgA72pvFxWYNaG8ZxjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D+3qMq+d7eafHDwEjgMRTmWfo7nWYLSkOkKTfR2lexrXTcEX+IZnWPTYtGu2uYcCP1
         vFOIjtr7EhqdyYkvRdsCEIYDssQf6SM4E4dF+opSP8OaYJYWz97gUjNySkcaDZDbwRkU
         liSKEmVy8zYYgqbX2VwHRf/v/0whuEpfIrdCg=
Received: by 10.227.208.85 with SMTP id gb21mr1584963wbb.14.1307678387818;
 Thu, 09 Jun 2011 20:59:47 -0700 (PDT)
Received: by 10.227.54.76 with HTTP; Thu, 9 Jun 2011 20:59:47 -0700 (PDT)
In-Reply-To: <20110609162604.GC25885@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175595>

Good afternoon Git! Thank you guys to give me comments.

Jakub and Shawn,

Sure, Notes should be used at the case, I agree.

> (eg. git log --oneline --decorate shows me each svn revision)

My example might misunderstand you. I intended tags could show me
pretty abbrev everywhere on Git. I would be happier if tags might be
available bi-directional alias, as Stephen mentions.

It would be better git-svn could record metadata into notes, I think, t=
oo. :D

Stephen,

2011/6/10 Stephen Bash <bash@genarts.com>:
> I've seen two different workflows develop:
> =A01) Hacking on some code in Git the programmer finds something wron=
g. =A0Using Git tools he can pickaxe/bisect/etc. and find that the prob=
lem traces back to a commit imported from Subversion.
> =A02) The programmer finds something wrong, asks coworker, coworker s=
ays "see bug XYZ", bug XYZ says "Fixed in r20356".
>
> I agree notes is the right answer for (1), but for (2) you really wan=
t a cross reference table from Subversion rev number to Git commit.

It is the point I wanted to say, thank you! I am working with svn-men.
They often speak svn revision number. (And I have to tell them svn
revs then)

> In our office we created the cross reference table once by walking th=
e Git tree and storing it as a file (we had some degenerate cases where=
 one SVN rev mapped to multiple Git commits, but I don't remember the d=
etails), but it's not really usable from Git. =A0Lightweight tags would=
 be an awesome solution (if they worked). =A0Perhaps a custom subcomman=
d is a reasonable middle ground.

Reconstructing svnrev-commits mapping can be done by git-svn itself.
Unfortunately, git-svn's .rev-map is sorted by revision number. I
think it would be useless to make subcommands unless they were
pluggable into Git as "smart-tag resolver".

Peff,

At first, thank you to work for Github! Awesome!
I didn't know Github has refs issues. (yeah, I should not push 100k of
tags to Github for now :p )

I am working on linux and windows. Many-refs-repo can make Git awfully
slow (than linux!) I hope I could work also for windows to improve
various performance issue.

=46YI, I have tweaked git-rev-list for commits not to sort by date with
--quiet. It improves git-fetch (git-rev-list --not --all) performance
when objects is well-packed.


=2E..Takumi
