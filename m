Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68A71F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 18:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbdIFSM0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 14:12:26 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36321 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdIFSMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 14:12:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id m9so16615417pgd.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bWt9B/9oG1z1rRlbf1MwaKZuN0PT9FGHjHBBAOEEqOY=;
        b=T3jR660g/5TtoN/ZfkzvUSQJxwsWtXSRc6SuxnHQaRlHxWWpprwFU+FoxmVyK272AF
         659NkgKRQvtgZqEQPDuyrWZ7IhJg9DX4bPHkVBBP9KYeCrpYDURYhMpUEAYiVmyvNt4/
         Jst+hmD/L6IkTDdZ35HzLtu8rtjF6aQ9ws0vxFwk7EIUudOFXV+jAcmnhQC+10r/W6lx
         ZVK3tpwfDLFm3I7CV4Ia4utKAv3X9qvIi6kB1UedjZ4FqLwc/1l4ppW5gT6RyfDfZZmw
         mzClKuKg/vBOh3iYplD/ym+3iwiPCU1Fxo90IQ1CJFtIEN2zh6MrMvt1vCnUQRQEWqwB
         w5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bWt9B/9oG1z1rRlbf1MwaKZuN0PT9FGHjHBBAOEEqOY=;
        b=uRgQDIgAzAdBJrUZ0N5f0T0xySxbqOHyagy4sltL54VV1Cah2aFzFmuhZfhY8vJA4O
         zZjCj67Vv+HlDSfliSKE8INN3ivR05k5zvuJu5LWkIFMTTgqewfO7ZonIrpffMXzUFSE
         jKvNEEMWsPl/dRVQ2bJzeZzMSPJCwfyNYRQEZtLr8yHk8XdfQD/XXsGnLqJBUsoSZnru
         aUTsMTobW0VIytx8Ws3lkcMt5/WlRVv+WVFn1JomgCyXiOBLk6wuIjNU03ngqyJI0qUw
         /kXUI3LLJ48Z3Gm4XArxnYcxtKut8Gy8/H3AU3606E7WNuw01Ve3h3/Y44Nt84Upoavf
         FTvQ==
X-Gm-Message-State: AHPjjUh3d0GYqWdT2MJJ5I0w7KFw0AjWP+h3NUqkBAS/woPVoUCblNJR
        iH2N6PovAjmx3gejpAj2HZwXui7/ZQ==
X-Google-Smtp-Source: ADKCNb4/vIaHiANSliHNuCFUBbzU8Sisx4RX+D6wwo2sqEmlIVldEbqBAgloffRpsvgjFemmQEGUSJbSCL3cTcEQ6x8=
X-Received: by 10.84.211.136 with SMTP id c8mr3478pli.45.1504721545163; Wed,
 06 Sep 2017 11:12:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Wed, 6 Sep 2017 11:12:24 -0700 (PDT)
In-Reply-To: <xmqqmv68bzvj.fsf@gitster.mtv.corp.google.com>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu> <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
 <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com> <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
 <20170905203622.6fs3hr7zfa7mwpqn@sigill.intra.peff.net> <xmqqmv68bzvj.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 6 Sep 2017 20:12:24 +0200
Message-ID: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 23:26, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I noticed the HEAD funniness, too, when looking at this earlier. I agree
>> with Junio that it's not quite consistent with the general rule of
>> "string list items point to their refnames", but I don't think it
>> matters in practice.
>
> Yup, we are on the same page; the "fix" I was alluding to would look
> exactly like what you wrote below, but I agree the distinction does
> not matter in practice.  IOW, I do not think the code after Martin's
> fix is wrong per-se.

Well, "not wrong per-se" tells me you'd feel slightly more comfortable
about the state of things if we did this. ;)

I'll take Peff's hint, tweak/add comments for correctness and symmetry
with the previous patch and add an if-BUG for symmetry. Peff: Do I have
your sign-off? (Do I need it?)

Junio: The topic is in pu as ma/split-symref-update-fix. Re-roll or new
topic or as a separate "patch 4/3" for you to place on top, any
preference?

If we re-roll, would you prefer Peff's much smaller take on patch 2
(strbuf_release where it matters, instead of sprinkling "goto out" all
over)? I think me and him agreed that we'd be fine either way. I'd reuse
my commit message, if I get his sign-off and "From:".

Obviously, if Michael or anyone else has any input, I'm open to that as
well..

Martin
