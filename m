Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A841F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeEQWKz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:10:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36743 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeEQWKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:10:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id p4-v6so7182189wrh.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cHPOYrziXkQImvpiKObwtZDieI1xanGTFWVxMIMwFBA=;
        b=cl/ukbfuFQd9HJLhNaJgZ+ZuL689awmB4vz87B8/TFGSVYrBsQuwnmcprnBgpC8VhT
         9L3RSKuBP7baj9sVh2fo2sZHLgf+zrqJx5L+MoJnGXTp/tcrn2YjTDmuQzydjHN6PbCo
         vejVOoOj7scqPu4TpFZj6EIIC+Gw2Ip9YHl2NsDPw2McNKyO3n0JE1E8dTMsn+q/i2HF
         7kcjjqiJgOdrbzBRNB9mbmRIekavgnT5D3nT9tH1hhtm2IQJaEC2rz3pWa/Tq5VAobd7
         qyLPLXdHc2X5Tu/zalYbLnL24FqJZTKhX35REdLivbifCCuP6WrAnkoc0OYdL+/Xo8Lf
         4lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cHPOYrziXkQImvpiKObwtZDieI1xanGTFWVxMIMwFBA=;
        b=ZyiwW7Kl/C7r908p2k6m3x5/TlnRMV9FQr1yhFdZm00Yh+4hUNPqBXz4zx5lWxK0/S
         jroCG2tg/M9fsO2kwyYmnZM6ZmzXl3bRGoD0HOzwExVEb3kGupcQ1VIsT/0KjOTDmUJV
         OdvZKOsRXmDv2HfKCHB0t1+dFVoSYL3Rzj/6c3+MQSRYdoIfKpmc2mydiw2M5KLgOkf5
         M+LADOokbkuqyOTvmHhMlAiBjIKlX1cxzTpEMToalvemxeX8ABm0/MkuWqDrX1V+zSek
         EyqtED7UQkjwItorXKGPHXr/Y3uEy646Mp3ew24YaGlu3z1zqxvvADRqDb+JjgjuudC4
         1b6w==
X-Gm-Message-State: ALKqPwct0Zuu0I261ii4SCfK5wRaYV2CmAvLbJdvWFMcmEo+DYllK1HL
        fJycDwchcao6OL7oUqaJegs=
X-Google-Smtp-Source: AB8JxZrLxoTeWESEiuYNHXwDysbQXp3/TaheH8erm5x8yenUuxfxQExztnfPFj/tNEyYGZvgfURxQA==
X-Received: by 2002:adf:8e82:: with SMTP id q2-v6mr5938521wrb.53.1526595053679;
        Thu, 17 May 2018 15:10:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v18-v6sm8827221wrf.76.2018.05.17.15.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:10:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] unpack_trees_options: free messages when done
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
        <cover.1526488122.git.martin.agren@gmail.com>
        <abc39c9991d6df627b40fd8b4fe9812e7ef78d77.1526488122.git.martin.agren@gmail.com>
Date:   Fri, 18 May 2018 07:10:51 +0900
In-Reply-To: <abc39c9991d6df627b40fd8b4fe9812e7ef78d77.1526488122.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 16 May 2018 18:31:00
 +0200")
Message-ID: <xmqqin7m53x0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> The strings allocated in `setup_unpack_trees_porcelain()` are never
> freed. Provide a function `clear_unpack_trees_porcelain()` to do so and
> call it where we use `setup_unpack_trees_porcelain()`. The only
> non-trivial user is `unpack_trees_start()`, where we should place the
> new call in `unpack_trees_finish()`.
>
> The `opts` string array contains multiple copies of the same pointers.
> Be careful to only free each pointer once, then zeroize the whole array
> so that we do not leave any dangling pointers.

The verb to make it zero or fill it with zero is "to zero", I would
think.

To be honest I am not sure if I like the way this change is done.
The clear_unpack_trees_porcelain() function has too intimate
knowledge of what happens inside the setup_unpack_trees_porcelain()
function; it not just knows which fields are always allocated but
which are duplicates, which must be double checked for updates
whenever the latter gets modified, yet there is no large warning
sign painted in red in the latter, so it is easy to change the
latter and invalidate the assumption the former makes by mistake,
leading to new leaks and/or double freeing.

I wonder if an approach that is longer-term a bit more maintainable
is to add a new string-list instance to opts, save these xstrfmt()'ed
messages to it when setup_unpack_trees_porcelain() create them, and
then make clear_unpack_trees_porcelain() pay *no* attention to msg[]
array and the positions of these allocated messages and duplicates
but just reclaim the resources held in that string-list, or
something like that.

