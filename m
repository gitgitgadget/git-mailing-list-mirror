Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40641F404
	for <e@80x24.org>; Fri, 14 Sep 2018 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIODaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 23:30:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIODaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 23:30:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so11947270wrb.8
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dCak68f/+nyYc4LrG1nfaygi7hLZrGNrevk/JCrmJJM=;
        b=grNS6amQpAw8noL0uqJ0xsB3Le5fjp1BNk0M+F83vJwm32RuH3l3Fm1Fx/Su9Rpf9q
         pygCuDKRDQNPs0RykitvYS2eXMpd1gtthEIhrgC1vk3fQ9HE0902Qh0D2N9uoueSHYel
         ek+olgFUKCK7AXMyNcN68vsm83Q69cSEqrbQjxTGwcMeTh6BzarBMNVn7mA0TFvl9Nwv
         n550KTCU2COFzwYoY1dqtIClcfjqKj772EorwH8KyaOuOVAzpK1G/rAjxz8gRuoXR/qC
         s80mDcXxYeokR8+r58DTuBIrHE9KRf+iScDMdiaU5KoOAHnRtnQ28u6/rINlW2P4TVoT
         NV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dCak68f/+nyYc4LrG1nfaygi7hLZrGNrevk/JCrmJJM=;
        b=nrcfHuZHq8qw7IL/KL4LZAwBrihqPvAEoQ7Fcpjqav75BvND425jJ02sUJU8BTJBJE
         qLQVOvfvdujCAmlxzcQaYactiZzgWM7a1yJ2m2KL2dwXgBdlD35D308L4j/o0ljCcKsE
         Px7m1EvRLsbVkCyiDcq0iPgYjV5vnDzaaGtCcXBHkmj9hVYtgb5U2iBqZxGCHQGLSnut
         OOVn2hQ3qS3fTQzSyEaUHOsCjA7+/pz3zyEhgPcM9DTjm1cI94li3Weht00S2nIBKZqI
         EPAQI3PsW1asGEKny1VeL4GgNoSZdwlnumUH3of1cuQWLDix65F4nkuvKClHN/Es/NsE
         kiHA==
X-Gm-Message-State: APzg51DWUYyzC1dUui9Bcr/QOKpJb2P0hyC+4C8ftb//Hfa6YFQRyy9O
        9PIQAzhuT98+KdVlPzZYs48hdaRQ
X-Google-Smtp-Source: ANB0VdZOCrzxppxzdFDAmYg4m7Sd6fkQWOfS6TVghl1nCkyILDauOnZYHNrMAcUMJgpz6rC9Wnv7zw==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr11927716wrh.65.1536963228165;
        Fri, 14 Sep 2018 15:13:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d12-v6sm8802447wru.36.2018.09.14.15.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 15:13:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "peartben\@gmail.com" <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 4/5] read-cache: update TEST_GIT_INDEX_VERSION support
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
        <20180914201340.37400-1-benpeart@microsoft.com>
        <20180914201340.37400-5-benpeart@microsoft.com>
Date:   Fri, 14 Sep 2018 15:13:46 -0700
In-Reply-To: <20180914201340.37400-5-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 14 Sep 2018 20:14:03 +0000")
Message-ID: <xmqqtvmrafs5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 653688c067..397eb71578 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -134,9 +134,9 @@ export EDITOR
>  GIT_TRACE_BARE=1
>  export GIT_TRACE_BARE
>  
> -if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
> +if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
>  then
> -	GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
> +	GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
>  	export GIT_INDEX_VERSION
>  fi

Is this done a bit before ...

> @@ -159,6 +159,7 @@ check_var_migration () {
>  }
>  
>  check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
> +check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION

... this has a chance to kick in to say things like "Whoa you have
TEST_GIT_INDEX_VERSION that is an old spelling of
GIT_TEST_INDEX_VERSION", isn't it?

>  # Add libc MALLOC and MALLOC_PERTURB test
>  # only if we are not executing the test with valgrind
