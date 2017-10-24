Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634C81FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdJXSsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:48:14 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43510 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdJXSsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:48:13 -0400
Received: by mail-io0-f196.google.com with SMTP id 134so24958802ioo.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4gvpIOr9me+63gdj8uYXyyvS9LgUO76KaTY9Zjj/FQ=;
        b=XGzOqVuPKpzI8s2rYhvLUy3+ROx5cZMjFQtqcgRqpLIK638M/kYv8/GPmZ82qNVhSV
         MZbAoQ7bU5khrrPoT3VqCxPyOzN+e61NbfpTMJ3032L7QQ6BTWnUmYUa2tJqdJpiK0nJ
         dT46wRApDZVeamLsy2JT+LfFn0uUdL1rWBWfsJJKlxMmFpSelR0JP5rDx/5spR1FwP4v
         B4Rzmobp2EHjr6mKAASpsrVzC8aSUp2xIQYj1PcKZM+3q3YDsz6rdNvEEmgSu5LpyaHR
         3qCuokKz5zzHi5HwLnr9clFiUL9Go0COVSBiwz03SrpuXxhbZVAhH0gauJS5/8Gc1OIb
         NOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4gvpIOr9me+63gdj8uYXyyvS9LgUO76KaTY9Zjj/FQ=;
        b=hga0HM7gA7vRxDcCHpKLvSTUolP8ni3Mrjnmgv+HH+ymm4I+3l9+M0D8k05LZ/Jf18
         T8aZBhIB8UVLUfcaZzkNSklfO80ddLQLMjVbcQX2lexUSBxGEG901dpSosr3mKzTZZ5Q
         lJmokFvG9kcjvStBJ6KFkDjDN8MvL2L/f4kSYBuywAfiYYtQAApLS8h2KEjsUq+WfDQf
         I41m5uvQNPMJb+EC6WEL9nqwPYXGqBzYKsRCcXXTIdbD6WspAmQYA9qx6WJUWqDVcKJm
         XqnqihG1HUSOTPlviDXG4bGN02pYIetkZFkOw6LDqXVPn38TifbWaDjUs3dIeZnIDytK
         NPFQ==
X-Gm-Message-State: AMCzsaVOS24KFW+yzgy2DXEyh3S+cTFoWHGf6LYeIsu1czPtLutvyfrd
        HIWTMZB0rWFxSsL+qqQOR22DBA==
X-Google-Smtp-Source: ABhQp+TvhsIgwBLeQW3TqN94CKkOqxP3Q71VQRgxZvyWNCC/a1CIfHRgD+t93q0DXLMP3WM1oJ6GJQ==
X-Received: by 10.107.13.134 with SMTP id 128mr22191486ion.160.1508870892274;
        Tue, 24 Oct 2017 11:48:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:89d4:9a95:7fcc:a26])
        by smtp.gmail.com with ESMTPSA id g84sm355664ioa.82.2017.10.24.11.48.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:48:11 -0700 (PDT)
Date:   Tue, 24 Oct 2017 11:48:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bturner@atlassian.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        peff@peff.net, wyan@google.com
Subject: Re: [WIP PATCH] diff: add option to ignore whitespaces for move
 detection only
Message-ID: <20171024184809.GC79163@google.com>
References: <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com>
 <20171024000931.14814-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171024000931.14814-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  diff.c                     |  10 ++--
>  diff.h                     |   1 +
>  t/t4015-diff-whitespace.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++-
>  
> See, only 10 lines of code! (and a few more for tests)
> 
> We have run out of space in diff_options.flags,touched_flags.
> as we 1<<U31 as the highest bit. We could reuse 1<<9 that is currently
> unused (removed in 882749a04f (diff: add --word-diff option that
> generalizes --color-words, 2010-04-14)). But that postpones the
> real fix for only a short amount of time.
> 
> Ideas welcome how to extend the flag space. (We cannot just make it
> a long either, as some arcane architecures have 32 bit longs.)

One simple idea would be to convert the single 'flag' into various bit
fields themselves, that way if you need to add a new flag you would just
make a new bit field.  I'm unaware of any downsides of doing so (though
i may be missing something) but doing so would probably cause a bit of
code churn.


-- 
Brandon Williams
