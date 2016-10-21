Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625E820229
	for <e@80x24.org>; Sat, 22 Oct 2016 00:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935716AbcJUX75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 19:59:57 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34514 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJUX74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 19:59:56 -0400
Received: by mail-qk0-f196.google.com with SMTP id n189so8378998qke.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kM1By4MBVRAbEfv8/pErV94OGNtZquUHHgyv4CUlXzA=;
        b=uVrGHqMyQGSKHTcFOroHKjz3LGd0e1MOgkXesDBbaQrK5Fs049LhSANIEEUZISgXuO
         pxS2FKfCujHA6DNPJ3V275s+wE2ZqOutzeSGwRjtTHWOc0jO+5eHtvF3bWxp3jKT7+Fz
         TxtcbyEfB/IiaF44aFFozBZSZ3iqXTMxJxBWJiNbVxgDvDvSEi5DU80JKobIn0AvR5yt
         un5O7yiWX5msEX7/Ws4d1uoW9caZ4qmy7RFvmomYTH6hUQTTbYr4jmRd7NAHBkJ9F6m5
         yo0xcaXb5js+rJAPuv+mrBRFBgmDflojceouv9SeH011WP2gUIRO2kCOfvs3Yqb8KOF6
         sD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kM1By4MBVRAbEfv8/pErV94OGNtZquUHHgyv4CUlXzA=;
        b=J/0/l8IfOxqQQM721mpWZyPIggCHy7ZMWKjt0s6fIv+D1dU8WBsVUJEpjnj8qBz0hc
         Rv+h1ZXtNdMpXqVDYu9yTwoDRezKtZms0Pk86iYtq6mo7BrrAXtlu/W1Upa1k5vsmj4v
         zNrgdNcpewlU03TqC3jNhbDB2swOJQcCEyNurgxoucG/Ol2RuKjng5KPmMxBNZvCTnQQ
         5bv/MAKphOQ9cblxHk93MhIkH9QfWeVNzmDGwivF33ShHqonvVIGuQF+w7LHX3abgMxk
         9jY4uXIoyeLa5wPsc2mkip6FtolT6SRiY1suq1qVT3VKnoiGdumqtZUfC96zoIhJylY2
         dIsw==
X-Gm-Message-State: ABUngvePlp2oYgqyRnjIW0P2Yr/Jrp9CHYLXP+vl743lneP7fRAYJvyoFA6TIY17dNLayJVB0R910n4n6bw9dw==
X-Received: by 10.55.138.129 with SMTP id m123mr4301005qkd.159.1477094395112;
 Fri, 21 Oct 2016 16:59:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.22.203 with HTTP; Fri, 21 Oct 2016 16:59:34 -0700 (PDT)
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 21 Oct 2016 16:59:34 -0700
X-Google-Sender-Auth: Pb2aS2atnlJGyHEaHjYzTioTIfg
Message-ID: <CAPc5daX-bdSBAxy60zG2ZuGbrjGwRcsvHFktCqKw_o2QuuWTEg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] allow non-trailers and multiple-line trailers
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 10:54 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> I've updated patch 5/8 to use strcspn and to pass in the list of
> separators, meaning that we no longer accept '=' in file input (and also
> updated its commit message accordingly).

Thanks for a pleasant read. Queued.

Hopefully this is ready for 'next' now.
