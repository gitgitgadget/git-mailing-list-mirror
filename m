Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1851F404
	for <e@80x24.org>; Fri,  7 Sep 2018 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeIGRxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 13:53:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44404 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIGRxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 13:53:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so16088783qtk.11
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8VbCYOVHqO1zllHcbCFgDJVROjIuUOxsRhZbCukRPyI=;
        b=ALnE1QIGEr2ZpAVfXNDyulp/fJMVI2ilVihC/WgABXH271pKmBH6bXfELICiyalD/T
         9shS4h01rME6PAJbKlBJq+XBc+kI6fz9QBEvIeBCniWeBeAjwLfmxvUG9O40su21IUBH
         BPwDFsDhRfI/UG/QL2pK2EgwhY6uadQMpphlC1tUiQs/F0XQpq+ggf4wiiQ5zkUhAB3F
         3TDqztthHCXbHhQChpcTd4wLeSoS2GAVlpTTcRGSJcDWTdTeiHuEgevm4PYwpYrVI1YN
         uSPRDAEOV9lVGxeRpkKFmJESuAqXK2PkuyFrUgvmPA94MlW/myD2BLpLO33OqcipE4h1
         DUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8VbCYOVHqO1zllHcbCFgDJVROjIuUOxsRhZbCukRPyI=;
        b=YN6oCkvQGTfQmPxQL/2f8WYlaTyX0hunHeZ0OxHru/xe6TNRvZDOdEHzB14PHibRzT
         aGm9c2tKhJcOXdlOP7GFBBgmMpTnfRtSDkdV7eEHGUXJcFUTvYOJw+CgT2yzl+z3gQNE
         TQq84ylsOC74vjqzIQEWkycvpNHYjLPwR0Uk3DQky0mV5xHJvcy4UXMKEV3ERWHRDnj9
         9fFdPWNYG9DoVCSI5JRQ7maTV1IcaRRJOnXHdzLLVulhKMQOaukVrt4iM4+87U8UWXXJ
         3Ixb+9M8zRikzAkfThy5m6Bey2cMrQg10roJuHIWQDQlbEUVy9+pJRTZzxM315lOi3R3
         eumg==
X-Gm-Message-State: APzg51DpJrq/eIW8Th4AU8Oej5AYV3nxSmSHsfPWvMah5HgarbzEA/8p
        cgFoFm4GhPFZqVwCmgCgcfM=
X-Google-Smtp-Source: ANB0VdbRKIQTb+Xl8Iv9HLXekjY867W8EdUgJ3IGGjM+Drl8zmXeuP8316IMxlU4VTu+SH6wPcr9Xw==
X-Received: by 2002:ac8:3b4a:: with SMTP id r10-v6mr5942235qtf.118.1536325932560;
        Fri, 07 Sep 2018 06:12:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:941c:6325:aef0:7c76? ([2001:4898:8010:0:7d52:6325:aef0:7c76])
        by smtp.gmail.com with ESMTPSA id x76-v6sm5300861qkx.25.2018.09.07.06.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 06:12:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180904202729.13900-2-avarab@gmail.com>
 <87h8j1qy59.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <75c8f1f1-d836-7dda-b30b-6c2fec73b194@gmail.com>
Date:   Fri, 7 Sep 2018 09:12:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87h8j1qy59.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2018 8:40 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Sep 04 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> Before this change the "commit-graph write" command didn't report any
>> progress. On my machine this command takes more than 10 seconds to
>> write the graph for linux.git, and around 1m30s on the
>> 2015-04-03-1M-git.git[1] test repository, which is a test case for
>> larger monorepos.
> There's a fun issue with this code that I'll fix, but thought was
> informative to send a mail about.
>
> Because the graph verification happens in the main "git gc" process, as
> opposed to everything else via external commands, so all this progress
> output gets written to .git/gc.log.
>
> Then next time we do a "gc --auto" we vomit out a couple of KB of
> progress bar output at the user, since spot that the gc.log isn't empty.
Good catch! (I do want to clarify that the graph _writing_ happens 
during 'git gc' since 'git commit-graph verify' is a different thing.)
