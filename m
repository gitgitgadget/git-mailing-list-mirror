Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D670EC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A291D61934
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhC2Ksd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:48:33 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:42984 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232711AbhC2KsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:48:24 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4F88SR3Xzvz5tl9;
        Mon, 29 Mar 2021 12:48:20 +0200 (CEST)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <71c34328-9814-2777-3a9d-f908602dd36f@kdbg.org>
Date:   Mon, 29 Mar 2021 12:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.03.21 um 12:18 schrieb Phillip Wood:
> It would be nice to include indented define forms but including them
> means that any change to the body of a function is attributed to the
> last internal definition rather than the actual function. For example
> 
> (define (f arg)
>   (define (g x)
>     (+ 1 x))
> 
>   (some-func ...)
>   ;;any change here will have '(define (g x)' in the hunk header, not
> '(define (f arg)'
> 
> I don't think this can be avoided as we rely on regexs rather than
> parsing the source so it is probably best to only match toplevel defines.

There can be two rules, one that matches '(define-' that is indented,
and another one that matches all non-indented forms of definitions. If
that is what you mean.

-- Hannes
