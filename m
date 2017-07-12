Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A0720357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbdGLVTJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:19:09 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33717 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbdGLVTI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:19:08 -0400
Received: by mail-pg0-f41.google.com with SMTP id k14so18955774pgr.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dBpcCrZafpQW9Uxsr0L1lxz6hmbMeApcrClT4f4nB0=;
        b=Qvli74RReB5m8Jju0zBdIeFmW9iEAnYLnTzs5lS6Ya0/ZmxlrgfrAw1DwPQ76m01K5
         t3dC8egfXq/a1qR/VnXQuWDZW40JGPVky+o5/WS+sqHtc3bMHoVGeDzLD8O19a23J8Q5
         lA5EvAAYNxojAbYdgf9meyoob4Sg1x/WpWJeVwoB/eQoIvgXX02dUVPf/8ZAbrMT2fV6
         305XBHQFtKj7uEMW0Yi8O4Y7WWsm0ENtgqSU+4/zCjpSztMyAxhWguP9BtvHFAxl62os
         ge+pNi2bzV1ZoEBc4OE5BMxtxBJU8AwlAwrHjEbNDkK0kxt8vosV+/e/d7CEM/ndVMQi
         /yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dBpcCrZafpQW9Uxsr0L1lxz6hmbMeApcrClT4f4nB0=;
        b=Qlmou4vz9CqJnGbnStENWfrEIn2g+gsgUT+9nGUre1ejM907cWSwyM33ENh0xBkDXv
         OpCCrtvNdBQN7s9h/mfof3klp9x9Wo/G1rAzuOhxBrZ11HHad2eY+ggP2tg2PNcyUPR3
         BRrFtwM6fn3VpCVwt+I11lnBQkpJpOaXax3ofRfo/OzDly21tLYX/bTP4fHL9pfwWtKv
         sHYL97utKOYJAXKoK0mlEOrwnuB2QHp+xGYIWLQiIaACt2O1CcIq80/GMiZheU7PTMzR
         T4cUaT9EibTKIr/kptlpkLZV8JFZLPp7L03bHTJg0wO7VT/FcemLgOW51VmX88oUfa20
         4rHQ==
X-Gm-Message-State: AIVw113eOSWYVXtWvf4o5dvrOGFP6Qa7mdngZMheuHe6P71SL6/piqq4
        9hgAFrUG1pJHaizrBEEqXg==
X-Received: by 10.84.217.214 with SMTP id d22mr6220610plj.269.1499894348054;
        Wed, 12 Jul 2017 14:19:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:1ce6:29df:5a5f:94ee])
        by smtp.gmail.com with ESMTPSA id z86sm7867168pfl.40.2017.07.12.14.19.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:19:07 -0700 (PDT)
Date:   Wed, 12 Jul 2017 14:19:05 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] trailers: create struct trailer_opts
Message-ID: <20170712141905.14c812b4@twelve2.svl.corp.google.com>
In-Reply-To: <20170712134646.17179-2-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
        <20170712134646.17179-2-bonzini@gnu.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Jul 2017 15:46:44 +0200
Paolo Bonzini <bonzini@gnu.org> wrote:

> -static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
> +static void print_all(FILE *outfile, struct list_head *head,
> +		      struct trailer_opts *opts)

This can be "const struct trailer_opts *", I think. (Same for the other
functions in this patch.)

> +struct trailer_opts {
> +	int in_place;
> +	int trim_empty;
> +};

I was going to suggest that you make these "unsigned in_place : 1" etc.,
but I think OPT_BOOL doesn't support those. (And OPT_BIT is probably not
worth it.)
