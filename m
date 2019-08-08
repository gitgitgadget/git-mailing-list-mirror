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
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C011F731
	for <e@80x24.org>; Thu,  8 Aug 2019 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbfHHSss (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 14:48:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36329 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbfHHSss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 14:48:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so69669733qkl.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WI1DWFbud7a0sFAB88Dq9C7ibknrYGnqE04MtRIm9bU=;
        b=us5wvttgnOWGXW+ei3L2GTMX6gI/P8DJhWsUHq0Ip/E5/Pfktq2nULNy4DG8BO0OH+
         Uemt+B+ERJbtqQmx0ZJamdEh9Ao+jNPvWiEFaZuUIQPlahWwhdiNxIVWAyu2f4Phwdf3
         gFv90ADoUJwBL08vNZD/hN9tc0Ip3kw3bBn6GqQY3ZuNqAO3T8aeQ9XBlECgBrY7M7lr
         6GGVRw+Ip5gKGXlh7k4Msj2QkPiYPjR8VViTUmkM18veCJm6zAY/TT5C+3Ay0R3GC8Je
         lrt9+rpGPL8H1ghhwTiGrTjnFnmMamT72zgl22gGWLgttUvZ1C4/dHBh755dkWz3wLFN
         Q16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WI1DWFbud7a0sFAB88Dq9C7ibknrYGnqE04MtRIm9bU=;
        b=L1mdYRWGDiCOIy01ST5dxnvsFNEahNIx9Mrxh6dh1CZPsCA7uWEMOwxofzZ959t9pw
         YFm+x8VbIHUANqhNrPA0DFjHBtjcPARuMoi57C546D+eoIJIi7sGMJSYOp00DV8FylXz
         rCb+1Sz7PVgbe5j0CaQ1C7yMULJYA/CAcG0HMTa7UCQHbIqqNaACVyoj0stZlo9PrMEo
         VXwrhAVhknKIV64HVGOL90fcG3jRu+x9na1dtgTdd1z09J6GeL75o+IhOmzx+Mo3cDGd
         4Yzvh1hYXKL9JWgu23SOYBFVmWHu28cuWY7zVss2gkyRTS7T9IqOlt347AmQwpj7At15
         wLHg==
X-Gm-Message-State: APjAAAVfq1pBb2x01rTQiTS/yfWQSqmnFaOOgjdfCPz/oQWiFGO/mgE9
        wqJ6SyzNPiC6lYlCC9TENIQ=
X-Google-Smtp-Source: APXvYqz1fRMH0zwh9dn+F1tXeER7Vl2fO/cW5ViruXIIQ6xo5YiUiheMOO7Gv0+L/qnXeV2QC2b7SQ==
X-Received: by 2002:a37:4781:: with SMTP id u123mr13514984qka.263.1565290127671;
        Thu, 08 Aug 2019 11:48:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7487:521b:1543:4364? ([2001:4898:a800:1012:25bb:521b:1543:4364])
        by smtp.gmail.com with ESMTPSA id q42sm2451466qtc.52.2019.08.08.11.48.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 11:48:47 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
 <pull.292.v3.git.gitgitgadget@gmail.com>
 <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
 <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c9598b37-9941-15eb-c599-b7f0e921a1b2@gmail.com>
Date:   Thu, 8 Aug 2019 14:48:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2019 2:34 PM, Elijah Newren wrote:
> Sorry for the late reply...
> 
> On Tue, Jul 30, 2019 at 3:49 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> --- a/Documentation/config/merge.txt
>> +++ b/Documentation/config/merge.txt
>> @@ -54,7 +54,8 @@ merge.directoryRenames::
>>         moved into the new directory.  If set to "conflict", a conflict
>>         will be reported for such paths.  If merge.renames is false,
>>         merge.directoryRenames is ignored and treated as false.  Defaults
>> -       to "conflict".
>> +       to "conflict" unless `feature.experimental` is enabled and the
>> +       default is "true".
> 
> I have a hard time parsing that changed sentence.  Perhaps something like:
>    ...unless `feature.experimental` is enabled in which case the
> default is "true".
> ?
> 
> ...
>> diff --git a/repo-settings.c b/repo-settings.c
>> index af93696343..e0673938c0 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -34,6 +34,18 @@ void prepare_repo_settings(struct repository *r)
>>                 free(strval);
>>         }
>>
>> +       if (!repo_config_get_maybe_bool(r, "merge.directoryrenames", &value))
>> +               r->settings.merge_directory_renames = value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
> 
> Shouldn't that be "MERGE_DIRECTORY_RENAMES_NONE" instead of "0"?
> 
>> diff --git a/repository.h b/repository.h
>> index e7a72e2341..b8e52dd48f 100644
>> --- a/repository.h
>> +++ b/repository.h
>> @@ -19,6 +19,20 @@ enum untracked_cache_setting {
>>         UNTRACKED_CACHE_WRITE = 2
>>  };
>>
>> +enum merge_directory_renames_setting {
>> +       MERGE_DIRECTORY_RENAMES_UNSET = -1,
>> +       MERGE_DIRECTORY_RENAMES_NONE = 0,
>> +       MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
>> +       MERGE_DIRECTORY_RENAMES_TRUE = 2,
>> +};
> 
> Thanks for adding these; makes things much nicer.  :-)

Thanks for the feedback! It's just in time for me to send a v4.

-Stolee
