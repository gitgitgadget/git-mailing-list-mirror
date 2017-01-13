Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EDDA20756
	for <e@80x24.org>; Fri, 13 Jan 2017 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdAMUm3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 15:42:29 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33916 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdAMUm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 15:42:27 -0500
Received: by mail-lf0-f54.google.com with SMTP id v186so46452115lfa.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JY8s41NfB7fDMTwhOEtANId1KhKh1aROjXvDn2reMyg=;
        b=vcJqjVLEjY//C319gwWafGVLLt1vZFaXk+k/6cbhaPZbrOCYJWv8Bl9opFnaexuzvg
         HC6Ts0upeR1hn3lCJO22h7myvbHpWGxi/ldnrK8FKwzVVOPez6hl93zYPNz+HqPX3TfV
         TgGAKmGif7x082LZJCyXjF2nP6wpSRZTq4HMpW5fTeM7qcNMFrSXNM6UU2XDRzpBqYF0
         C1d14VQyPN6Acr3ov1+lQChvMf7gaUF247rU9Vib4S/rCzbdI81EQ4ru3xS029A9rUHO
         4q4GlgvhkDd/SguMdShoURXeXXMx4WyX0SCtxisRkFNLzcSf8MimJbHgg49Go+1z1XtY
         GgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JY8s41NfB7fDMTwhOEtANId1KhKh1aROjXvDn2reMyg=;
        b=GYyVkh+W4Ej726PyHFXqw8nDGyi39/oqcJSpixItPOC2dZWzaX7ZqXQWqB39eDWDvI
         wU/lw6l8tU2e1ipEQXu7HRA1r7aSRVplzA/8gPq5ainhaZTpra+hLS7HZA1oBoGqFtho
         mBAfCMP670Yx2qi3vB/+Omul3c+OChE4I+ZGHew02LUratw8xSJtcrR4pCK8vwR7RoXY
         A5eszP6BDARYi72pKGUSNBA9G7kQQU2/ukEwo/vUHo+pNOZgkkrJv8AMLR74g9PKwXbH
         PqP5EAI7TtPVl+UBlxVEHWXrzaJ+qbcAHmImDyiXglodwbjZivUe94inmxLTvqYxlBWM
         ZPFA==
X-Gm-Message-State: AIkVDXLO4xhwb6+ZxSw8Hf/M1n0jWDgRU6Mq9fpj4cFJ6smKuEXFnxT+DRV/kCqO8pgXrj4QNAkwt1Rh7KOqOA==
X-Received: by 10.25.24.152 with SMTP id 24mr8507579lfy.12.1484340125265; Fri,
 13 Jan 2017 12:42:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 13 Jan 2017 12:41:44 -0800 (PST)
In-Reply-To: <xmqqpojqhk3i.fsf@gitster.mtv.corp.google.com>
References: <20170112001721.2534-1-jacob.e.keller@intel.com> <xmqqpojqhk3i.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 13 Jan 2017 12:41:44 -0800
Message-ID: <CA+P7+xoR7oOEg-WW4AqWNYfn4f2W4vwxFLyxc+buzAi7h2xfyw@mail.gmail.com>
Subject: Re: [PATCH 0/5] extend git-describe pattern matching
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 10:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Teach git describe and git name-rev the ability to match multiple
>> patterns inclusively. Additionally, teach these commands to also accept
>> negative patterns to discard any refs which match.
>
> You made quick responses to reviews with "will change", so I am not
> queuing this round to my tree; please don't mistake that as my
> indifference or opposition to the topic.  This sounds like a good
> thing.

Perfect. I will probably take a few days till I am back at a computer
and can do this, but I will be submitting with the suggested changes
soon.

>
> As to the semantics of mixing positives and negatives, I would
> recommend this to follow how positive and negative pathspecs mix.
> IIRC we chose to use the most simple and easy to explain option,
> i.e. a thing must match at least one of the positives and must not
> match any of the negatives to be considered a match.
>
>

That is the current implementation, so I will stick with it. It's the
simplest, and easiest to implement.

Thanks,
Jake
