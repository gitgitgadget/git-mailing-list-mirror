Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4832022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdBWTJk (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:09:40 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:34019 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdBWTJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:09:39 -0500
Received: by mail-ot0-f179.google.com with SMTP id x10so235279otb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r+eJNRlpPaVxd+houH1Hx0TGEBGdwzWN5PdHpkKuIQU=;
        b=YZrqfi7T7gEXmN/kFsGzxBDzDdWRlRvEMxEgtBkNk+Ahj5e910zcctTkWbkc6uCAQL
         PtF07WCF4WSLp3FUBOLTc07258fDs1hydctZWt9UWlTe9IbWJTOBu1hwTZ/x1jG5I9JO
         VrllLvpX7iLuuarmoMF1SAMRFeyxh9QJst97nrtXPRdlN6SOc4HpdnQeuxRN7X9KHsHZ
         foQKoVQT5NZDElrR88rqQbHyDwq9357qI1ks/j95+4zgLN1IN7Q9cat84tLAEWuC40Hr
         bnsXXj7BC0qo/6+1dwxuwR/6OddxigbplFHBW018f++TeL9eBN7fZmIt1joErR34u4xp
         mqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r+eJNRlpPaVxd+houH1Hx0TGEBGdwzWN5PdHpkKuIQU=;
        b=nAnoMKQwFJefLntJ84Rw9eOuhcwYZUesTFacvGcojl3fhzn9MyTkjfn8zxjrUth0pn
         Sxoh5YsVLtdSnCl9hoJ9c2xZv2TzCC7BscI+dxNxzoSbfx07wEVc6qd3sEtHUecdKjGD
         19OJMmmbH0J41Gx+AFPmrfGrIT8+wK6M/Mwak8Rinh7BRhw4d83OOzKD4A503QlqkUzI
         P+9LbFCeHWvox7gwIfMQVsgB/Eh9Psr5ha7fR5szjJCKjRIbpq9EUDG6SaX5WeKCa8VI
         PlAl/0QNx6oWLxnor7syYI0SCavTvpilisMiWoNnmTvP5q3a4kAXxR8oF1hNdWbfXHfZ
         Hn6A==
X-Gm-Message-State: AMke39lfS9483RLP0g8hWRpCJu0ZYiPshpKJ9ZgrH+vVAwQ9kDHROUhnjn7xAblM+Njitswh9gl1bBys7oevDA==
X-Received: by 10.157.41.135 with SMTP id n7mr19089565otb.165.1487876973128;
 Thu, 23 Feb 2017 11:09:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 11:09:32 -0800 (PST)
In-Reply-To: <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net> <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 11:09:32 -0800
X-Google-Sender-Auth: sAVjVFqiaq8diH-HDYxdiNmbADE
Message-ID: <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 10:46 AM, Jeff King <peff@peff.net> wrote:
>>
>> So I agree with you that we need to make git check for the opaque
>> data. I think I was the one who brought that whole argument up.
>
> We do already.

I'm aware of the fsck checks, but I have to admit I wasn't aware of
'transfer.fsckobjects'. I should turn that on myself.

Or maybe git should just turn it on by default? At least the
per-object fsck costs should be essentially free compared to the
network costs when you just apply them to the incoming objects.

I also do think that it would be good to check for the disturbance
vectors at receive time (and fsck). Not necessarily interesting during
normal operations.

And in particular, while the *kernel* doesn't generally have critical
opaque blobs, other projects do. Things like firmware images etc are
open to attack, and crazy people put ISO images in repositories etc.

So I don't think this discussion should focus exclusively on the git metadata.

It is likely much easier to replace a binary blob than it is to
replace a commit or tree (or a source file that has to go through a
compiler). And for many projects, that would be a bad thing.

> It's not an identical prefix, but I think collision attacks generally
> are along the lines of selecting two prefixes followed by garbage, and
> then mutating the garbage on both sides. That would "work" in this case
> (modulo the fact that git would complain about the NUL).

I think this particular attack depended on an actual identical prefix,
but I didn't go back to the paper and check.

But the attacks tend to very much depend on particular input bit
patterns that have very particular effects on the resulting
intermediate hash, and those bit patterns are specific to the hash and
known.

So a very powerful defense is to just look for those bit patterns in
the objects, and just warn about them. Those patterns don't tend to
exist in normal inputs anyway, but particularly if you just warn, it's
a heads-ups that "ok, something iffy is going on"

And as mentioned, a cheap "something iffy is going on" thing is
basically a death sentence to SCM attacks.

The whole _point_ of an SCM is that it isn't about a one-time event,
but about continuous history. That also fundamentally means that a
successful attack needs to work over time, and not be detectable.

In contrast, many other uses of hashes are "one-time" events.  If you
use a hash to validate a single piece of data from a source that you
wouldn't otherwise trust, it's a one-time "all or nothing" trust
situation.

And the attack surface is very different for those "one-time" vs
"trust over time" cases. If you can get a bank to trust a session one
time, you can empty a bank account and live on a paradise island for
the rest of your life. It doesn't matter if it gets detected or not
after-the-fact.

But if you can fool a SCM one time, insert your code, and it gets
detected next week, you didn't actually do anything useful. You only
burned yourself.

See the difference? One-time vs having a continual interaction makes a
*fundamntal* difference in game theory.

                Linus
