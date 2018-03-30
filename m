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
	by dcvr.yhbt.net (Postfix) with ESMTP id 351A31F404
	for <e@80x24.org>; Fri, 30 Mar 2018 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeC3PNI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 11:13:08 -0400
Received: from mail.javad.com ([54.86.164.124]:41686 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeC3PNH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 11:13:07 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 218C53E9A4;
        Fri, 30 Mar 2018 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522422786;
        bh=Sx2FUW9uIMy6Nm/nT9FcwkeEKD3ruZdU/nz2RTUhoxs=; l=2595;
        h=Received:From:To:Subject;
        b=KrtbpbnH7P2Jr4aEQTdiJ8ctqLeZJCupoHSKFk0phhTfXBrWxPtnERrr9VFv9TR96
         227bisDPTC1HzCOHsK6BPSiYVJEanS6VgFLz0DwvZKMSdnbkphXroALb0Ffnh5+a+F
         LwdZuNAbe2qVBuA6LaIaZyoR/XEWKbAruYSGc5Bc=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f1viB-0002SO-PN; Fri, 30 Mar 2018 18:13:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
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
        <874ll0d9nt.fsf@javad.com>
        <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
        <87r2o48mm2.fsf@javad.com>
        <CA+P7+xo19mHrWz9Fy-ifgCcVJM2xwzcLj7F2NvFe2LwGbaJiDQ@mail.gmail.com>
        <87zi2r5swc.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803301235560.5026@qfpub.tvgsbejvaqbjf.bet>
        <87bmf5zqn3.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803301523060.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 18:13:03 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803301523060.5026@qfpub.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 30 Mar 2018 15:33:46 +0200
        (DST)")
Message-ID: <87tvsxwq9s.fsf@javad.com>
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
> On Fri, 30 Mar 2018, Sergey Organov wrote:
>
>> Could we please agree to stop using backward compatibility as an
>> objection in the discussion of the  --recreate-merges feature?
>
> No.
>
> The expectation of users as to what a `pick` is has not changed just
> because you wish it would.

As if I ever suggested to change user expectations. Could you please
stop putting words into my mouth?

I _am_ a user, and I expect 'pick' to pick commits, no matter how many
parents they might have.

And no, --preserve-merges did not ever pick commits with number of
parents more than one, it rather threw them away and re-merged the
heads. Calling it 'pick' was a huge mistake indeed! Fixing that mistake
is what I expect, as a user.

Just teach the 'pick' to correctly pick any commit, please!

>
> That is a matter of backwards-compatibility.

OK, fine, at least its only about user expectations and not about some
scripting incompatibility.

> You see, if you are driving a car for a hundred years already, and then
> switch to a different car, and it has a lever in the same place as your
> previous car's windshield wiper, but in the new car it has a button that
> activates the emergency driver seat ejection OMG *it has a seat ejection
> like in the James Bond movies! Where can I get that car?* Sorry for
> disgressing.

Except it's irrelevant as the 'pick' will still pick commits.

> I am really concerned about that willingness to put an innocuous button,
> so to speak, onto something users got really used to, over the course of a
> decade or so, when that button should really be made red and blinking and
> OMG where can I get that car?

It's irrelevant as the 'pick' will still pick commits.

> So to reiterate, I am really interested in a practical solution that won't
> cause nasty surprises.

I rather don't see how it possibly could cause any surprises, especially
compared to using 'merge' to pick commits.

> Meaning: `pick` != merge.

Exactly! Use 'merge' when you merge, as you are already doing. Use 'pick'
when you are picking. You don't merge "merge commit" when you are
picking it!

> That was a mistake in preserve-merges, as I have only mentioned like a
> hundred times, and we won't repeat it.

The mistake was that it used 'pick' to denote re-merge. You already
fixed that mistake by introducing 'merge' to re-merge, thanks God.

Please don't commit yet another mistake by now using 'merge' to pick!

-- Sergey
