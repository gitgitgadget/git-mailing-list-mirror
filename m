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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA9E1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 18:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfHAS1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 14:27:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35298 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAS1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 14:27:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so71297335qto.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCDS0Ixh3emDVfkAwoXzezV/kwr+yjxiPZ3jq9jn9D8=;
        b=rIfTMXJ80mAlHP6bqKN7nO3tgcerXMvecjG7KYMDqlvCQhGi8poaX3uZpyiA9MdtxM
         pu58JK0Ey+ZDd8uGqiqD5TmG9AseJ8EspUawTsH/g/yAS1WSFYQeE48Csd9k17vmMMAJ
         oHU5oDASkARiRUJd0x/Y1FfhDkmG80hy/IDGGbYu3T2ZdEl2G3Wq0ysWBiRRNQjt4oRV
         IzMV35Fi/CFjxrydMSBBZQkPq+la18oSzPNNpdbFqWvqlJfT9/J+wdLFGISEUhPpMLbq
         7lp8jF8dBwLESzam6YbttSDwp1tG5G7aDUntTUZAk3KO24XtfCYY78hXSeHyOvGcySpA
         lLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCDS0Ixh3emDVfkAwoXzezV/kwr+yjxiPZ3jq9jn9D8=;
        b=poE5bS5FAA8sWK9IrvJskjj7u8QSk1kC1SW54eOBu+sdpfwmWz9Ya6KPbscb5EZ7my
         laLa5+MtHWlshfiMAl8drnfT5lP0330PGdcx3pmVd1Do+2oW7MqPI29OqkWAI8OoPuBn
         gObtIbjPBwMtnxPk7hGZE5OOJ7omltE/4pF7MftjBA+NX4NNvklNRgifSMc6xZtpi6wK
         gQ+Xxk3bIGr5EbaTmget05N79emesocPyu1efqJK9LsCvpQTynVo9m4x3yDmjSASfxnw
         ILksCWpPJPb4WM4AvzV9J8Pr8cvVS2r2AbqEMDDknnTl9mSWx+bJ0M8ufOPP6LK0XsZc
         mgTg==
X-Gm-Message-State: APjAAAXuX8NxbRvya7Rcbpk6fGZvybN/gezaAYBEoJbyAZZk4rp76rOo
        hAPQSNu6Im2NjqpefZ3cWPM=
X-Google-Smtp-Source: APXvYqwdKhkeg+9eP28ZD/2UJ5nR/ktaDVD6bHyMihEWUTXa/BayzFCXrGQzIqecZnFdnHMQr9kvkQ==
X-Received: by 2002:ac8:27db:: with SMTP id x27mr95370247qtx.4.1564684044167;
        Thu, 01 Aug 2019 11:27:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4870:3e0f:c9e6:7998? ([2001:4898:a800:1012:f9a3:3e0f:c9e6:7998])
        by smtp.gmail.com with ESMTPSA id b18sm27279552qkc.112.2019.08.01.11.27.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 11:27:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] repo-settings: add feature.manyCommits setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
 <pull.292.v3.git.gitgitgadget@gmail.com>
 <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
 <87mugu5jtm.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f8445819-f5b7-44da-8610-6f9d81475228@gmail.com>
Date:   Thu, 1 Aug 2019 14:27:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <87mugu5jtm.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/31/2019 11:01 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 30 2019, Derrick Stolee via GitGitGadget wrote:
> 
>> +feature.*::
>> +	The config settings that start with `feature.` modify the defaults of
>> +	a group of other config settings. These groups are created by the Git
>> +	developer community as recommended defaults and are subject to change.
>> +	In particular, new config options may be added with different defaults.
>> +
>> +feature.manyCommits::
>> +	Enable config options that optimize for repos with many commits. This
>> +	setting is recommended for repos with at least 100,000 commits. The
>> +	new default values are:
>> ++
>> +* `core.commitGraph=true` enables reading the commit-graph file.
>> ++
>> +* `gc.writeCommitGraph=true` enables writing the commit-graph file during
>> +garbage collection.
> 
> During the whole new commit graph format discussion (which has now
> landed) we discussed just auto toggling this:
> https://public-inbox.org/git/87zhobr4fl.fsf@evledraar.gmail.com/
> 
> This looks fine, but have we backed out of simply enabling this at this
> point? I don't see why not, regardless of commit count...

I would be happy to drop feature.manyCommits and instead swap the
defaults of core.commitGraph and gc.writeCommitGraph to true if we think
that is what we want to do for 2.24.0. We can use the repo settings and
UPDATE_DEFAULT[_BOOL] for this purpose.

Thanks,
-Stolee

