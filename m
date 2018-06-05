Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2BA1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 16:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeFEQhs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 12:37:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45286 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeFEQhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 12:37:47 -0400
Received: by mail-qt0-f195.google.com with SMTP id i18-v6so3070381qtp.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KXgSgcE2DeV4VZ5MMSQZsHOBA2UyqsNW1dsB9ms6UkU=;
        b=UbuS/hkLIix4+k6Js3jJ96XyBU73/5OpeIfitx5MDG3URWyqdXZC/1XnhONnPwgcmT
         ugOI2oRXw+Dv6Hf25HS1bmr6e/3eHYThMokoQ/5zBILl7UDGP6zBEdBAw+wxDgf8J5WT
         Pf9AySCvUmqYYue+mQFhVHfTXC8WThYOWSQH1+XSlxiVkUiTK/Ub9F19OSchs7SRwVzw
         A2mDhg2n+dOu4n9zTotaLm0n1fESSiNdPaQTE0AI3F9f++BjUdOmD/WD0de3OzXIT0Ps
         aUX9WI3WtCcO9gAzRzi2Gn+8HO46TfASZU4jjQjBGGt5qMJI58NOgGu7ngjgYGInm/cZ
         KhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KXgSgcE2DeV4VZ5MMSQZsHOBA2UyqsNW1dsB9ms6UkU=;
        b=rW1GY3Q2M39ToKX/IBXpXsb/T1ZbjGqjEJSPUtNzrhsko5/foS9FRQqsf83bTUL8DA
         d6hQ5aIA1I4F1W6qvt0H1SXG9n4Yl7Adg4hGMTpowbaFQ0BATIVRSFaas5a6iyrZqWFE
         Iki5Q5aVYBnRc9wOamvtwwfkqg6124la0fVI1PhDwVINYegUuMxgcTG+kLZuGNdVxzLd
         fj3BDnTfhcIAwWK4vvwkJ9LsAX46mtrFZ0xy5/MUl0iGcEevwBhr/4tJ9tcL18H3iSpN
         P0qLZl/hiO0JPAU5RxLURHdQ7PggYZzj1eHAZSoc2xjmbizaLDKPZtaogyQ921ebFxVM
         kQbg==
X-Gm-Message-State: APt69E3Ob/SZv/bvMEthVivDdcto0t8SvURIg/opq6UA//cDI62lx0bi
        Iks7Xg/pZ+Azix7Zgg5tzOQaItl4
X-Google-Smtp-Source: ADUXVKK8h0gpCJyUyof1slkyX2XoELFgU2Zsl5my4aU9xLXmkCPK2Hc0+I2Qcq62bBekbVV67cKLPw==
X-Received: by 2002:aed:3d0b:: with SMTP id g11-v6mr24250628qtf.313.1528216666717;
        Tue, 05 Jun 2018 09:37:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3049:497a:f2dd:f3b2? ([2001:4898:8010:0:197f:497a:f2dd:f3b2])
        by smtp.gmail.com with ESMTPSA id m59-v6sm36297401qte.8.2018.06.05.09.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 09:37:45 -0700 (PDT)
Subject: Re: [PATCH v4 00/21] Integrate commit-graph into 'fsck' and 'gc'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <CACBZZX7N2xy0iX-zqZG2-g-44D1+X1bK38oqMWrWX0ZE1v9C-A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88258f58-c28f-0f74-a378-003704c41117@gmail.com>
Date:   Tue, 5 Jun 2018 12:37:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7N2xy0iX-zqZG2-g-44D1+X1bK38oqMWrWX0ZE1v9C-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2018 10:51 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jun 4, 2018 at 6:52 PM, Derrick Stolee <dstolee@microsoft.com> wrote:
>> Thanks for the feedback on v3. There were several small cleanups, but
>> perhaps the biggest change is the addition of "commit-graph: use
>> string-list API for input" which makes "commit-graph: add '--reachable'
>> option" much simpler.
> Do you have a version of this pushed somewhere? Your fsck/upstream
> branch conflicts with e.g. long-since-merged nd/repack-keep-pack.

Sorry I forgot to push. It is now available on GitHub [1]. I based my 
commits on 'next' including the core.commitGraph fix for 
t5318-commit-graph.sh I already sent [2].

[1] https://github.com/derrickstolee/git/tree/fsck/upstream
     fsck/upstream branch matches this patch series

[2] 
https://public-inbox.org/git/20180604123906.136417-1-dstolee@microsoft.com/
     [PATCH] t5318-commit-graph.sh: use core.commitGraph
