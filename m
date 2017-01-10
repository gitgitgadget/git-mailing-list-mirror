Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E7220756
	for <e@80x24.org>; Tue, 10 Jan 2017 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbdAJWLQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 17:11:16 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32914 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbdAJWLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 17:11:15 -0500
Received: by mail-lf0-f68.google.com with SMTP id k62so13181308lfg.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1LXQYK5KLv2ELremF0Z4wcP5REjJJZ2mMA+uIK6bnDY=;
        b=e1K9uCW6LYUgTvbKhg/h50evAXVYPuaPpu9DZN9oE9jhSIlV8tCWTi4/gEHgqx/7Ed
         /ID6UItUZzvNbRBUPFeyAfhqrIdNyAJEF/rtg9z4Uld8mXFkmxVz2uoMkvqm4Cglkz2t
         CvxmiNw5NWC3wk0cJGvjwTLQpzzIoKP0Q4djYXuzfkPHzli7j4Z4zCiN2KRaJ14+YdeH
         ZT2LRDTfhf09zhwEOnvUokqC4s6Ft1vP/eRjy41hAN6tg2EWTnv6ygxvFR17X3rsBUzy
         zWP+9tOlBxnKKtDi6abrpMuaiWa80n2Z6JpdC+VU/LvEo/vKyE7LAWM1wlpAEbYaSxJA
         Dt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1LXQYK5KLv2ELremF0Z4wcP5REjJJZ2mMA+uIK6bnDY=;
        b=q0wCIMVNOICMq3ziJ2L22ueuarW7sypNCGTMeGkjOWR4MbrtBc11gwH1vrQh0Bqgta
         NHMBemlsY3wMraJC/YJmP5K4gssX1K965UFeODTy0ZLg5SeZpHspeoYT69WsJlNUSj2F
         PiARB8X1cmS5vE6uZCeb91cgOo8jOzlwzgQtkhPhwDlS9egF+T9XcaPVXJs55+SEcqwY
         y5q2lZIuHv22IKzZXE4peRojwosm7ZOa9Y/PqUVfZcRQVGNgN0nhmdK/byK2p2W/wiFq
         lD7QvyJnfFh2tsUcF315lCtY4y68WIiDP4aoy/TjVtMTWgtpBSetlpHLTQnofWrEAv6m
         /8uw==
X-Gm-Message-State: AIkVDXIkqmKJmssG26kPDveDrSZaS/ZNWHO4KRLkiMPLSGmHkgZOYuPOMLt0YJfKLi9QKA==
X-Received: by 10.25.158.143 with SMTP id h137mr1674615lfe.142.1484086273370;
        Tue, 10 Jan 2017 14:11:13 -0800 (PST)
Received: from [192.168.1.26] (elk217.neoplus.adsl.tpnet.pl. [83.21.204.217])
        by smtp.googlemail.com with ESMTPSA id l72sm777336lfe.32.2017.01.10.14.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 14:11:12 -0800 (PST)
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process
 protocol
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com>
 <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Jakub Narebski <jnareb@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
Date:   Tue, 10 Jan 2017 23:11:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 09.01.2017 o 00:42, Junio C Hamano pisze:
> larsxschneider@gmail.com writes:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Some `clean` / `smudge` filters might require a significant amount of
>> time to process a single blob. During this process the Git checkout
>> operation is blocked and Git needs to wait until the filter is done to
>> continue with the checkout.

Lars, what is expected use case for this feature; that is when do you
think this problem may happen?  Is it something that happened IRL?

>>
>> Teach the filter process protocol (introduced in edcc858) to accept the
>> status "delayed" as response to a filter request. Upon this response Git
>> continues with the checkout operation and asks the filter to process the
>> blob again after all other blobs have been processed.
> 
> Hmm, I would have expected that the basic flow would become
> 
> 	for each paths to be processed:
> 		convert-to-worktree to buf
> 		if not delayed:
> 			do the caller's thing to use buf
> 		else:
> 			remember path
> 
> 	for each delayed paths:
> 		ensure filter process finished processing for path
> 		fetch the thing to buf from the process
> 		do the caller's thing to use buf

I would expect here to have a kind of event loop, namely

        while there are delayed paths:
                get path that is ready from filter
                fetch the thing to buf (supporting "delayed")
                if path done
                        do the caller's thing to use buf 
                        (e.g. finish checkout path, eof convert, etc.)

We can either trust filter process to tell us when it finished sending
delayed paths, or keep list of paths that are being delayed in Git.

> 
> and that would make quite a lot of sense.  However, what is actually
> implemented is a bit disappointing from that point of view.  While
> its first part is the same as above, the latter part instead does:
> 
> 	for each delayed paths:
> 		checkout the path
> 
> Presumably, checkout_entry() does the "ensure that the process is
> done converting" (otherwise the result is simply buggy), but what
> disappoints me is that this does not allow callers that call
> "convert-to-working-tree", whose interface is obtain the bytestream 
> in-core in the working tree representation, given an object in the
> object-db representation in an in-core buffer, to _use_ the result
> of the conversion.  The caller does not have a chance to even see
> the result as it is written straight to the filesystem, once it
> calls checkout_delayed_entries().
> 

