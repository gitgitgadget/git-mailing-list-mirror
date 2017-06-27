Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B21620401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdF0SL6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:11:58 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36173 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdF0SL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:11:57 -0400
Received: by mail-wm0-f53.google.com with SMTP id 62so32141724wmw.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/RmybFj0YL7hEjr2mLfrfxkqwN+jT4FhPPe7taldE3U=;
        b=nhN77S5Nn0mrF3PcAMm71skwVrkabvXGh/T44NNWTtgsGzKIWYK7l1UYyK3D2Q3bKx
         iZKmLcKY6Oc5nVI7TF9jPy3RtVbTl7e5FOzBcGh7VJHOLm/aWv7lFlaFsP6PjeHU2soG
         6Dm/EjsAikW56BsZ5XCWxtc6lbG3kQmmAuB+FOsHdfqrSA3lLBNPC4WV48cNDvqhNlO8
         cm/hgMLbDOrAu6k3bt+jWB8RCOhVJeABWafUf7pFZy1RRH57EVlBIrLu4Dze73Gt5Al7
         pe5m1nJm9UZ+FPk4mVD3G/IRrFtCGx/oLhRcDi185oZpQYQgUmi0VkKFa4qbg9bPM1Qp
         vS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/RmybFj0YL7hEjr2mLfrfxkqwN+jT4FhPPe7taldE3U=;
        b=m67eFZC8I9Ujm/O8dwlK0CSxI4nAbfxo//4582/OYj6WAxU44qqndia+LAd4aEB6j6
         +waB4lmR2N0gCxH1TH7GOC3/cOht5x0WGf5sC4RMbB324kxG8IjiSFtRoswFmU77yrIf
         RWY+XxZvk3t/NW3DOG8CZVSOVlqN8iyKRhxfGNJbGYeXOZOAPFKSs1Zbh4M3xX8WToO/
         z8UvzD1Zx0/RNeVG4mlIhmvYLKGHrQ16ZF6fcXMEDbRyQJjK64rxBosPb2vGcL8IxSsX
         fwrQM1LQyVZq2Ji6lUbHd/oGqb7NfEM75sra+SEx64vK7b3b27tDxLh4xHNMzqcsCdB+
         MwNQ==
X-Gm-Message-State: AKS2vOw829FfO+bvs74i/W7VaguRRO/WUl2EfczemvsVynfqXsEyHkfF
        JY/PsCvWp0WrOvkk+Wo=
X-Received: by 10.80.163.210 with SMTP id t18mr4925488edb.158.1498587116102;
        Tue, 27 Jun 2017 11:11:56 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id x13sm1933004eda.67.2017.06.27.11.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:11:54 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPuxu-0005xF-1W; Tue, 27 Jun 2017 20:11:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 20:11:54 +0200
Message-ID: <87wp7xjo5x.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +#if (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
>>>       defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
>>>       defined(__sparc))
>>> +/*
>>> + * Should define Big Endian for a whitelist of known processors. See
>>> + * https://sourceforge.net/p/predef/wiki/Endianness/ and
>>> + * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
>>> + */
>>>  #define SHA1DC_BIGENDIAN
>>
>> These look sensible.
>
> By the way, I wonder why this didn't catch the sparc running
> Solaris.  What does Michael's system use to let the software know
> that it is targetted for a Sparc, if not __sparc?

Because in the current code is, abbreviated:

    #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
    #if /* byte order is bendian */
    #define SHA1DC_BIGENDIAN
    #endif
    #else
    #if /*some processor tests/* || defined(__sparc))
    #define SHA1DC_BIGENDIAN
    #endif

And since Solaris defines _BYTE_ORDER we never get to checking __sparc,
and in fact the "/* byte order is bendian */" test errors out.

This is fixed by my patch, where we first check gcc settings, then
glibc, then processors, and finally _BYTE_ORDER (but as discussed that
last bit could be adjusted to sun && _BYTE_ORDER, if we can find what
"sun" is.
