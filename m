Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8FD1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 16:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeC3QgI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 12:36:08 -0400
Received: from mail.javad.com ([54.86.164.124]:57269 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbeC3QgG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 12:36:06 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 72E963E9A4;
        Fri, 30 Mar 2018 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427766;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=TiSUnWMMUzjQzXX6SFtcj+KBVK/EwerwqNyNhDGlYNjc10Y9lY8TS/VUN6f8VGBuo
         dpJCMSm3rmVVQcOHgHzx6qYmnQsSJvVLpgCW8LBk74yiLQVYKDlU2iF3JjI73n+7AY
         6uwzFsHcWkVxKoEDSDzaknWNaYWsfVGlAx37hYc8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427766;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=TiSUnWMMUzjQzXX6SFtcj+KBVK/EwerwqNyNhDGlYNjc10Y9lY8TS/VUN6f8VGBuo
         dpJCMSm3rmVVQcOHgHzx6qYmnQsSJvVLpgCW8LBk74yiLQVYKDlU2iF3JjI73n+7AY
         6uwzFsHcWkVxKoEDSDzaknWNaYWsfVGlAx37hYc8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427765;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=CJga/yAoVAtTDLhw13GuEMkEaP4qaaJaZTWJLO4/xkpXUj+RuzHWTZ01isDrTE0Kq
         kJQp2yv85EXJB0eSeb4pMm3ECd+4Lujqmae7taaiIF5uO6QLmdQCrj3WlHd+Lh5SRQ
         eI+wtXHGwZGOR/fvbENIF6rWt+rwWD+IINWOYOak=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427765;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=CJga/yAoVAtTDLhw13GuEMkEaP4qaaJaZTWJLO4/xkpXUj+RuzHWTZ01isDrTE0Kq
         kJQp2yv85EXJB0eSeb4pMm3ECd+4Lujqmae7taaiIF5uO6QLmdQCrj3WlHd+Lh5SRQ
         eI+wtXHGwZGOR/fvbENIF6rWt+rwWD+IINWOYOak=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427765;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=CJga/yAoVAtTDLhw13GuEMkEaP4qaaJaZTWJLO4/xkpXUj+RuzHWTZ01isDrTE0Kq
         kJQp2yv85EXJB0eSeb4pMm3ECd+4Lujqmae7taaiIF5uO6QLmdQCrj3WlHd+Lh5SRQ
         eI+wtXHGwZGOR/fvbENIF6rWt+rwWD+IINWOYOak=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427765;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=CJga/yAoVAtTDLhw13GuEMkEaP4qaaJaZTWJLO4/xkpXUj+RuzHWTZ01isDrTE0Kq
         kJQp2yv85EXJB0eSeb4pMm3ECd+4Lujqmae7taaiIF5uO6QLmdQCrj3WlHd+Lh5SRQ
         eI+wtXHGwZGOR/fvbENIF6rWt+rwWD+IINWOYOak=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522427765;
        bh=M07lrkG/4yXOjqwifjg3qGtSqZCu5NfnGW0OV3FILPI=; l=3359;
        h=Received:From:To:Subject;
        b=CJga/yAoVAtTDLhw13GuEMkEaP4qaaJaZTWJLO4/xkpXUj+RuzHWTZ01isDrTE0Kq
         kJQp2yv85EXJB0eSeb4pMm3ECd+4Lujqmae7taaiIF5uO6QLmdQCrj3WlHd+Lh5SRQ
         eI+wtXHGwZGOR/fvbENIF6rWt+rwWD+IINWOYOak=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f1x0V-0002bV-DE; Fri, 30 Mar 2018 19:36:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
        <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
        <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
        <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87woxyf4lk.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87605gd9oy.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803301537250.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 19:36:03 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803301537250.5026@qfpub.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 30 Mar 2018 15:41:16 +0200
        (DST)")
Message-ID: <87h8oxwmfg.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Wed, 28 Mar 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > I use rebase every day. I use the Git garden shears every week. If you
>> > do not trust my experience with these things, nothing will convince
>> > you. 
>> 
>> Unfortunately you have exactly zero experience with rebasing merges as
>> you've never actually rebased them till now, and it's rebasing merges
>> that matters in this particular discussion.
>
> Who says that I have 0 experience with that? Oh yes, you do. Like, as if
> you know.

I just didn't see even single symptom of it in the discussion, still I
said nothing about it until you started to use your presumed experience
in place of true arguments.

> Guess what I do with those Git garden shears' merges? Can you guess? Of
> course you can. But you'll never know until I tell you. It is a little
> silly to try to tell me that I do not have any experience with rebasing
> merges when you have no idea what strategies I tried in the past.

Please notice that I never even started to discuss your 'merge'
directive, exactly because I believe you have huge experience both
implementing and using it that could be relied upon. Just don't mix-in
rebasing merge commits into it, as that is fundamentally different
operation.

And the other unspoken strategies you tried are irrelevant here, as you
declined the whole idea of replaying merge-the-commit instead of
replaying merge-the-operation until recently, and it seems you still do,
at least to some level, by attempting to use 'merge' operation to replay
"the (merge) _commit_". I'm afraid that whatever you've tried in the
past likely suffered from the same conceptual confusion, and thus did
not work indeed.

That said, negative experience is still an experience, often helpful,
but what is relevant here is that it likely was not about rebasing merge
commits at all, so trying to use this irrelevant experience in the
discussion to support your arguments, or rather lack of them, seems even
more unfair to me then using relevant experience for that purpose.

> Now, Phillip's strategy is clearly the best strategy I ever heard
> about,

For 'pick' vs 'merge', it's not about strategy, it's about concept. It
looks like you still believe that you somehow "merge" a merge commit
when you actually rebase it (with Phillip's strategy if you wish). You
don't merge it anywhere, period.

> and I am in the process of doing Actual Work to Put It To The Test.

That's the best outcome of the discussion I ever hoped for, seriously,
and I'll be all ears to listen to the outcomes of the experience you
will gain with it.

BTW, when you have it working, use the strategy you've implemented for
non-merge commits as well, as a good one should still work fine.
Moreover, it should better bring exactly the same results as the default
existing strategy being used for non-merge commits, even in conflicting
situations.

Hopefully /that/ experience will finally push you strong enough to get
the concept right, and you will finally understand that what you've 
implemented is nothing else but a _cherry-pick_ of a _merge commit_,
that reads simply _pick_, for brevity.

-- Sergey
