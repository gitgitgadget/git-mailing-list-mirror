Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2727F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfARRgg (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:36:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33297 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfARRgf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:36:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so16092135wrr.0
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hRu23PPAW7HAtA8bWmfEspCIO92t4s/N69JnAti3ldU=;
        b=q8c/7xJn4BhdnRn7JSJciW7jFConCjPttP6K5pQVDU9sGyrNmDk4sjJrJ9Y9754Xza
         A2TNpIgtGuRaZHKffDgtgREzU+R+U3MKhWAZu+H2DdQwsxt8hneATzQYK6Md+r9LzyHq
         iczcdMhuKB4bNDNfOANFniROiQSSFcPur1SGhNsLCTcGT2/Iqgb7gGP3T/9+zZz1Ia2m
         dra5KE8A5uFoyQfGzdM3CTdx9GX4gG6I4BSZ/3p5SnP3NBAFWhox3U4luq9WE52285i0
         5y5GZwnZpGwK+TI8kbYboWCfc64GOjvOC0WWiIb/u5gLLue2ePzlH0H1eB7ayXnHGTf7
         GJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hRu23PPAW7HAtA8bWmfEspCIO92t4s/N69JnAti3ldU=;
        b=qQAKVXVmAejZstWT2AqQyMezFC746MpsP1MKS7nTiYsJoA1MjNQk1EyFYVrB+Y1l1R
         4e4Y8bh3eP9fHnANSVAUxZVF5VjgsIDWPfYjEE3pWdQsHH7aLhKisi26rHPrDcmSFl1M
         QJaVs+6tHViOyTxiL1Gaw7g5V94J/knsn5oSgNaKpXz93F1FUMmPNlCQ3G7Bb6/bjQwX
         ZQHptZGChgEHVmgBo6GVScXOyp6QgYYvpAb0Bxcx/HMv/Q6sBMf/oXwM8RD4dWWfkx48
         j7FVGESjQKZgF7mF1n1sHw2WKh5Rtb9RX4ARmWeTFixU1r2NjVk9iJ4vHC5Jac9944LO
         CTvg==
X-Gm-Message-State: AJcUukdThY/a/eQHmTOXMh14KVrvOS0ehqfrngWOVptnq2KVhoPzXg60
        eW6qYqdooCN9pyYs10F/Y9E=
X-Google-Smtp-Source: ALg8bN6lW3+5Cz4fbrP0vNW6VurrLISkhjJKMb+OxWLSFzBh0sJiSIyMGwmfp0bdFiiZcTCqEYW2JQ==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr18279761wrf.164.1547832993417;
        Fri, 18 Jan 2019 09:36:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 125sm74291117wmm.26.2019.01.18.09.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:36:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-2-brho@google.com>
        <87k1j247ui.fsf@evledraar.gmail.com>
Date:   Fri, 18 Jan 2019 09:36:32 -0800
In-Reply-To: <87k1j247ui.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 18 Jan 2019 10:45:41 +0100")
Message-ID: <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Jan 17 2019, Barret Rhoden wrote:
>
>> -		die("Could not open skip list: %s", path);
>> [...]
>> +		die("Could not open skip list: %s", path);
>
> You're just moving this around, but now that this has two uses let's say
> "Could not open SHA-1 list; %s" or something like that.
>
>> +			die("Invalid SHA-1: %s", sb.buf);
>
> Unlike Johannes I think it's fine to leave this. This file-format is
> SHA-1 only now. We can cross the bridge of making it (and others)
> SHA-256 somehow when we come to that, whether that'll be allowing
> variable width or a different file.

I tend to agree.  The Documentation/glossary-contents.txt makes it
clear that "object name" is the most formal term to use here, with
synonyms like "object identifier" and much less formal "hash".  For
now, "SHA-1" is good enough, even though "object name" is acceptable
if we really want to future-proof.  But I would suspect that people
would colloquially keep saying Shaah-one even when we start using
different hash function(s), so such a future-proofing may not be
worth it ;-)

