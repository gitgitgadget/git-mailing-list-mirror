Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7C320954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbdLGTEu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:04:50 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41546 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbdLGTEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:04:49 -0500
Received: by mail-pf0-f196.google.com with SMTP id j28so5359963pfk.8
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOV0BRAfpsbIdW6Iy1dqXOaGRetxoMSIDL7ALj0VT9c=;
        b=cYRNw3fXG23xTgPFvk061VoUFNy4knYMI1Zz1uR5e5yRWTApUfxq2WNwxs6LU3+FwA
         rDmH6iLTDDj1V5BmA3eP91uRDlbyRsmnxHyMQRv7YbrzQOMxd4ScUrsHUGQDDIUKLczH
         ic7nvst+NCBP9VfUFM3Ldw/7xM5atIQy0yQDWehgBe90j5DTSAUqAC408yGaqPAvUSf3
         DD9o2WfWiqKvrhP5q0shbz7IyF2uDaa1q/+rdERiQEEpfyGr805kiK6p9+442o/zsHCg
         cN9BEpXQAvBkuecF+maaB0GoFFZeO9NPRQWTV9SXeY3+zjtlGBetV6Zph0CGM8ba43S7
         g3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOV0BRAfpsbIdW6Iy1dqXOaGRetxoMSIDL7ALj0VT9c=;
        b=anBuEPgzI9Hj9TxWGX3lE9rOlH8gcfs/9KkgTAP3WxB7rtwwkyvQ0bnOx2CReiu/7N
         cTUT7crTV6T4ffacpbvYkPe5vEl+A+8CMU0/antOXhiv32n9pSnp8a50splvuPuyIAud
         7Mi3Io5kGdf2otV2JFVJS7dAuDxROA3QEBcLjStn885DpatrckzwyqyBauf0bysrGUSn
         tEzd3HNMgNrv5BbCg/t1MB9MwEvfAoiz+T+zHCSFBNLPbppHdEenp+b7NRwdFSLox3qC
         T6pvo9yybMkhN1DkCfrMJdKopgeaHtCEaNBTMa5PTygFtGBb1DRLqgwimCU2KTWATtmT
         X3cw==
X-Gm-Message-State: AJaThX66PVBXT85SABzD4PixnZfhWC9Hmmdk2xoI3A456EOMUOsTIsT9
        4iFJ0SON0y4Cn+8ocqrOw0d8KQ==
X-Google-Smtp-Source: AGs4zMaYRypmUvnT9hxEx/0oMBSXhQ/VKvkP0dTQ1GGSZqlM1YmaMc3Z3GHoQ7on8KbNTZHMk3UbOg==
X-Received: by 10.84.196.164 with SMTP id l33mr24131862pld.19.1512673488932;
        Thu, 07 Dec 2017 11:04:48 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id d2sm10607560pfe.164.2017.12.07.11.04.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 11:04:47 -0800 (PST)
Date:   Thu, 7 Dec 2017 11:04:46 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 08/15] connect: discover protocol version outside of
 get_remote_heads
Message-ID: <20171207190446.GB152943@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-9-bmwill@google.com>
 <xmqq7etye5il.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7etye5il.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > @@ -193,7 +195,17 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
> >  		if (!conn)
> >  			return args.diag_url ? 0 : 1;
> >  	}
> > -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> > +
> > +	packet_reader_init(&reader, fd[0], NULL, 0);
> > +
> > +	switch (discover_version(&reader)) {
> > +	case protocol_v1:
> > +	case protocol_v0:
> > +		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> > +		break;
> > +	case protocol_unknown_version:
> > +		BUG("unknown protocol version");
> > +	}
> 
> We see quite a few hunks just like this one appear in this patch.
> The repetition is a bit disturbing.  I wonder if we want a wrapper
> around the "reader-init && discover-version && return an error if
> the protocol version is not known" dance.  That would allow us to
> write this part of the code like so:
> 
> 	struct packet_reader reader;
> 
> 	if (connection_preamble(&reader, fd[0]))
> 		die("unknown protocol version");
> 	get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> 
> or something like that.
> 
> By the way, is that really a BUG()?  Getting a connection and the
> other end declaring a protocol version you do not yet understand is
> not a bug in your program---it is a normal runtime error, no?

While we could wrap the preamble into a function it sort of defeats the
purpose since you want to be able to call different functions based on
the protocol version you're speaking.  That way you can have hard
separations between the code paths which operate on v0/v1 and v2.

As for that case being a BUG, yes it should be a BUG.  the
discover_version function won't ever return a protocol_unknown_version
value.  Its only there to make sure the switch cases are exhaustive and
cover all the enum values.  That does bring up a good point though.
This error should be handled as a run-time error and not a BUG in
discover_version, which I'll fix.


-- 
Brandon Williams
