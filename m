Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E0020248
	for <e@80x24.org>; Wed,  3 Apr 2019 06:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCGrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 02:47:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfDCGrv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 02:47:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so19687739wrn.11
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 23:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gOoNOWiB/r+D3XHxeImpaoBeV04B58CESUeByF63kR4=;
        b=ZlWZfzxQvlW8ueSAwTg+rO8GCTxI/lARSbEWSvqCZEHomK5cRlQiL/2EXw3T5qVKWK
         McaEuBIQGL3A4wdHz8MxJMPysBovKerh57Lgq9u4Z4a2DWDiFM68PO69M9kfrkiLjPFT
         2lNqLYmAoYmrXTFfje/PnmYZMWbc96Oa66VtSAiXqmkKLTjx3mPVha81t55oeyJDtKz8
         HlDIsvpBNVmYmoFk7yp17lFSLr7gx8nx5MUdEP67qMIh4x1OIt4gSyivwIpZfX40XEN3
         e33Ek5Ay0t7ud6FkHwQDsagN6ehlRbTSFUDr14dzYzMmGU3q5BTZsfRJdVnR2QMhUcBd
         whMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gOoNOWiB/r+D3XHxeImpaoBeV04B58CESUeByF63kR4=;
        b=ZQi2ON5mz70WHprydjpKikIU0Y3wTD4GeCItzRzPEjkEP6qlqHAnJgW+YBhftTJHaR
         OA/DPpbO3BlmwZ7fFLbBtr69NkmBGT2Tk8kmTA1A1w8lFdgwiM94I1cz91xdzWI5t8BW
         2/IPpyyBsfJmLlDMqo6dDhUJKlPkBUJOV8Pi0mgXXXlo+Pj3EMyzwnMBy7q1I5wXKX4s
         D/FtvSxILyqkfmWlIwYssc6DXWcoGlXaoO14ibRcsI1mQIKvKjlN6Oywvjm04U7yqABb
         y6hb6S0Hm3VIvVQoZUXUMlUhjkiFrifOB/yy+2B6jKDZY+i3Wb9d0W0kyWF0yw3nJ+dY
         G3xQ==
X-Gm-Message-State: APjAAAVON3orzdPnEQJfCD68NiDX4fupQdTjBifT9lixznSPfYIpCq7e
        bipO65KrJwApuaBGf4oBv7w=
X-Google-Smtp-Source: APXvYqzah9R4JlamuwX+/H+PWe8nnKn52WdA/W8k53pM6MBxpLn1V9KClO9/2pgjTrzLBv8nczI5ww==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr31531916wro.152.1554274069306;
        Tue, 02 Apr 2019 23:47:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z8sm13562893wrh.80.2019.04.02.23.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 23:47:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] mailinfo: support Unicode scissors
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
        <20190401215334.18678-1-rybak.a.v@gmail.com>
        <20190401215334.18678-2-rybak.a.v@gmail.com>
        <20190402143615.GC10564@sigill.intra.peff.net>
Date:   Wed, 03 Apr 2019 15:47:47 +0900
In-Reply-To: <20190402143615.GC10564@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 2 Apr 2019 10:36:15 -0400")
Message-ID: <xmqq8swrtwj0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In fact, I think you could then combine this with the previous
> conditional and get:
>
>   if (skip_prefix(c, ">8", &end) ||
>       skip_prefix(c, "8<", &end) ||
>       skip_prefix(c, ">%", &end) ||
>       skip_prefix(c, "%<", &end) ||
>       /* U-2702 in UTF-8 */
>       skip_prefix(c, "\xE2\x9C\x82", &end)) {
>           in_perforation = 1;
> 	  perforation += end - c;
> 	  scissors += end - c;
> 	  c = end - 1; /* minus one to account for loop increment */
>   }
>
> (Though I'm still on the fence regarding the whole idea, so do not take
> this as an endorsement ;) ).

I do not think we want to add more, but use of skip_prefix does
sound sensible.  I was very tempted to suggest

	static const char *scissors[] = {
		">8", "8<", ">%", "%<",
                NULL,
	};
        const char **s;

	for (s = scissors; *s; s++)
		if (skip_prefix, c, *s, &end) {
			in_perforation = 1;
			...
			break;
		}
	}
        if (!s)
		... we are not looking at any of the scissors[] ...

but that would encourage adding more random entries to the array,
which we would want to avoid in order to help reduce the cognirive
load of end-users.

In hindsight, addition of an undocumented '%' was already a mistake.
I wonder how widely it is in use (yes, I am tempted to deprecate and
remove these two to match the code to the docs).
