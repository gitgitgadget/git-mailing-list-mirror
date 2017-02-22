Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A559201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 00:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbdBVAKK (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 19:10:10 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35813 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbdBVAKG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 19:10:06 -0500
Received: by mail-io0-f176.google.com with SMTP id j18so33638429ioe.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RCvVv5A7t+0KLmqQdEbCJTl6jJm0ahVILMVp48lN0C8=;
        b=QmrV18x8KCempueMzjBMCCe9pDqRxp0hNrIMG8k26sEvqvFojLXMQqoBdns2NiytzJ
         l7gcOElb3h6Uo7KyiuDA1D6fmYT2A37KIg/3WyJdgP0hAN9syL1bJRLwJATqPNR0/K8F
         sTTocHvfDfrDZg9nIAO/CCRv53Khzzty1NqiDTJ7lnkI+s456O/bstk37u9KJGFMhpYd
         p7bcXwVzWtMgZH5jtUOBmNZNTBwbwlQtZIbr+LlVUOg2qGZBMV8P8htzNpaHbYRf1fda
         F3EafI3hL43rpTNkupO1ZrIh/UfCcF8YB3ZY5YQKTc9An3VgHc3TZ2GayedMsVlbeuAb
         P1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RCvVv5A7t+0KLmqQdEbCJTl6jJm0ahVILMVp48lN0C8=;
        b=cpBkJznjHSaozTekbcYGQzLCGnAWj5DHu+u7n2x02b1gwht7D8W6A/0d/8KOVZGb5C
         vqvdFN/gyVQ0AJVSQSBFqgJ9anDiRAST3U7OF6ZQp51GTnEKfrxU3KojE3s0NqD6A5Sw
         NbJpXbbLD21GFhXlOVxT5FjFE72mEtvVYfrO6UD51kuwXCW9fKwQvRVOLj8ZrMQWuD2T
         dIWB9+WEzfFg34rBdk0IDuBRN9Xuw0j9FNULRi+ZkuG9PLqBb3VM0lLPiBHjxLdTnRKo
         h7uoLJi0/eayqosy0hFRWJYmdXb9nMnK8vk7QeQiDP2VurovQpgeSH9/Fwf1Lkixw2aI
         9NfQ==
X-Gm-Message-State: AMke39lkFnQWYBIJGVT+4DYLC+BFNUhxsvb/Uj0Lonr4ojSo46zYVml9Fs6jFVXDpfaeeHldUnrceghxV9DNVGpw
X-Received: by 10.107.47.162 with SMTP id v34mr17276582iov.52.1487722204046;
 Tue, 21 Feb 2017 16:10:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 16:10:03 -0800 (PST)
In-Reply-To: <20170221234037.ga44u3birwd5whab@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net> <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net> <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net> <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
 <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net> <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
 <20170221234037.ga44u3birwd5whab@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 16:10:03 -0800
Message-ID: <CAGZ79kZRZz8h8cfrzsOPH+YT7QdF9vQ3C3XBZfGA1SaF+1mEzw@mail.gmail.com>
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Jeff King <peff@peff.net>
Cc:     Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 3:40 PM, Jeff King <peff@peff.net> wrote:

>> > One other caveat: I'm not sure if we do insteadOf recursively, but it
>> > may be surprising to the child "git clone" that we've already applied
>> > the insteadOf rewriting (especially if the rules are coming from
>> > ~/.gitconfig and may be applied twice).
>>
>> When a rule is having effect twice the rule sounds broken. (the outcome
>> ought to be sufficiently different from the original?)
>
> If you have:
>
>   url.bar.insteadOf=foo
>   url.baz.insteadOf=bar
>
> do we convert "foo" to "baz"? If so, then I think applying the rules
> again shouldn't matter. But if we don't, and only do a single level,
> then having the caller rewrite the URL before it hands it to "git clone"
> means we may end up unexpectedly doing two levels of rewriting.
>

I see. Thanks for the example. So really what we want is to record the
unencumbered URL (with no rewriting) and then at run time lookup various
places of url.*.insteadOf (which might change with the git version
that you use)

Thanks,
Stefan
