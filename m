Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C5E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 08:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfCRIPm (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 04:15:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42445 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRIPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 04:15:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so11812375wrr.9
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PXoBIRI38QzA6IKTPiV+7sxLpcHnxGv3Cx5uX2qiVcU=;
        b=WJQtAyUrElAL1Bw0Plf/9g1SwJq7Bd/N7C5VZRvsHiTLCZ6MDdpGg5m/PKasoPKF3P
         iiBn2XiATGgilFLgaaHLhsEqW+6NSlbnYPZyHlf2sp/RZ5hJtkMFz/P9tyw1fWxfMBnt
         qpMsWYoCD2/KUM3mEQe6Bdqtog0xelyFbwBSLNebMWVnLIByX7Yxi0/Oqs/m1W9b676B
         n910jMyda9X4OiZtj1d6LnLFDOwpfgmhonDJNzjQaTFNHc3xeqHtXXDaNBXkqZJgxqon
         nmJhcMr2dE2aT8VY35Yu8wePyz+bgC5HfBTrRMUn1dZfcDzIL7GFtTqLTmEZW5W+OusR
         gwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PXoBIRI38QzA6IKTPiV+7sxLpcHnxGv3Cx5uX2qiVcU=;
        b=chqE56ajgR5wTICOZdPjMJMu3hpAubDONx1ovXzlOQ8YbNL4hisCqu9YS62fxz7qyV
         ixT8XpvrZSn0IL3W0GUv00NdrMEyE+NLcgZT7ld2Lfcu2VD1v6+/bdyEp57a5rp5qsGZ
         7mrGc3Y4BEwe1UDa0DbD3SLjAliYEe1JaH3NU6nlxZDjPwwvwjLbqEf9WQ9iBC/nKZsw
         gy6KI8Zm60KZhkxEC0XaIVcxxSKI88zND9jlVQfWFenI1T61dzD8r5dpazjLcJXmo8KD
         o1s4Zp0DmL+volhxbHPlWl0oXASWzDY6E2VEY7ynoYNHvBr6MMUBRZ7n+mVp844NJVPJ
         tK5g==
X-Gm-Message-State: APjAAAV5XzwRU1H5viPZn/p3WYr+G1DSJk5+OaM4nWM+Ka5uXqrLf50x
        q471xGgGo8vtLMfYgDl0zzM=
X-Google-Smtp-Source: APXvYqwq7Y+eEKpItYjY00p/loKp2EGkZGPUPRVWLh7/d8lWrje2I+P1KJvl1MWL2hp0fooANJRzqg==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr10551287wrs.157.1552896940048;
        Mon, 18 Mar 2019 01:15:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w24sm6307889wmi.40.2019.03.18.01.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 01:15:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Chang <ttjtftx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 3/3] t0000: use test_line_count instead of wc -l
References: <cover.1552835153.git.ttjtftx@gmail.com>
        <bc3dee82a91592e50fd39c5a332b13b76fefa009.1552835153.git.ttjtftx@gmail.com>
        <87h8c1a1mi.fsf@evledraar.gmail.com>
        <20190317200609.GA1216@hank.intra.tgummerer.com>
        <87ftrkab2w.fsf@evledraar.gmail.com>
Date:   Mon, 18 Mar 2019 17:15:38 +0900
In-Reply-To: <87ftrkab2w.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 18 Mar 2019 08:36:07 +0100")
Message-ID: <xmqqpnqozjh1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> No objections to changing this, but I don't think it's the fault of a
> commit message if someone reading it doesn't get an explanation for a
> future unrelated improvement.
>
> The times when a commit should have such an explanation are cases like
> e.g. introducing a function that's not used yet to make a subsequent
> commit smaller, or other such cases where the change is incomplete in
> some way.

Deliberately omitting an obvious improvement "while at it" would be
similar to adding a function that is not used yet.  Careful readers
notice "why don't do it at this step while touching the same area?"
just like they would notice "why do it at this step when it is not
yet used?".  While it certainly is *not* required, they would find
it helpful to answer such questions, erring on the safer side.
