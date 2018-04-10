Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B051B1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 01:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeDJByt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 21:54:49 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46315 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeDJByt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 21:54:49 -0400
Received: by mail-wr0-f173.google.com with SMTP id d1so11304274wrj.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wg5+gLDvZxTMfreLzjWh45/JR1fJ0+iIgTdGldBgVpE=;
        b=VZpP9nXauqZcbNDdVpZ3JdYCKsJKuV+h9BitTeFZBdV/36F8NdOSuduH6kiDLBQUFf
         i/+uCJ5GAhB0a/PGIV8oMuM+tV0vTJO5KPsQil6RKxlZu8qImTQwD9rBafvOafr2f/mM
         Crjvy/7UcyPGE9PecuG77EhBGwOzHQKqYZE2/8ocbX4LjAZI3px0EYFpS/fIq1PDDu9I
         Rys0awHH1dFsralwpSI2cvAPyYuhuxhgxA1R4OfFXuqR+Dkfwd8kLK4/+6YFbVNSdLCN
         gcll+/WyYt+j8v34ZSz2VR8O4RhormLRjKd72Cr5WTJoKOh5Sx6AF1kawIxXJLzOKf9e
         nq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wg5+gLDvZxTMfreLzjWh45/JR1fJ0+iIgTdGldBgVpE=;
        b=mLhxJHJB/WsN6yp29bEQnUprCwYbWXITyRGa9YiLna712kMBP0OLma/F7t+i4eC35x
         w1I494oP8+T58GQvLCYtssamSndEaDofMA//wV5nlVPVsEhPRxYInC/teM3euhn99/EI
         ugWhEhQGLTp4w6/W1pbH/fOhSYVdv6rAIzQawDa4ZoDIJug2Qj1TJQFUTbJ8UmnqdhxK
         cDdnpftmjeXFm095d6r18wDsfxoIKJK8Yz8UsxuN91ERpXPKPOr4JNI8OH391x9VtECL
         6g4M/Y0CwTAThXGs63UK9pMDOXBaUqDgYNaHAs/OKYyoMReMVuvMuEsJ0HeS8OTcBgAD
         ziFA==
X-Gm-Message-State: AElRT7FhrzC0a8OE+b2b1azOcuyBpmIX8bklZvLW31APAyuEhv7/kpuV
        CwkN5ARs2Ox/hHrJoDE8owY=
X-Google-Smtp-Source: AIpwx49h7S88ZcfgB4gQJifz4aGPgWba88Uued2+wL9JQAgeHEa3THRdk2h3stu/y0qqS+WeT3KVVw==
X-Received: by 10.223.154.182 with SMTP id a51mr30792631wrc.176.1523325287518;
        Mon, 09 Apr 2018 18:54:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 39sm2985989wry.89.2018.04.09.18.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 18:54:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v6 3/3] builtin/config: introduce `color` type specifier
References: <20180306021729.45813-1-me@ttaylorr.com>
        <cover.1523319159.git.me@ttaylorr.com>
        <20180410001834.GE67209@syl.local>
Date:   Tue, 10 Apr 2018 10:54:46 +0900
In-Reply-To: <20180410001834.GE67209@syl.local> (Taylor Blau's message of
        "Mon, 9 Apr 2018 17:18:34 -0700")
Message-ID: <xmqqk1tf4yhl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index b644a44ae9..7c8365e377 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -177,6 +177,10 @@ Valid `<type>`'s include:
>    ~/` from the command line to let your shell do the expansion.)
>  - 'expiry-date': canonicalize by converting from a fixed or relative date-string
>    to a timestamp. This specifier has no effect when setting the value.
> +- 'color': When getting a value, canonicalize by converting to an ANSI color
> +  escape sequence. When setting a value, a sanity-check is performed to ensure
> +  that the given value is canonicalize-able as an ANSI color, but it is written
> +  as-is.

This makes sense, in the same spirit as a value with "path" type
where tilde expansion is not done at all while setting.

Will queue.  Thanks.
