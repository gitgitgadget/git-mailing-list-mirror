Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076D61F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDLLbB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:31:01 -0400
Received: from mail.javad.com ([54.86.164.124]:40432 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbeDLLa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:30:59 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id BC9CA3E8B8;
        Thu, 12 Apr 2018 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523532659;
        bh=k1VRVCaw9t29EcCCs9qHZK22IFVyq5EGJDNd/HheQmo=; l=561;
        h=Received:From:To:Subject;
        b=ghSuIbcNwYtii3Kv6yuZQ5oNIZsgDP4/rL1ZCc4llJQTHSKEJhJSU3oTVZ3Rb3+fI
         Pxtvc3tXW2dgtbuFt/WmEiuG7YhWzP5EsFlqMSqOZYif77uQiXGpudnG8lITAIpc6c
         1gRypZRUpvLxEGuQlERTJOH/ipIpcYnpBpZ9SQF0=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f6aRM-0001do-Pz; Thu, 12 Apr 2018 14:30:56 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 14/15] rebase -i: introduce --rebase-merges=[no-]rebase-cousins
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <349021284f5b3b9c57a49f88221cef1eb4643020.1523362469.git.johannes.schindelin@gmx.de>
Date:   Thu, 12 Apr 2018 14:30:56 +0300
In-Reply-To: <349021284f5b3b9c57a49f88221cef1eb4643020.1523362469.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 10 Apr 2018 14:30:26 +0200
        (DST)")
Message-ID: <877epczmof.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

[...]

> ++
> +By default, or when `no-rebase-cousins` was specified, commits which do not
> +have `<upstream>` as direct ancestor will keep their original branch point.

<upstream>

sans quotes, <...> are used without them throughout the manual page.

> +If the `rebase-cousins` mode is turned on, such commits are rebased onto
> +`<upstream>` (or `<onto>`, if specified).

<upstream> (or <newbase>, if --onto is specified).

sans quotes, and there is no <onto> defined.

-- Sergey
