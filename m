Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA0E20248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCMBoB (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:44:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32992 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfCMBoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:44:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id c13so3370252wmb.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8BvtsCR8ChTXWMHqILHAqUSyLgfp3jWheNq3Vk3ZF8c=;
        b=lvLI4lk1TIG/dVxA0dv2WEgpCocXX/8sJbtLi4pvPEZ6bROfyr9P1HNJdO600YhQzQ
         2VPD4tPsbauZrv83G3Qrl7ZOdFaM+tL6xJ4/8u03j9z6T4RUMDAZMD8BjUyPkK7PE2ly
         0io28+GZsUZLWNo5EUN3GR6UVfcvuaYTIedLOeMmbfHMUJLAc4yz72lFPFz5XSerTTIe
         MhYv6wZ68qmZIfFFKZiQVoPbyIYWI+JoWeIWuq71vOrmf+DDKYUZYUrOVJFJbfj5pHj3
         ytQOyxkh8OyzMjuyEChvb83l/N0t0faWdahrIxd5p1OSztZ4/um2vFc/TAgP3wNDCBGq
         BWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8BvtsCR8ChTXWMHqILHAqUSyLgfp3jWheNq3Vk3ZF8c=;
        b=EvHkKwVCXIVET4wW/bB7BqagkHjNL8ZzavbAc1gfSIhOb+HdU+/rqBKLMHVlDwEgnp
         tVYhqRI7mZEpUqTkDw6R2yXUouYUUYpGCrpGxQwT/pEPhYNwhA5Diam84bQvETeY8is2
         gb3A9yUKEtl6nrVguO+haXN3BLiRDFZJvL/TZoPCmae9cPlUMbu2nchOxQbAWR3AadXV
         cF1i1Io1P/2QAbD5PX06pO8WX7UzZyHdtR7ck4F4gUQPtKLGmxfazl4CvU68WapWSU8A
         DUX1JA9V5w3QjLz6nYq+lYWG2ejjnH4DdpnNGRwqtP8dAAlkxnWzq6l4oSzm6bKNonyb
         TbCA==
X-Gm-Message-State: APjAAAWJbMPr2Txp4w9cRilqAJIpc/DcNpPvwrups+8s95SDl8hs/n8P
        eLoxX+SC8wgayUrJ25+ese8=
X-Google-Smtp-Source: APXvYqy2fxidmNQ8UMGZMuQZ+rwyVXNoPFbcl9Dg719ulN+4meFNwnu9qqok4VQsYORisoXV6DwIZQ==
X-Received: by 2002:a1c:6442:: with SMTP id y63mr405778wmb.31.1552441438324;
        Tue, 12 Mar 2019 18:43:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o12sm32155325wre.0.2019.03.12.18.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 18:43:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: Race condition due to reflog expiry in "gc"
References: <87tvg7brlm.fsf@evledraar.gmail.com>
Date:   Wed, 13 Mar 2019 10:43:57 +0900
In-Reply-To: <87tvg7brlm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 13 Mar 2019 00:28:05 +0100")
Message-ID: <xmqq1s3bh7ky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I'm still working on fixing a race condition I encountered in "gc"
> recently, but am not 100% sure of the fix. So I thought I'd send a
> braindump of what I have so far in case it jolts any memories.
>
> The problem is that when we "gc" we run "reflog expire --all". This
> iterates over the reflogs, and takes a *.lock for each reference.
>
> It'll fail intermittendly in two ways:
>
>  1. If something is concurrently committing to the repo it'll fail
>     because we for a tiny amount of time hold a HEAD.lock file, so HEAD
>     can't be updated.
>
>  2. On a repository that's just being "git fetch"'d by some concurrent
>     process the "gc" will fail, because the ref's SHA1 has changed,
>     which we inspect as we aquire the lock.

Both sounds very much expected and expectable outcome.  I am not
sure how they need to be called bugs.
