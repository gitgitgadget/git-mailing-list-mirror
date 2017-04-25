Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA98207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 03:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980466AbdDYD7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 23:59:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36018 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980463AbdDYD7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 23:59:13 -0400
Received: by mail-io0-f194.google.com with SMTP id x86so52396948ioe.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4hM0cqwd9AFxEhQOWJErUylZTwpcbb3IsxUY3By3wx8=;
        b=OQw1NOUKswhmY+FJhh2zIXR/MXugtSBjaEc+itH7ytAgy1Pq+sfmEwCF+bfbPqHo8l
         Y7/mGmokcnYTEtYae3MBeO6EcCzmDutBFPr5HNeMz6HAUcNw+F75J6mH3YVDZ0MZGpry
         kYjHW3QakMICA6ap0Qyv3xkugnX+hiHIBRPEqD4cM6keiiOEaeLeHhOkbfXUxFDh1+ZJ
         x9jiatHLG9fDYTR/+BwowRHSFufVsMY2pAvHT1X0qxyFMInixMJqx8VqfRWF45Yyl6ek
         fdON8NLxwS5MtRRlpUEWpGpswynOFphe83seMY8fS0DOqks2hcmR4SS65dnHhoYHfmru
         eN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4hM0cqwd9AFxEhQOWJErUylZTwpcbb3IsxUY3By3wx8=;
        b=SV5+PZAVSQlCrs/WEhUB+4SucECDJoJn8Fo19b0SfO4r6i+861mnNyuGANRF3yzpeU
         U74OF7IOxINzXh5w6LUf5tyhZnZ7rYa8J33WeZAmbsWyTJ1+hph7YELJ83mAUCfOVgs5
         D2RAGIzhlV2xTnY+7xWAjj/SkBZ2DYdkcLUEje3mCf8hHmEMQDvzpjmiKk++Pm5nCps+
         4r9JZHW024yirfasvguwoIRIU8zDjsmIYWpTTZbcIuoLrx0Tb23tq3wzn5h4qjm7npPB
         ItK7XtFrYEnX0QBOwFb3FvypkT1CqzQAWW/mbLAumedM+VAd5KcZBD63bG0myUM+UFW9
         ESWQ==
X-Gm-Message-State: AN3rC/4XhzOnNrLM/tAuSLyBQzXhPvVrWb4jZJQUobaSNF4ojKXqQML2
        CQXA0QeIXH3fY/TmWts=
X-Received: by 10.107.63.11 with SMTP id m11mr12315024ioa.149.1493092752422;
        Mon, 24 Apr 2017 20:59:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id r189sm970452ita.28.2017.04.24.20.59.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 20:59:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
        <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704241226440.3480@virtualbox>
Date:   Mon, 24 Apr 2017 20:59:11 -0700
In-Reply-To: <alpine.DEB.2.20.1704241226440.3480@virtualbox> (Johannes
        Schindelin's message of "Mon, 24 Apr 2017 12:28:27 +0200 (CEST)")
Message-ID: <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Should we at least clamp in date_overflows() so that large values
>> representable with timestamp_t that will become unrepresentable when
>> we start allowing negative timestamps would be rejected?  That way
>> we won't have to hear complaints from the people who used timestamps
>> far in the future that we regressed the implementation for them by
>> halving the possible timestamp range.
>
> Please note that the date_overflows() command only tests when we are about
> to call system functions. I do not think that it does what you think it
> does (namely, validate timestamps when they enter Git).

OK, then please read my question without date_overflows(), that is,
"should we at least clamp the values with some new mechanism to
leave the door open for supporting times before the epoch, even if
(and especially if) we leave the use of signed integral type for
timestamps out of the scope of this series?"

