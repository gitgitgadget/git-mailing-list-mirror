Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447B420D11
	for <e@80x24.org>; Fri,  2 Jun 2017 03:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdFBDp6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 23:45:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35915 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFBDp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 23:45:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so10750256pfb.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 20:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A/LIDDn0nERxF/vNI4Oj9nzeUd/im0KS/tjyNOdk3yk=;
        b=HB4NAfZ8HtWX7gv4Z2rGDX6LSBzmjiePqk5WFyC8iHAxUnY8bjcWv731jfbLM5YbXC
         JhT7K16B8Ne8JJ2HSbfgYyaZrkN/uPQVzOLapqZy7K63gm0GA431eCxgmIGJ1RA3Y5ui
         6d1xG29r89U/ps64cJkf394t5bFeGiw3B4tY/H0C9WsieYjZESAJx6/YW5rFTY/JBdDP
         axAZbYp/2/LTYg9b04lelI+Nu2RYbTiz6tj8K3Vwd8iif4IdZkkMsf/Z6sY8OmUXS9Be
         nSMKP9394s1YGaPFz3817/KsaXecSvmiUEX/Xu1wF959MLfWjKgNPxVYMEOitkQA9oJ3
         uMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A/LIDDn0nERxF/vNI4Oj9nzeUd/im0KS/tjyNOdk3yk=;
        b=h758gz1wW8K+66nvSaZ7uYsr9yKmgzFrLhlQLqWmhNkaEHiSy8mtRLw3791B7x1hv0
         ZmK4Gp7kwnTGSTH3Zwyh8a6EdiNEEpMu3DmnJ3paJGtlxoGWNQHnlZkH1MlZ+jJ5z2JH
         4gtDCevo0+KJZ1QIgdzQGIrW/bzWm/D7pA4iCOy1ATkMzKjclBlBQOEJaAgGKlunlYc5
         aK1or8dUsc9Z97zdVX1DCVHnHAuf/OixjzoHj7IcNw3d0WzEQ1FSKThSk80GhFTpuxcj
         6tWKUJPItuteoieP0FW7b8yFbzErDiRiMPnFMv6eHQv9+67kEqSHU8GQ4uM5UWwW3CzX
         0aSQ==
X-Gm-Message-State: AODbwcCOecOc5yWlrmSk2GVl78GmrNqQo0rjg08lzVA2/7d8mp4JQC2b
        w3LWV+xB9HdKMHU/o2+mEg==
X-Received: by 10.84.210.106 with SMTP id z97mr97605977plh.6.1496375156311;
        Thu, 01 Jun 2017 20:45:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id h123sm33261198pgc.36.2017.06.01.20.45.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 20:45:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [WIP 1/2] pack-objects: rename want_.* to ignore_.*
References: <cover.1496361873.git.jonathantanmy@google.com>
        <cover.1496361873.git.jonathantanmy@google.com>
        <5e8aebf2726481ef63838291c32e07439289d922.1496361873.git.jonathantanmy@google.com>
Date:   Fri, 02 Jun 2017 12:45:54 +0900
In-Reply-To: <5e8aebf2726481ef63838291c32e07439289d922.1496361873.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 1 Jun 2017 17:14:54 -0700")
Message-ID: <xmqqwp8vyrv1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, pack-objects conflates the concepts of "ignoring an object"
> and "including it in to_pack".

Hmph, that statement is a hard to read and agree to.  I thought an
ignored object that is not going to be packed is one that won't hit
to_pack?  

I agree that "including to to_pack" and "actually appearing in the
resulting pack" are three different things, though.  Preferred base
objects that are used when constructing a thin pack are thrown into
to_pack because they need to participate in the delta base selection
computation, but by definition they shouldn't be contained in the
resulting pack (hence, nr_result is not incremented for them).

> This is fine for now, but a subsequent
> commit will introduce the concept of an object that cannot be completely
> ignored, but should not be included in to_pack either. To separate these
> concepts, restrict want_found_object() and want_object_in_pack() to only
> indicate if the object is to be ignored. This is done by renaming these
> methods and swapping the meanings of the return values 0 and 1.

I am a bit confused by your reasoning.  I guess it will become
clearer if I knew exactly what you mean by "ignoring".  It is not
like "pretend as if it didn't exist in the rev-list --objects output
we are working off of".

> We also take the opportunity to use the terminology "preferred_base"
> instead of "excluded" in these methods. It is true that preferred bases
> are not included in the final packfile generation, but at this point in
> the code, there is no exclusion taking place - on the contrary, if
> something is "excluded", it is in fact guaranteed to be in to_pack.

This one I can understand.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/pack-objects.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

Without understanding why this change is desirable, I can tell that
overall this does not change the behaviour, which is good ;-).

