Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D53B1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 13:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJGN4e (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 09:56:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36257 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGN4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 09:56:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so12639877qkc.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8P1ABeRmcvLdzLswUCUGjIqMM0fleY2xv2mV/rLtVlE=;
        b=tBg5UMMCMisvIUsxTzlwxu1YACCAkzscaccWVduc5qyMltjotY8MjysDrvLUzS5S+M
         vg1c+j57VEhjyNnR6F6EFy+3zOGeo22Ad+T1R7QbSFsNc0gwxnvEmUAid5x0bH45Yv1P
         tuI4TFfK9P8wDY7ORNEti/xF1I/OQvzJ/HlK5lazKM0yV2V5QhIvo4HVq8o4SU0xKtNP
         gRfHXLZJuPf6tVlGHWGJ7EkZrRcqRz6AWEoiX83IL13EmMp+zpBpe16VivhKIGeLnlxm
         3rOI0Il+Y+c6F2BFs+M4owl2FZ5AD/7zigL75dulewnDpiEeihF2itqW9hb1n/fr2r7C
         uICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8P1ABeRmcvLdzLswUCUGjIqMM0fleY2xv2mV/rLtVlE=;
        b=RSwrhD2LUI4ad+BL/gt8tMfNY9nmj4EboZ6rq+8mqcFyloC3/I1CjUIbigXMZaqXdF
         3kJrsRQWm+gsEAf3/aahCBnbCHjbrba8OIKFo+Kwtsenqs2nO0YoFeqIpPmeHqy7wImu
         4OTqpYrcNCTyf5a9PGwIxKDBN9sqT9zYK4X6lctUvPvaOn4zry/vvb175Dn0ohcfe8/L
         8waU6s9DO2RhQWqYJ6veBEXyOSo73sSBNDMIGgTRQgH5wNDueinmWvvg2Bs/x/VFD0vT
         ddyK8K7xgMxDvghSTtc/oRsmObqyStC7D0UkoPQ14E3iWfW/F2nk8wa9CMlyQAAGhuBc
         0z/Q==
X-Gm-Message-State: APjAAAVa4D3Or0DHa2U8euvzGyqyEM+FumCAfHFSXO7VUpRosR33odPh
        fUaumhFQGB1D0s2JQwX5yz8=
X-Google-Smtp-Source: APXvYqzcQz6S+1CW3o3kGzlxA0YmaVodc8LTb0OyNCLLeiS0IfXsI3UOtDps2mreRamj8JD4Ke2IaA==
X-Received: by 2002:a37:9e57:: with SMTP id h84mr23482066qke.226.1570456591786;
        Mon, 07 Oct 2019 06:56:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f906:ddc1:af61:734b? ([2001:4898:a800:1012:aa3a:ddc1:af61:734b])
        by smtp.gmail.com with ESMTPSA id c201sm7801318qke.128.2019.10.07.06.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 06:56:31 -0700 (PDT)
Subject: Re: [PATCH v2 03/11] clone: add --sparse mode
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <fef41b794a9886664616ce5e5c7902a82a474c2d.1568904188.git.gitgitgadget@gmail.com>
 <CABPp-BHaV+XX63Y46b8wHk0rHzdAbfDQDZAQe3pHcA63WerigA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c57c71d3-ddd6-464d-a442-713707ee94f6@gmail.com>
Date:   Mon, 7 Oct 2019 09:56:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHaV+XX63Y46b8wHk0rHzdAbfDQDZAQe3pHcA63WerigA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2019 3:40 PM, Elijah Newren wrote:
> On Thu, Sep 19, 2019 at 3:06 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
>> During the 'git sparse-checkout init' call, we must first look
>> to see if HEAD is valid, or else we will fail while trying to
>> update the working directory. The first checkout will actually
>> update the working directory correctly.
> 
> This is new since the RFC series, but I'm not sure I understand.  Is
> the issue you're fixing here that a 'git init somerepo' would hit this
> codepath and print funny errors because HEAD doesn't exist yet and
> thus the whole `git read-tree -mu HEAD` stuff can't work?  Or that
> when the remote has HEAD pointing at a bad commit that you get error
> messages different than expected?

At the point where `git clone --sparse` calls `git sparse-checkout init`,
there is no HEAD. We need to initialize the sparse-checkout before the
clone operation populates the working directory and creates the HEAD
ref. For that reason, `git read-tree -mu HEAD` wouldn't work. But that's
fine, since there is nothing to do. The index update will happen later.

> 
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 895479970d..656e6ebdd5 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -99,6 +99,7 @@ static int sparse_checkout_init(int argc, const char **argv)
>>         char *sparse_filename;
>>         FILE *fp;
>>         int res;
>> +       struct object_id oid;
>>
>>         if (sc_enable_config())
>>                 return 1;
>> @@ -120,6 +121,11 @@ static int sparse_checkout_init(int argc, const char **argv)
>>         fprintf(fp, "/*\n!/*/\n");
>>         fclose(fp);
>>
>> +       if (get_oid("HEAD", &oid)) {
>> +               /* assume we are in a fresh repo */
>> +               return 0;
>> +       }
>> +
>>  reset_dir:
>>         return update_working_directory();
>>  }

