Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A6D1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeBSF2u (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 00:28:50 -0500
Received: from mail.javad.com ([54.86.164.124]:60953 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbeBSF2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 00:28:49 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 59F213E89E;
        Mon, 19 Feb 2018 05:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519018128;
        bh=l5dNI5TR5qnTa56wlmZE6aW4rWYhEND3fx93VASyuRo=; l=2285;
        h=Received:From:To:Subject;
        b=c7TIwpqS+NL2wUrFFNcKmu+SRnTk7MnOMFobg7C4yJXRIP4TsMaTgA4Q+w9jTrPsg
         5YyubosN5W/suDpgUYI7132O6D7DFewMt2Pl7WZwg0HU/xypladqs/LWmvfhpS5MBt
         5MER1Vk4sv4Bvqnu0IQdynXO0obk14AjyJbcC86w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519018128;
        bh=l5dNI5TR5qnTa56wlmZE6aW4rWYhEND3fx93VASyuRo=; l=2285;
        h=Received:From:To:Subject;
        b=c7TIwpqS+NL2wUrFFNcKmu+SRnTk7MnOMFobg7C4yJXRIP4TsMaTgA4Q+w9jTrPsg
         5YyubosN5W/suDpgUYI7132O6D7DFewMt2Pl7WZwg0HU/xypladqs/LWmvfhpS5MBt
         5MER1Vk4sv4Bvqnu0IQdynXO0obk14AjyJbcC86w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519018128;
        bh=l5dNI5TR5qnTa56wlmZE6aW4rWYhEND3fx93VASyuRo=; l=2285;
        h=Received:From:To:Subject;
        b=c7TIwpqS+NL2wUrFFNcKmu+SRnTk7MnOMFobg7C4yJXRIP4TsMaTgA4Q+w9jTrPsg
         5YyubosN5W/suDpgUYI7132O6D7DFewMt2Pl7WZwg0HU/xypladqs/LWmvfhpS5MBt
         5MER1Vk4sv4Bvqnu0IQdynXO0obk14AjyJbcC86w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519018128;
        bh=l5dNI5TR5qnTa56wlmZE6aW4rWYhEND3fx93VASyuRo=; l=2285;
        h=Received:From:To:Subject;
        b=c7TIwpqS+NL2wUrFFNcKmu+SRnTk7MnOMFobg7C4yJXRIP4TsMaTgA4Q+w9jTrPsg
         5YyubosN5W/suDpgUYI7132O6D7DFewMt2Pl7WZwg0HU/xypladqs/LWmvfhpS5MBt
         5MER1Vk4sv4Bvqnu0IQdynXO0obk14AjyJbcC86w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519018128;
        bh=l5dNI5TR5qnTa56wlmZE6aW4rWYhEND3fx93VASyuRo=; l=2285;
        h=Received:From:To:Subject;
        b=c7TIwpqS+NL2wUrFFNcKmu+SRnTk7MnOMFobg7C4yJXRIP4TsMaTgA4Q+w9jTrPsg
         5YyubosN5W/suDpgUYI7132O6D7DFewMt2Pl7WZwg0HU/xypladqs/LWmvfhpS5MBt
         5MER1Vk4sv4Bvqnu0IQdynXO0obk14AjyJbcC86w=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ene0M-000346-LS; Mon, 19 Feb 2018 08:28:46 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <CA+P7+xrgmSHv-coOdUAmBm31Sd0DzYdoez=tVO8drew9q7DExw@mail.gmail.com>
Date:   Mon, 19 Feb 2018 08:28:46 +0300
In-Reply-To: <CA+P7+xrgmSHv-coOdUAmBm31Sd0DzYdoez=tVO8drew9q7DExw@mail.gmail.com>
        (Jacob Keller's message of "Sat, 17 Feb 2018 20:16:34 -0800")
Message-ID: <87a7w5r1ip.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

Jacob Keller <jacob.keller@gmail.com> writes:
> On Fri, Feb 16, 2018 at 5:08 AM, Sergey Organov <sorganov@gmail.com> wrote:
>> Hi,
>>
>> By accepting the challenges raised in recent discussion of advanced
>> support for history rebasing and editing in Git, I hopefully figured out
>> a clean and elegant method of rebasing merges that I think is "The Right
>> Way (TM)" to perform this so far troublesome operation. ["(TM)" here has
>> second meaning: a "Trivial Merge (TM)", see below.]
>>
>> Let me begin by outlining the method in git terms, and special thanks
>> here must go to "Johannes Sixt" <j6t@kdbg.org> for his original bright
>> idea to use "cherry-pick -m1" to rebase merge commits.
>>
>> End of preface -- here we go.
>>
>
> I hope to take a more detailed look at this, also possibly with some
> attempts at re-creating the process by hand to see it in practice.

Thank you for your interest and for the review, and yes, some testing is
what the idea desperately needs. Unfortunately I don't have much time
for it right now, nor am I fluent enough in git internals to actually
make even a raw prototype really soon, sorry. Anybody who is interested
is very welcome to volunteer!

[...]
>
> This might be a bit tricky for a user to understand what the process
> is, especially if they don't understand how it's creating special U1'
> and U2' commits. However, it *is* the cleanest method I've either seen
> or thought of for presenting the conflict to the user.
>
[...]
>> - it appears shiny to the point that it will likely be able to handle
>> even darkest evil merges nicely, no special treatment required.
>>
>
> Yep, and I like that it has a pretty reasonable way of presenting
> conflicts for resolution. It may be a bit tricky to explain the use of
> the intermittent commits U1' and U2' though.

Yeah, I see how all this sends somewhat unique challenges to the
implementation to get user interaction in case of conflicts right, even
though all the basic concepts are old buddies and should be familiar to
the user.

That said, the recursive merge strategy comes to mind, where creating
virtual merge base may itself cause conflicts, so something similar
enough is likely to already exist.

-- Sergey
