Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE74320282
	for <e@80x24.org>; Tue, 23 May 2017 06:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965793AbdEWG1B (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 02:27:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35888 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965790AbdEWG06 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 02:26:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so25264557pfb.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 23:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MD4o6g6vXjADuimuXUJiUYXG4T2s/p9asuwlAMrfdJ8=;
        b=SUUVWu0bK6JZOiybO3idV/Fr7REZt4AcCbdzRawKjo3nwRKZBNCuJUz7aIu5GRW7dA
         H4RgQ0kkuT9cQzbJRfyS0TaAzDl+AfEAl/Q2t+8PxjZUsPIoqXyizB0qtusYepCgZVqD
         UmwxZLjId7mJuUhsNfv89mTMi935q7Wmo4Cj5qCfNWj5TuxP7EGoHNrLzL2UgcYLdaMu
         XXp9pzke95zJisqAY9jzf9AmG+2x7dY9S4Jw+NoYC4Uk2dCMuAK175IEuu/gMR0UPKL5
         q/7Gx7TI5lVOFqa45HPZoC+YyOqUoM23JTw9WEz45tIFuQrpTK4PT4TdDMBjyG2gFBJI
         OmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MD4o6g6vXjADuimuXUJiUYXG4T2s/p9asuwlAMrfdJ8=;
        b=VUmMFwZmaWd20Pyr4XU3yggMuPAFcNv5f9e9rRiexKqQ6rWylrh79wtsJm8CmsXPay
         XOGcehWD/Sd3bDa2KIXIA4o8WOX6fpY3IzkucU11nxBMOajqIFZTdvAX1mULrV7+PJcL
         XYzLG4HDJZzSTBxNQt4Gaf5jvzX8gfxAMg8L247etLfk3quXLcjnBYPkcWZOkeM0pCjH
         RKSMwpfjJVmSeqc62nffUvFqrjcGANmjQ9uFBjwCBGVVUFq/wKdVQ6mK2ntEavNaZNJb
         8LggkG9BZ6fx1OAtPdcKzhfVXDmBoewdgZScx+Uh/U2vFvMeLfoHCzZnXZOO0pgmCyty
         +KYg==
X-Gm-Message-State: AODbwcAHMWzCSP/vITq9SxvaA9UZ7f9Us/J1xdpKMmM7HL+0UUV8W4T7
        NsQIpuXtLl01Dw==
X-Received: by 10.98.66.214 with SMTP id h83mr30298967pfd.182.1495520817367;
        Mon, 22 May 2017 23:26:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id o194sm34837482pfg.117.2017.05.22.23.26.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 23:26:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCHv2 2/6] submodule test invocation: only pass additional arguments
References: <20170522194806.13568-1-sbeller@google.com>
        <20170522194806.13568-3-sbeller@google.com>
Date:   Tue, 23 May 2017 15:26:55 +0900
In-Reply-To: <20170522194806.13568-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 22 May 2017 12:48:02 -0700")
Message-ID: <xmqqefvgks0g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
> index e8f70b806f..2672f104cf 100755
> --- a/t/t2013-checkout-submodule.sh
> +++ b/t/t2013-checkout-submodule.sh
> @@ -65,9 +65,9 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
>  
>  KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
>  KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
> -test_submodule_switch_recursing "git checkout --recurse-submodules"
> +test_submodule_switch_recursing "checkout"
>  
> -test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
> +test_submodule_forced_switch_recursing "checkout -f"
>  
>  test_submodule_switch "git checkout"

Doesn't the above look crazy to you?  

It is hostile to other people (and those who need to make merges)
who have to work with test_submodule_switch_recursing that older one
used to take the full command but its definition suddenly changes so
that the caller now must omit the leading "git".  Even worse,
another helper with a similar-sounding name, test_submodule_switch,
still must be called with the leading "git".

The same comment applies to the one we can see below.

> diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
> index f86ccdf215..a000304221 100755
> --- a/t/t7112-reset-submodule.sh
> +++ b/t/t7112-reset-submodule.sh
> @@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
>  KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
>  KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
>  
> -test_submodule_switch_recursing "git reset --recurse-submodules --keep"
> +test_submodule_switch_recursing "reset --keep"
>  
> -test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
> +test_submodule_forced_switch_recursing "reset --hard"
>  
>  test_submodule_switch "git reset --keep"
