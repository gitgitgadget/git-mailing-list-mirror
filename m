Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B312022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdBWS31 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:29:27 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35733 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdBWS30 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:29:26 -0500
Received: by mail-oi0-f51.google.com with SMTP id 62so22016785oih.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=58SrX8qyBkQklREmHniHmnwkgiGI77VgNmIf7zI8EfY=;
        b=q0Qeeze67mKK0j423wRK1YbjUBCC3VEPs8z2FCbPCYFDuqAs5M9gzsTfZqskhviBsN
         VzVhFtfJAF/Ej5npawGBrb9fDxC9l1HMDfjLZBSIvCm5Ed0AgDVtgqAbNKKclNdGDzRP
         BJPPGHLCFaIHxNNbjKua5jLJIusfoi7gfabiNx5Audy2GqqIYgZYWQ84z6XDNtm+fCVB
         2D9bcLDaC5LObbaKQe4M9Eq2BPf92wGFChFOXd7mIiLwGaATHJDayTCl5yOQpJaJK5ml
         x3fKuK16wqNLAjHPyH8TzoiMIsp9x5cyEBVOaBwwTozOIbPe4ZpYjf7MwSEMYR6Yqn1e
         wsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=58SrX8qyBkQklREmHniHmnwkgiGI77VgNmIf7zI8EfY=;
        b=WgSFqAAfUi1/1HNQ0WlfS9D7dJKM1lzcuUlalfLpryPmrm1utaJVzKhWQ8yf50xs77
         MI6E/KwTZ9cBHZhHcJnNxk6zx6terZ9LVxKd4aVKNch8aQKacy5L43WySuS11efSO2rL
         QJNkhPm2yYmnOLe3IVMaC3CfsKEDm5ZMwkSxygkeTfcMGQZ6WChMOpqR6J7+olnXASPO
         LlRWTjEO908zbpmOlf2pXqTpAfgLf5a1he4c4yK2OrHhfGuF1JCd3FzSlv/kD8gJaZyL
         CXehIAW1ByRjax4Kl4CC4xRQpkKETUmBqDr5nTqjMCUGumPgkknQDLFqliiYwZXMKsSL
         o8bw==
X-Gm-Message-State: AMke39kwAISH9AnNyszIel0txUSvJx44rC59BELOJDbtmQO69IO6ueDNTnZ5Jfj7o1NCAXecUq0EbsqjcaGYJg==
X-Received: by 10.202.242.8 with SMTP id q8mr21264105oih.129.1487874550323;
 Thu, 23 Feb 2017 10:29:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 10:29:09 -0800 (PST)
In-Reply-To: <20170223181018.ns4vyosgzmuoyiva@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
 <20170223181018.ns4vyosgzmuoyiva@kitenet.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 10:29:09 -0800
X-Google-Sender-Auth: MQ8tqOA3cIDmHAkRlDH9GG0s6yY
Message-ID: <CA+55aFz98r7NC_3BW_1HU9-0C-HcrFou3=0gmRcS38=-x8dmVw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 10:10 AM, Joey Hess <id@joeyh.name> wrote:
>
> It would cost 6500 CPU years + 100 GPU years to generate valid colliding
> git objects using the methods of the paper's authors. That might be cost
> effective if it helped get a backdoor into eg, the kernel.

I still think it also needs to be interesting enough data, not just
random noise that is then trivial to find with automated tools.

Because for the kernel, it's not just that an attacker needs to do the
CPU time. Yes, first he needs the technical resources to just do just
the attack and create the situation you described.

But then he *also* needs to build up the social capital to get the end
result pulled into the tree (ie if he depends on the hidden spaces, he
needs somebody to actually do a git pull, not just apply a patch).

.. and if we then have a tool that then finds the problem trivially
(ie "git fsck"), he's not only wasted all those technical resources,
he's also burned his identity.

>>  (b) we can probably easily add some extra sanity checks to the opaque
>> data we do have, to make it much harder to do the hiding of random
>> data that these attacks pretty much always depend on.
>
> For example, git fsck does warn about a commit message with opaque
> data hidden after a NUL. But, git show/merge/pull give no indication
> that something funky is going on when working with such commits.

I do agree that we might want to do some of the fsck checks
particularly at fetch time. That's when doing checks is both relevant
and cheap.

So we could do the opaque data checks, but we could/should probably
also add the attack pattern ("disturbance vectors") checks.

And the thing is, adding those checks is really cheap, and basically
makes the whole attack vector pointless against git.

Because unlike some "signing a pdf" attack, git doesn't fundamentally
depend on the SHA1 as some kind of absolute security.  If we have the
minimal machinery in git to just notice the attack, the attack
essentially goes away. Attackers can waste infinite amounts of CPU
time, and if it's cheap for us to notice, it completely disarms all
that attack work.

Again, I'm not arguing that people shouldn't work on extending git to
a new (and bigger) hash. I think that's a no-brainer, and we do want
to have a path to eventually move towards SHA3-256 or whatever.

But I'm very definitely arguing that the current attack doesn't
actually sound like it really even _matters_, because it should be so
easy to mitigate against.

                   Linus
