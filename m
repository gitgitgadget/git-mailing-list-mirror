Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20527205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 13:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755974AbdABNkP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 08:40:15 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36588 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755769AbdABNkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 08:40:14 -0500
Received: by mail-it0-f65.google.com with SMTP id n68so47916945itn.3
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VHJmmCPpXTBc/NXBSxITtPwD17+WnDqDCCLsSNkJFJU=;
        b=Ka0nw0gm3T/tx2EoXQaAvzk1b9RZUeQe2nC8awXlmPvZhgDp9wOWyKFPeBV6vPtqqD
         ohkUhNaT8O1zv0Z/jzjdGkvj9o7FEdtPAYBNpA1YMHATxXbYASHj+k4/tIozuzP99Vk+
         p+49DQw2LAFSbI1p1dvbN3u65yptPbc/waV9HkocnLgfJWfReTPX0L1Z70rCx7c1CtgD
         iI3C6S7ch0MUFCK09SViwyXkrdyOwrUNXodXDNqloyxoZpd266gy+oLyKt6KGBgXPQYL
         IebPU4riH658ZRkmyCaCvTOktMsep6LlqyUlqK9BziJwWk7VK58J2mZM7v73ztC81il4
         mMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VHJmmCPpXTBc/NXBSxITtPwD17+WnDqDCCLsSNkJFJU=;
        b=Uj6V+EmFaU1CTDIywi3TdW9wzgY25LDTW+1Z7QNHVEdEoEfRHoylwNhLNVzMc4hRQQ
         XA0L/YIbniArOdCCVnu0m5RzPK0UOhi+26/SRsqDC4SdiW0PjjLBG4U33PDSeJRuHWLr
         yarjjE5VJM9gQXrsNGxS1TuxR5fj7QOXgBgZSXSM7TYo3V1EDuV7Fm1ZnVXjJ4hkOu7L
         WlNdK+kU97AZaNAtXGcrzKX3AMKP22TsS9KhHl9sYJjt4ZSvwJD2hUdxTLjLq7yNMTH6
         uS+PlTYZZkQxsu223CzroBxQznyE0KJUcHRF3wXt/hIFRlolPuzkYr2VbWE8Zf2fEXtC
         dyyw==
X-Gm-Message-State: AIkVDXIO0K6iyo0OBtvPzHllobBEk3WwNMx3A1SGkWwzml7sABVhW3rEf2RAckg+0rwQfqv8/cUp2z511jlWgw==
X-Received: by 10.36.216.132 with SMTP id b126mr51153421itg.45.1483364413318;
 Mon, 02 Jan 2017 05:40:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Mon, 2 Jan 2017 05:40:12 -0800 (PST)
In-Reply-To: <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com> <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 2 Jan 2017 19:10:12 +0530
Message-ID: <CAFZEwPNbtamFfFy7vYXurpEWBDmRMyPB9+Ep-hm4uZVMREbq5Q@mail.gmail.com>
Subject: Re: [PATCH] don't use test_must_fail with grep
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes,

On Sun, Jan 1, 2017 at 8:20 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> which makes me wonder: Is the message that we do expect not to occur
> actually printed on stdout? It sounds much more like an error message, i.e.,
> text that is printed on stderr. Wouldn't we need this?
>
>         git p4 commit >actual 2>&1 &&
>         ! grep "git author.*does not match" actual &&
>
> -- Hannes

This seems better! Since I am at it, I can remove the traces of pipes
in an another patch.

Regards,
Pranit Bauva
