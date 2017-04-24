Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13CAE207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 06:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165404AbdDXGYD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 02:24:03 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33623 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760288AbdDXGYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 02:24:01 -0400
Received: by mail-io0-f195.google.com with SMTP id k87so45691613ioi.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=dXQixrcuYYq3uOoyFLNq1KdYihE6F9X8e5Z3mYdsQSc=;
        b=FJXvPXrqYYLMuFG/DDi4ZoWn0j9hsUru/P6ZJx1TYN74IPF7oCjzO+3Qo2hoFUIP1z
         bZDB/SrrDjPqyW4HvOZQyWJ0PxkqWfPqxBQDpKMShJ+ldeHE2D0AvcVcD4RH5cCRKMI3
         izgkkjSm5Ayr5p64TF4rNJlaPnvBw5+u0ryyMTp/04jBv3PpA3O0Tz4wcqHtP6u+KTlE
         u7kdqbbfScwaPxQrOPXSjuoUURRjV2rdFjJ/qqtOqiuiF7AvRwSD/IIiG9r3n/6QdMTe
         JTxk3xb64SqgPVkWXXFCnv6Lrn6k3+mRFPaQOdAnYs/2dUvz6fKHZJObp+QQgaQ5chIb
         FYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=dXQixrcuYYq3uOoyFLNq1KdYihE6F9X8e5Z3mYdsQSc=;
        b=TFdTo4W8260GGqUQgGvvkcf9tJkp9G1VdhaJ4UmwR90J00/pSTS1wtLLTTRE48LvOw
         lm5R6QQUCELn96VbwC2Dk5+W7kKt3AMLh37Lz4iPRAdKILIcF28RFfc1lRHmBPefIHUM
         g9GVtkjH3YFzHgUelqhAVeCcF2BJAFY7W9l6qrMl8v0C0tNFCOulRw5G2ldE6erV6Pe/
         sOtQxYHO4TZFiPVT9T0uI0D9kaHZ4+LaV+FZMLHIS4KogjM9oRBrrCCzUEPuujZm1F7t
         XiHWGXtEo2dsFsCbH8PdCGFI2CLif65BOwzPqkJ8HzIzgF649NeR+pkFXfiR6xAsC+g+
         P1lg==
X-Gm-Message-State: AN3rC/6+PMeKBsbPu6jOQ87OPHvdmMG3KY3lbngwT94B0mxgXcw2IFIl
        H6N0rU5E0pLECg==
X-Received: by 10.98.108.68 with SMTP id h65mr22533998pfc.98.1493015041003;
        Sun, 23 Apr 2017 23:24:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2de5:352a:86fe:efcc])
        by smtp.gmail.com with ESMTPSA id s10sm28437431pfe.28.2017.04.23.23.23.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 23 Apr 2017 23:23:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/53] object_id part 8
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 23 Apr 2017 21:34:00 +0000")
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Sun, 23 Apr 2017 23:23:58 -0700
Message-ID: <xmqqk26az5kx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.
>
> A small number of functions have temporaries inserted during the
> conversion in order to allow conversion of functions that still need to
> take unsigned char *; they are removed either later in the series or
> will be in a future series.
>
> This series can be fetched from the object-id-part8 branch from either
> of the follwing:
>
> https://github.com/bk2204/git
> https://git.crustytoothpaste.net/git/bmc/git.git

This is a huge series with a lot of effort and some of the patches
(non-mechanical ones) may need careful double-checking, which I'll
try later.  I think I managed to deconflict other topics in flight
(including some stalled ones that I should have discarded earlier).

Thanks.
