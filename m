Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B641F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405396AbfBNFtQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:49:16 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44076 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733014AbfBNFtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:49:16 -0500
Received: by mail-wr1-f41.google.com with SMTP id v16so5010045wrn.11
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 21:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J9Tb05BcjYjaBBVZ5zEEPgF8t470qddJBNgdN0pXWIw=;
        b=avUv02iQRh9WVUa7Th3fgOf9gpSNV2VZH64MjDOlpvPlWUtxn05g9hwvMuve/hhArr
         dyxN3MWoR316b/PHbOAkyo/bomrjKK8IwlVV40bJHd40izkJpgp5z0ElrkXF7q7QJFSR
         iIE7f2L2nn1gM9Q2wBwzEeQdTBEu/FvOy8Cf/lUurcIS5d4LEfdNRXwG8nN9oKpQ7rCm
         TeyHvjYGifvKjpiEPECZvOOAhjhuRR86LQRY7wiZeYbZdzpQV9s5iAi3whc/CxaJXwxN
         rl3WWLpqhQL9upcVQJhAkLO2CVFLF53+QmOy14aeJBuzQYMWo69w94ObhGlA6LZQ2Hbh
         sdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J9Tb05BcjYjaBBVZ5zEEPgF8t470qddJBNgdN0pXWIw=;
        b=FUV3mS6bm2ACb6U+BuLcpTCz57pBW7MRCe0bJoxVnIpsWj0HCCCMrYw4QZY2CM9ptC
         A0Jd8IV/pMnBfGjvAWOdhrsvz/d4SHcNPj5drarcAUb1b83+jI6qQoLkrrvtsDxuZHhK
         IdS29/mhR8ACw/sQWiGhfyHvcVg8KgI6DGJj9iKAunbUmUn7vwKr1tFuXz4RGv0tGWNn
         Y26jaCn1ZBRsiX72YyTw7QeGiB+328Iewclq0eR0DkKpbrkWgXxkyFTSFK+qGUFusXEA
         Q2MBXF8QUetJfsKVmR/2e2ZxtqM6krMLcWfIbBJT91jqWllrFQXZBk7CPYs6kDbxmUuU
         rs6A==
X-Gm-Message-State: AHQUAub95ml6jzhyW512zXgtLcoOhliuFr/EPdeWHV8Gfe54Vc4GB2r4
        GlUD747R4fPogD3mHi7hkTY=
X-Google-Smtp-Source: AHgI3IaHzN3qYU5yUEgqYjPtToFfe0G+Oa9nZlazW9RRWSURjoATd4ExDvC6kDqAeGa2JfexskOaqQ==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr1216634wrx.85.1550123354565;
        Wed, 13 Feb 2019 21:49:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b18sm776668wro.80.2019.02.13.21.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 21:49:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
        <20190214035944.GB7209@sigill.intra.peff.net>
Date:   Wed, 13 Feb 2019 21:49:13 -0800
In-Reply-To: <20190214035944.GB7209@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Feb 2019 22:59:44 -0500")
Message-ID: <xmqqzhqy9axy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 13, 2019 at 07:33:22PM -0800, Junio C Hamano wrote:
>
>> [Graduated to "master"]
>> [...]
>> * js/smart-http-detect-remote-error (2019-02-06) 3 commits
>>   (merged to 'next' on 2019-02-06 at ec1a6f67c1)
>>  + t5551: test server-side ERR packet
>>  + remote-curl: tighten "version 2" check for smart-http
>>  + remote-curl: refactor smart-http discovery
>> 
>>  Some errors from the other side coming over smart HTTP transport
>>  were not noticed, which has been corrected.
>
> Hmm, this was maybe a risky one to merge as part of -rc1. It is just
> enforcing the rules from the spec document, but it's possible that it
> may trigger on some poorly-behaved server.
>
> I'm not worried enough to suggest pulling it back, but it's something we
> should keep an eye on during the -rc period.

True.  I actually think that it is probably a good idea to unleash
this kind of thing as quickly as possible to the real world.  Those
outside the project, or even inside it, tend to only discover issues
after a feature release is made, so while I am generally in favor of
merging a new and potentially disruptive change in an early batch
after a feature release to 'master' (which would give us enough time
to fix things up until the next release), I do not think that
approach would help third-party interop issues very much.

.
