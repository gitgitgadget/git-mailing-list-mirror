Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFF82013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdCCCnz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:43:55 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:34976 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdCCCnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:43:52 -0500
Received: by mail-io0-f180.google.com with SMTP id z13so22297715iof.2
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 18:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=G0ROl1GQSxU4PFXvPIh80LD9pi1Fg6gvgn0ghQbo6yM=;
        b=fJGbb89L90CzzW0cXKNmo5deq/cF1KO0s0jT3DREhlTGyP4gGsVOPWS1JMuhtXhsED
         GGcUlZzBm/pXHv60eKBBB90zAul7rF2FP0nfVzsLoBo2IaLH92akOfGy/fO8YqfFnQLo
         SxHFcQock7Togj/HY95/U5gc+Kh3pKZou4saegy0yw5nc14mRChyR7s4SG/GFLO/OTJZ
         cA0Txm9lg8NHfePhvpr4txTLm/nZJuhSIH/k5ClbxNE2yzU2nBdJ1GXQUH7KlMn0bwZN
         k7I0E5pb9Elkjx1co06oMFtZCeyby5E+c+DocodNXPrctumlLzrlp0wu8I416YpPS2cr
         IYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=G0ROl1GQSxU4PFXvPIh80LD9pi1Fg6gvgn0ghQbo6yM=;
        b=Nj0XwHEGDS0u1vs+GzHuUn/lWVoY5dYwsBM+WVZZSpfuSliYJ/EEz+BhG6da99xhjd
         ZnyFWodD7yBkJM8DdJfBbK4HYsoxxo4r6C2YPfwfPN8DvnPFzKBAE6VejTGcumwSbXM4
         o2dgbp5l4gt0YHh/B0i9MsrHstakgN+nDQred2VQsimoEkz+5EBWtQsU8UMDpNzLWNRA
         SP4a8b9uvbskC+kJQuWISTWgcVH0hv1ui9tt7osqyCNB71kaXkDuesp6KKqSBLehqEz/
         4pkJJ8dTFzfUmZC6SA6Vh3yqqMuJaOwWw8j1KixmX7FGJjH3EbHLzl9oF8yNPT1MjQbD
         oGIA==
X-Gm-Message-State: AMke39lAaN3E3YVzThx7g91gVoo3hCaPwcTOBxfg7hxjAEl+tTWovDXDgxdNaypVfefdQrV6CTKHAaor2HA7qg==
X-Received: by 10.107.178.137 with SMTP id b131mr816406iof.50.1488507548232;
 Thu, 02 Mar 2017 18:19:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Thu, 2 Mar 2017 18:19:07 -0800 (PST)
In-Reply-To: <20170303015047.p4lpkdzp4hbpz5vi@glandium.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
 <xmqqk287be9l.fsf@gitster.mtv.corp.google.com> <CA+55aFziZRA29foAMbM-HS5fiup7T0TuYf4XQ1kNT_SR7FfSgw@mail.gmail.com>
 <20170302215457.l2zhxgnvhulw2hl5@kitenet.net> <CA+55aFzdJcFZQdJ78rvZ92nNZRsKfcUKMCiXwTVYR34JAuznrA@mail.gmail.com>
 <20170303015047.p4lpkdzp4hbpz5vi@glandium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2017 18:19:07 -0800
X-Google-Sender-Auth: kYfCs7Q7kn6_HtAdGmJKJw8m11U
Message-ID: <CA+55aFyTXodj=EpEu0GNpcNak3GMCMyq7w0_SnzdcU3VKQAsgQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Mike Hommey <mh@glandium.org>
Cc:     Joey Hess <id@joeyh.name>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 5:50 PM, Mike Hommey <mh@glandium.org> wrote:
>
> What if the "object version" is a hash of the content (as opposed to
> header + content like the normal git hash)?

It doesn't actually matter for that attack.

The concept of the attack is actually fairly simple: generate a lot of
collisions in the first hash (and they outline how you only need to
generate 't' serial collisions and turn them into 2**t collisions),
and then just check those collisions against the second hash.

If you have enough collisions in the first one, having a collision in
the second one is inevitable just from the birthday rule.

Now, *In*practice* that attack is not very easy to do. Each collision
is still hard to generate. And because of the git object rules (the
size has to match), it limits you a bit in what collisions you
generate.

But the fact that git requires the right header can be considered just
a variation on the initial state to SHA1, and then the additional
requirement might be as easy as just saying that your collision
generation function just always needs to generate a fixed-size block
(which could be just 64 bytes - the SHA1 blocking size).

So assuming you can arbitrarily generate collisions (brute force:
2**80 operations) you could make the rule be that you generate
something that starts with one 64-byte block that matches the git
rules:

   "blob 6454\0"..pad with repeating NUL bytes..

and then you generate 100 pairs of 64-byte SHA1 collisions (where the
first starts with the initial value of that fixed blob prefix, the
next with the state after the first block, etc etc).

Now you can generate 2**100 different sequences that all are exactly
6464 bytes (101 64-byte blocks) and all have the same SHA1 - all all
share that first fixed 64-byte block.

You needed "only" on the order of 100 * 2**80 SHA1 operations to do
that in theory.

An since you have 2**100 objects, you know that you will have a likely
birthday paradox even if your secondary hash is 200 bits long.

So all in all, you generated a collision in on the order of 2**100 operations.

So instead of getting the security of "160+200" bits, you only got 200
bits worth of real collision resistance.

NOTE!! All of the above is very much assuming "brute force". If you
can brute-force the hash, you can completely break any hash. The input
block to SHA1 is 64 bytes, so by definition you have 512 bits of data
to play with, and you're generating a 160-bit output: there is no
question what-so-ever that you couldn't generate any hash you want if
you brute-force things.

The place where things like having a fixed object header can help is
when the attack in question requires some repeated patterns. For
example, if you're not brute-forcing things, your attack on the hash
will likely involve using very particular patterns to change a number
of bits in certain ways, and then combining those particular patterns
to get the hash collision you wanted.  And *that* is when you may need
to add some particular data to the middle to make the end result be a
particular match.

But a brute-force attack definitely doesn't need size changes. You can
make the size be pretty much anything you want (modulo really small
inputs, of course - a one-byte input only has 256 different possible
hashes ;) if you have the resources to just go and try every possible
combination until you get the hash you wanted.

I may have overly simplified the paper, but that's the basic idea.

               Linus
