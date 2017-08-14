Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818EF20899
	for <e@80x24.org>; Mon, 14 Aug 2017 19:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdHNTv6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 15:51:58 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33633 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdHNTv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 15:51:57 -0400
Received: by mail-yw0-f182.google.com with SMTP id p68so61251827ywg.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=40D00RRsmiQfhygUcqQ+QxZOZxFMXnjEGj5IqyPgcjY=;
        b=a3Ui89bW4vmfFB/muh/WO1qnvR07jELRApK77HAVWuWxsYRjx+WE20GPJbGgz1UKob
         MQm4EC+hSMTTS8L1mJZ578HJwEHGN9cRHZDu1gzVKzeM+UPqzxPZh1XP2VpeXyvCnBBP
         C/bUl0JdESUQYObg1Ee+ORjyoblWVmvcAQTrLyx6aDLfkVo727DdFpobFKoXY3vPDUXb
         q3tl7ZEWLiiL4XFEhR7qfqMSXq+21qHTQuWTblE3YM5Er4V0dCq7GMoRqFDwYEvJT10F
         x98kmpj2MigH9/YagMYgZ5sCTknl2lGV6bbaW7f/ClDpZkkQIBfvtlE3DAS757vnADAl
         GtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=40D00RRsmiQfhygUcqQ+QxZOZxFMXnjEGj5IqyPgcjY=;
        b=bFdDVldvdDIKDv59oLS4pMcRfJT04WVZixaqv9OH9sSSA1hxDVm7Z7Qh2cWnLQlseT
         Z2ko+JBDBbbDs/aDWl4Z53a34UqIp/A2dCtxDi/Rj78yw7AT/dJZU6DwK7RgJpkqiLCw
         AXlz8ZyBpP0uOv8hhocbAgP7jQeWeDv1LiqDbCb6z/igpitjrGFtOSByHS1cA029yViQ
         73vmC8ce/ngt1KabLlHVixTrFsoosEXu3uUMascDBi3E15BPBLwVwlyG5Kbq9qptcZnn
         GtUmdN9ejximiE90SCQPzVbGsF5stwwOwAZ/6xWgioZjowSd3Bn6D6HH/OMJeFyZ05Rq
         eHDw==
X-Gm-Message-State: AHYfb5jz++yXo0uBOh4NR6t5vVEu9ejFlNW/i01aKiIKiYpoUjipC6yg
        GdEHAhr5nopsXHqvId2C2s5g+7CKsByY
X-Received: by 10.37.115.78 with SMTP id o75mr15575150ybc.244.1502740317151;
 Mon, 14 Aug 2017 12:51:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 12:51:56 -0700 (PDT)
In-Reply-To: <xmqqbmniuei9.fsf@gitster.mtv.corp.google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
 <xmqqk229y5zd.fsf@gitster.mtv.corp.google.com> <CAGZ79kadqx3PcchM6h_U5U6nsMVf3wHSUHt1XpD_XWxYdoYudg@mail.gmail.com>
 <xmqqbmniuei9.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 12:51:56 -0700
Message-ID: <CAGZ79kYHW3bpexhiDnoNfyp=etBJ6nPhyLYR09+4jMpw25hR_A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Aug 11, 2017 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> My preference however is to keep sb/diff-color-move topic as-is
>>> without replacing and fixing it with incremental updates like these
>>> patches.
>>
>> I would have hoped to not need to reroll that topic.
>> Though I do find patches 1&2 valuable either on top or squashed
>> into "[PATCH] diff.c: color moved lines differently" and
>> "[PATCH] diff.c: color moved lines differently, plain mode"
>> respectively.
>>
>> So I'd ask to pick at least patches 1&2 on top of that series, please?
>
> Yeah, that is exactly what I did before reading this message but
> after reading your comments on the patches ;-)
>
>> (I am missing the context for *why* you preference is to not do
>> exactly this).
>
> I see what I wrote can be misread, especially due to its lack of
> ",instead", that I want to keep the broken one as-is, with neither
> reroll nor fixup.  That is not what I meant.
>
>  - If you choose to squash so that the resulting history after the
>    series graduates to 'master' will be simpler to read (due to lack
>    of "oops, that was a mistake"), I do not mind a reroll.
>
>  - On the other hand, as the topic has been in 'next' for some time
>    and presumably people tried it in their real daily work when
>    needed, keeping what is queued as-is has a value---we have a
>    fixed reference point that we can go back to to compare the code
>    with and without the fix.
>
> I do not have a strong preference, but if I were asked to choose,
> I'd choose the latter.

We'll go with the latter then. Thanks!

Other reasons for the latter that I want to add:
* The patches are written 2 month apart, which may indicate that
  there was real usage and hence fixes with a more substantiated
  understanding of the new feature.
* We should not strive for "perfect" history IMHO. That is because
  commit messages provide a lot of reasoning and add a lot of value
  for understanding the code. If I were to squash and reroll, I would
  need to make sure these points are addressed in the commit
  message to have a result that is equally good.
  The history only needs to be "good-enough", which we defined to
  "bisectable on all platforms that we care about", fixups/bugfixes
  are like the cherry on the cake, it draw attention on its own.
  Not a bad thing IMHO.
