Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3CF20365
	for <e@80x24.org>; Wed,  4 Oct 2017 17:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdJDRJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 13:09:32 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:54247 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdJDRJb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 13:09:31 -0400
Received: by mail-pg0-f45.google.com with SMTP id j70so6816485pgc.10
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q2WatHD7TWmcrDQKxmLgb6W6YfDKE0KKFUah3q7qvtk=;
        b=f8rfy0k4MY4ratA/BUkQjJ+JgE2l5fw21FOiJzvtCrhzipQW+73wm3FXhhAniT5mB/
         8WPitgmZnB8oEtlhY2SAfOJye2Osn4FEF+CW5RG6yNYP/idPdQp1dWdBKHT9bbhkjhTO
         E07fWxNxgMhDlDATVCIyHk9FDGOpuVMrSHEYokFIda/uQ9DGuj1CTasOou+zEgsowhkQ
         Rjejt3mPAvxnYr7ja+6EXpBW/oJlN93p6RNLlpArzGoH0DsspUu6b3mgZFaUACRiiwKj
         Xek6dk6Xjw4lpxJG4zE3pOM9HgBQcGev+SodK+HI/Uh8KOp2/FJ2jL3w4kHJE1sI+HSU
         bZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Q2WatHD7TWmcrDQKxmLgb6W6YfDKE0KKFUah3q7qvtk=;
        b=HV/17Twp7I//T4VMSxPr+zSTqLz7XXVupV3NJUUFDvShdUvF5SyC7q4qqSso1SJpBJ
         EYdNtRYzKUVjLpz8nMoeQW6i7nKs/yn5PQ/BkQLeoe8ayYeDGJWsP2fFHoLN5IoKkBCN
         lEPOLRqk3kJo1krmkxSHwMXIjrbiUhNqkbHqZsWAPbHhcZCxPsCXmzYxrZEIceOiKMVz
         ofu1gjPB2pOKujcy8zKvV9QxG0DQ4p7UX9wWREDXn995SiFVNYPC6M+C/GJ2VCNS5ZZ7
         En4tolrfb7UpbD3Lf56aKs4Zp/A8Cyf67PEr+Y4qxjDtW9djE1yp2/St8Lp1AbFXMWpY
         iB6w==
X-Gm-Message-State: AHPjjUgGbrM/GZ4LZ9Zbn4zB1p4lorg+ayS6DjGzO4DvGx0ai4Aq2c/s
        zniNEmHPRrDmRvbzIarNy0v/dCcM
X-Google-Smtp-Source: AOwi7QC6btNEaAGaRSYARYFJoTOLuAv9OA1ZPBoYnb0yq2eJkAR5KBkPtDY2p76H+n9nh0YsKzzwqQ==
X-Received: by 10.98.178.80 with SMTP id x77mr20393353pfe.12.1507136970511;
        Wed, 04 Oct 2017 10:09:30 -0700 (PDT)
Received: from mix-director-10 (astound-69-42-0-111.ca.astound.net. [69.42.0.111])
        by smtp.gmail.com with ESMTPSA id u73sm27225735pfi.58.2017.10.04.10.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 10:09:29 -0700 (PDT)
From:   Ernesto Alfonso <erjoalgo@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: disable interactive prompting
References: <87tvzehp13.fsf@gmail.com>
        <20171004170119.GO19555@aiede.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 10:09:26 -0700
In-Reply-To: <20171004170119.GO19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 4 Oct 2017 10:01:19 -0700")
Message-ID: <87mv56hmbd.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The prompt asks for my https username/password:


> $ grv
> origin	https://github.com/user/dotemacs (fetch)
> origin	https://github.com/user/dotemacs (push)
> $ gpom
> [1] 22549
> $ Username for 'https://github.com': 
> $ fg
> { git push origin master &>/dev/null < /dev/null; LAST=$?; test 0 -eq $LAST || echo "gpom failed with $LAST !"; }
> Password for 'https://asd,csd@github.com': 
> gpom failed with 128 !
> $ 


Thanks,

Ernesto

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Ernesto,
>
> Ernesto Alfonso wrote:
>
>> Waiting for git-push synchronously slows me down, so I have a bash
>> alias/function to do this in the background. But when my origin is https, I
>> get an undesired interactive prompt. I've tried to disable by
>> redirecting stdin:
>>
>> git push ${REMOTE} ${BRANCH} &>/dev/null </dev/null
>>
>> but I still get an interactive prompt.
>>
>> Is there a way to either
>>
>> 1. disable interactive prompting
>> 2. programmatically determine whether a git command (or at least a git
>> push) would interactively prompt
>
> You left out an important detail: what does the interactive prompt in
> question say?
>
> The general question is also interesting, but seeing the particular
> prompt would make it easy to look into the specific case at the same
> time.
>
> Thanks,
> Jonathan
