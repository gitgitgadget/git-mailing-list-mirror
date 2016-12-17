Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92B61FF6D
	for <e@80x24.org>; Sat, 17 Dec 2016 08:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbcLQIDC (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 03:03:02 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36634 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbcLQIDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 03:03:01 -0500
Received: by mail-yw0-f177.google.com with SMTP id a10so42826949ywa.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 00:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+x5OJANDpqdVb/QAgYtJhOR9jL+XzXXm3OvQGc5txP8=;
        b=NXo9uDmhU3jeNkTNXL1kLWhWm5N8I/+m4EFC9tTJicdqo20hQYSkcMzQNrZVxukpwo
         UlMSG5427k3hUn7PDJKSEo5kFMELpYNBp0GArQMJFEgrHPi3MmRvV/s39iO7YR14yaTF
         5ChzsWVF1xHougnRpwNVgXEw5+mPoeA3HfR1STl6Y5iJgNGZt9YZf/UcKr9be9w9cnRt
         9fW/wJuXuRolmxI94wqrLl+jtOGk9WJSJPqrjmaWRztA66NxmrjPbIQP56v80NDF1Z05
         zezLGMt/dcJdplF9anEn8O1lyjr7LbGtbL1x6SE+GTlcA6ZQwoL1ryTjNk7UwCrWzxbi
         Lb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+x5OJANDpqdVb/QAgYtJhOR9jL+XzXXm3OvQGc5txP8=;
        b=k47trovRcvSAjIixHxFLYflXP6ThqWZvo+rwJfB4DmDM1/B2Uolp1g+QrLp62hLXtU
         XCJAtP//ut3LTPcw+rajfGwG3fusajcDvfGqqv7rf+wNbbm/8Kik4Oeqg5DdnmDtK4/l
         IMrr2jlr3FTCNpGwapQVugjpsBOaqF8dgLYvlZz3EMfMqBtD5veHt8Q03p25fMmYJnW1
         txbvkf4agdmmhWKVVSaJdIxFkUdfEj6ev3vBo7U+lSKRYtOFYLYyFvVVbOnQl1VtU9E5
         ByMrTorPpQ3jtDyugBW32R82KtmimGRtR0mGdOP8TZQrnsNPa0iaEHKjOwyrpDsWLYvZ
         2uyA==
X-Gm-Message-State: AIkVDXI/WEA66CX5gP5x7rYgKpUbEQ0ejUfehMU8QHQ3qcj6Qr+ZfcUyKb8hvw4DrKeAtMhZYfx0jTezkyDp4w==
X-Received: by 10.13.254.71 with SMTP id o68mr5893281ywf.318.1481961780581;
 Sat, 17 Dec 2016 00:03:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Sat, 17 Dec 2016 00:02:40 -0800 (PST)
In-Reply-To: <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
References: <20161217005442.5866-1-jacob.e.keller@intel.com> <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 17 Dec 2016 00:02:40 -0800
Message-ID: <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Although I do not think we should spend too much braincycles on this
> one (we should rather just removing the older one soonish), I think
> this patch is going in a wrong direction.  I agree that "the last
> one wins" is a bit hard to see (until you check with "git config -l"
> perhaps) but it at least is predictable.  With this patch, you need
> to KNOW that indent wins over compaction, perhaps by knowing the
> order they were developed, which demands a lot more from the users.
>

I don't think we have too many config options that interact in this
way, so I understand that "last writing of a particular configuration"
makes sense, but interactions between configs is something that would
have never occurred to me. I'll send a patch to drop the compaction
heuristic since I think we're all 100% in agreement that it is
superseded by the new configuration (as no case has been shown where
the new one is worse than compaction, and most show it to be better).

Thanks,
Jake
