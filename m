Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5061F424
	for <e@80x24.org>; Tue,  8 May 2018 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755771AbeEHUhf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 16:37:35 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35545 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755753AbeEHUhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 16:37:34 -0400
Received: by mail-yb0-f171.google.com with SMTP id j143-v6so2508195ybg.2
        for <git@vger.kernel.org>; Tue, 08 May 2018 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S3EtvzHZQnVnmXs3izqBC/5MViK41DOtYAOSsJKvZ3w=;
        b=pixv8zuiC40swJLDMPOTT3zxZmaBE93wpDTjM5Lsgp32J96yYYcx1ILwh4JDAquSjB
         KavZCqzvWHKQA/MfEgHPvOtIEcglaI9FE/AqW+JDJpd4AO88ly/nXtAo7F2lChXCR9b6
         1E8FPNxSJnk5dMILVGLmDnBCjWwu08LKQ+MN6cowQG9KeUz22eKZDkXu1Kblzgr4I0op
         wrsKVsQcP3ZzEtY/7y8TRxZF2TXu8EZj4iekYo/N35LJx1oOxcG87lBtMJZoqukQNXTm
         N/MtDjfFi5eHRdNxD5qYPeHIOnA6ijQgJR4I4hRW4IEx9pjRmGlrpieD8k9FgjY5USVl
         XuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S3EtvzHZQnVnmXs3izqBC/5MViK41DOtYAOSsJKvZ3w=;
        b=ChB1J7Wrc6cid2KAwAYG3x2yP/mT978l1iI1PhlPytlhvbvz3iHc7EEQN0oAxMicXV
         /Q/64LxyUA4xkDW/Xc71+lgxluER+tmzutF9j3Sfu/X6gvguxVzON3M3mCXUGNk0NXT+
         z8qlKVznJTbxItWcZ/bou+K4bEDYNjT47DV8YUfoBfmKho/RvqnHwOKvk/LomJpZjbUd
         DTG0ODNJ0/3oZy5XOcd2L3uLCkeGYIL3/TtcfbpANSUFGJD+OpoZ2E1n7mwxqcwBnxG7
         O8m7MxtqioFCxSp5XmRY2hVXLsbR1Qlj0HAWk/Ox+udrwhp0bvS71bh/3Uu+t6Eew+TL
         e5Mg==
X-Gm-Message-State: ALQs6tB98JAGuLPbn840pdusPrmtTlSa6sJRBKmV1m8c03Elx3tIKyhO
        GZndBWE04Kt4ylBFvLY5OHwAPv10jcWON5wVlXoLEg==
X-Google-Smtp-Source: AB8JxZpLcbUP+XO7IjynrGIcqfh/eebGN9/LFiPToB04ifzPxCK0jTzec+eVbRQ3On6HXt9OA+yazbgS/yzPoTqma3w=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr23627198yba.352.1525811853646;
 Tue, 08 May 2018 13:37:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 8 May 2018 13:37:33 -0700 (PDT)
In-Reply-To: <20180508130431.287a9f273a847c375b3b1e2b@google.com>
References: <20180507225916.155236-1-sbeller@google.com> <20180508193736.14883-1-sbeller@google.com>
 <20180508193736.14883-14-sbeller@google.com> <20180508130431.287a9f273a847c375b3b1e2b@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 May 2018 13:37:33 -0700
Message-ID: <CAGZ79kbgxFJ-+t=50r9gVMTm4xomh+pgm81r2QLnDvTqxpxV6g@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 1:04 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue,  8 May 2018 12:37:36 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> +void clear_alloc_state(struct alloc_state *s)
>> +{
>> +     while (s->slab_nr > 0) {
>> +             s->slab_nr--;
>> +             free(s->slabs[s->slab_nr]);
>> +     }
>
> I should have caught this earlier, but you need to free s->slabs itself
> too.

ok.

>
>> +void release_tree_node(struct tree *t);
>> +void release_commit_node(struct commit *c);
>> +void release_tag_node(struct tag *t);
>
> Do these really need to be defined in alloc.c? I would think that it
> would be sufficient to define them as static in object.c.
>
> Having said that, opinions differ (e.g. Duy said he thinks that release_
> goes with alloc_ [1]) so I'm OK either way.

I would have preferred static as well, but went with Duys suggestion of
having it in alloc.c.

I can change that.

Thanks,
Stefan
