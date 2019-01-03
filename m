Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA69E1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 11:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfACLhJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 06:37:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfACLhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 06:37:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so33262678wrw.5
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c2M4eoIpS99RqnKJIYWedeR6J9N3RJcwaee0e9c+ryI=;
        b=aTcn7S6wsm1dL24doTToWsNcNy/aHyxt1ioNoB9ltrVHUWIxJJoX4etgpL2vQgFzPn
         XMZ805quq1HVfOl7ph+bBqk08mUnQ+NyRxRn7QbvvjygrT501kFO1CNXYaheDT7WBK5F
         siw61D9RpaTUottjCWFJv4zVO6Q2gYwLSwuAGhWg8yNa762A4B5R0WptZLpIa0cL8TTf
         WEHXT8R/VfCK5BHXTumPnAtNX1Q/WMkx+WKDQpMhotQq3uU9IPxTgyv+GRz30MMb+aYw
         /8x4Mux6dXg6jrDhg/4sr5DETO5pu16fjhSDFBVlhdiwmxhjMWM3YCtgAkrYaz5+6v+S
         QcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c2M4eoIpS99RqnKJIYWedeR6J9N3RJcwaee0e9c+ryI=;
        b=lwFqb+2NlUmVYY9apaeeXseyQuU1tFqpPLedW44nzwwRb7Bd2TUVVpOC9IFY3fuRsk
         9f09M3sY7bUlKSv63VCvwtTOKfQ0C7K9WNm6naABXhcLi6ZXPS5SVeDXqSMKXzyf12ul
         8MYDXzbZaNGM1cokV2zY0M02iqy21MEbDdGZSnF9hs3aJHn0rc1tUZJSQ1ab/LzAa4oG
         gNHOh23kubYPCg1f/nIENq9qC9MKlR8ENKcxe+Eh95JE+rVuEe5U+BBw1ABfBfyJ0FWA
         jq0FXAmGoOHIpk0DUvlhwyp0uoIEYdVDejw0YT4OT6arXPCL6EQYtYsrobR3Ack1rXYK
         dhRA==
X-Gm-Message-State: AJcUukfg+kR6Uy1ZhiejrcOo3eL+D7GjWsEpxnfmUQCMNniV4jJbZE3w
        kAudZzdz70R8WvzwaSYMoOmNwio2
X-Google-Smtp-Source: ALg8bN4uMfXgiAHfb4H5F4rDBN0nt0L6qXcd+u8X7CwHn2f4u4Z76M2sfDMt5WV32bSgcBsWy9So9Q==
X-Received: by 2002:adf:94e4:: with SMTP id 91mr43723700wrr.322.1546515427097;
        Thu, 03 Jan 2019 03:37:07 -0800 (PST)
Received: from szeder.dev (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id o5sm67536850wmg.25.2019.01.03.03.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 03:37:06 -0800 (PST)
Date:   Thu, 3 Jan 2019 12:36:59 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: check Bash version for '-x' without using
 shell arrays
Message-ID: <20190103113659.GA4673@szeder.dev>
References: <20190101231949.8184-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190101231949.8184-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 02, 2019 at 12:19:49AM +0100, SZEDER Gábor wrote:
> To my understanding both shells are right and conform to POSIX,
> because the standard allows both behavior by stating the following
> under '2.8.1 Consequences of Shell Errors':
> 
>   "An expansion error is one that occurs when the shell expansions
>   define in wordexp are carried out (for example, "${x!y}", because

That "define" above always stops my (non-native) English parser for a
moment or two...  shouldn't it be s/define/defined/ ?

It's not a copy-paste error, POSIX does indeed write "define" there,
see:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01

(First paragraph below the table and the Notes.)

>   '!' is not a valid operator); an implementation may treat these as
>   syntax errors if it is able to detect them during tokenization,
>   rather than during expansion."
> 
