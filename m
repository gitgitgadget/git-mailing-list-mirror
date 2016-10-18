Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D701F4F8
	for <e@80x24.org>; Tue, 18 Oct 2016 00:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbcJRAtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 20:49:22 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34240 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbcJRAtU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 20:49:20 -0400
Received: by mail-qk0-f171.google.com with SMTP id f128so253853874qkb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b/yqeKh7bmkKK0MzaNkAp/jhv2W9QZUyO320BMe/JKQ=;
        b=TU3ZpuNT1+Dw1rVDtkozc+pJkez7oHYGGN3MUQoPcLUeSTu/z9hxY/y4VDa0d8f/hs
         XIRBkzh6QCFGVdbV7uEzH7UcGdWs1CAnd0qnpxcWAqI3E/yF60pjm3cx+DthG/Sg5Daq
         RwJsFuiPabFp8VxJUOggQLl4Q84K7Sa4HUeGinT2QdswGTnB1R+phEdf1buQme9v4PQM
         GEtWxWDJSLG2AERf9g92V9xQvua2Sze4bFZQc19d28mnwnr2qgZ6tAZ2SEdMul9CmhLE
         P2mfeFEZFhKcoKcGUJFrw8uys9fBlzMKo485jCQjhqBVWXTJAKfD9PfzIu3xJsfQfUf+
         ADmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b/yqeKh7bmkKK0MzaNkAp/jhv2W9QZUyO320BMe/JKQ=;
        b=ZHBNjNU+71/nGofEE8kMTw7HHuJRKuVy1KgMk72zkpPHYeQueLA0zpsk/ZptELWZ8k
         CD8IKaFluUVgorUx6q5ng2U7R16I9kXXgB8q2mBDW3eNnwGPttoDwRqhCDWARlleWmMF
         LZmgQWzSSeC0rlc7OFuw9y98VFUWYSOG8bpGng77cknNKLLEolhyz9WK4zkORFC3/+pE
         Dm75D+hqKjNd7VSw4XL7UR2aM8ol+8eOsBZzJriCMfgSKinJ2JUGE2+q5NhmnWbmAZUS
         LH0D5KmO4kkEnhtvwtg1MMx49xtmtORqJ6myOtlCwTIiq8QJGUhtFz0vyW5epbLJFk3D
         elaA==
X-Gm-Message-State: AA6/9Rmal5CPmU9hcNqluhQGTCIYMzR9WLKpAwRJEgffSfOoVctvVC9SQaEbcualYWKXsDd0RzkHD9Ko3t7wh7WO
X-Received: by 10.55.129.1 with SMTP id c1mr211260qkd.53.1476751759626; Mon,
 17 Oct 2016 17:49:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 17:49:19 -0700 (PDT)
In-Reply-To: <1b3fe84e4b6126884a801e721d0a93c41fcb4184.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com> <1b3fe84e4b6126884a801e721d0a93c41fcb4184.1476466609.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 17:49:19 -0700
Message-ID: <CAGZ79kYLq1qA4_Qg2x5Fiu5AmGBZdozm4zk6K7LkU+uJ1LNUTw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] trailer: allow non-trailers in trailer block
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 10:38 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>
>  Existing trailers are extracted from the input message by looking for
> -a group of one or more lines that contain a colon (by default), where
> +a group of one or more lines in which at least one line contains a
> +colon (by default), where

Please see commit
578e6021c0819d7be1179e05e7ce0e6fdb2a01b7
for an example where I think this is overly broad.

Another made up example, that I'd want to feed
in commit -s eventually:

--8<--
demonstrate colons in Java

First paragraph is not interesting.

Also if using another Language such as Java, where I point out
Class::function() to be problematic
--8<--

This would lack the white space between the last paragraph and
the Sign off ?

So for this patch I am mostly concerned about false positives hidden
in actual text.
