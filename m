Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DE61FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 05:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdBIFJ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 00:09:26 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34391 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdBIFJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 00:09:25 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so12972617pfb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 21:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XD2d6CwUxMGlG+H40qptnNhaWRrgE4sv41Wr5AiURIM=;
        b=jS67aIA6SIER+vU5i82yLTMDhni4Wo5Wvu4e9qdu3z26nj6/VIai1tmHLD0wyacjLm
         Y5Tjv7k08D0+RSvgAXGePqd268NVfaqLlip5/fVfiuJ33MZxk3NkXua4G2pcYhCxkPib
         23XXoWS7Tsp8ERBuFsnDQpJNwR9zwuc6JA54mo7ZeEJSt0gaXuDUGzLeBwhmCXjMVcKg
         4npC00uOVlt7A3EKNTRrdHTM3z+BnPoil2JwmbyHgeucPEF/CjujV8XEyM/x+anCpeR2
         jrBE6ENwhMHbBgkq0SZ2kUEypR0haSphcNs8EqN/Z4fy304ksucWMWCNuEgITszbUqIR
         rNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XD2d6CwUxMGlG+H40qptnNhaWRrgE4sv41Wr5AiURIM=;
        b=sKc2N5k5WccIq2A11k7AleXf1by8X3fftfAC9M9hmyu8B6rswhCDkGEEtmYnzQG50a
         +oo4n1YJHsEV/hHGUIc8+wmSWizbsvMvjQ4QfKQxH1LmAf/RD+9Bm9UMSnD2Ch0bjT6p
         AxY2/Om6fz8ybQ7/PJxL1ZZSHA0FjNiXMn7nkNQjVXfNzXG1HrRUSWtsn0nd0KuvVERy
         e+mrlxBhZO1ZfarNSxPndxazXWM7G2TxJWFapnmVJmTeTL7ZBkx9Ja2txthT8hmEAeVe
         jXYehx5HUZsgK4v5RPLYeUg35TP+So7ClXjQmKKX6s4F164IOpkL6VLzNt5+FE6cN6dq
         CNSQ==
X-Gm-Message-State: AMke39na1uQJApbPW1KjT2maX+/COUCtuwzp4RiKfA1jH7e+OYbJB7jvrqZGk+EU6u4WtA==
X-Received: by 10.98.72.216 with SMTP id q85mr1564034pfi.75.1486616964501;
        Wed, 08 Feb 2017 21:09:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id h4sm24346318pfk.96.2017.02.08.21.09.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 21:09:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <20170209034657.qbkzbbzuvjpxl422@sigill.intra.peff.net>
Date:   Wed, 08 Feb 2017 21:09:22 -0800
In-Reply-To: <20170209034657.qbkzbbzuvjpxl422@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Feb 2017 22:46:58 -0500")
Message-ID: <xmqqy3xgrlvh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Feb 06, 2017 at 02:34:08PM -0800, Junio C Hamano wrote:
>
>> * sk/parse-remote-cleanup (2017-02-06) 1 commit
>>   (merged to 'next' on 2017-02-06 at 6ec89f72d5)
>>  + parse-remote: remove reference to unused op_prep
>> 
>>  Code clean-up.
>> 
>>  Will merge to 'master'.
>
> Hrm. Are the functions in git-parse-remote.sh part of the public API?
> That is, do we expect third-party scripts to do:
>
>   . "$(git rev-parse --exec)/git-parse-remote.sh
>   error_on_missing_default_upstream "$a" "$b" "$c" "$d"
>
> ? If so, then they may be surprised by the change in function signature.
>
> I generally think of git-sh-setup as the one that external scripts would
> use. There _is_ a manpage for git-parse-remote, but it doesn't list any
> functions. So maybe they're all fair game for changing?
>
> I just didn't see any discussion of this in the original patch thread,
> so I wanted to make sure we were making that decision consciously, and
> not accidentally. :)

Ummm, yes, I admit that this was accidental.  I didn't really think
of parse-remote as an externally visible and supported interface,
but users have tendency to break our expectations, so, I dunno.
