Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28121F403
	for <e@80x24.org>; Fri,  8 Jun 2018 03:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeFHDPV (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 23:15:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39402 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbeFHDPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 23:15:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so5698165pgc.6
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SGsS8Ute3YglNgkGQiO78ym8hiaxuns7xlAsw9jLZnk=;
        b=hZNTVcAukXBy2ElnWzTBJyQlHsGvXzsdkTOsu4w8HqqTeYcM5hJ6WtnE4H48CfUgUl
         l0UhO6dezBICLONCT85632DGsH/CiihvlwxaZ7cuZWKhYQEylwG3YyNi+ogBFcb0Et2U
         ON+dNNdLZzcclfudbleAzduhISFIZgSBCTebQGFU7lwDoJfk9kmdtJldiT+m9xfr5m+O
         TeaQNvdoYlp0y5G9K67RCG4KkUpv0NVv0YRJuHOT1eIjtQiF3DWZV0uyR0RgPy0Q9ZeW
         ZLoh8qvug4Pxw3lK9TN1yHbeSk/VUInxYJagl8sBXSqRWomY8rebOoYkkospcoaIJH9G
         b2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SGsS8Ute3YglNgkGQiO78ym8hiaxuns7xlAsw9jLZnk=;
        b=DapLKdUgIwHp5RWJ4IUCIIPKq/PpHnpT7X7eJTxao6M3d4KXicZ1ZeLboiOHnDH7ye
         x5U2855ukttOhiZqRh7o8u78Ew2CbncoIufbyde3b3duD2LrAkM0lpYVbRNLjcUMKevI
         EYMVcnIXX3hSYZZMkvBI6syYSloAZFr9XJUValejWeNIYnpNMosnYD4S7YdefiMQyo0e
         aA81Db1kx/YuKDOZzrxRy2yS2W8bef0YsgW5zGdf07+DwvOGY+pZxF4oGfVNuQP3/Kf9
         BwdcQ1QMdhrv6OI0ouGkcG7VL4fVNw6ZQVtdo4GwtwIs5q45fcmk/ZhaGlbxvadvNYGS
         ws9g==
X-Gm-Message-State: APt69E0kfRC9z/AbTXTcpneA1o9f00CunxS9pcdH55mlrrM9OxD4c8Pm
        yHg6V96qHm2Lgn20O/TdIeI=
X-Google-Smtp-Source: ADUXVKLvHvHjaR+l31jbWlhPs7dWt58CSwKDorSZFnbY+xC/28Nc+C+3MXR4G03HpzQy5wgX2h+/ig==
X-Received: by 2002:a63:7c12:: with SMTP id x18-v6mr3762775pgc.220.1528427720256;
        Thu, 07 Jun 2018 20:15:20 -0700 (PDT)
Received: from macpc0swsu4.ads.autodesk.com ([132.188.71.4])
        by smtp.gmail.com with ESMTPSA id p22-v6sm47812798pfj.166.2018.06.07.20.15.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 20:15:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH v1] http: add http.keepRejectedCredentials config
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180604185551.GA4296@sigill.intra.peff.net>
Date:   Thu, 7 Jun 2018 20:15:16 -0700
Cc:     Martin-Louis Bright <mlbright@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, Johannes.Schindelin@gmx.de,
        pstodulk@redhat.com, nickh@reactrix.com, jeremy.wyman@microsoft.com
Content-Transfer-Encoding: 7bit
Message-Id: <46F82119-D185-4B41-828B-FC92709CFCDA@gmail.com>
References: <20180604122635.95342-1-lars.schneider@autodesk.com> <20180604144747.GA27655@sigill.intra.peff.net> <CAG2PGsoHajiYbS29F2nD+_0i2b4+Min5NR3tQYDb3MH=BW=0Aw@mail.gmail.com> <20180604185551.GA4296@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Jun 2018, at 11:55, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Jun 04, 2018 at 12:18:59PM -0400, Martin-Louis Bright wrote:
> 
>> Why must the credentials must be deleted after receiving the 401 (or
>> any) error? What's the rationale for this?
> 
> Because Git only tries a single credential per invocation. So if a
> helper provides one, it doesn't prompt. If you get a 401 and then the
> program aborts, invoking it again is just going to try the same
> credential over and over. Dropping the credential from the helper breaks
> out of that loop.
> 
> In fact, this patch probably should give the user some advice in that
> regard (either in the documentation, or as a warning when we skip the
> rejection). If you _do_ have a bogus credential and set the new option,
> you'd need to reject it manually (you can do it with "git credential
> reject", but it's probably easier to just unset the option temporarily
> and re-invoke the original command).

I like the advice idea very much!

How about this?

$ git fetch
hint: Git has stored invalid credentials.
hint: Reject them with 'git credential reject' or
hint: disable the Git config 'http.keepRejectedCredentials'.
remote: Invalid username or password.
fatal: Authentication failed for 'https://server.com/myrepo.git/'

I am not really sure about the grammar :-)

Thanks,
Lars
