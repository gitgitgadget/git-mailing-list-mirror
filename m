Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822F81F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfACSyb (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 13:54:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35520 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfACSyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 13:54:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so16277682plo.2
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3ZHtJbHW5gQCLZeZKororo9ctfbA+h/jS/JID7v9FM=;
        b=Wz1vX9Ubiid9dP1/BWUfAKCpcMN3YnD8rn8OgSTBjY6oVGmRSpS4mTaClH/5gHPdYk
         KNMkAzCG6hgBm8xjucbQCiRf4UalAowPH+Ycur/1UBieZnwgixELGGkgmKBo5jJYO8gA
         +3KUC/Ftn9NeYmDaj96Kgf0OT9rFXkX8278y0Z1hxHQkmmJUhOwmCLtvlUEKmwwNnzEA
         SS89b102ooz/AbStLmHgxHoKegkFA5xY4KboNqfu78M41sdABaTCAuwL4CLx5TPk0sS2
         A3LJ6a5FfraJzOVOTGadJSMRTY4x6D7fl6tpyncBIzK+Yhlj0mZYuo3nxeLrHvLbAK+g
         3/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3ZHtJbHW5gQCLZeZKororo9ctfbA+h/jS/JID7v9FM=;
        b=YefkSdkG+v3CufDWfuip5TJlHWdAhX2OeHdskQgFkrXC7+SiN9UBBSu/y2eOpNnxmL
         IgM0Hie7wes+tcC1LgU4S+r16fqSuiZbzla5/DmRMUux0BBk2l/SGSTO5oDUUklYt8L8
         aYFcfMtwW9oBq0sfNHFpcRqCLKDAPiXYS2CkonjszGQ8znXxAmY3HfYsTho7oK9lBY3Q
         RieLTT3otj0lwhdCcLiJZwccYEw6m9UQYdBnTQPt4F+9k9UEllG5Mt0PY1rUNVwmI9uv
         ZycXw1HOxjsvLQSxSdeX2NQv00aWZUOgiCJdRBxWx9BoPuPwaJQySqtMcW3XpDnmtJXk
         ljqQ==
X-Gm-Message-State: AJcUukekds5ywQRT1eiWgO56U9eAvgg273rC6tLE1Y8fY1AW65IbJave
        hUP+BHJwO5eH4e7QAhiOf+o=
X-Google-Smtp-Source: ALg8bN66oTH9pzDv6FryOQ47ILUFI4IroBbwksQ6UB3LgLPTpOVycTW55K8VCja6F7S63mtOsBSeOQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr47302075pll.273.1546541670328;
        Thu, 03 Jan 2019 10:54:30 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 84sm187909394pfa.115.2019.01.03.10.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 10:54:29 -0800 (PST)
Date:   Thu, 3 Jan 2019 10:54:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20190103185427.GA237830@google.com>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
 <20181012185450.GB52080@aiede.svl.corp.google.com>
 <20181012191531.GA22611@hank.intra.tgummerer.com>
 <20181227185900.GE146609@google.com>
 <xmqqa7khisue.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7khisue.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> I think it is a good idea to give fallback/redundancy for this
> case.  I do not have strong opinion between -Wall and -Wformat,
> but I'd probably vote for the former if pressed.
>
> -- >8 --
> From: Thomas Gummerer <t.gummerer@gmail.com>
> Date: Fri, 12 Oct 2018 19:40:37 +0100
> Subject: [PATCH] config.mak.dev: add -Wformat
>
> 801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08)
> added the "-Wformat-security" to the flags set in config.mak.dev.
> In the gcc man page this is documented as:
>
>          If -Wformat is specified, also warn about uses of format
>          functions that represent possible security problems.  [...]
>
> The commit did however not add the "-Wformat" flag, but instead
> relied on the fact that "-Wall" is set in the Makefile by default
> and that "-Wformat" is part of "-Wall".
>
> Unfortunately, those who use config.mak.autogen generated with the
> autoconf to configure toolchain do *not* get "-Wall" in their CFLAGS
> and the added -Wformat-security had no effect.  Worse yet, newer
> versions of gcc (gcc 8.2.1 in this particular case) warn about the
> lack of "-Wformat" and thus compilation fails only with this option
> set.
>
> We could fix it by adding "-Wformat", but in general we do want all
> checks included in "-Wall", so let's add it to config.mak.dev to
> cover more cases.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> [jc: s/-Wformat/-Wall/]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.dev | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for tying up this loose end.
