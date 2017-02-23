Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0232022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdBWSBE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:01:04 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:32917 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdBWR7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:59:40 -0500
Received: by mail-ot0-f176.google.com with SMTP id k4so29190709otc.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=INnyEcaHW3NmlVR6m1ui3lH3LEQNIyWa70fUrQqYreg=;
        b=XEHNf51D7bsE11Jnmv0VUAsU8e5ECbUAFLswpmZh4vKYFXF5NxEgGMtjtUsL2TCmrS
         YkzptXgqTomuuZmSUawDwfoZadJZLfIHUVkIA7UAxYQXZrhnC911G+WNUqe7SSlHuYS2
         CyPjBWzmE2j9piwURK/RDkMO5OiiIY+VRu7VTaJM7gS9HGpJ//dQJKU4v89sThEhZH8b
         57/W5sqQxusYyyT8w1hyduKI62xFmXJBvuJxEruDhwQymLIytDuOdbIthBektUmnD8nR
         V+eUGxOCJY2CKHo1PhDPqiZcEXryRZsj90pGep/ac/fLuorjorIHGwN/fCGUJR30eb5L
         nVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=INnyEcaHW3NmlVR6m1ui3lH3LEQNIyWa70fUrQqYreg=;
        b=uDO5qLAsbnAMDp27t2kOfARHdgDoROvT2htGY2VsUSqSCsJfox1TufGflARdeLfdMV
         n4+Wf64ZCYAiEdtzSe2UIWh+6gg8yqr5XR8lNVvpz5ZSMaHppNQY4cAnthVgfK6i/0I9
         KgoEcVbOIVyOst+jWBF6Wd0taJgs/faEGOv1VSWe7Gb9WBstINkyNcyyoaLxmvU1QfvH
         t28PkaPWl2bcI8pa8+klaI8DUTaeWkcaIFS2p/ZDa5QN3hgZlTZkSREyqHQfHTYf3lZ+
         s+0iSTmJ8rQhodnnfJERGAioIo2vCHWIAw7iErAJ9BRBKtR0JVagdPy+3Hx7pI3ubcIK
         Sf/Q==
X-Gm-Message-State: AMke39nxnuQRODv/s7eOIKdsF53jYaUxhbXrIPtNeC3VW2gxhOMsdVmXff4kiWuO+8x3Rya04TtILbYYyx5VsA==
X-Received: by 10.157.45.194 with SMTP id g60mr18973243otb.87.1487872356719;
 Thu, 23 Feb 2017 09:52:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 09:52:36 -0800 (PST)
In-Reply-To: <20170223173547.qljypk7sdqi37oha@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 09:52:36 -0800
X-Google-Sender-Auth: SIJs2eu9XC1btpvOlWEqRG0KV7E
Message-ID: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 9:35 AM, Joey Hess <id@joeyh.name> wrote:
>
> Attacks using this SHA1 break will look something more like:

We don't actually know what the break is, but it's likely that you
can't actually do what you think you can do:

> * I push a "bad" object to a repo on github I set up under a
>   pseudonym.
> * I publish a "good" object in a commit and convince the maintainer to
>   merge it.

It's not clear that the "good" object can be anything sane.

What you describe pretty much already requires a pre-image attack,
which the new attack is _not_.

The new attack doesn't have a controlled "good" case, you need two
different objects that both have "near-collision" blocks in the
middle. I don't know what the format of those near-collision blocks
are, but it's a big problem.

You blithely just say "I create a good object". It's not that simple.
If it was, this would be a pre-image attack.

So basically, the attack needs some kind of random binary garbage in
*both* objects in the middle.

That's why pdf's are the classic model for showing these attacks: it's
easy to insert garbage in the middle of a pdf that is invisible.

In a psf, you can just define a bitmap that you don't use for printing
- but you can use them to then make a decision about what to print -
making the printed version of the pdf look radically different in ways
that are not so much _directly_ about the invisible block itself.

              Linus
