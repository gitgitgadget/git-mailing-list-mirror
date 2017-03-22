Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6D22095B
	for <e@80x24.org>; Wed, 22 Mar 2017 05:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758405AbdCVFsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 01:48:33 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33757 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbdCVFsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 01:48:32 -0400
Received: by mail-wr0-f182.google.com with SMTP id y90so6053234wrb.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 22:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+mlXfri8KH2VFgWTgPK+j0jDMGCmOuQv9w8dellV/iI=;
        b=LxPtcgkR0104EVHLMMkYq94eoz/gTu9d/BDgGvnIm5gar0kF/zFvFDX40XqHD3iVpx
         /Hnbb/hS5YTfrNs+/JLSzJ9WsZGepNy3M2YYBfkzDLROMEQJjimEAZ0gZYj1CozexHiv
         knb2f0fzBy5eYqeOSFRq74xjTui1NhdEZ3lf2gwUeT+/Eo+hiAQS3a2MqQcC6aomq0+s
         7IXKjFHsjdJAM+voHybgD9hvi8FnY1Vvy07odhFxZimhU4RnxyGMZ9gAHnXzRDuH9/5y
         egTE+iXzbmvO170S0nuH/VodR0j/GgIVaNpOwBL3d5oVM8A0wIHOZWBv3AvF+DgmHSRr
         i6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+mlXfri8KH2VFgWTgPK+j0jDMGCmOuQv9w8dellV/iI=;
        b=sYcuGjiM+TdXD7SN+mL0lJuIIesrhnlTgbNiHzF1svJ58OZtLP1l1Uh3AWwT7zZc7G
         OVDWI9MiHasrf0w6nnr8luCQEcc8cISpzGdJmA8W/YJ+duRLavjqBR+97/IUim7oxnCx
         slpmT5BUHdxCN5cOhTu72mzr/9TkP5GO5nRVEAXACrX3BvT9GDy6N5Dgukp0Xf0hIrjI
         +IMbLgXLf6BPWgHpQhP8T4dtAo4VR0m5HIMUAYn9Z/SDhzpc5jHChpt2Zcg9RQ2fsyaM
         /bk0tf7MIPfoAWQGNJ3Lre9QIm+Jn77W2J1hNAvuMKPtsfjZgt/FbsGqY5ZYC9p/1ihu
         FLOg==
X-Gm-Message-State: AFeK/H0HjgaG1XfnB8AtqA7JUsv1aXQNHippX09r93b35H2w7vuQp5Ns0ltUMr3gHfQcuVXRG5+G/neCm4Cp3A==
X-Received: by 10.223.130.144 with SMTP id 16mr36910220wrc.32.1490161663853;
 Tue, 21 Mar 2017 22:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.91.2 with HTTP; Tue, 21 Mar 2017 22:47:23 -0700 (PDT)
In-Reply-To: <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
 <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com> <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 21 Mar 2017 23:47:23 -0600
Message-ID: <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-03-21 16:28 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  test_expect_success 'log.decorate configuration' '
>>> -    git log --oneline >expect.none &&
>>> +    git log --oneline --no-decorate >expect.none &&
>>>      git log --oneline --decorate >expect.short &&
>>>      git log --oneline --decorate=full >expect.full &&
>>
>> This ensures that an explicit --no-decorate from the command line
>> does give "none" output, which we failed to do so far, and is a good
>> change.  Don't we also need a _new_ test to ensure that "auto" kicks
>> in without any explicit request?  Knowing the implementation that
>> pager-in-use triggers the "auto" behaviour, perhaps testing the
>> output from "git -p log" would be sufficient?
>
> BTW,
>
>>
>> +static int auto_decoration_style()
>> +{
>> +     return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
>> +}
>
> FYI, I fixed this to
>
>         static int auto_decoration_style(void)
>
> while queuing to make it compile.

No problem. Do I need to submit a second version of the patch with a
test for `git -p log`?

-Alex
