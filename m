Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0031F51C
	for <e@80x24.org>; Tue, 22 May 2018 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEVTCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 15:02:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44041 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeEVTCA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 15:02:00 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so5485340ybp.11
        for <git@vger.kernel.org>; Tue, 22 May 2018 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EsMJNEDgddoGSyqXtjWDeqSjZX/DdF//Z3RWi1T6YH8=;
        b=dMKyNdSQp0rXBscgEUrpSRo/fl/smtCWjF3mEUF8Rllbsw1Rz8a5SJL7p3kewuh0sX
         ZzdV4nzyOoZs505DFLsGblF3UgQ7MHxVCu84wqowTipI2Hd4LAt6RGUWMT+wn8cJo+2V
         sahl0qErKz9p/vo/1D2LEzJVLBUA5N90Z99lfKvJws0C5bBoAousyClrg3kkyYYOBig9
         qtaTf3UIZYF7C7GoGMr31gjsaRgzojAnTZDrEqfFpRUXxRuRHxthQ4L2JhtXx2o7E8kj
         TTl2kI0hGx1bAG4UAGuThF8cJ17JnlTHfBKuMTUEz/hyP3JL7ivALFg6OIoaDlRrNDil
         sorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EsMJNEDgddoGSyqXtjWDeqSjZX/DdF//Z3RWi1T6YH8=;
        b=f0pbH7ckCIakXw40EJrqfBmGJDEyaWQsbg9Zx4UJJKJbpaSrOkkv6hV2Hj8TvzOXIf
         6RYFotR7tdlxtFGKUv8XIX8Ilv4ab6VT6f6up9VpJRA/Caf98dgu1h3LHM97fOF5SOOZ
         7tqmRs+Ts7jlY3+bscEW0W3hnnxx+Fq2kyatZJxDFlvKFG142Ey/uA9SMXRgCKlIEI9X
         k6+qFcH8nE/bmtsbu8tU1ZXnRW9DJ5dDlsjQrAGp3qNwaRIhigDqIki9szjvSKnI5A/J
         Pvr96XxsItXG+ZKlK2J6IsCBSNUy6iAf21OcUONNVqbUQoBQxBxVDl6Vc4MsMNqpwAaw
         B9uA==
X-Gm-Message-State: ALKqPwfTPIx1M0pToj38ebmMGqoAAVlaI5rsydmKOhcsRT1Ryp9z5Ma1
        yjzcU+zujXi758Zh575oS8r9iPj654Ns97TYoR9NPQ==
X-Google-Smtp-Source: AB8JxZqeKU9cJJOdQEx6yrno82e1AnQknuzjiOFUwVxmvibn5GPDJaongnYstMewaYnSX5TbdNzOl9wu2r0b3dKwbG8=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr3559039ybx.352.1527015719938;
 Tue, 22 May 2018 12:01:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 22 May 2018 12:01:59 -0700 (PDT)
In-Reply-To: <20180522114440.0b1aa23a780efe6a68770d9b@google.com>
References: <20180521204340.260572-1-jonathantanmy@google.com>
 <CAGZ79kb96Fxf1OBbnqmAtAm_EA5y9+0NKcNqhKjXhavWe6WzWA@mail.gmail.com> <20180522114440.0b1aa23a780efe6a68770d9b@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 May 2018 12:01:59 -0700
Message-ID: <CAGZ79kbe0mAQW-2iGX2Q+WEWJ-MEoBcXtyBOb8a-7iWApp7pqw@mail.gmail.com>
Subject: Re: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,
> I wouldn't characterize the errors as "off by one errors".

Yes, I put it in quotes but realized that would not convey it very well.

>  They are
> more like...let me use a diagram:
>
> A
> |\
> B D
> | |
> C E
>
> Suppose we know that the server does not have A, has C, and may or may
> not have E (we sent "have E" but didn't get a response yet). My method
> restarts the walk at all the parents of A (that is, B and D), but D is
> irrelevant to the situation (and should not be walked over - this is the
> error).

D is irrelevant to the A, C situation, but it is still a useful probing point?
So I would not call it an error but an inefficiency?


> In this patch, I wrote the new algorithm and deleted the old one.
...
> You're proposing that if I proceed with this, I split the patch into 2 -
> one to move the negotiation algorithm, and one to update it? If yes,
> normally I would agree, but the current negotiation algorithm is not
> very sophisticated (and does not take up much code), so I think it's not
> worth it.

ok, in that case I'll just dive into the code.

>
>> > +struct fetch_negotiator {
>> > +       struct sent_commit **sent_commits;
>> > +       size_t sent_commit_nr, sent_commit_alloc;
>> > +       struct prio_queue candidates;
>> > +};
>>
>> Maybe we can just declare the struct fetch_negotiator here and not
>> define it, such that nobody outside the actual implementation tries
>> to access its internals?
>
> That's possible - I wanted to allow allocation of this on the stack (to
> save a malloc), but perhaps that's over-optimization.

Ah good call. Please keep it that way then.


>> So even if we do not use the skip commit logic, this would be a benefit for any
>> http(-v0) and v2 users of the protocol?
>
> It would conserve bandwidth, yes, but storing all the commits sent with
> additional metadata for each would require more memory.

I did not see the memory requirements here as a problem until now.
Are you saying this memory might be too much to keep around?

Stefan
