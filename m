Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B18621847
	for <e@80x24.org>; Wed,  2 May 2018 05:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeEBF7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 01:59:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33089 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEBF7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 01:59:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id o4-v6so12603732wrm.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 22:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KU5KwUvvtyzUIjaUKek9B5IfB+MEhl23Nun1MPewVoE=;
        b=XMn0gvfXFPmufANfzw0XbcOl0BBa2PqicfSeL4a7dzi4g8PVNQHsRJq9Z6BM7m//Z5
         FAj39T3YNq9t2ZbgjD16RKtgU3CLIvHtxxI/UvhaFai8h65ZbPU/SdhozULO45LNBe6y
         B2mgBIqtR1Tzgfe31BIJY8hU/BXEbF1v43hzSLcF0DhWPMien7C2dEjskefK4IcvZTNl
         nVz372ig6wlLOwci4OzxDcm3mFdb1nlLaHQduQi8B+9nYemDhfsPv/V1teSQtU7JcvX6
         hQ3YiHfoZE4jdtZFfKrRbSddvU9NGenWLgDcFkNFVz9g34rP+GDbiOeXsB4j2yh3x6Mw
         zcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KU5KwUvvtyzUIjaUKek9B5IfB+MEhl23Nun1MPewVoE=;
        b=dIHf+f7MhAsh+BnWen8crbCRlsldmR0VKr+kBsIKtXaq3aexzj20K2eAKFAJQEn413
         RTtKyTo8Y/gAgV+k/v6YsN4tTTS2E3ZFWj1NBQ9MP0aDyugThEeWZe+icw/kkd+ItfSH
         QomlZDo8DU0iz1J2znerqqN44obGCpyB6QRd+dzZbDwUSha4uFKNhx4haJV/TKUeAahL
         T6wU53sOtQS2MvgjMk5b224NYq/jt7Do3dk64nK5J05zfDIij8f67wgh4bAwuz5Jy6T4
         hMm0d6SzQZfWaByRVE/21gyHVTSb3gS3Ej/n29IBEeHMAmIjrVRmn02G5LZ6WIxvIpLP
         80gw==
X-Gm-Message-State: ALQs6tDiITUN6VseJRbBYbW54eDJOW9x9HpAFThfheIefg9SiLyKgETq
        7OZG+PTLwYSi/n2a0NrHO0Y=
X-Google-Smtp-Source: AB8JxZrb8kWxUbj6ahMBhONx9GSM5pCW6hi0yof40tKSx1LcwNCWdVPflRqvlbT1BYx8ZiB8cZ7Wkg==
X-Received: by 2002:adf:da4b:: with SMTP id r11-v6mr13303295wrl.154.1525240789912;
        Tue, 01 May 2018 22:59:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j76sm27575370wmf.33.2018.05.01.22.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 22:59:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH 1/3] submodule: clean up subsititions in script
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
        <20180502005528.19740-1-kcghost@gmail.com>
        <20180502005528.19740-2-kcghost@gmail.com>
Date:   Wed, 02 May 2018 14:59:48 +0900
In-Reply-To: <20180502005528.19740-2-kcghost@gmail.com> (Casey Fitzpatrick's
        message of "Tue, 1 May 2018 20:55:26 -0400")
Message-ID: <xmqqy3h2vbqj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casey Fitzpatrick <kcghost@gmail.com> writes:

> 'recommend_shallow' and 'jobs' variables do not need quotes (they never contain
> spaces) and do not require any additional prefix, therefore remove the
> unnecessary subsitition.

The resulting patch is good, but "they never contain spaces" is not
a very good rationale.  The real reason is that (1) we use them only
to hold a single token value (or leave them empty) in the current
code, and (2) if the feature they represent is enhanced in the
future to make them multi-token options (e.g. we may allow $jobs to
contain, in addition to "--jobs=2", "--jobs 2" for whatever reason
later), it is likely that we would want these multi-tokens split at
$IFS (e.g. "--jobs" and "2" get passed as separate option, not a
single "--jobs 2" string).

> 'progress' is a boolean value. Treat it like the other boolean values in the
> script by using a substitution.

This is OK.

>  	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
> -		${progress:+"$progress"} \
> +		${progress:+"--progress"} \
>  		${wt_prefix:+--prefix "$wt_prefix"} \
>  		${prefix:+--recursive-prefix "$prefix"} \
>  		${update:+--update "$update"} \
>  		${reference:+"$reference"} \
>  		${depth:+--depth "$depth"} \
> -		${recommend_shallow:+"$recommend_shallow"} \
> -		${jobs:+$jobs} \
> +		$recommend_shallow \
> +		$jobs \

