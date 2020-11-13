Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D2CC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DB4208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMQhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:37:35 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:20206 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKMQhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 11:37:35 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kdc4q-0006P4-8u; Fri, 13 Nov 2020 16:37:33 +0000
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <32a5617e-49b8-c6e9-4b1e-09e77bcae8fa@iee.email>
Date:   Fri, 13 Nov 2020 16:37:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/11/2020 12:16, Patrick Steinhardt wrote:
> This commit thus adds a new way of adding config entries via the
> environment which doesn't require splitting of keys and values. The user
> can specify an config entry's key via `GIT_CONFIG_KEY_$n` and a value
> via `GIT_CONFIG_VALUE_$n`, where `n` is any number starting with 1. It
> is possible to add multiple entries via consecutively numbered envvars
> `GIT_CONFIG_KEY_1`, `GIT_CONFIG_KEY_2`, etc, where each of the keys may
> have a matching value. 

> When no matching value exists, it's assumed to be
> the empty value.
Is this a good choice of default in the face of potential mistyping when
entering commands, or cut&paste editing of scripts. It's easy to see
cases of mismatched KEY_2 VALUE_1 entries.

Wouldn't it be better to warn about un-matched key/value pairs?


> +GIT_CONFIG_KEY_1,GIT_CONFIG_VALUE_1::

Shouldn't the man page entry indicate that it's '<n>'  ?

Philip
