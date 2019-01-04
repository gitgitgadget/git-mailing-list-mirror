Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD88F1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 11:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfADL0C (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 06:26:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35346 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfADL0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 06:26:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so909601wmt.0
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eIZVPgkjsgS6Mn66NDxLBtEkcEKe84r8d61Qhal3UZ8=;
        b=fAP7H3okv/ZhRva2wnChU0eDqnHg0LEPblJEZROhsb1L5SnUssl8GjpYtNF4IA/PqB
         aIviHMogU+3rwARCAbKJcbAZ9AnRdEFE8ylGIZr/xXUV/dUUB150lifRjDFt80D1FUSA
         OGqfD7yAFHIlsGSIkmcKQ+Xa0LRBfkjbnVH4X2BIRMJfBJShEORNKi4N0fVj52oegtVM
         hAA635+97ABZI2qf3FBBWNsKZQSFc+W8sSzjJShkwLOZlZrOiaFtd6gG9brd2A1KHpnO
         qqsuAYZKEPvqP0fz+gBfAGqbpl9wqqKPJNTd0zEsS5wB5uWFYXX63bjFrVvyseVmNoER
         T+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eIZVPgkjsgS6Mn66NDxLBtEkcEKe84r8d61Qhal3UZ8=;
        b=FI/LZbFaJ3Lcw4z4e6lhkZjTHHFN7xcK/5nwqmYl08VTLB4KY6vqInHVjkZkv9/Ywd
         snahEmqUGelGBjiGzoYn/ZOIZ3GZJoeC2XL/epqbvKAKLqmj+rTt3gbKOKzNyNgKqLAf
         oB4YyYYT9Xqz+wBLBqqtNwlpcx3vJNTQq39SbUL0Q8nOUN7lSm//nyQJ/Qr9l5o8RDX3
         cmOCZt7NNILu9YHPlRu8Z8blgCY44oQQ7dxpgOH4TaHuI5kZdw7knTOf3jzBnBPEyAtw
         xn+g+H6SNJ/3oBWD2WsFUGKfmq8tydJjjhJ+cTQaJkxqo1VvDZJn4YUQqtJWxad8BPP4
         WTnA==
X-Gm-Message-State: AJcUukeEaVENkH8wQKrdXHyQVfaXBlvLndIrFn5ONWcvd+BFvY3e072C
        GZBpdPQgxKN7rRsPvO5cXDSWS+Ba
X-Google-Smtp-Source: ALg8bN5NLTf9M1c1rmlIZNmwU5SH0A09VHBuHiWVH9pUsnZM/RUOmjeqHw+8kZvzplXF9GiVVf/ajA==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr1078359wmi.144.1546601158930;
        Fri, 04 Jan 2019 03:25:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k7sm43345978wrl.51.2019.01.04.03.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 03:25:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] test-lib: check Bash version for '-x' without using shell arrays
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
        <20190103114317.11523-1-szeder.dev@gmail.com>
        <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com>
        <20190104093015.GC4673@szeder.dev>
Date:   Fri, 04 Jan 2019 03:25:57 -0800
In-Reply-To: <20190104093015.GC4673@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 4 Jan 2019 10:30:15 +0100")
Message-ID: <xmqq5zv4fyuy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Jan 03, 2019 at 12:29:35PM -0800, Junio C Hamano wrote:
>> Let's treat this as an independent and more urgent fix-up.  I think
>> it is sufficient to apply it to 2.20.x track, even though we could
>> go back to 2.17.x and above.
>> 
>> And then let's tentatively kick the "stress test" series out of
>> 'pu', and have that series rebuilt on top of 'master' and this
>> patch.
>
> I rebased my '--stress' patch series on top of
> 'sg/test-bash-version-fix', and the result is the same as what's at
> the tip of 'sg/stress-test' at 1d1416a34b.

Yeah, sorry for not reporting what I did after pushing the
integration result out.  I ended up rebasing the stress series on
top of the updated fix with eval myself.

Thanks.
