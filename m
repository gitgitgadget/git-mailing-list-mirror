Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FCB1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeKQGN2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 01:13:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36660 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 01:13:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so3868435pgm.3
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEEUE0rsIBozJkFCqGfHFpkYJf6W8ObSVaJ7JBSZ2jE=;
        b=U6zcUScCpF1P7VQIdQRwoM1VX1EEzNA9TjQhue8u8OhZhO3NDl0xrMqbQKGolb4zCI
         5HyB9N1WWi7yWKAnDU5NLwVaAwWOYO8D5k9a6itH8I1MW/Avd4SvcUc62yOuA7CzEy9s
         DPVeGYcnCrQI05ehS1WYzWLPuCLGOTg2Yu4qXMhcUZb3MIqX77BmeBGHl/oD62OqYxuY
         AbZmcU+o54+mmFhZi0ue/lxl8fsEcwuip8RGD5fXaVvsiMXTS4WV/Lp9SEymKQlYtyQm
         FWUKvM8CuSdyEbUlh9FGgyr/K4rYHYOvLtbtN0te0ZbFkthEVEIkiMjb1F6hf7WiSvGJ
         f3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JEEUE0rsIBozJkFCqGfHFpkYJf6W8ObSVaJ7JBSZ2jE=;
        b=kSF4U012ccldfYIPt5T2HZNfjJ9E7W0PmrBtQ28o+sdW6w0+EOFAVKVOvntMvNSuy5
         cES2pLI/rwPU85gb0WKHnaSlZm0RuQIk62cH54Etq5abUCnsP+KygbT0zf8A77vOwYVg
         gW2+DncvMJsuZbAdrYTJ1qkpXPwQuFBoh3V7BDj8934jt0JqlH2BHrA/RycuFPUSoAPY
         oCLWJGaSxrdlW8N2Uw11FSrEXpG14kc38DqH9CPT1BOfKZdRRTaJMwrtyCLzwUvKPBlo
         iyK+3GQfkF26pIUI/By8TN0zVxCkrTG0YBvTqYYxeJObA0H8nzuUyt0EbNIiFohkaIfj
         3qIA==
X-Gm-Message-State: AGRZ1gJ8Zfy2HxTKskSIobLl+SwZ0Dgg/d8QcnkCR0rar529M9O1fLNT
        bNLETOXHX34k8CjiAxH13R1Bhg==
X-Google-Smtp-Source: AJdET5etSHaCrygR2mneB86abN1UJQe+E/dKtuhiYFCCyl6oT7PJ6tBMiUkEBrTlOizJ7rnWpL4Oag==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr11389600pgg.429.1542398380672;
        Fri, 16 Nov 2018 11:59:40 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id i193sm40769641pgc.22.2018.11.16.11.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 11:59:38 -0800 (PST)
Date:   Fri, 16 Nov 2018 11:59:32 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181116195932.GA9703@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
 <20181113225320.GG126896@google.com>
 <xmqq1s7os7rz.fsf@gitster-ct.c.googlers.com>
 <20181114195757.GJ126896@google.com>
 <xmqq4lchn3jy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lchn3jy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.16 11:45, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >> What I was alludding to was a lot simpler, though.  An advert string
> >> "version=0:version=1" from a client that prefers version 0 won't be
> >> !strcmp("version=0", advert) but seeing many strcmp() in the patch
> >> made me wonder.
> >
> > Ah I see. The strcmp()s against "version=0" are special cases for where
> > it looks like the client does not understand any sort of version
> > negotiation. If we see multiple versions listed in the advert, then the
> > rest of the selection logic should do the right thing.
> 
> OK, let me try to see if I understand correctly by rephrasing.
> 
> If the client does not say anything about which version it prefers
> (because it only knows about version 0 without even realizing that
> there is a version negotiation exchange), we substitute the lack of
> proposed versions with string "version=0", and the strcmp()s I saw
> and was puzzled by are all about special casing such a client.  But
> we would end up behaving the same way (at least when judged only by
> externally visible effects) to a client that is aware of version
> negotiation and tells us it prefers version 0 (and nothing else)
> with the selection logic anyway.
> 
> Did I get it right?  If so, yeah, I think it makes sense to avoid
> two codepaths that ends up doing the same thing by removing the
> special case.

Yes, that is correct. The next version will remove the special cases
here.

> > However, I think that it might work to remove the special cases. In the
> > event that the client is so old that it doesn't understand any form of
> > version negotiation, it should just ignore the version fields /
> > environment vars. If you think it's cleaner to remove the special cases,
> > let me know.
