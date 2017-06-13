Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8380E1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbdFMRji (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:39:38 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33956 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdFMRjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:39:37 -0400
Received: by mail-pg0-f46.google.com with SMTP id v18so63752781pgb.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Os2//B7QBh7EBrj+btybrR1dPnXX7j1Gav8z4CHm3uI=;
        b=KBXR4KCZPzM5bpRhVBO/R25DUKIhr6fUDm7w5jQiZN9iZKBshxQ+zPlRziiWxhISuT
         F1Vh4IfG/TIROyfNWEOSQpIogFp1t9Kgxkpib+l0tPyZEYAp+abm8cp9l1BXRiku3DIY
         SiLtqpR1xYReQ8VeMkjOQ5EKKLLl4XryUsdt1jtO0+orabp5Q5zDmQtZ0XbZTFW1B3cw
         1R7/PFCS7vUFF8+FTJxXhCUXcZ8cN+y/qzfquEZXXCcpgBGjuNzVLC9298ZSOnTzQUle
         U8t7sWmdiAhpBp8vZdrJGG6Wcrpr0JCB+WiJVyyOO15UHK1EEQDuBAd/dEhvU3hJ6Bgr
         s+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Os2//B7QBh7EBrj+btybrR1dPnXX7j1Gav8z4CHm3uI=;
        b=o1DurEbKiO5TtyzeQy/qnpUEIO/yzOppKpKPA7GajAZ66cQsVO3BGaw124RNdekhDm
         SMmPe1CowoGty8bPjRL7uYPQWYnZsBM2AMQ6aZqnsNx0gTnjkzpkqYLiJSHN3sTQl364
         XBt+JreiPbVG+Wo0htdkcE+ZZcO0ZI6TXzUmWpaoeIePM9UAnIKKqePmrvV9MqWy6oiw
         vHHsGlZ+xgmTiHUpKRtNBtev5VQ6GTgCK17+Ffq7c4JjWvent9Yj2Z/iHUEqJQoEDKjX
         Mjx+axely9MGTLKjPSN68S8VH4LxlWhBBfp6lrw9JsBbyOkqdNdOufk/MLjYbaNRyCKO
         INLA==
X-Gm-Message-State: AKS2vOy5vhTLCUV7brr555qOkh1UXKcxGZYP+Tf/nmItEi9WNo2FyGU4
        XVDbhEVDCuGCAg==
X-Received: by 10.99.99.65 with SMTP id x62mr692666pgb.211.1497375576433;
        Tue, 13 Jun 2017 10:39:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id n78sm9027153pfh.128.2017.06.13.10.39.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:39:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] branch: add test for -m renaming multiple config sections
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
        <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
        <xmqqwp8f7r01.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5e1cGKeHZhA1vWebdZek=a+TdYzXc5GuXaDi8SpL1YXw@mail.gmail.com>
Date:   Tue, 13 Jun 2017 10:39:34 -0700
In-Reply-To: <CACBZZX5e1cGKeHZhA1vWebdZek=a+TdYzXc5GuXaDi8SpL1YXw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 13 Jun
 2017 19:31:23
        +0200")
Message-ID: <xmqq7f0f7pnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 13, 2017 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Indenting using <<- would make it easier to read.  I.e.
>>
>>         cat >config.branch <<-\EOF &&
>>         ;; Comment for ...
>>         [branch "source"]
>>                 ;; Comment for ...
>>         ...
>>         EOF
>
> I should have added a comment for that, I can't find any portable (but
> suggestions welcome) way to do that and preserve the indentation, so
> the test_cmp would still succeed if the moving/renaming function
> munged all leading whitespace in the config with -\EOF as opposed to
> \EOF.

Ah, I see why it is done that way.  You could indent the lines in
the configuration file with SPs (<<- strips only HTs, no?)

> It's just a sufficiently large number, I thought -A was portable
> enough after grepping the test suite, but on closer inspection it
> turns out those were all git-grep invocations, oops. Yeah all I need
> here is all lines after a line matching a given string, so that sed
> command works, will fix it up to use that.

Oops, indeed ;-)  Thanks.
