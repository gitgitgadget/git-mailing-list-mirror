Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106811F453
	for <e@80x24.org>; Wed, 23 Jan 2019 17:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfAWRws (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 12:52:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37234 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWRws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 12:52:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so3543498wrt.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 09:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uvADzmDdi3bk0OHCfuFGysGyM9BC/qOk2cP4Ia81MSk=;
        b=qK1a95t3+k+sf956ZdlzDfnSTLsJ+hlmByXDtEf5RtgSqS45rBWh5HUx/dB5GTn4gN
         +KIamCB6jKZFucDM9OKeoTp5SUv0GOd3BPIXqcXSG5X8U/vMQd2OgySSubU/D7jOYjUE
         Jqn8ZIQy+c4EHT9AvfJCur272pYOUvGdBE5pX2mJ5gSSqdtr4kt1t0KgCLiJ/sdLSd8M
         XBgtPssBo3ntjF25c7RDb4rxKFGLtSOVLOZLKGL8WLbt8G7MAzUJb0OpbD5B2ihQ3P7j
         gBucxO+V1x0rgq5D2R8U4Cv9bchaHIm6ix0KqqJ5kmSfnn+NTT3oT+FvCD/HPBRTWHA4
         JHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uvADzmDdi3bk0OHCfuFGysGyM9BC/qOk2cP4Ia81MSk=;
        b=nR1h7o98moGaaVeFDCYPZsiKLkjJKXBlnRZX+WZQs2RFhQeE4nUeaFoUug7oSIN7zD
         5lT0KR+KSxfgDOj6IvPVphdm3hxtR6w3paRdyLBDeDZKAOyApUiNPQDnihmsqj8qrLFu
         6FkjgiOhR2Pr2Osa/3eIx9Woi9sX+OAoOdLM0cTs5em77F48Im82K/vdaHFUGmM1QQjA
         H57HIiTCIGSyaQ5u9CWboBujPWgAGXPsoOj+O4QR0Iemn3BnERL4343qtW4w4GjjMLO9
         zr3RcHGRx9Hi5iYagHcSlT2cfFNE2C1oknlZhhqX5Xfvj9AT2dYKEZThk8WSXSOzWNmN
         G5gg==
X-Gm-Message-State: AJcUukeyaL+XVF98E8fUmmqg7p5u3ja5ClxDw+aK6MkEmHqzu9BVHC6b
        SsB76qmYmqvxrRdEjCuskgM=
X-Google-Smtp-Source: ALg8bN7u7NvXJUfyZsSi1uskCmTJ1JVqgGtNkUuh6Uh+sPX/CuSxKx8iOdpGJM0n3+GjMhm/fSFaEg==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr3898457wrx.298.1548265966422;
        Wed, 23 Jan 2019 09:52:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t12sm97322798wrr.65.2019.01.23.09.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 09:52:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 00/10] commit-graph write: progress output improvements
References: <20190116132947.26025-1-avarab@gmail.com>
        <20190119202121.3590-1-avarab@gmail.com>
        <09f8fc01-898c-58f7-f14c-7a843e2e34b9@gmail.com>
Date:   Wed, 23 Jan 2019 09:52:45 -0800
In-Reply-To: <09f8fc01-898c-58f7-f14c-7a843e2e34b9@gmail.com> (Derrick
        Stolee's message of "Tue, 22 Jan 2019 13:30:07 -0500")
Message-ID: <xmqqd0onclci.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/19/2019 3:21 PM, Ævar Arnfjörð Bjarmason wrote:
>> Improvements since v6:
>>
>>   * Integrate my "commit-graph write: use pack order when finding
>>     commits" patch, and per Junio's suggestion put it at the start so
>>     it's easier to split the two apart.
>>
>>   * A signed-off-by of mine was missing on that patch. Fixed.
>>
>>   * Replace SZEDER's two patches with his re-roll at
>>     https://public-inbox.org/git/20190118170549.30403-1-szeder.dev@gmail.com/
>>     for convenienc, since mine needed rebasing on top of his.
>>
>>   * SZEDER rightly pointed out that I was doing some work for nothing
>>     in https://public-inbox.org/git/20190118171605.GM840@szeder.dev/;
>>     fixed.
>>
>> SZEDER Gábor (2):
>>    commit-graph: rename "large edges" to "extra edges"
>>    commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
>>
>> Ævar Arnfjörð Bjarmason (8):
>>    commit-graph write: use pack order when finding commits
>>    commit-graph write: add "Writing out" progress output
>>    commit-graph write: more descriptive "writing out" output
>>    commit-graph write: show progress for object search
>>    commit-graph write: add more descriptive progress output
>>    commit-graph write: remove empty line for readability
>>    commit-graph write: add itermediate progress
>>    commit-graph write: emit a percentage for all progress
>
> I'm a few days late, but I took another look through the patches and
> they look good to me. Thanks!

Thanks, all.
