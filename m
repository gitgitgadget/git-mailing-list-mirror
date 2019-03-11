Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E3B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 10:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCKKOv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 06:14:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33123 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKKOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 06:14:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so4407553wrm.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WicZgbJszxfXxeNtb4940DpXQ6VdefB4qPwAO8n6QxE=;
        b=d2R73aszFKAsjnn40MNJkOumm+hNY6uHd0paTzc99winQo9zbqWYcoju98l2UfiqYz
         rVrrcd1cZWj7/dZZO9lZJcFvdWl7/GK5EOqTMmkUQgwEAD7afhUjDEnxYbgPSMy8wV0u
         m8BlfRR6VP6cXBFsRvk/o73lZkebnpl+LA562tgmnNGE3XcJZaUI8Ouj/pm1my0gTcYj
         8GVA7vV1KkKCKPbAKTjN4VIeW7HlAcgQF0Nc80Hdjxm8NpyWwYNR2R1OqhcERtzSi29o
         Mw4tZy+x88P4OUa59dZMDE2fDi3DFnEbDDuyMGXoUC0QHj30jjmj402s4hPXdYJAu/xO
         g8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WicZgbJszxfXxeNtb4940DpXQ6VdefB4qPwAO8n6QxE=;
        b=JmzDRNiMPMzM34IYr/9Vk5TIZsbXIR1KQDjuu4CARGr6MsBegxaE5nD2lTKc/a39N7
         Mm17/wUUvoGLmjeQwGf0FNLPea9Ts1Zu311DZbnrsERONEhBC5F0vK+3w53PjGyd6psk
         FCMqQRwb5Tw4hu3yyD/okLheP7+he7goilW73fwipeShyIaaUYgolo4r28k+AfmkwxxD
         lkRnDkf2dK264j4AB7YyGXyTYkjKLD2SOIFx6PcKjCbnwicgttFRs0vVEx8VLm6br4E3
         DvsY8J4JBmCqwbRDx052XZPhTjt6NO81gGnG5uHzt4mEorcUFAW95JH/ivRaij4eh4eu
         CTNQ==
X-Gm-Message-State: APjAAAVmnMSUqT6x3kAXHWHoTf/YEBbbmq6e2QeiUkmaB5kjX6sSB0na
        zHsK2LzxEjsbPyemZBa8zxE=
X-Google-Smtp-Source: APXvYqw1NL13n9rcAmDr4d8wPtvRMDQfP1k/s5F2Zh2LkpFy2VyyM3BSMZMx7nz5j0YB38LSgwCm8g==
X-Received: by 2002:a5d:45c8:: with SMTP id b8mr1021723wrs.3.1552299288397;
        Mon, 11 Mar 2019 03:14:48 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-31-213.as13285.net. [92.22.31.213])
        by smtp.gmail.com with ESMTPSA id e23sm14390755wme.15.2019.03.11.03.14.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 03:14:47 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/8] merge: cleanup messages like commit
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
 <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
 <CAPig+cS5YsjxuLGNAtfFguQvy2p2bJECSsHksx356+WsO1ct5w@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2e10d78a-d92c-76c1-abc3-49ad1be55779@gmail.com>
Date:   Mon, 11 Mar 2019 10:14:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cS5YsjxuLGNAtfFguQvy2p2bJECSsHksx356+WsO1ct5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton/Eric

On 11/03/2019 05:49, Eric Sunshine wrote:
> On Sun, Mar 10, 2019 at 11:42 PM Denton Liu <liu.denton@gmail.com> wrote:
>> This change allows git-merge messages to be cleaned up with the
>> commit.cleanup configuration or --cleanup option, just like how
>> git-commit does it.
>>
>> We also give git-pull the passthrough option of --cleanup so that it can
>> also take advantage of this change.
>>
>> Finally, add testing to ensure that messages are properly cleaned up.
>> Note that some newlines that were added to the commit message were
>> removed so that if a file were read via -F, it would be copied
>> faithfully.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>> diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
>> @@ -47,4 +47,65 @@ test_expect_success 'merge --log appends to custom message' '
>> +test_expect_success 'cleanup commit messages (verbatim option)' '
>> +       git reset --hard c1 &&
>> +       git merge --cleanup=verbatim -F expect c2 &&
>> +       git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
> 
> An earlier patch in this series "fixed" a test with a Git command
> upstream of a pipe. Yet, this test adds such an instance.

Is it worth worrying about? We're not trying to test cat-file here and 
if it does fail the test will fail as actual will be empty. You could use
git log --pretty=%B >actual
which is clearer and saves forking sed.

Best Wishes

Phillip

> (Also, style: add space after '|'.)
> 
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'cleanup commit messages (whitespace option)' '
>> +       git reset --hard c1 &&
>> +       { echo;echo "# text";echo; } >text &&
> 
> Style: add space after semicolon or use &&-chaining inside {...}.
> 
> Alternately, less ugly:
> 
>      test_write_lines "" "# text" "" >text &&
> 
> (Or even a here-doc, though the leading and trailing blank lines make
> the here-doc ugly.)
> 
>> +       echo "# text" >expect &&
>> +       git merge --cleanup=whitespace -F text c2 &&
>> +       git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> 
> Git upstream pipe.
> 
>> +       test_cmp expect actual
>> +
>> +'
> 
> Style: drop the blank line before the closing quote.
> 
>> +test_expect_success 'cleanup merge messages (scissors option)' '
>> +       git reset --hard c1 &&
>> +       cat >text <<EOF &&
> 
> This here-doc probably ought to be using '-' and '\', so:
> 
>      cat >text <<-\EOF &&
> 
> and indent the here-doc body.
> 
>> +# to be kept
>> +
>> +  # ------------------------ >8 ------------------------
>> +# to be kept, too
>> +# ------------------------ >8 ------------------------
>> +to be removed
>> +# ------------------------ >8 ------------------------
>> +to be removed, too
>> +EOF
>> +
>> +       cat >expect <<EOF &&
> 
> Ditto: <<-\EOF and indent body.
> 
>> +# to be kept
>> +
>> +  # ------------------------ >8 ------------------------
>> +# to be kept, too
>> +EOF
>> +       git merge --cleanup=scissors -e -F text c2 &&
>> +       git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> 
> Git upstream pipe.
> 
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'cleanup commit messages (strip option)' '
>> +       git reset --hard c1 &&
>> +       { echo;echo "# text";echo sample;echo; } >text &&
> 
> test_write_lines "" "# text" sample "" >text &&
> 
>> +       echo sample >expect &&
>> +       git merge --cleanup=strip -F text c2 &&
>> +       git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> 
> Git upstream pipe.
> 
>> +       test_cmp expect actual
>> +
>> +'
> 
> Drop blank line before closing quote.
> 
