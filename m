Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25941F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 07:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeCPHbj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 03:31:39 -0400
Received: from mail.javad.com ([54.86.164.124]:52517 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeCPHbg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 03:31:36 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id B18343E961;
        Fri, 16 Mar 2018 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521185494;
        bh=O2gKyGdjE5PGnvUVFL/KJ7N0zuREgsImn/EaUqS0zcw=; l=2775;
        h=Received:From:To:Subject;
        b=Lrk7grrYS0f28mrJtwNuLHuPznth4weFh8FPPTF1sF5I+r1mrho4FB+I1FhYb7OJZ
         ZYSxzUx1afNg28uTfMg1fFLDlcL0d/8ek06daZ34WUZKswIJGd5uNCZPTou2Of2CEd
         ID2Vznp2MUKAE3U1CKvGMQwuu8qttoChm0WhUpJ8=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ewjps-0006ZM-1d; Fri, 16 Mar 2018 10:31:32 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <877eqgardi.fsf@javad.com>
        <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
        <87efkn6s1h.fsf@javad.com>
        <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
        <87lget7p2g.fsf@javad.com>
        <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com>
Date:   Fri, 16 Mar 2018 10:31:32 +0300
In-Reply-To: <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com> (Igor
        Djordjevic's message of "Fri, 16 Mar 2018 00:08:07 +0100")
Message-ID: <87vadw3297.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,

[...]

>> As I said, putting myself on the user side, I'd prefer entirely separate
>> first step of the algorithm, exactly as written, with its own conflict
>> resolution, all running entirely the same way as it does with non-merge
>> commits. I'm used to it and don't want to learn something new without
>> necessity. I.e., I'd prefer to actually see it in two separate stages,
>> like this:
>> 
>> Rebasing mainline of the merge...
>> [.. possible conflicts resolution ..]
>> Merging in changes to side branch(es)...
>> [.. possible conflicts resolution ..]
>> 
>> And if the second stage gives non-trivial conflicts, I'd like to have a
>> simple way to just do "merge -s ours <heads>" on top of already rebased
>> mainline of the merge and go with it. Note that the latter is
>> significantly different than re-merging everything from scratch, that
>> would be the only choice with "all-in-one" approach, and it essentially
>> gives me back those simple "rebase first parent and just record other
>> parents" semantics when needed.
>
> I`m undecided here, and while I do see a point in what you`re saying, 
> this being new to general public I dont`t think you being accustomed 
> to it is a very strong argument :)

Sure. It's mostly that having already familiar step separate seems to be
a good idea, as well as resulting isolation of the new stuff, where I
readily agree not to granulate it further. As if the latter actually
makes any difference... Octopus merges? I mean, really?

> Yes, having more steps would mean more power/options to the user, but 
> more complexity to explain to and guide him through as well, not really 
> sure where the line should be drawn - for the first time, at least.

A good thing is that while it runs smoothly it still runs smoothly both
ways.

> Also note that, for example, in case side branch(es) dropped some 
> commits (interactively or otherwise), first step alone would still 
> reintroduce those dropped changes, thus later possible `merge -s ours 
> <heads>` would be a pretty bad "evil merge" case and a wrong thing to 
> do in general.

Except that my presumption is that the second step has been run already
and has stopped due to conflicts, so I see the conflicting result of
dropping those commits on side branch(es), check the previous state of
the right side of the conflicting merge, and decide those state, being
the result of the fist step after possibly demanding conflicts
resolution, is fine after all. Thus I just re-merge -x ours the
branch(es), instead of re-merging everythig from scratch only to finally
get back to the same result, be it evil or not, the hard way.

-- Sergey
