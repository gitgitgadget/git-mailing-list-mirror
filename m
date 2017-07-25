Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CBC1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 19:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbdGYTyf (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 15:54:35 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35614 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdGYTye (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:54:34 -0400
Received: by mail-it0-f48.google.com with SMTP id h199so56718631ith.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7p3iK94VdEXT8FWfDquhNdVO+mF+Dj2C5s69LaLrsXw=;
        b=mER0yIB5DI4dBpRXXKcQ1eH7IRZ0rj9+dAWuPgeXXRHamS3PUdWxdVgFghon8e8Ssu
         cRVaJch4B3UNg5VCoucEUE/+QZrzoRS8nFB67MV+HZzu+uG5x9JnrFlNQevj/gR+IzPj
         otqFxju938bsB3oqJdxSVAqKbqXOAEZ0EtTJ9y+/NmIZD5ppMZl/09ZTDVLqK0tOxgpn
         Aq/KPNBjn8jWBTW8BRnKf2KytM5I0ifiUb1TopZfi/O5tR+sJ6DkXW445z5EQ6WFgKD/
         lvfNjyWhOE4fbjzwhXpIMAPsV0RFxv2ezIU0r/2a/nD2t8KReaqUAzEeMCjQDoCBfpXM
         +lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7p3iK94VdEXT8FWfDquhNdVO+mF+Dj2C5s69LaLrsXw=;
        b=dV9qCGj7jd7wboRpppT+Ll8l5whgA1W06fd7CgcuE1RdaryB5hkiWH4KxbEtgSx6rD
         uJMhbi6X2v9mxthHVkPgDxagn5grfN+qWNfbtajuzA86lFNXq70ehm1ukO/g8KIVKaT3
         b2MTAaTJfYpkH4qIr+fizquYpfXNugLiXwPMHQSJGDNzTlNlPv6802AiVxBD7ymWGG/N
         g4sDOa0nRC+LYJ3rH+Dc5TdJTu35kz90//+Q9XTxXAVvEwzDlDXdW2vH/Nmx7Xc/gbLB
         TDe41pwSfdzoRTBNfzS+fn3FHG9FGUDQreY9B469eCMEeZ5R3SVIFcC0T9bb2TrlC5c7
         OkZQ==
X-Gm-Message-State: AIVw111VUNJtmKeg/sMSXIIhXysTpLmbJiQuurMmGeIIGsnhFuOtUfl6
        mjIS8Yz+b3os1nhW344=
X-Received: by 10.36.173.2 with SMTP id c2mr1893421itf.16.1501012473221;
        Tue, 25 Jul 2017 12:54:33 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id y12sm7193335iod.83.2017.07.25.12.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2017 12:54:32 -0700 (PDT)
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict
 resolution
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
 <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
From:   Raman Gupta <rocketraman@gmail.com>
Message-ID: <1d07fa3b-cd3f-42fd-87c1-0627de7c04f2@gmail.com>
Date:   Tue, 25 Jul 2017 15:54:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/07/17 01:52 PM, Jeff King wrote:
> On Tue, Jul 25, 2017 at 11:09:55AM -0400, Raman Gupta wrote:
> 
>> I had an interesting situation today: resolving a merge conflict
>> required modification in other files that were not themselves conflicting.
>>
>> I just realized that rerere does not remember any changes to these
>> additional files -- only changes to the conflicting files. This makes
>> the end result of rerere obviously incorrect in this situation.
>>
>> So my questions are:
>>
>> 1) Is this a known limitation or is there a reason rerere works in
>> this manner?
> 
> Yes, it's known. Rerere works by storing a mapping of conflicted hunks
> to their resolutions. If there's no conflicted hunk, I'm not sure how
> we'd decide what to feed into the mapping to see if there is some
> content to be replaced.
> 
> That said, I'm far from an expert on how rerere works. Junio might have
> ideas on how we could handle this better. But I do note that for
> repeated integration runs (like we do for topics in git.git, as they get
> merged to "pu", then "next", then "master"), he keeps non-conflict
> fixups in a separate commit which gets squashed into the merge
> automatically. See
> 
>   https://github.com/git/git/blob/todo/Reintegrate#L185-L191

Seems relatively simple to me, at least conceptually.

1) Store the state of the index after the merge.

2) After conflict resolution is complete (i.e. user executes "git
commit"), diff index @ step 1 with commit.

3) Assume that all changes in that diff are related to conflict
resolution (as they should be), and save that diff to the rerere cache.

I could be missing something fundamental here though...

>> 1b) If it is a limitation/bug, what would be needed to fix it? With
>> some guidance, I might be able to submit a patch...
> 
> As far as I know, something like the Reintegrate script above is the
> state of the art. IMHO it would be useful if something similar were
> integrated into rerere, but I'm not sure exactly how it would know when
> to trigger.

I've seen the Reintegrate script before. It is very specific to the
git.git workflow. I think it makes sense to expose this particular
capability in git proper, given that rerere itself is exposed. Plus
that could actually simplify the Reintegrate script a bit.

>> 2) In the meantime, is there a way I can identify these cases, without
>> which I cannot really trust rerere is doing the right thing?
> 
> I do think it would be useful if rerere could look at a merge result and
> say "OK, I've recorded these bits, but there are other lines that are
> not part of either parent and which are not part of a conflict". That
> gives you a warning that such lines need to be part of a fixup (rather
> than you being surprised when you redo the merge later and have to
> rework the fixup).

Agreed.

> But I don't think even then you can ever trust rerere fully.
> Fundamentally you're applying some changes from one merge into another
> context. There may be new sites that also need fixing up, and the tool
> has no way to know. So you should treat a rerere-helped merge as any
> other merge: assume it's a good starting point but use other tools (like
> the compiler or automated tests) to confirm that the result is sensible.

While I agree that every case cannot be handled, and this type of
validation is still necessary, I believe git should cover the cases
which it is proper and possible to cover.

> -Peff
> 

Regards,
Raman
