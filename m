X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Rationale for the "Never commit to the right side of a Pull line" rule
Date: Fri, 27 Oct 2006 01:56:00 -0700 (PDT)
Message-ID: <546144.34624.qm@web31811.mail.mud.yahoo.com>
References: <ehqp1u$j4$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 27 Oct 2006 08:57:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=2XVU1o70NG88w3t81Kk6j5dy+kNnDTOV2IuaNkzmNxq7LYAJpvKp36tQPVcmzp3g4RhgEwOU5j2K2Qtdqhu/9qmw4QZRDcbYeiiUZQnrQE86AyiZBlv6IBrqWFr8WgN+IpX2D+qL5uNWvwWrmyVllrDyrbKKuB/8Ed6b+QCst/k=  ;
X-YMail-OSG: atp5SsUVM1lvXV2Gu0q0ueF1CjV9IXD5hv3M1QE1CGvzaXra9MHU1m60qMJzNAn5HMJ3yuZRliYPon3Q8I.V0apFLFLhkaoZhRHt7PLqRII4dqrCyWjqEHXCcfok7oG4iNF2hELJ3coV24M-
In-Reply-To: <ehqp1u$j4$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30310>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdNVh-0000cT-GP for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946001AbWJ0I4E convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006 04:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWJ0I4D
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:56:03 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:15528 "HELO
 web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S965257AbWJ0I4B
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:56:01 -0400
Received: (qmail 34637 invoked by uid 60001); 27 Oct 2006 08:56:00 -0000
Received: from [71.80.233.118] by web31811.mail.mud.yahoo.com via HTTP; Fri,
 27 Oct 2006 01:56:00 PDT
To: t2a2e9z8ncbs9qg@brefemail.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com> wrote:
> Hi,
>=20
> Could someone please point me to / give me the rationale for the "Nev=
er=20
> commit to the right side of a Pull line" rule ?
>=20
> I found the rule in the second Note of the git-fetch man-page (eg=20
> http://www.kernel.org/pub/software/scm/git/docs/git-fetch.html).
>=20
> It's been taken over in _bold letters_ by X.Org/freedesktop.org in th=
eir=20
> "UsingGit" document (http://freedesktop.org/wiki/UsingGit).
>=20
> In both places though, I don't see any explanation, but rather a=20
> commandment ;-) . Am I missing the ovious ?

Yes, you are missing the obvious and yes it is explained.
Read the 2nd "Note" for the documentation of "git-fetch":

http://www.kernel.org/pub/software/scm/git/docs/git-fetch.html

Quoted here for convenience:

[NOTE]
You never do your own development on branches that appear
on the right hand side of a <refspec> colon on `Pull:` lines;
they are to be updated by `git-fetch`.  If you intend to do
development derived from a remote branch `B`, have a `Pull:`
line to track it (i.e. `Pull: B:remote-B`), and have a separate
branch `my-B` to do your development on top of it.  The latter
is created by `git branch my-B remote-B` (or its equivalent `git
checkout -b my-B remote-B`).  Run `git fetch` to keep track of
the progress of the remote side, and when you see something new
on the remote branch, merge it into your development branch with
`git pull . remote-B`, while you are on `my-B` branch.
The common `Pull: master:origin` mapping of a remote `master`
branch to a local `origin` branch, which is then merged to a
local development branch, again typically named `master`, is made
when you run `git clone` for you to follow this pattern.

  Luben


>=20
> My candid thoughts: to me the practice recommended here seems=20
> subjectively "cleaner" indeed, but is it objectively better or even=20
> essential? Why?
>=20
> TIA
> J=E9r=F4me
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
