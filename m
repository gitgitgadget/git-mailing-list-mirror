Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FD91F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbcHFUTV (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:19:21 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35877 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcHFUTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2016 16:19:20 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so67802575wma.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:19:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WSw7eRU0JtilIdBwMeHRltLEeIIEuE83k1XbeUgM2so=;
        b=YZ0INTkQFzBJgW9qQv718zGJEdIghQ9Pvq7oUbjJZTunPCkGZIYfx6ZpiskOaxMl7u
         U2IQZ/0G/FnAt3Fr5GjpKdipl5uj+x0g0+Z+iUL65U8l6TYqcpCEBNfnxfzEQGOfgxKc
         SDtIW0lbyXcNQeZM/LMa3qkN9w9I+JQaYjRK3eb3JpEp+3EU3jgYuKyfgZ1rz1nd6zn5
         7nS+z9paNyiSJNIIMv6mEXj6NMuRRu9OcctCpjBJcpllIsQqmv0sjSDZVwB8AGJXcXYn
         GFvg/Mop2K1q3KNIeEaPK93cuLpfbhdFmkAQVH8btHrRoZcEDVLF3LCrsXWuK3kHXYKy
         vEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WSw7eRU0JtilIdBwMeHRltLEeIIEuE83k1XbeUgM2so=;
        b=mKOsSBBeKKacSV6pIf9HqGUcr3jZK8xYbr2W59e14Vo57I+CMVmZSu/n3H8MCU9+eK
         t5HV/s9YQvrz3B5k9KQJ3F/JrQxN4fKutK/jHWKfd7jJv0CsqBW7Kk4AZJ00xctcAYN7
         APwXAAincfPJvaKyslb0IcaQ0exhTMG87XdFgs9GH0M8Hk8gmDzrpVYSAerBx8A7mJ29
         +YxBz9qEUUegBXbOwgwX0x9ry0u8IJlnqnX+T93Xhkg8qoSW4U6ZKXwEqaN6OxUP+MLX
         5/PQGM86xrhB8pnMYiCqxsgib3wnYJwU+5H09Pi8GXZcRL1B7K1b/Zd4GOmSEW8GqD+5
         chZw==
X-Gm-Message-State: AEkoouulpk0S6DoKlQCnQjYL6z9pkYELtJZu2Ef/4IfdhYxNlbnaxkI6T6zQy8XbxikGFw==
X-Received: by 10.194.240.4 with SMTP id vw4mr10768153wjc.134.1470507893238;
        Sat, 06 Aug 2016 11:24:53 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5C12.dip0.t-ipconnect.de. [93.219.92.18])
        by smtp.gmail.com with ESMTPSA id uo4sm24012454wjc.36.2016.08.06.11.24.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Aug 2016 11:24:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Designing the filter process protocol (was: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <607c07fe-5b6f-fd67-13e1-705020c267ee@gmail.com>
Date:	Sat, 6 Aug 2016 20:24:51 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <90A43E20-B2F5-4377-8DC3-2298BDD7CC71@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-11-larsxschneider@gmail.com> <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com> <ABE7D2DB-C45F-4F29-8CC2-8D873FD6C36A@gmail.com> <607c07fe-5b6f-fd67-13e1-705020c267ee@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 20:30, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> ...
> 
> 
> 2. HANDSHAKE (INITIALIZATION)
> 
> Next, there is deciding on and designing the handshake between Git (between
> Git command) and the filter driver process.  With the `filter.<driver>.process`
> solution the driver needs to tell which operations among (for now) "clean"
> and "smudge" it does support.  Plus it provides a way to extend protocol,
> adding new features, like support for streaming, cleaning from file or
> smudging to file, providing size upfront, perhaps even progress report.
> 
> Current handshake consist of filter driver printing a signature, version
> number and capabilities, in that order.  Git checks that it is well formed
> and matches expectations, and notes which of "clean" and "smudge" operations
> are supported by the filter.
> 
> There is no interaction from the Git side in the handshake, for example to
> set options and expectations common to all files being filtered.  Take
> one possible extension of protocol: supporting streaming.  The filter
> driver needs to know whether it needs to read all the input, or whether
> it can start printing output while input is incoming (e.g. to reduce
> memory consumption)... though we may simply decide it to be next version
> of the protocol.

I would like to change the startup sequence to this:

Git starts the filter when it encounters the first file
that needs to be cleaned or smudged. After the filter started
Git sends a welcome message, a list of supported protocol
version numbers, and a flush packet. Git expects to read the
welcome message and one protocol version number from the
previously sent list. Afterwards Git sends a list of supported
capabilities and a flush packet. Git expects to read a list of
desired capabilities, which must be a subset of the supported
capabilities list, and a flush packet as response:
------------------------
packet:          git> git-filter-client
packet:          git> version=2
packet:          git> version=42
packet:          git> 0000
packet:          git< git-filter-server
packet:          git< version=2
packet:          git> clean=true
packet:          git> smudge=true
packet:          git> not-yet-invented=true
packet:          git> 0000
packet:          git< clean=true
packet:          git< smudge=true
packet:          git< 0000
------------------------

This would allow us to detect the case if a user configures an
existing clean/smudge filter as `filter.<driver>.process`.
Since Git is talking first, it would not "hang" in that case.

Would that be ok with you?

Thanks,
Lars

