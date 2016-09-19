Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A441F2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938866AbcISNR3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:17:29 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32847 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936528AbcISNRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:17:25 -0400
Received: by mail-io0-f180.google.com with SMTP id r145so90627717ior.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C2KI6s3MgpPgUm+MdR4MjgZm9R/B/xF73HTGLnEuykw=;
        b=lYoNzYgcXddFk4i7aiR1k2l628S9WAn3zYEhItQP5G0LlUETBvKW6Y8CKerVStiNyU
         8F+EwFYwFUJzX9IGCDn9MrvjwFlecp5HAfoBYbOVrk+ljtFgfcCb8jkoCFf+dnBWRTer
         ipCPsGk8d5yY1OSEqykoUjI+TJmdEzzR1mbb+daLDqnHCLf5r9mtkW96N7ni4n1cdFD4
         1K5izOdsVwMONfKn519LsVd6FnFVuxPMZSela7QtTr8rG1DNbYEFjwYeGHtjEJYHTEZL
         MuqVuvB6rVPrnzv2IT0syn0rzq155QUhp3ybv6DU8bw1qDA9mKt7soLhb6UWhBPCIKW4
         iXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C2KI6s3MgpPgUm+MdR4MjgZm9R/B/xF73HTGLnEuykw=;
        b=ZImYpAyPcvtfQl8mCgXBzXxIDfyBHZ7gaVgcFGCsuhys5mmnu2vzrTsjsZkFmUP6XJ
         6+oyIg4nFG5qDUDngVowiN/Fir/59d7Gmj3DvcC8qOh/HiKe2JfWEyT1aqZHuMFZzkyq
         oqVKb99YUalLInsfMjqOYVZCfejhe1trX3c9KKgsgH5KJ8sa2Bx/aWsLzX5PAhYl2Aho
         9bRcBdIOOxp9lWy9nlgRXxVvtqOAMQvVfyuR3r4ELMlxWhOzkb7aC24TtguCM6EGHEDz
         VpfhRoTDbE0LDpvZkOYwfvWKV4h6eOevmzPN19rh8qGRhAkidTFZiKK5e33TScgXQaLo
         8L2Q==
X-Gm-Message-State: AE9vXwMvOQdOZXOg36xPWOro0EDhiCb9jLxzeGWd9Y6kAKzsz7e0TlEDg/t7zp5v8tKi1PUFAyPZ3eAcoaSrQg==
X-Received: by 10.107.175.18 with SMTP id y18mr36025053ioe.86.1474291044165;
 Mon, 19 Sep 2016 06:17:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 19 Sep 2016 06:16:53 -0700 (PDT)
In-Reply-To: <xmqq1t0loxz4.fsf@gitster.mtv.corp.google.com>
References: <CAGHT48L2s_nf-oSGPKrOB7uo5UAkCScNh+Ju5xH1dE5DFVnHwA@mail.gmail.com>
 <xmqq1t0loxz4.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Sep 2016 20:16:53 +0700
Message-ID: <CACsJy8AGYPfX9936QJyKU8paxbt+SABMbeCWnpgVvODFr7v4LA@mail.gmail.com>
Subject: Re: git add --intent-to-add silently creates empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Aviv Eyal <avivey@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Aviv Eyal <avivey@gmail.com> writes:
>
>> Using `git add -N` allows creating of empty commits:
>>
>> git init test && cd test
>> echo text > file
>> git add --intent-to-add file
>> git commit -m 'Empty commit'
>> echo $?                                    # prints 0
>> ...
>> I'd expect `git commit` to error out instead of producing an empty commit.
>>
>> I've seen this with git 2.8.1 and 2.10.0.129.g35f6318
>
> I think I've seen this reported some time ago.
>
> https://public-inbox.org/git/%3CCACsJy8A8-RgpYxYsJBaLrMia7D3DfQPr4cxASNsaLyCnmgm3ZQ@mail.gmail.com%3E/
>
> I do not offhand recall what happend to the topic after that.

Yeah. I'm a bit behind, no, I'm waaaay behind my git backlog. This
definitely gets a rise-up, together with the multiworktree bug fix in
git-init.
-- 
Duy
