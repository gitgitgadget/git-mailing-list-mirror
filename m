Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D315A2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 20:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758192AbcKDU6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 16:58:20 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35911 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757632AbcKDU6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 16:58:18 -0400
Received: by mail-pf0-f181.google.com with SMTP id 189so57534707pfz.3
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1XvKkkwgpCRh+G4gYF8NTtMEkrcz06DqJtVWUHuzA5w=;
        b=RxYic7Cl4gxqAsQmRj5vQ0aJKbR77UhPw3O6RQI3yWsXfrcW7WpjqTYwdqw0J98gTx
         fmD0GjuvF4tlb+JArn9AOpMvaXV295GkUe75ji+aJSPC8BXx5owclcDYBRJyNOzeB60S
         GqwNxy7FC5F4cYeGz0bQ5agC347qiQen8/LB8pabmFWd70Uo2jolDbghNGUnkirHrtC5
         Vj7Kk23vui1b1eLPEwyr5YXZApqFWDm34pwbnTW+xcRQ33nFXIpEIbLI7GFr+bRL703P
         KsVGEtXQBfGp6DcHspB6xeo30sB/2tfhedIHj0oVfH49ChMtIk5BC3ebru1n87jxb40H
         jxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1XvKkkwgpCRh+G4gYF8NTtMEkrcz06DqJtVWUHuzA5w=;
        b=TeyIDV5F9aahlE2epbaLv0zDe/WFxaKIoEN+RxDswZIhBsY/P0vvN2qyTQ7COGB8wy
         xx7KSG39NjRC8+GyzEchX4MtYigqoXkfdKrUXAIwVRfyIBth9s5La5PbfEVm7mvXW9hg
         KIj+DZfwmZJiLRSjZpkLzKvPXdsPYm9ChMrHAIQiOKjTH4TE9B/cJ6IizVTDuHjlafpn
         anKby9HcnDXdFpQIs66OY8nqm3VBZ0NAEL2AOlh3CKB7vm/J4GiBcEw5DjW/Rdq7VbFS
         cbqz9XCHJMpkxWafR5qk3S/m7YrRemLBORsb52NK8UVgauiN+fc+8jIw6K5LqwU7AZwz
         xJzQ==
X-Gm-Message-State: ABUngvfM9vbPv6SeKnFMK3ACumYvMTV081YlujHP9sOvcz/An2BA1E+jBygBocdn3+x2sBI3
X-Received: by 10.99.53.75 with SMTP id c72mr24839997pga.168.1478293097522;
        Fri, 04 Nov 2016 13:58:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:28d2:ac2e:cc40:c119])
        by smtp.gmail.com with ESMTPSA id 12sm22412299pft.83.2016.11.04.13.58.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Nov 2016 13:58:16 -0700 (PDT)
Date:   Fri, 4 Nov 2016 13:58:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, bburky@bburky.com, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH v3] transport: add protocol policy config option
Message-ID: <20161104205815.GA127933@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478292933-7873-1-git-send-email-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04, Brandon Williams wrote:
> Signed-off-by: Brandon Williams <bmwill@google.com>

Is there an acceptable way to give credit to Jeff for helping with this patch?

-- 
Brandon Williams
