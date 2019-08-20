Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419EA1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHTShV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:37:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36961 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTShV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:37:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so13427189wrt.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPK3cUroRC6mQhqQYxLBebCGvhr4uYlRQlcJs2MB1C8=;
        b=Zcm1xyFS2ai5w6H+dkY8WqeQsG0fJQqGZbNvMNC2Itb/LvhRZwj7NyIJoS7a4Kobhi
         N1Qn/vsU0kMxFW2Auvlq4CSQHxzXDJ5m+jYtStVCyHY9m7A8VLsYA4cBinWLuuRt95oZ
         QcAdmXxfJlUxGePWearuugjRSzwlns8csudrPLwy3LvDAuQHrfGFZzS7V2q7gW01nA/H
         NlkM9lt+EjTDAM6QYIAN3rYtbl3FiTxqSOmycuVTwv29Ho0/zm7fZJc9DRuFDAeE2h++
         eID1Val1ZfirFFhjIbJc33OjAHiGIOU+Jni8r1QKGKmTzaACkWg5/zt4oNKOwIOfKLxK
         a9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BPK3cUroRC6mQhqQYxLBebCGvhr4uYlRQlcJs2MB1C8=;
        b=g4WenQu4OAyL9va3iU24uSUh8pAVjC6iheTETKoV6KoF2wolB6yeREKYHrksSwg9zJ
         M+2eXV2Bs4MhAg5lbSGKsdsib96F1IRxXZp0myumQbefd7bhWhSja4IhLBVdtmhIAC2v
         vUNyoMelTNwJo04oFuMjovLrcY/i7FVZHuNbd+IVGLAlMxKHXGu2A7bcm8bAHtw02mvJ
         SAf7xUTRbG/RcdxGSQigwgPVJnYvOLAW//Fev7rNKNwlXAr2yJe3RtXlUbEEs0zadgAV
         XQBfib38QEiMDduA2M8Tzimp+ySIfz9m5g7go8vs7OfBpm/dqakHm5voiQIJ02FY5UXP
         IkPw==
X-Gm-Message-State: APjAAAU3r55oF/rdUQ6AbiTd/WFy3P3DTkGh54BIXVk0mclj7AaOgFOF
        FZkL2vlRDP960IZgSFxgxsQ=
X-Google-Smtp-Source: APXvYqz3eUTVYFkykhRW3jwC5u6s8zkpxkkUoJ38yFOwN421iGh9byhn9uiKfWi/1xIQ7MJb+iZIXA==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr37626783wrs.117.1566326238936;
        Tue, 20 Aug 2019 11:37:18 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-13-95.as13285.net. [92.22.13.95])
        by smtp.gmail.com with ESMTPSA id a11sm19813563wrx.59.2019.08.20.11.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:37:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/6] rebase -i: support more options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
 <71c313d7-e08d-f62f-c52e-aabca0d97002@gmail.com>
 <xmqqsgpvvi3s.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c8bede99-8926-2bdc-a3ff-b8ee49bb6e34@gmail.com>
Date:   Tue, 20 Aug 2019 19:37:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgpvvi3s.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/2019 18:53, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Rohit
>>
>> On 20/08/2019 04:45, Rohit Ashiwal wrote:
>>> I've tries to incorporated all the suggestions.
>>
>> It is helpful if you can list the changes to remind us all what we
>> said. (as a patch author I find composing that is helpful to remind me
>> if there's anything I've forgotten to address)
>>
>> Also there are a couple of things that were discussed such as
>> splitting up the author and passing it round as a <name, email, date,
>> tz> tuple and testing a non-default timezone which aren't included -
>> that's fine but it helps if you take a moment to explain why in the
>> cover letter.
>>
>>>
>>> Some points:
>>>     - According to v2.0.0's git-am.sh, ignore-date should override
>>>       committer-date-is-author-date. Ergo, we are not barfing out
>>>       when both flags are provided.
>>>     - Should the 'const' qualifier be removed[2]? Since it is leaving
>>>       a false impression that author should not be free()'d.
>>
>> The author returned by read_author_ident() is owned by the strbuf that
>> you pass to read_author_ident() which is confusing.
>>
>> Best Wishes
>>
>> Phillip
> 
> I've looked at this round, but will push out v2 for today's
> integration cycle, mostly due to lack of time, but there do not seem
> to be great difference between the iterations.
> 
> The "ignore-date" step conflicts semantically with b0a31861
> ("sequencer: simplify root commit creation", 2019-08-19) but in a
> good way.  Without the clean-up b0a31861 makes, we need to munge the
> timestamp in two places, but with it, there is only one place that
> needs to modify the timestamp for the feature (in try_to_commit()).

That was my hope

> You may want to see if these "more options" topic can take advantage
> of the "simplify root commit creation" by building on top of some
> form of it (I do not know offhand if b0a31861 ("sequencer: simplify
> root commit creation", 2019-08-19) must build on other two patches
> to fix "rebase -i" or it can be split out as an independent
> clean-up), and if it is feasible, work with your student to make it
> happen, perhaps?

If it is separated out from the first two there will be a minor textual 
conflict as the first patch in that series changes the root commit 
creation to stop it writing CHERRY_PICK_HEAD and then b0a31861 deletes 
the modified version but it shouldn't be a problem to resolve manually. 
Rohit do you want to try cherry-picking b0a31861 onto master and then 
rebasing your patches on top of it? - it would be nice to simplify things.

Best Wishes

Phillip

> Thanks.
> 
