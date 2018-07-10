Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4821F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 21:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbeGJV1o (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 17:27:44 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:32802 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJV1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 17:27:43 -0400
Received: by mail-qt0-f174.google.com with SMTP id l10-v6so19697548qtj.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+1XhkXx99dLPu/k9o0KIMjv4vERJ3EQuU+nAZps4gZs=;
        b=j+EpXemLol4m2pDfKO+IkXF0qWtl0hVSQpt3CQ0MpTBU+KzcAulmsk3T/nqYQ+xly5
         cMJywqvj/A7+cFjARckAuMFUkPC77AcMqNya+dgAVUba1tRjmqce7RaSF8/3bT+i6nkI
         3Bt5bw9jZiWuiPLWk798iKj4lUSzulOfCZpo+UQmZ3+mZrP+5cigUuwe/KzLltSwk9sE
         w3d0B8VqNU9/7yD8/e0Cx3GcYduS5xHWVl5LOR7MNz47/up1oZ4Hk27F3Nks5YhUB1+D
         WV/yKXdbEP+PgzXq8FRye+qtkaMg5UM+pyI7zosdDPJA/su+e2+lULO6nPrk49gyqw0C
         9Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+1XhkXx99dLPu/k9o0KIMjv4vERJ3EQuU+nAZps4gZs=;
        b=NVyMXf/NLgYhwduOcYQXMlG444JXh35WtcqR4d3ElQn/raC/8opPLvWqypurr9G+vO
         wuRg/wrllp/GJ+SD6ERYkmN9vZGWxR+Fs+Mz9Yl5ubHJiOO3dhvYKas3HvlSUYw4vVma
         gl+tPeuGQyq6MRbxcZtiLFlE72C+izUSPXcjv8jQdF2sRxDhaPuxDdWFuaaJcgE2leUR
         iALiQowxEaGVLhwj5xvz8uTB/Jos7F5SKxw2BHEWFfxMODjr27Bt8K7/xdao34puJQvu
         xBsDv0zvQ98p1xGtGgn/CQUTs01olW2adLZehoSvTSW4CByJQhUyri94hs6/YHRaMzgb
         QMTg==
X-Gm-Message-State: APt69E1Pr0V6Bm+Wk6sDrdUZDKYq5IZQyMgmYOOeiwT8NHCBjyn2cPI7
        BiOeHTGsYdxi//i8gyWg2os=
X-Google-Smtp-Source: AAOMgpdHlQsJg+VU1bP+xBGxQYapjE3p5sDlyiaGYZoLcBckWYgOv0qN1K13Bpyqh594jr+U6ZJqpQ==
X-Received: by 2002:ac8:354e:: with SMTP id z14-v6mr25604567qtb.261.1531256231231;
        Tue, 10 Jul 2018 13:57:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w79-v6sm15841377qkw.35.2018.07.10.13.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 13:57:10 -0700 (PDT)
Subject: Re: [PATCH v1] convert log_ref_write_fd() to use strbuf
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>
References: <20180710182000.21404-1-benpeart@microsoft.com>
 <20180710184534.GA27535@sigill.intra.peff.net>
 <xmqqsh4q6fpb.fsf@gitster-ct.c.googlers.com>
 <20180710202128.GA6886@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9666fa00-607c-a212-3104-a9ef8ff2a60b@gmail.com>
Date:   Tue, 10 Jul 2018 16:57:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710202128.GA6886@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/10/2018 4:21 PM, Jeff King wrote:
> On Tue, Jul 10, 2018 at 12:41:52PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>>> -	while (buf < cp && isspace(cp[-1]))
>>>> -		cp--;
>>>> -	*cp++ = '\n';
>>>> -	return cp - buf;
>>>> +	strbuf_rtrim(sb);
>>>
>>> Using rtrim is a nice reduction in complexity. A pure translation would
>>> include a final strbuf_addch(sb, '\n'). It looks like you moved that to
>>> the caller. There's only one, so that's OK now, but it may affect topics
>>> in flight (and I do in fact have an old topic that calls it).
>>>
>>> But I think it's OK, as the change in function signature means that any
>>> callers will need updated anyway. So there's little risk of a silent
>>> mis-merge.
>>
>> It is interesting that we came to a slightly different conclusion,
>> after doing pretty much the same analysis ;-).  Unless Ben has a
>> plan to use a version that trims the trailing LF elsewhere, there is
>> no point changing what the function does, especially because the
>> existing and only caller does want the terminating LF at the end.
> 
> The original actually does a funny thing. It writes the newline into the
> buffer, and then maybe calls copy_reflog_msg(). If it does, then we
> actually subtract one from the length we feed to the function, to roll
> back over the newline. That's harder to do with a strbuf, as those kinds
> of manual length shenanigans are discouraged (you'd use strbuf_setlen()
> to roll it back). At which point, you are much better off not adding it
> in the first place, and building the whole thing sequentially:
> 
>    1. add the early bits that are in all entries
> 
>    2. (maybe) add the tab and message if there is one
> 
>    3. add the trailing newline
> 
> And that's exactly what Ben's patch does.
> 
> So I think the end result is much cleaner that way. My concern was just
> that the function semantics were changed.
> 
> -Peff
> 

And that is exactly why I ended up moving the logic to append the 
newline out to the caller.  I wrote it the other way first but it was 
pretty messy - since there were no other callers, it was cleaner/simpler 
to move it out. :)  For any future callers, it is pretty trivial to add 
the call to strbuf_addch(&sb, '\n') if they want a trailing newline.
