Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57FE2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbcGGUBZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:01:25 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35449 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcGGUBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:01:23 -0400
Received: by mail-yw0-f177.google.com with SMTP id l125so23525619ywb.2
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 13:01:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=c0gcZ25dfp1ZZN9A7mWW7oLmLhqS89p1fFmzLtA4IcQ=;
        b=TbC3IhL2oYUl8b0udOCv5pjZLsk+qqxo7cqkd8iLw8RljVX9l0IiZXXudBnL5r8/49
         QZMomtkcQFbYJq9PnpeBgy64Z5FiucXWkEcz+AEY2YgxIcl6wEbNIaG+mDVfQIq7Un98
         4/rD5E1/yG3EhSpEYsUAoFOX2hst2KX7kk9aMXE9RlWTFC66c9ZxBOkdB5ZqPY2olIr7
         urweWGkbwutmP+TDI4xES7SDSD3SqNZRoe7ipWHUJbL/a+UfFjiNxLT0fXDwpCaYPQly
         f06QC5uU9RUjxEL0777O7XuKNIv6cJqTth3tA2VvYWmXe94UAjw7QAeek+TZ8hFFPri9
         IAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=c0gcZ25dfp1ZZN9A7mWW7oLmLhqS89p1fFmzLtA4IcQ=;
        b=SMsxclA2jmCsRepW5w6xpNHS7zkPWgQE9AlTDg6rZ3L3xt4A8MRM6t8D4v/Utw0/Rl
         gTtod9D4ucATfGjFcV3i/ZeKaxgoFjk5P/ZHlVVdqi1V8hUmRQTXLgL55TptEOQ3jyft
         LjzO+J2Yv8LA7SdQmlMKud5OzJ+/C/J2mux6gtH5QLxa+fx2qmrRtnwHm+ttYNtQ7e1X
         Jr441Iv4H7eM9Lp5ShuPZl4D3hXKNBn1zZLm7aosizA+jMlH2dvc6MWEOEvfesrMRtt7
         SngzA06WOr/m3i7fJ54Zb3zBAhDpMqZEKqSohjl+6kMbOw/uCX8b0fKfPO3xy5vPKMnR
         Sa6A==
X-Gm-Message-State: ALyK8tJQw8YTkjNAIj6ne0GkM1bBD5KM1T48h7qYIVK4a7dCH3Guu22ESR/5HiXN19CKvTUUStB5GztncPqVXw==
X-Received: by 10.129.89.213 with SMTP id n204mr1832210ywb.176.1467921682596;
 Thu, 07 Jul 2016 13:01:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Thu, 7 Jul 2016 13:01:03 -0700 (PDT)
In-Reply-To: <xmqqinwhp6pv.fsf@gitster.mtv.corp.google.com>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-5-sbeller@google.com>
 <xmqqinwhp6pv.fsf@gitster.mtv.corp.google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 7 Jul 2016 13:01:03 -0700
X-Google-Sender-Auth: 0JtCTaoJFxUdu47lkj5YjSj8AMs
Message-ID: <CAPc5daUnUtUK_9caymCkhkdH7DQSEY_UhuyraJmeo9y4Mo86yQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] add a test for push options
To:	Stefan Beller <sbeller@google.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The functions `mk_repo_pair` as well as `test_refs` are borrowed from
>> t5543-atomic-push, with additional hooks installed.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t5544-push-options.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>  create mode 100755 t/t5544-push-options.sh
>
> FYI:
>
>     Applying: add a test for push options
>     Test number t5544 already taken
>

I'll just move it over to t5545; no need to resend.
