Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B0220970
	for <e@80x24.org>; Tue, 11 Apr 2017 18:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbdDKS1p (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 14:27:45 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35108 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbdDKS1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 14:27:43 -0400
Received: by mail-pg0-f45.google.com with SMTP id 81so2449064pgh.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aKCyPPXZE/cwsjAWeHEM8dm7cNqNiHvMCjltU4jIBls=;
        b=uEqAQmeLty7n5jYMQ7/L7AQfPyR0x3QSyH5XJ3oizXyxsAizMwG/vvfHZ1enZkqaih
         ut1gyqU/dGW1rdBhqZEdsd1L1Y/RuuCIaxj+gCyHTThgXbGdXaRaxfVRjSt7HY7T29qA
         hbMH9NcFbOctMnWswbGgqhAI+AnKWtp95zFDM+Wu8B7ij1GaApQZwaKe8A4mtiOUGCjw
         gl0NczOMckqR/L+/au1+bOWQ9dtCjMASORrqnzO0TYl6nWwr9V7ev72TZ7lpBWboSYiy
         H/7Te8ohVGfR61APpVWIrpk8wPkjzHJlE7dCxUZLuufrU2256f9m94E81KpuIyLJO2i8
         SYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aKCyPPXZE/cwsjAWeHEM8dm7cNqNiHvMCjltU4jIBls=;
        b=l86DC2NdqV9/TmGrm0p1omPx9B1WVfdDITMV8p4y7hcskUxoumAmlJulPTCgsIAL7D
         cI/MDKabGjSjF4CFEWn3VA6ePQcM04DVf/yUoY5P/A/QHLMXnNd6VcK+rDTEE3tr/J0m
         7ykYmVhWg1t5d7f/jNjTsAnPrVbJ+HaOCC7tMqSwVVXtq3O/cwfyi7lTKpzTQNoMEBBH
         UvQwU7xZi5Z13Rp5e6qkSV0BoCsZQX3GCI062VRuGIX6wuvOXskwpYEoW0LOcuX6yZZx
         KJQ64qxkaFg/HqfeIb0GTijgA6tWYneoP/rh1+QwIoUCBloLQld6DAcBN3J6+VD/7jnd
         dheg==
X-Gm-Message-State: AN3rC/5LfCzDax1MoCqupLNkz101hDVZgvuNOFRCMBOc4cxoRMUyZLTUHm5psUmviIQ0pQ==
X-Received: by 10.98.10.25 with SMTP id s25mr9870432pfi.78.1491935262784;
        Tue, 11 Apr 2017 11:27:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id e67sm31898679pfe.64.2017.04.11.11.27.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 11:27:42 -0700 (PDT)
Date:   Tue, 11 Apr 2017 11:27:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170411182740.GO8741@aiede.mtv.corp.google.com>
References: <20170411181357.16580-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411181357.16580-1-dturner@twosigma.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner wrote:

> Unfortunately, in order to push some large repos where a server does
> not support chunked encoding, the http postbuffer must sometimes
> exceed two gigabytes.  On a 64-bit system, this is OK: we just malloc
> a larger buffer.
>
> This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> buffer size.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  cache.h       |  1 +
>  config.c      | 17 +++++++++++++++++
>  http.c        |  6 ++++--
>  http.h        |  2 +-
>  remote-curl.c | 12 +++++++++---
>  5 files changed, 32 insertions(+), 6 deletions(-)

The only unresolved issue was whether we can count on curl being new
enough for CURLOPT_POSTFIELDSIZE_LARGE to be present.  I say
"unresolved" but it is resolved in my mind since git doesn't build and
pass tests with such old versions of curl --- what's unresolved is
formalizing what the oldest curl version is that we want to support.
And that doesn't need to hold this patch hostage.

So for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.
