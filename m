Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0624E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeFFLbq (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:31:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43579 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbeFFLbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:31:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id y89-v6so5901110qtd.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1tPC0LYkKayKE9pZ3/s86X2JVrsNCg+5gRgw7SWq9/8=;
        b=W2ZND73ExqOeOf0HoJUFdF2wW/gHU7EA5z4LurLai0H1U781cEmp9SRuKyBBz6lg5K
         zLOBKm0MhGx1ME3o9d6lRmCnXoNPW1Sf6l0mrZEqqoRqEmVXY6D5wzn/2qEiTk4yF6MM
         EATVGDHUQfE7qnStLPYP4ASoTfqT3BXtCEt9lyenXEaIdhearU984XRsOmoCsSmT6D6q
         0SlVy/ZZCMQjnNz17ndYCagxKI55/QhdJVCzV0kft3N1gurirGu+XNccXoR6znyZfunY
         EMLPrY416dziHoCpmtKxIqkJgAVUI4uDdQhF3NbsiGQhsaK9RvxJ21Ily7nw5XSSfpLb
         ldgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1tPC0LYkKayKE9pZ3/s86X2JVrsNCg+5gRgw7SWq9/8=;
        b=iHg0MXsdN5tVWIm83DpUw2SGDUfNDWPWAt7WppsiRSiHOyEAqhtDOPVB/92AEC6E60
         BjhVPSXfqze6AVjgTQrHcPR+1mb7clO3lcg5J6aQGcHJTnk+pySn5vwvJKEjjr4fJPq/
         VOfFB0PCU43dylYXrioIx7MxOK+oO+KnbsyHOKFXsjIzn1pY0flf+ULfVGUKGoMat60n
         lDA4IqVlKgHBSOZhqb0WRt9FQaOsMkJoqlaRekNjki3yKncco+CGeHL7pbTxe0JCIqBT
         6lz15da0/UIand1vGlB2hWu0Bv2ya7uwxJTODry67TLodX1NE+V7aeN+e36Ob4oFzUBh
         hzjA==
X-Gm-Message-State: APt69E1g0tLxdFeBCwlJe1vqPGUXO02pSjyCO07l0ryAZLNN+bs2l58Y
        RZE4aC1IOLPqAVCDfqMMmw32vrM9fSQ=
X-Google-Smtp-Source: ADUXVKIGJH6+g+HveHrO5oHXto8r2/PbJOwxH6FlbawS+KN9RLBAO4GFVEfWW1UGVPFqmTMJblGEwQ==
X-Received: by 2002:ac8:4407:: with SMTP id j7-v6mr2274522qtn.117.1528284704285;
        Wed, 06 Jun 2018 04:31:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3049:497a:f2dd:f3b2? ([2001:4898:8010:0:197f:497a:f2dd:f3b2])
        by smtp.gmail.com with ESMTPSA id x12-v6sm20899807qtp.10.2018.06.06.04.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 04:31:43 -0700 (PDT)
Subject: Re: [PATCH v4 17/21] fsck: verify commit-graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180604165200.29261-18-dstolee@microsoft.com>
 <87k1rcyxxj.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73c4edcb-dd13-04e9-b4b6-0f415e5e8768@gmail.com>
Date:   Wed, 6 Jun 2018 07:31:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87k1rcyxxj.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2018 7:08 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jun 04 2018, Derrick Stolee wrote:
>
>> +		prepare_alt_odb();
>> +		for (alt = alt_odb_list; alt; alt = alt->next) {
>> +			verify_argv[2] = "--object-dir";
>> +			verify_argv[3] = alt->path;
>> +			if (run_command(&commit_graph_verify))
>> +				errors_found |= ERROR_COMMIT_GRAPH;
>> +		}
>> +	}
>> +
> This doesn't compile under clang on master. It needs to account for
> 0b20903405 ("sha1_file: add repository argument to prepare_alt_odb",
> 2018-03-23).
>
>      builtin/fsck.c:837:19: error: too few arguments to function call, single argument 'r' was not specified
>                      prepare_alt_odb();
>                      ~~~~~~~~~~~~~~~ ^
>
> Ditto this error due to a missing resolution with 031dc927f4
> ("object-store: move alt_odb_list and alt_odb_tail to object store",
> 2018-03-23):
>
>      builtin/fsck.c:838:14: error: use of undeclared identifier 'alt_odb_list'
>                  for (alt = alt_odb_list; alt; alt = alt->next) {

Thanks, Ævar. I forgot to rebase onto 'next'. Doing so now and will send 
v5 shortly.

-Stolee
