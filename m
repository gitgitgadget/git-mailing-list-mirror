Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2751B1F661
	for <e@80x24.org>; Wed, 12 Jul 2017 21:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbdGLVKd (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:10:33 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34886 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:10:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id c73so18688681pfk.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbz7yf33PDFUhQsaCgKOeqK0PCI34fLwlXa+Sk3y9oI=;
        b=P2DGUysOEq3ddXL9nu/cyWZpBqjnVakI5AqdQk8A/ndTaeBv5BAuiDSYJDU5FBeGKd
         3uSksZcZMsesgUvqffWb9lV6DRbDqcVCbo26Z239UqCEen4wdAEga/A+1tT3ja1gHPoc
         f2ManojioFRSwjsRsoKxplfcdYZe8PuUk7FekPc0QyB7d1mluzNPPookmzYCgmumbRwI
         mtLBL5N2zORen6dw6hla80jSqtBumPg1zbidZH33rao0qOp6PF4j3J99FR166sIj68Hk
         eIY2tWyKhwxgZ63Wg5gAjR6h37UIch7/A8H4ctf6AGziP4XgcSABY5LLBu0i1SAW22yW
         WcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbz7yf33PDFUhQsaCgKOeqK0PCI34fLwlXa+Sk3y9oI=;
        b=e9XivjMkdR7JK7iWMmM1B5XyTL1Iix78mENDYxh+e/56w3DRmAK7uyrtty/cey2g7X
         MGupgNS+A2zdPuvns3V4rND4ZVlKqqDcFOKQ00n34+9ndSP0zM/xdGOXh0Y6qeobEmF/
         iwdXCoao44WO6FdvUtG7eQf1jrA7T2Umxus5pcG7qrwlhe+YWiK48Xs8x+vUskelxl3D
         s3Yaq5TvyYFd/GQsVpB15RKhrhwhrQFPQVjcBt9QAKxg81JmvV/bFUdqsfZjKPYsDmix
         ovHqa7xhL91fRQnItHYIPJab7jnbBVGo0tC8Z0YJAaeaOnuV/7f9fC/suJXBjtwvbZLN
         L+Yw==
X-Gm-Message-State: AIVw1105jD0mzEDwQXMzgsQakhNnPtJDfwUWx/52wolaT0nUysK4Zsc+
        UHBPJbpDl/FmuLO2KyWT1w==
X-Received: by 10.84.217.7 with SMTP id o7mr6080721pli.156.1499893831383;
        Wed, 12 Jul 2017 14:10:31 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:1ce6:29df:5a5f:94ee])
        by smtp.gmail.com with ESMTPSA id y192sm5454269pgd.38.2017.07.12.14.10.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:10:30 -0700 (PDT)
Date:   Wed, 12 Jul 2017 14:10:28 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] interpret-trailers: add options for actions
Message-ID: <20170712141028.2d6beecc@twelve2.svl.corp.google.com>
In-Reply-To: <20170712134646.17179-4-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
        <20170712134646.17179-4-bonzini@gnu.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Jul 2017 15:46:46 +0200
Paolo Bonzini <bonzini@gnu.org> wrote:

> +static int option_parse_where(const struct option *opt,
> +			      const char *arg, int unset)
> +{
> +	enum action_where *where = opt->value;
> +
> +	if (unset)
> +		return 0;
> +
> +	return set_where(where, arg);
> +}

This means that we have the following:

    $ cat message
    Hello

    a: a

    $ ./git interpret-trailers --trailer a=b message
    Hello

    a: a
    a: b

    $ ./git interpret-trailers --where start --no-where --trailer a=b message
    Hello

    a: b
    a: a

When I would expect the last 2 commands to produce the same output. Maybe
invoke set_where(where, NULL) when "unset" is true? And change set_where()
accordingly. Same for the other two option parsing functions.
