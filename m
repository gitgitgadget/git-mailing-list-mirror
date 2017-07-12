Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E92A1F661
	for <e@80x24.org>; Wed, 12 Jul 2017 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbdGLVNz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:13:55 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35301 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdGLVNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:13:54 -0400
Received: by mail-pg0-f48.google.com with SMTP id j186so18777960pge.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWOr69xcXYUgvTNC+vIs1WrXnmiLgMZzNPLl8QMNOj8=;
        b=AamvZhCylkIcK7g8HstrjaY1S2+63KCZOgGowTVQPRv6rGVLBhshtpn79SgHIl8NSB
         XkfAAYFWeC45xSHctWARu48kDuZdy1++uQ1hPYm1bzLJU+K4+LWgKYisOAiHhweRdA9M
         qoAkYEHBPjc+yotMfqFxOQVDBNxZGhb/FCUvGZT1GvZ1S0+g1m3NEyCGsrk4Nvasgayv
         480aW282FmNGHZwJ7+PXB2wNYgA3+UGMRMknBxaLbFcaYVJ87GC0egni5XZklQbKsf4i
         8X3oCMcjmongEke+n8p+xNPZY+Xm0S5SRlisNXRklfHD19dwDY54Nf+p/fXciHtrLqAD
         QqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWOr69xcXYUgvTNC+vIs1WrXnmiLgMZzNPLl8QMNOj8=;
        b=WFkcSv19osnxHNm8u7I1iX0JQuF1LEvhLg+/P2dlm2wvJkdlcgPfLpzbpx8LpYHV+J
         a+IEx7wT4awVqGyvDAWSL/pUwLxkAbMWTb6m8n1lfP6Qdl/Hr7tf3zYEc6O6CXx1WPSl
         cGaUbidxjuUEnFRB5pLJg/0yQrnt1Kn87zekInAUVeAh0+B+dzCUqI0XIvEcuDGr5atc
         1YTQ+M4CjY2bA65jrKLBf3UunbTRBU7VKYl/RdlRaGxdK0UpOGLie4/61cXBjd4J2oSC
         wOzOtTxQqmgn27m9dGje06lIj9BuzltHJTUCUOzNDNYeht6/8W7EuDjp6WpMN5Cd/Ww7
         wmgg==
X-Gm-Message-State: AIVw110JqEWKwBP9bXzGfUHho/dS+WiRSvd+n0ndSPEqVpdx7hTc9/dT
        f1G6ZkMS7KBCXOfTIbrA7Q==
X-Received: by 10.99.98.193 with SMTP id w184mr5871664pgb.155.1499894033816;
        Wed, 12 Jul 2017 14:13:53 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:1ce6:29df:5a5f:94ee])
        by smtp.gmail.com with ESMTPSA id b13sm7115194pfc.25.2017.07.12.14.13.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:13:53 -0700 (PDT)
Date:   Wed, 12 Jul 2017 14:13:51 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 2/3] trailers: export action enums and corresponding
 lookup functions
Message-ID: <20170712141351.73a8ea60@twelve2.svl.corp.google.com>
In-Reply-To: <20170712134646.17179-3-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
        <20170712134646.17179-3-bonzini@gnu.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Jul 2017 15:46:45 +0200
Paolo Bonzini <bonzini@gnu.org> wrote:

> -static struct conf_info default_conf_info;
> +static struct conf_info default_conf_info = {
> +	.where = WHERE_END,
> +	.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
> +	.if_missing = MISSING_ADD,
> +};

I'm not sure if Git is ready to commit to using designated initializers,
so maybe avoid those for now. More information here [1].

[1] https://public-inbox.org/git/20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net/
