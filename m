Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A741F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBJKZD (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 05:25:03 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:41490 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeBJKZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 05:25:02 -0500
Received: by mail-ot0-f172.google.com with SMTP id r23so10040542ote.8
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 02:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8wlwdh/Dm5fd44C8ijjY58TKqqN2+GhiEQossFCyCjg=;
        b=NNLRyIJ1H18ERy7kwTl6ACD9LXxV17q9ta1DpAY0ydqh2Po8NFyZGW8H/qQuaUYXZT
         w5ZG2VbRqWm/FbYUYxL/MFDXL/O8JgTCKEVvsXKDiAp7V9eVebrj95gb3a2SZpyuO/qM
         vSRd7pY1sTqZ/OIhjwfgZGAEq3StRSl9dZe+UEsAmC9e1O8PX3KbmpzDz7wf+TNE9YKW
         sj73a3PV9jSNho7C6oQmn0AD+rSavX3w3MfD3hSWxomj/ZndXDXFkuBEyBxKIg4bdJ4s
         5li58FF/AJQpibEKZxQOmtTdFGbhkZGTm3MJNnFMM+FyQT83b0h22QBZRSOZEhzfkpcG
         MnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8wlwdh/Dm5fd44C8ijjY58TKqqN2+GhiEQossFCyCjg=;
        b=Oi2dW8JCicm68Ef8OdDiTz/WoA9CJMOsNcBNc4EbbcO160atbOTcxV6f0KBcvQESBk
         9ZfZ3Mh3E6xewiXvuTTk9LWY4g3uFgmv0oylQMgFcU84u2cmuUKRBU5oy9ipTX9OsXyz
         jNpoQVMwphNjfVzIsEZ1r9lZ3zt5ZKuoS8PCis3E0OEmBzFVQCLTBUSnSYN+wAWdzsmm
         clDA6XZBsfJrf0D0RL2aaNRSboTON/6VajQct4lTZH2iL2Sk41ZdRE8VGotvUmAMPFDq
         bb7S3vIZ10sDrL6dyNuRN67Ch+a67ZZ4gUmXgv7ZZdDfqB2fuLhArQ+DuI8Ez+CoUv6y
         8mig==
X-Gm-Message-State: APf1xPDKMVV49o4NEyasqqLGqVw0RqBhx8nNHzNLGfKIdCsmAoJ35tVj
        /1xzb7qE2BOojt79dhJ6dk9DwHqiBlw3/wB1EWE=
X-Google-Smtp-Source: AH8x224RGrbK6YDSWPgz3OTbqUeY8R2iWS1jTRJyHbo80lHJDy+Z+JhXuVZEy1rNXZ5sl8L0bXr6fdHLb1rEsA5OL8c=
X-Received: by 10.157.53.5 with SMTP id o5mr4246862otc.181.1518258302077; Sat,
 10 Feb 2018 02:25:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 10 Feb 2018 02:24:31 -0800 (PST)
In-Reply-To: <xmqqy3k47jdg.fsf@gitster-ct.c.googlers.com>
References: <20180201130221.15563-1-pclouds@gmail.com> <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
 <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com> <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
 <CAPig+cR9RycfLz0C6tXA4iPXdqoyczfij8CBaU4MmRGRmuRhSQ@mail.gmail.com>
 <CACsJy8AiBq__c0UET5ywMbTTz_MJNo-bZ-qAaoGZXdMNnECcaQ@mail.gmail.com> <xmqqy3k47jdg.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Feb 2018 17:24:31 +0700
Message-ID: <CACsJy8ByZzR4GqVus=__RUg7W390e2ABoCb1ANewb5KRmBuV4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> ...
>> Then we still need to decide the new keyword for this feature, I feel
>> compact is a bit too vague (I read --stat=compact as "it's compact
>> stat", not "stat with compact summary"), so perhaps
>> --stat=compact-summary, or just --stat=summary?
>
> Yup, this is about giving summary in a compact way, not about giving
> a compact stat information.  I agree with all the above reasoning,
> and that is why I said that your "compact-summary" was a good way to
> refer to the feature.

OK I'll wait for a few days. If there's no comment, I'll go with
--stat=compact-summary.
-- 
Duy
