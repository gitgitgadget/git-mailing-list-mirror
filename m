Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2537E2032D
	for <e@80x24.org>; Thu, 14 Mar 2019 06:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCNGHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 02:07:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37064 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCNGHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 02:07:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so4463521wro.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5ggkt2n/Q8hFENdjzvslZVZVg+punIhFW89GMuj1YaE=;
        b=glZjAaxu0gZIoyzIXDqAuGW45s/y/kgq4RFHlfjANVGtyQvAbjEvvVVGi2hwkNGW0F
         vZUg1KFqk9l4oUDrz/N9LJ5aR1p070tPLlXE7ZgmYiWxHwPg3kxmmgWMdIrO5cLhF5f+
         fq7U9q7ZTI4Ptt2Xrn8P0Ls/LdCfxtAsRvAQGqX15EOlAVSobKn1kRaq+sgdPmsGN3SF
         2GkhIs2wcm0UadC+vIjNPm1FKSyz8pcACKbCvKRNpx5oSGnIpAhsrFZFpP4481DOx5mz
         00C9NObbd/QQHswnnth1u1VyUqpVvPTnoDQFSZaNj3iOAXght29aHedx0APzcs+0GZqZ
         o9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5ggkt2n/Q8hFENdjzvslZVZVg+punIhFW89GMuj1YaE=;
        b=esNdxQ2xzsrHXVxiJv9dS9COfHOcqZ7JQIIsFqhh5xd1L1tTC49o5VuNi7vlHXx7eP
         hl1qKNG0yvvPSsrGNBjpONOU106jbH1+6po1E3rM7lP5skPBrt9xcbGMZ4bQXXXhSz/V
         s3b5c2BDEckzRXsdq0FBUDEshnLp3FhUaBgkd/6VzTbrKfFOEwIGnh7p758mDqbsaqD+
         rGZOSpqwOzyL5ObYbrbBgbSFpypTZiq9uhCCT8pQjm5tSQQzIc1NxefBQESAhENOkpqS
         IimtDUWJGuz1WIOqeOL3tj325iPcT6H/fam2NV2ymFtfqtwzoGc/ibET1V2aClnn4TUZ
         f0VA==
X-Gm-Message-State: APjAAAUgz3v2CFDgSehEiDB9cpQOOUfK13G6NXJBzjpe+VYYRRPF48pS
        W/zJIX0whsjrf1sz+xVpyrPvtb2XkmE=
X-Google-Smtp-Source: APXvYqxHUb/sevlpo0Lq49dJ4UTXo7JUBGrJ7IrOq+/n2FQtSTnwa+BSwpwBaiVstaG2wH8wl7aiUQ==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr12698324wrs.109.1552543664631;
        Wed, 13 Mar 2019 23:07:44 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a204sm724666wmf.12.2019.03.13.23.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 23:07:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
References: <cover.1552519463.git.steadmon@google.com>
        <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
        <20190314001600.GC31968@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 15:07:43 +0900
In-Reply-To: <20190314001600.GC31968@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 20:16:01 -0400")
Message-ID: <xmqqwol27zv4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This definitely seems useful. Could we drop the final "%" and make it
> either a single-character "%t" or "%(iso8601)" to match our other
> formatting strings? There's no _technical_ reason to do that, but it
> just seems like there's not much point in being unnecessarily
> inconsistent.

I do agree that %TOKEN% is not among the patterns we've used before,
and I fully anticipated that it would attract paintbrushes when the
proposal hits the public list ;-)

A big question is what we want to be consisten with, though.  From
the readability point-of-view, for-each-ref language %(token) is
easier to read and extend.  A secondary question is that there
likely are things other than the timestamp of the time process
started that may want to be interpolated, so we may want to pick
some useful vocabulary upfront.  If we can declare interpolation
will be done ONLY for timestamps, as Ævar suggests, taking strftime
pattern directly from the caller may be sufficiently simple to
explain and useful, but I am not sure "only for timestamps" is a
limitation we would want to adopt this early in the design process.

> Doing this automatically for directories feels kind of magical. I'd have
> expected it to be just another placeholder. And in fact, I'd think using
> the process id as a placeholder would be pretty common. Between
> timestamp and pid, that's generally unique (though I'm not opposed to
> the random placeholder if somebody really wants to be thorough).
>
> That leaves the door open for being able to append to or overwrite
> existing trace files later, if we want to make that a possibility.

Thanks.
