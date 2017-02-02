Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDA61F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdBBJ0l (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:26:41 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35105 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdBBJ0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:26:39 -0500
Received: by mail-ot0-f180.google.com with SMTP id 65so7565852otq.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ZKbpnN1kjRIhfh/fqz+FJLZxRPNS2QQYrg+CWrCBUc=;
        b=q8kdhbSNsegp9/YrI/JzBMr74B30OJTofV3yJZW1WsBblpoCWRSCDI8ihH9p6pWIqJ
         rCnxe8QUaEyXqWKRGZ3mNKtaPPK7eWdFYAi/M3fFayA6SCvKn/5UbdpQNpVBLV6snsUI
         oQVkFFCcpqlpk1UIkfquwAnnMykeY52X7lXDuOY7Vr+n011h8Qb4c7OG9pMYOrB73TTO
         OCOQbMfVrxJp4a6v8X30mjQrhYO22lTO7ZcHSbdphzKCK9Ko4MW4L8fBCo58whZ8PgT+
         +VnnLcRl/sUpuE6uIoFW3XU7Z5gqh6ge+3varxuR5C+BW8z6qbLQl66nK5rocufkt83e
         i4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ZKbpnN1kjRIhfh/fqz+FJLZxRPNS2QQYrg+CWrCBUc=;
        b=dGHzYVaqh4mV5jfEZvAqWY0TLoheTVNOum/3VtsVIWX8bzZobCJsZO/kUV1z2r+nEK
         xFSMi3wqFWx4QKojNllrlDeugpUZiAAzuHoG38zlM/vjprp1hmFfE4NHH4jKqwgg//Ju
         wz+0TDoo5uDUX5r5tQSDJVMF6Z/AIB9a2M43u6izvEEluKPY7ZBgh3qKyc0nQUzVpntB
         05iwU/OPTjl01rxSBUADTNBDEKbXROB3vV5WWI+cY3XCB3LiQGFTMm45lAbkiHxxxits
         zTjV5v8DwF+IxDVLXWwylQcegk9pOOJQ46v+VOdDmymMbB3rVgCGNgfCmXRa7C5frSiJ
         PJow==
X-Gm-Message-State: AMke39n0FaN/KJX6ZEHpeyyD+mTZpIcXvSe0k08kG7ejtyVoOJjh+X0GkySd5hS3APdS6zG/K2CscazxtnwzOA==
X-Received: by 10.157.20.146 with SMTP id d18mr3425697ote.37.1486027598206;
 Thu, 02 Feb 2017 01:26:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 2 Feb 2017 01:26:07 -0800 (PST)
In-Reply-To: <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
References: <20170129002932.GA19359@dismay.proulx.com> <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Feb 2017 16:26:07 +0700
Message-ID: <CACsJy8DED9WRr_T6g43bxHUGQYVnfaTx15hqSGiiajvi0TxtuA@mail.gmail.com>
Subject: Re: git-daemon shallow checkout fail
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 12:27 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jan 28, 2017 at 05:29:32PM -0700, Bob Proulx wrote:
>
>> However the problem driving me crazy is that this only fails this way
>> on one machine.  Unfortunately failing on the machine I need to use.
>> If I try this same setup on any other machine I try then there is no
>> failure and it works okay.  Therefore I conclude that in the failing
>> case it is trying to write a shallow_XXXXXX file in the repository but
>> in all of the passing cases it does not.  I browsed through the
>> git-daemon source but couldn't deduce the flow yet.
>>
>> Does anyone know why one system would try to create shallow_XXXXXX
>> files in the repository while another one would not?
>
> It depends on the git version on the server. The interesting code is in
> upload-pack.c, which is spawned by git-daemon to serve a fetch or clone
> request.
>
> See commit b790e0f67 (upload-pack: send shallow info over stdin to
> pack-objects, 2014-03-11), which lays out the history. Since that commit
> (in git v2.0.0), there should be no tmpfile needed.

It must be it. There's nowhere else that upload-pack can create
shallow_XXXXXX. (receive-pack and fetch-pack can).

>> Of course git-daemon running as nobody can't create a temporary file
>> shallow_XXXXXX in the /srv/git/test-project.git because it has no
>> permissions by design.  But why does this work on other systems and
>> not work on my target system?
>>
>>   git --version  # from today's git clone build
>>   git version 2.11.0.485.g4e59582
>
> This shouldn't be happening with git v2.11. Are you sure that the "git
> daemon" invocation is running that same version? I notice you set up a
> restricted PATH. Is it possible that /usr/local/bin or /usr/bin has an
> older version of git?

One easy way to verify is clone or fetch again with GIT_TRACE_PACKET=1
since we send the server's version as a capability since 1.8.0
-- 
Duy
