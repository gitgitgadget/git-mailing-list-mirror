Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AE01F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfH3KRO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 06:17:14 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42277 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfH3KQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 06:16:58 -0400
Received: by mail-wr1-f46.google.com with SMTP id b16so6372205wrq.9
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ircBb5c7HZaS5XCTanhllRkvN7Yo2as+QHKFS3/1WwY=;
        b=cEzoYCVVt9vln0B8jvS85mZcWjrs69WXg+VTm7U6YqCFLO2wJzNL0vO/1IFHnLcyd2
         11Izw1wJAxZ9o4uG2x05M6rI+Gy/rivEq/Yp7sCTtEDQbqA3/2Y+fnMMZtCeIosv0VLt
         wH43s5OEPxLC31rj2vNvKMT7Y6MTLpbX9L2r1FTYiW7jk7otiiAa58uiEsyS6NbMjLEG
         sEbJnWI0VC9jaEV46MT2HT/WQSm+d1fYgOU2GDa2eur2CuQwi3aj09HWiWxXALrHcoB1
         ECZTVT6gPa9Vs/r8u/heR8sYyFC4ovpmQa3AxDcpZrer3mknh+pi737Vj+Z8Hh3HoTk+
         rq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ircBb5c7HZaS5XCTanhllRkvN7Yo2as+QHKFS3/1WwY=;
        b=SgblqXhz10ReUBFGaP0haoY4GRqtcUR4zTc8nyP8DO1e9AgT9di+tzv3sL2xmVr66h
         anwwkAld46qWnQ/hYpVicMAE8j1w87nb8+def9SnRntphFYntxo4DbaiC5V1zK3b3uxh
         GRs/9WlBPDf/XMqezDd4vpIOxuV+3DqZKtZstmVE9AQdWuEos84BMK9PCg+CDWE2JJwY
         EqL72qYbF4fHzaxgvXGd1E1R4RN2wKLeQXvNeb+RS7St/howwVom4BQvlyrp2IyPDbVw
         eRhrNAFnYIQXv7njN7eaRyjcJsGBTTNGreVk0yuk9sHFw4PORc0vlvAjzzI1yZ01uZZs
         R+CQ==
X-Gm-Message-State: APjAAAXdUx5Qm4AyQWrDFicF5KZrcvJE2uWoikQ7p6zaqr3WwESOdpy0
        JtBiChygd4ULNLhVL6UpENctmr8X
X-Google-Smtp-Source: APXvYqxBBxr98HXi84qk81ULeUKUgkLHbgz42MdXri4hpH84+vOyeRMT+PYv02UbnFT+87THo60KgA==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr6678003wru.9.1567160217130;
        Fri, 30 Aug 2019 03:16:57 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id f13sm3893692wrq.3.2019.08.30.03.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 03:16:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF
 incorrectly?
To:     Dmitry Nikulin <pastafariant@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
 <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
Date:   Fri, 30 Aug 2019 11:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dmitry

On 29/08/2019 15:36, Dmitry Nikulin wrote:
> Thank you for the reply.
> [...]
> However, for the original repository where I first faced this problem
> (https://github.com/yandexdataschool/Practical_RL), Git passes a very
> weird set of args to the external diff:
> 
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M master coursera --
> week02_value_based/seminar_vi.ipynb
> week2_model_based/practice_vi.ipynb
> ['./print_argv.py',
>   'week02_value_based/seminar_vi.ipynb',
>   '/tmp/amudWz_seminar_vi.ipynb',
>   '8f8016963c888b7dd8dd20f60b7d6fdb41b26c1d',
>   '100644',
>   '/tmp/Ub7zPz_practice_vi.ipynb',
>   '21db80f53b632d975a9af0acbaf397eb717cde2c',
>   '100644',
>   'week2_model_based/practice_vi.ipynb',
>   'similarity index 82%\n'
>   'rename from week02_value_based/seminar_vi.ipynb\n'
>   'rename to week2_model_based/practice_vi.ipynb\n'
>   'index 8f80169..21db80f 100644\n']
> 
> I would guess that this is a bug. There can clearly be a hotfix (after
> all, Git passes all of the information to the external that it should
> per the spec, that is, <old|new>-path, <old|new>-hex, <old|new>-mode;
> adding, however, some garbage). 

When git detects a rename it adds two parameters to the end of the 
argument list for the external diff program. The first extra argument is 
the new name and the second is the header with the similarity 
information[1]. I'm not sure why the last argument is being split in 
your example. It is not split in the example below

$git mv git.c renamed.c
$env GIT_EXTERNAL_DIFF='printf "|%s|\\n"' git diff HEAD
|git.c|
|/tmp/lMQpP8_git.c|
|c1ee7124edcfb0417539134d50212e997dc71c1f|
|100644|
|renamed.c|
|c1ee7124edcfb0417539134d50212e997dc71c1f|
|100644|
|renamed.c|
|similarity index 100%
rename from git.c
rename to renamed.c
|

Best Wishes

Phillip

[1] https://github.com/git/git/blob/master/diff.c#L4204

>I do not know though to what extent
> this information is correct. You say that this information is lost
> when I use the <tree-ish>:<path> notation; however, Git seems to pass
> paths and hexes correctly. This only leaves open the question of file
> mode. Perhaps it could be preserved at least for some cases, such as
> when the blob is retrieved from a path in a tree?
> 
