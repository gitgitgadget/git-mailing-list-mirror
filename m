Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5AC1F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEOIFs (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:05:48 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33999 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeEOIFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:05:40 -0400
Received: by mail-wm0-f45.google.com with SMTP id a137-v6so14795058wme.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FJ7QrGpci8VM2tUr3qPikv+9bl2RUcTv0scx+sZSMhs=;
        b=EpnPz7PSiUt9Lra+4BjKmSaOemDdB9hj2a20zqLWnelnMD12DtH8RuKrSAPHjV8Wcd
         M+sg10OwILnQLUBdpEDVTF4VvA2pSowyfHkfZfqtBURMn4scQWfZlMlHi+8+N89zwIIT
         Vm2d8S/e4m3MiRwqpBiEayKalGKptDZ9eCO/VXQGuqLjMjUqt3DxDi5mbeh4S1FIrhu3
         2ooQbe9b7LqkhDli8I48U6HGVpAUXrSEvQ6pDml1b6IFBTM3TuxmZNEkXF/ZyQAb9EvH
         vbi8cpaeyI99o2ot8fUj+H0iQEfIeCbRYSYaOIHD93NE/C6apvy9ZXsLs5fpKKh1jTZO
         7c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FJ7QrGpci8VM2tUr3qPikv+9bl2RUcTv0scx+sZSMhs=;
        b=XvpBBPKZmtYWzzJwu7vg9fqVoqz1ijoSqcrTIIZjr280yiqJxsAJQVqMKWEnp5vY+1
         3J8UYGacXX98lAsfzQu27vVLc+vkli+ax/LD9S1DC2qk3D9INW0cX9F4r3wUM2bUkx5H
         CbqegVk+H1jSLLNbThEcf5vprDi5mAIUNTxEqR4iGUE+yS05GsI+qZI+K0BqhvAlB0rP
         4p/JVyltisG+MUAPvYQgvAncjMnaql18aHGtMuX78CfSIyPaj5phyUxMMaSJF5GOJrLl
         QpOcHoRUpm0RwtHKEByB+AChW775LRz2ZveKSjqWWxRpos6QNr7W3NQzCo7dSXr52DZe
         qRAw==
X-Gm-Message-State: ALKqPweO3Y9BLAHF2PrSYsCqSmcl6whVbCZYIXO8g1uNQzKwnZgwXrAf
        r7F9HVF4/M7QUmct7Kf8Yz0=
X-Google-Smtp-Source: AB8JxZotuhceW30MttjaFQ6yKa96lt9A5NvM9oh6q9oSLKpCKff7uYlT5rSqyESaJ5nEyzvemitpsQ==
X-Received: by 2002:a1c:55c9:: with SMTP id j192-v6mr8108946wmb.160.1526371538999;
        Tue, 15 May 2018 01:05:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h81-v6sm11188205wmd.0.2018.05.15.01.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:05:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/35] refactoring refspecs
References: <20180514215626.164960-1-bmwill@google.com>
Date:   Tue, 15 May 2018 17:05:37 +0900
In-Reply-To: <20180514215626.164960-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 14 May 2018 14:55:51 -0700")
Message-ID: <xmqqvabp8hta.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This series refactors how refspecs are handled through out the code base
> by renaming the existing struct refspec to refspec_item and introducing
> a new 'struct refspec' which is a container of refspec_items, much like
> how a pathspec contains pathspec_items.  This simplifies many callers
> and makes handling pathspecs a bit easier.

Good.  IOW, a refspec is a set of refspec items, just like a
pathspec is a set of pathspec items.  The two level abstraction
would naturally let us work on individual items as well as the whole
thing as a single set, which is quite nice.

