Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3544D20248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDONXm (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:23:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42754 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDONXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:23:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so18986619qtc.9
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p6MrVS0wRFzicKcHZSxvPPAR8eaQFYHYf3pBKj/41dA=;
        b=fe0LjDEswHHEy+3SP0MkFiSlAgMIpw3led/DNYDScxxo8hpEEfh35cveNEepNU0zvR
         AsAyZ9RAnTurgQlT6L2dV+ozdjX/NIcz6AtD8oxXoZIOYmx62C19WZqaO1CX/FSqqAz5
         lp/Nq3wB/BuRvPDomv8Ut3hK+dCFR3Ce4hUK1/3HvPZ53O/92KWDzKlIwfnC4z+hvGKN
         6CMbTnN+O+UXDtU52oftUj05vI8ZOTxeCQOlWfbgaNTQBo9WDAGN8/wQFHHzc/PXoQTn
         /6Os7wMuLJbEZzkvTxNJGxXTNz/NxWWHPT2TAEmX7OnGt3OJS6v0eXsrwnxxeo1tW19L
         aICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6MrVS0wRFzicKcHZSxvPPAR8eaQFYHYf3pBKj/41dA=;
        b=lVm+1hrNSLBHnY6Xj2xJvdkAQ5lXXf29xZ1lGRhZ9f7iNKuKlBanboOfC0Ztfed2P+
         kR5/jOzRC2dg+rs22R4yMjwKQRac4imQfNEmL0ZH0+F5qDhdmRldnRm9eRDU1zu0FSng
         8VfDlrFABok6YVUDUIoZRF0mTIg23OE8ejAZwDHf8q5akvoQiSciYQwyQLTyQ/UuJGJn
         3P24GE1yYxnM/iy/qpX1sp0w00V2kCphyKLN/72uF8FhUHL7M6FpLbA96STJU3RaIU1X
         93C8TLNh/Wa5Y/p5ZGTVf7/LtfsSiwGwS/5cIrYwTS2v8jWHerk7jwt805M15PFn4drM
         0JWQ==
X-Gm-Message-State: APjAAAURjb69ADk7C84q6En9ZhAUBywUgXAqz0LBh6zbW6pBuDAaqXcF
        0qIo3L3jClZ/CccXgwp7kk2Zkw==
X-Google-Smtp-Source: APXvYqyJ3bv1RxErbvfezPFJEyGs7yrpVMVjMsUjU/6EWNl6R8SlVQep/iIrW9jlpNZ5B6i4GZLvig==
X-Received: by 2002:ac8:f38:: with SMTP id e53mr59776326qtk.115.1555334620671;
        Mon, 15 Apr 2019 06:23:40 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id x15sm24853782qkh.13.2019.04.15.06.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:23:39 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     Michael Platings <michael@platin.gs>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20190410162409.117264-1-brho@google.com>
 <CAJDYR9SL9JCJjdARejV=NCf9GYn72=bfszXx84iDc416sZm31A@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <9439c697-246f-3bcb-4d34-85099e577e8b@google.com>
Date:   Mon, 15 Apr 2019 09:23:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9SL9JCJjdARejV=NCf9GYn72=bfszXx84iDc416sZm31A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael -

On 4/14/19 5:10 PM, Michael Platings wrote:
> Hi Barret,
> 
> This works pretty well for the typical reformatting use case now. I've
> run it over every commit of every .c file in the git project root,
> both forwards and backwards with every combination of -w/-M/-C and
> can't get it to crash so I think it's good in that respect.
> 
> However, it can still attribute lines to the wrong parent line. See
> https://pypi.org/project/autopep8/#usage for an example reformatting
> that it gets a bit confused on. The patch I submitted handles this
> case correctly because it uses information about the more similar
> lines to decide how more ambiguous lines should be matched.

Yeah - I ran your tests against it and noticed a few cases weren't handled.

> You also gave an example of:
> 
>          commit-a 11) void new_func_1(void *x, void *y);
>          commit-b 12) void new_func_2(void *x, void *y);
> 
> Being reformatted to:
> 
>          commit-a 11) void new_func_1(void *x,
>          commit-b 12)                 void *y);
>          commit-b 13) void new_func_2(void *x,
>          commit-b 14)                 void *y);
> 
> The patch I submitted handles this case correctly, assigning line 12
> to commit-a because it scales the parent line numbers according to the
> relative diff chunk sizes instead of assuming a 1-1 mapping.
> 
> So I do ask that you incorporate more of my patch, including the test
> code. It is more complex but I hope this demonstrates that there are
> reasons for that. Happy to provide more examples or explanation if it
> would help. On the other hand if you have examples where it falls
> short then I'd be interested to know.

My main concerns:
- Can your version reach outside of a diff chunk?  such as in my "header 
moved" case.  That was a simplified version of something that pops up in 
a major file reformatting of mine, where a "return 0;" was matched as 
context and broke a diff chunk up into two blame_chunk() calls.  I tend 
to think of this as the "split diff chunk."

- Complexity and possibly performance.  The recursive stuff made me 
wonder about it a bit.  It's no reason not to use it, just need to check 
it more closely.

Is the latest version of your stuff still the one you posted last week 
or so?  If we had a patch applied onto this one with something like an 
ifdef or a dirt-simple toggle, we can play with both of them in the same 
codebase.

Similarly, do you think the "two pass" approach I have (check the chunk, 
then check the parent file) would work with your recursive partitioning 
style?  That might make yours able to handle the "split diff chunk" case.

> The other major use case that I'm interested in is renaming. In this
> case, the git-hyper-blame approach of mapping line numbers 1-1 works
> perfectly. Here's an example. Before:
> 
>          commit-a 11) Position MyClass::location(Offset O) {
>          commit-b 12)    return P + O;
>          commit-c 13) }
> 
> After:
> 
>          commit-a 11) Position MyClass::location(Offset offset) {
>          commit-a 12)    return position + offset;
>          commit-c 13) }
> 
> With the fuzzy matching, line 12 gets incorrectly matched to parent
> line 11 because the similarity of "position" and "offset" outweighs
> the similarity of "return". I'm considering adding even more
> complexity to my patch such that parts of a line that have already
> been matched can't be matched again by other lines.
> 
> But the other possibility is that we let the user choose the
> heuristic. For a commit where they know that line numbers haven't
> changed they could choose 1-1 matching, while for a reformatting
> commit they could use fuzzy matching. I welcome your thoughts.

No algorithm will work for all cases.  The one you just gave had the 
simple heuristic working better than a complex one.  We could make it 
more complex, but then another example may be worse.  I can live with 
some inaccuracy in exchange for simplicity.

I ran into something similar with the THRESHOLD #defines.  You want it 
to be able to match certain things, but not other things.  How similar 
does something have to be?  Should it depend on how far away the 
matching line is from the source line?  I went with a "close enough is 
good enough" approach, since we're marking with a '*' or something 
anyways, so the user should know to not trust it 100%.

Thanks,

Barret

