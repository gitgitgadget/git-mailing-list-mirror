Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862041F404
	for <e@80x24.org>; Wed, 14 Feb 2018 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031308AbeBNUQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 15:16:44 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55808 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030531AbeBNUQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 15:16:42 -0500
Received: by mail-wm0-f48.google.com with SMTP id a84so13706396wmi.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 12:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7Nv8oQ/NGyhYmrmE7wRM/e64NV6XW8SJuVdtHLwd5z8=;
        b=hC60wFT/aR6kwXsye9+Qiyi0K5XUFcHE9HLCuy0Z5lJgI7G3t/sVSO1z7ulBKrlsJK
         oZAhQrE31Cdltq+uTFU3EsFj07xuho7mNL66cPSF/v1L8BgwIKcqWsUD5Tz8iUJpGYOA
         mpXI/Nnu+/06e0rAE5cccQBIoMZsHaQtynoS6DxYlXZ8PJ4QYhzJFPgssO+KLwvVl+rG
         ow/XlO/SMoXFKy8colkwcJE08QI3s3DtCCHX9I3e/gyoRFU8hkZJv0AolU+LgsSt9u/u
         OaQVtCmHYMJ8P3t6BFZHMe/273IEfup8pFQqQVJY2GCs5Py1knGTmQXegLVmJ4w1/M6e
         5F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7Nv8oQ/NGyhYmrmE7wRM/e64NV6XW8SJuVdtHLwd5z8=;
        b=NYPTypkpMv32BQFezQ3muwBvH/0ohF71qF+tp3RCP3Yyayjox//K04ZMMPGB2iIhfe
         QD0uccuPFzZnMigLOSlcqa9zkKod6jXHA36mGXaqWlkoBzFUe6dWwWHiHpZDI6yfkLMh
         6kjCdZ7yD7443v934ldy4fTVs/N4mApzJvOiHxTB2ClUwPiF7NvneCLWbzdAr53bVQpw
         oBPuli5iHnqq+KcfwHODNMIIYnEkqePZyWt6uAQyo2weTiM3+dJCvX4fRSqSkiII8ASy
         wiYbPIJ5aDv789A6oHKyHxwrel8wrMyRwb6TbMyxUM4/q2650lKN6dc974B6ntsg3U9q
         ybCg==
X-Gm-Message-State: APf1xPDxJx3Gs6h27CNAnZBVzUwvG4RU4+3jcPUA/MlWHTTYgn2tjVAG
        vU7A300yYyOlbgE6CPC7jUo=
X-Google-Smtp-Source: AH8x225ftXNJckayQjMZx2TV2lIlvOccY26vrD8iIKp3w1huMsBjKG7sbqjpVgzpxuA9OUc/7OvkWw==
X-Received: by 10.28.71.198 with SMTP id m67mr249968wmi.40.1518639400958;
        Wed, 14 Feb 2018 12:16:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 56sm22536880wrt.23.2018.02.14.12.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 12:16:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEdAgpLMYW=i6ABzWHuqQvJcXDJ-6u-VuFAtU8sxiLvHA@mail.gmail.com>
Date:   Wed, 14 Feb 2018 12:16:39 -0800
In-Reply-To: <CABPp-BEdAgpLMYW=i6ABzWHuqQvJcXDJ-6u-VuFAtU8sxiLvHA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 14 Feb 2018 11:07:03 -0800")
Message-ID: <xmqqlgfvmimw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  Rename detection logic in "diff" family that is used in "merge" has
>>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>>  z/b and z/c, it is likely that x/d added in the meantime would also
>>  want to move to z/d by taking the hint that the entire directory
>>  'x' moved to 'z'.
>
> When you write release notes for this series, you may want to consider
> also calling out one or more of the bugs that were fixed as a side
> effect:
>   * a bug causing dirty files involved in a rename to be overwritten
> during merge
>   * a few memory leaks
> I added a reminder about these two fixes in the cover letter for my
> latest (and possibly last?) roll of the series that I just sent out.

Thanks.
