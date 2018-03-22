Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B0E91F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 11:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeCVLEC (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 07:04:02 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:12394 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCVLEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 07:04:01 -0400
Received: from [192.168.2.201] ([92.28.134.107])
        by smtp.talktalk.net with SMTP
        id yy0letgB8C0Wbyy0levrh6; Thu, 22 Mar 2018 11:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521716640;
        bh=YR7NkkirSj25O5Ij54SJLW7lqL5QRYf5oy7lPH+wsFI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eg1nl0kltlDE3gAOjNGNE5YPNy+R+SdGVEaSHxj67Qx55BgJRpL5+92P1SVQXRsOP
         nynTqua0Bp4XNBd66n53NV8L7flAPKZG6WbQx19CVhdEkje9xpARJX+yU/s9DlURV0
         SJiHEgucAUIe0vFaRkiAJpuwNhLvnFjwSrqQ9FlI=
X-Originating-IP: [92.28.134.107]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=AcBs9/+9F4N0T7Brpc/17w==:117
 a=AcBs9/+9F4N0T7Brpc/17w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=bGZ9TgXTXx3CYpaZLWAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] rebase --recreate-merges --keep-empty: don't prune
 empty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1803201639540.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <e306f33a-3cd9-b753-ed61-66b7ff614087@talktalk.net>
 <xmqqr2oer19v.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1f7194bb-f48b-e229-94ae-44c58636172f@talktalk.net>
Date:   Thu, 22 Mar 2018 11:03:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2oer19v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFTno5fNysmjaKK316IBnPrP8CLg7dLNEw8CmLYuNSFZUsI/m71rGe2L7WFp4J8vxU/aayjGYiuhvA97al5FVr3sC3d6bEsIwi4ykohenYLtb+usjkOB
 FKqIjaFchrYeFC18bRVwJtBmfvdvbqj3nD4lZ8/UXazKNMoX7yMMZ2TrzhjDlRAjnwbb1/Tf6L9nGDt6P2UD3TU1sogrhUpFa5dQBUvzQltGqb55bYRC17GX
 6ObMsDWD7SEvZKhxLlrCPDlZyruG0Kc7eRS1amV3coje11LlcGepXSrh4ATF54ZY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/03/18 19:32, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 20/03/18 15:42, Johannes Schindelin wrote:
>> ...
>>> As indicated in another reply, I'd rather rebase the --recreate-merges
>>> patches on top of your --keep-empty patch series. This obviously means
>>> that I would fold essentially all of your 2/2 changes into my
>>> "rebase-helper --make-script: introduce a flag to recreate merges"
>>>
>>> The 1/2 (with s/failure/success/g) would then be added to the
>>> --recreate-merges patch series at the end.
>>>
>>> Would that be okay with you?
>>
>> Yes, that's fine, it would give a clearer history
> 
> With or without the above plan, what we saw from you were a bit
> messy to queue.  The --keep-empty fix series is based on 'maint',
> while the --signoff series depends on changes that happened to
> sequencer between 'maint' and 'master', but yet depends on the
> former.

Yes, that is awkward and unfortunate but the idea behind splitting them
into two separate series was to have a single set of bug fixes in the
history. The feature needed to be based on master, so if I'd had the bug
fixes in the same series you'd of had to cherry-pick them to maint which
would break branch/tag --contains. I'm not sure if that is a better option.

Best Wishes

Phillip

> In what I'll be pushing out at the end of today's integration run,
> I'll have two topics organized this way:
> 
>  - pw/rebase-keep-empty-fixes: built by applying the three
>    '--keep-empty' patches on top of 'maint'.
> 
>  - pw/rebase-signoff: built by first merging the above to 0f57f731
>    ("Merge branch 'pw/sequencer-in-process-commit'", 2018-02-13) and
>    then applying "rebase --signoff" series.
> 
> Also, I'll revert merge of Dscho's recreate-merges topic to 'next';
> doing so would probably have to invalidate a few evil merges I've
> been carrying to resolve conflicts between it and bc/object-id
> topic, so today's integration cycle may take a bit longer than
> usual.
> 

