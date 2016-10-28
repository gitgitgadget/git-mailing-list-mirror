Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722CC2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 22:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756770AbcJ1WCZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 18:02:25 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33996 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbcJ1WCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 18:02:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id x11so55110452qka.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v8RUbRkDOvo6M3kBRelC58jmCE6DZJ2NdaaxIzhEEXw=;
        b=bbppfCaSeg/Pcq9ZhqAE0spW7il3S3s65shKgBLfIWgslf1pq4dw2g/aDogGS7zU74
         s5vnXIIIw05OKxoajIZeeGIaMzCn2M6R0V69v8eDdu86lmTMKTDvyIRHdodvAKMLB//S
         XUkpQ1PbvObbbxNH3QzDT93kjGi8/IqrrtZY9Rot1nU7aE8FacKqwpSEBFosELlU3Lxe
         Fga1X3pc/90NpeLHbk0Vv8eVQxblsFB0oRjs78L1l14YDGGQNUk5NYesgoPm4Av5L8HK
         2CotxcYR4PL1eqfdtUvH/c3r/qjtmrlmFNQu7r3/cQ6nDPxFvBARwtnpGOmP+v0fADc2
         p29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v8RUbRkDOvo6M3kBRelC58jmCE6DZJ2NdaaxIzhEEXw=;
        b=HMkasagmI+vOQSRyfD4Ju3qR35MUIA+VMRTDRZs4mM+5IiHjFPnKc4+i0l9LbxMo+s
         nLGJgF07gTL1bw5r51GaUbE0d7XiiWGR0NubG/FSOhwKLfpScZF6FqaYsh3DA5OeUyhK
         N9jVG2Pw5qlL5MqfMxrFchyafdAYRb7ffVfJ2kjRpjsRhDUXtZxdrYjChJ9OHHMuUfHU
         oH3BzajKG3QtVSrJnbLqnUO41oXRagbvC3q8Tll95x1eh829sVPLOA0i8quyEj8ugwCl
         IWsQ2VFq7HdQmW2fMVZBCEpxnNJ6iGoE5AZxZRUibl7fjFb+x5g/3y8g8rYvstIt1DeT
         os4Q==
X-Gm-Message-State: ABUngvdjBrHFogMgPCKNYKqJ8Nvf4ygBaPScQ3wiRL/F7yXRMU03A+dyek+JhA8moGxTPH5h86DzQcN9AnH0pObx
X-Received: by 10.55.129.1 with SMTP id c1mr12399490qkd.53.1477692143879; Fri,
 28 Oct 2016 15:02:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.34 with HTTP; Fri, 28 Oct 2016 15:02:23 -0700 (PDT)
In-Reply-To: <xmqqr370xi8g.fsf@gitster.mtv.corp.google.com>
References: <20161028185502.8789-1-sbeller@google.com> <xmqqr370xi8g.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Oct 2016 15:02:23 -0700
Message-ID: <CAGZ79kabjjtdpUw=KFj0CELrO5dxvx01JXVXWczhNcFoMjd+NA@mail.gmail.com>
Subject: Re: [PATCHv2 00/36] Revamp the attr subsystem!
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> previous discussion at https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com
>>
>> This implements the discarded series':
>> jc/attr
>> jc/attr-more
>> sb/pathspec-label
>> sb/submodule-default-paths
>>
>> This includes
>> * The fixes for windows
>> * Junios latest suggestion to use git_attr_check_initv instead of
>>   alloc/append.
>>
>> * I implemented the thread safe attr API in patch 27 (attr: convert to new threadsafe API)
>> * patch 28 (attr: keep attr stack for each check) makes it actually possible
>>   to run in a multithreaded environment.
>> * I added a test for the multithreaded when it is introduced in patch 32
>>   (pathspec: allow querying for attributes) as well as a test to disallow
>>   multiple "attr"s in a pathspec.
>
> I'd appreciate if you didn't unnecessarily rebase the series.  It
> would make comparing the new round with the previous one a lot
> easier.
>
> Thanks.

I can resend on the original base if you want to; I'd need to reroll anyway
now that the agreement is to put the attr_start call not in the Windows
specific parts.
