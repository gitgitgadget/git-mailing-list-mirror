Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D9D1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbcHLVoB (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 17:44:01 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36041 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcHLVoB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 17:44:01 -0400
Received: by mail-yw0-f172.google.com with SMTP id u134so22479909ywg.3
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 14:43:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m7SUnXMn59+U9TNfqzSlb9nWynyT7Fp4LefC4JnU8Ho=;
        b=U1RW6inAw1E4UKdQyEoT3XTO3tFUyo7Da8vfhuaNXWDjS5c0Cl/eyI0j6LQWutjLrY
         0AwHYSJ1j/j6yrtY/H/y0b0U9Ddi3ugK3BvVZDfae2zQhCMCoG8xmcsD+7lNQ6V3QkoA
         2tmmN5U+8TbUTYiMapHVByxA3pTrE/pDhuRYWLj7nS3lLTWgpZUBhTwV3nco9TxAe4rC
         JfJIzW4iT08UmrvuNPXJ7Ftm6shyyOZJJVILUAd2vkavkhgZGAC6amLBE4QP9aSF1NWN
         kcoWqsTaQaQDDuMEiEn/HdjoiUhjoPOEOy4Vz4lmjAM4C66V6ztdZANPJat6YqdpSL2M
         olRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m7SUnXMn59+U9TNfqzSlb9nWynyT7Fp4LefC4JnU8Ho=;
        b=B/56Ag2RMxfq+5nk4t8K6T6aUusgKYGuNQZRb+U61x7c8v/IBVF2D1CviYSp0CuC3j
         ZYY6SXg2y8cQiQRYtsh/cwY378DyMPEuIGOsgy737X6ZqrLCJWeZgz4Dbkr1jnsMFyHK
         HjW9pyShBePgJDcZQQhpvt2Pshm2VyIhlsOUoE6ZoezflsEU2/TNq1RRbn5eqG/VDfW9
         tJjOIEqwLcU+KO7N6zGS4dzCmXy1gf4Qy6pTZtn+BG+ejfYuQdMLuJDzSOBDB4Mhm7vD
         8xF5TlGq62hmsYJ7JC0Hzr2XKIBy3p2XLcIAJEwIknMgFUypv4QcBLWrQf5/lpmFBP+G
         6bjA==
X-Gm-Message-State: AEkoouur2lb8c/jXQu3jxWc40BMrqZinHHoFGX9AX0JFFE40wqrD+z/wwFp6WCUrAJ3v92zrVCiodrYOUGmlBA==
X-Received: by 10.13.197.195 with SMTP id h186mr12163997ywd.54.1471038235833;
 Fri, 12 Aug 2016 14:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Fri, 12 Aug 2016 14:43:35 -0700 (PDT)
In-Reply-To: <CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
 <20160811225946.18381-2-jacob.e.keller@intel.com> <xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Fri, 12 Aug 2016 14:43:35 -0700
Message-ID: <CA+P7+xq+GTbvzOtVvpu4_rdYYy-hhGZHhpk_ka=KkeU7UmQRew@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in
 a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 2:21 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Aug 12, 2016 at 2:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Otherwise, a "git log --graph -p --submodule=log-with-diff", when
>> showing a commit in the superproject that changes submodule from
>> commit A to commit B, wouldn't be able to run "git log --graph -p A..B",
>> i.e. as if the command recursed beyond the module boundary, would
>> it?
>>
>
> Hmmmm, yes. I'll dig through and see if I can get the prefix to be
> honored by the git log as well.
>
> Thanks,
> Jake

Ok so the big problem here is that unlike with diff which has support
for line-prefixes already due to needing it for graph mode, I can't
figure out where to get the prefix added for log output. Especially if
we want it to be honored prior to the graph output. This seems like a
much bigger task, which is better saved for future maybe?

Thanks,
Jake
