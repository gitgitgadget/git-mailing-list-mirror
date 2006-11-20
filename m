X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Feature request: git-pull -e/--edit
Date: Mon, 20 Nov 2006 14:09:50 -0300
Message-ID: <200611201709.kAKH9or1012062@laptop13.inf.utfsm.cl>
References: <git2eran@tromer.org>
NNTP-Posting-Date: Mon, 20 Nov 2006 17:10:22 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Eran Tromer <git2eran@tromer.org> 
   of "Mon, 20 Nov 2006 15:42:13 +0200." <4561B0B5.1020305@tromer.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 20 Nov 2006 14:09:50 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31923>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmCev-0000Kt-Bq for gcvg-git@gmane.org; Mon, 20 Nov
 2006 18:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966223AbWKTRKK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966225AbWKTRKK
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 12:10:10 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8379 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S966223AbWKTRKI (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 12:10:08 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kAKH9ob2025220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Mon, 20
 Nov 2006 14:09:50 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAKH9or1012062; Mon, 20
 Nov 2006 14:09:50 -0300
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

Eran Tromer <git2eran@tromer.org> wrote:

[...]

> What about fast forwards? Do you get to record the explanation for the
> series only if the guy you pulled from didn't bother to do a rebase?
> That's broken.
> 
> Let's face it, the merge commits generated when pulling have two
> completely independent uses:
> 1. They're technically necessary for joining DAG nodes that don't all
>    lie on one path.
> 2. They're useful as a record of workflow and a place to put comments.
> 
> The two uses are nearly independent.
> Consider the following silly DAG.
> 
>   A------------F master
>    \          /
>     B--C--D--E
> 
> Yes, E and F have identical trees. But it's actually *very useful*, if
> the commit message at F says "merged branch foo containing experimental
> bar from quux". And it shows up nicely when looking at gitk.

I don't see the usefulness of this. 

> Of course, you could just fast-forward instead:
> 
>   A--B--C--D--E master

Yep.

> but then you lose a meaningful and useful part of the historical record.

And if quux merges back, she gets the same plus a new merge node, and...
Linus told everybody (quite forcefully, I might add) that this is not
acceptable for distributed development.

> There are the obvious bad consequences if you make this the default,
> but how about adding a --force-commit option to merge and pull?

Fast forward is fast forward. Merge is when /independent/ changes are
integrated into one.

> You'd need to educate users on how to use this responsibly

Looks like you've never met real users ;-)

>                                                            to avoid
> noise, but that's not any different from existing stuff like rebase and
> revert. Most users won't even know it exists.

> And to answer Linus: yes, it's expected that only non-leaf developers
> will use --force-commit on regular basis, but that's not because
> maintainers are technically special in any way. It's just because
> maintainers have something useful to say ("someone's private topic
> branch, starting at A and ending at E, has just been accepted into my
> all-important public repo and here's why"). Anyone else can do the same
> if he feels likewise.

But the individual changes will presumably reflect said someone's
authorship. If they are interleaved with stuff by others or not doesn't
make much (development) sense. Yes, it might be interesting for a software
historian, but that's not git's main audience in the first place.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
