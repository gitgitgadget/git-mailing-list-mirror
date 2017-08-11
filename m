Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7788720899
	for <e@80x24.org>; Fri, 11 Aug 2017 18:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbdHKSaD (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 14:30:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33757 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbdHKSaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 14:30:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id u185so3698355pgb.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HzSejhTbtcl+SrOoIGxFmi1YbRAwE+Yt0dWJB25j8rM=;
        b=ZgPvCicCm20rGitlnZ0SbUZXNXwDpwj2ppM0D3BKas+xYocgv2FIJP3Ws6eftxur8v
         5V3aiTdjSvU0m8wEPBO96cYl2NsNDtfVBLvpPk2zJOzO0xXUR12yWT2vMsKFa7vdTLYi
         Uhox9feO9N9oAycJex2bF0ZN8OEwDx9iy25X8XQ6Osubt3+DX9dj30wsHcnPYMYNy1tO
         xwpy+V3gO2FajV9xo2hC/NpJXmNZc8dj2hKNVfz+oYFzLI2d50rQv1jm4pfPIZdsaItY
         KKAE8XQb0kSjlcqMlBq5R/nr6cml8hHpwF3Cr2CBJ85mkpP64+6puaqE5plG2AVQ1CVN
         FhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HzSejhTbtcl+SrOoIGxFmi1YbRAwE+Yt0dWJB25j8rM=;
        b=cbBydTptK2C6kQCISFh1KFvRLOb1jYQCJr5mtD5/GbDtipa7doGCQ1KXRq/hfKUYjT
         zsLtMVP80bgtjroX68bgNB9FQPaZFMmae28MmNKjerQQzEoVtShBOiCDkv64dLup/4Qz
         83E1xFkhAx8Ppae5fNBW6wAr1pxewdfizgOsBTVU9UTcy9n+nMyyOL3hFBP5dIWHZHZf
         idRD8TBxy67rEkOg2HZp2fkyKw7GHGI9zMy1tZfCdG0hs2ZYOSrG3QdaMztF3nd68V/T
         EL86qLHPHYMrPV9gRf02wuffHNdZPiqFtOA22/ez/YqYzIph8IcW5L4U5zo+JMBgbkZR
         eXYQ==
X-Gm-Message-State: AHYfb5hDX2sj+NRt+1aNRu/5HIEVS69qqQ7GiJ2Lm2o3IyY29KrbRmKQ
        DLxB/Cj/hSXqKA==
X-Received: by 10.101.77.6 with SMTP id i6mr16207292pgt.181.1502476201478;
        Fri, 11 Aug 2017 11:30:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13f:7d5a:88bb:1f7e:ca31? ([2001:4898:8010:1::785])
        by smtp.gmail.com with ESMTPSA id w1sm3085778pge.59.2017.08.11.11.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Aug 2017 11:30:00 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] dir: teach status to show ignored directories
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sxlijin@gmail.com, gitster@pobox.com,
        peff@peff.net, Jameson Miller <jamill@microsoft.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
 <20170810184936.239542-2-jamill@microsoft.com>
 <20170811173905.GA59325@google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <08b17af5-a8cf-ed15-9972-e7d655272a7e@gmail.com>
Date:   Fri, 11 Aug 2017 14:29:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170811173905.GA59325@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/11/2017 01:39 PM, Brandon Williams wrote:
> On 08/10, Jameson Miller wrote:
>> Teach Git to optionally show ignored directories when showing all
>> untracked files. The git status command exposes the options to report
>> ignored and/or untracked files. However, when reporting all untracked
>> files (--untracked-files=all), all individual ignored files are reported
>> as well. It is not currently possible to get the reporting behavior of
>> the --ignored flag, while also reporting all untracked files. This
>> change exposes a flag to report all untracked files while not showing
>> individual files in ignored directories.
>>
>> Motivation:
>> Our application (Visual Studio) needs all untracked files listed
>> individually, but does not need all ignored files listed individually.
>> Reporting all ignored files can affect the time it takes for status
>> to run. For a representative repository, here are some measurements
>> showing a large perf improvement for this scenario:
>>
>> | Command | Reported ignored entries | Time (s) |
>> | ------- | ------------------------ | -------- |
>> | 1       | 0                        | 1.3      |
>> | 2       | 1024                     | 4.2      |
>> | 3       | 174904                   | 7.5      |
>> | 4       | 1046                     | 1.6      |
>>
>> Commands:
>>   1) status
>>   2) status --ignored
>>   3) status --ignored --untracked-files=all
>>   4) status --ignored --untracked-files=all --show-ignored-directory
>>
>> This changes exposes a --show-ignored-directory flag to the git status
>> command. This flag is utilized when running git status with the
>> --ignored and --untracked-files options to not list ignored individual
>> ignored files contained in directories that match an ignore pattern.
> I can't help feeling that there is a better way express this with a
> better UI.  I'm not saying this is wrong, I'm just not sure how
> --show-ignored-directory would work when not paired with --ignored and
> --untracked-files.  Does it require --ignored to also be given?
Yes. This flag only has meaning when --ignored and --untracked=all
are specified. I am open to other suggestions on how to express this.

Another option might be to modify the "--ignored" flag to take an
argument, which would allow more explicit control over how ignored
paths are reported. This way, we could specify (for example)
"--ignored=explicit" to control the output of ignored paths.

>> Part of the perf improvement comes from the tweak to
>> read_directory_recursive to stop scanning the file system after it
>> encounters the first file. When a directory is ignored, all it needs to
>> determine is if the directory is empty or not. The logic currently keeps
>> scanning the file system until it finds an untracked file. However, as
>> the directory is ignored, all the contained contents are also marked
>> excluded. For ignored directories that contain a large number of files,
>> this can take some time.
>>
>> Signed-off-by: Jameson Miller <jamill@microsoft.com>

