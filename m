Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9637020323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbdCPToO (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:44:14 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37979 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbdCPToN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:44:13 -0400
Received: by mail-it0-f53.google.com with SMTP id m27so625902iti.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LQX5Jox7zSPOofgU5fY0rivxnWZ36k/9uSUSC0Jg2OQ=;
        b=nn+UJu+VR2cu03jxNyokUpMYpLe5OtE9+lIJf0e2SrqltS58v5uoKtmHjREtzhmAPR
         VgRpkfAX4LqXHCNVDOSrL7c4dcJRp86wpzI65tu/oeVEiRptHWe/EZbkXMwrQEV0/SmJ
         KaPfg5trovQwNbDCKnV3GYDfth2I9cmz8HbLSZKTssPQS1pKtFy9OgD9iZPXaS/MHC7S
         leD2CFoX8b6xYiRuRjcNNp7NWWcs4t+9dmuldla6XBeLfyDk3/tUgAwy7RvxfM/5nl2F
         0PBg6iHdnhY+fD4ycPaYRvmxxZf75IzDllYKKzEbVusBW+ye+mmRfu494NvbDVkxsvtA
         U0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LQX5Jox7zSPOofgU5fY0rivxnWZ36k/9uSUSC0Jg2OQ=;
        b=YBrNPxI4Rfwa1YPBMiENXvS8KAf5z2JlKfAtqrljctuXMxo1cIZImq6ASL68I6+X/e
         2jon4tkqcKqkgeLSbsEqnEigIgnHTWk/i3HL/OcRHCLj9gJA37zsxvZmLNrBB1S5Kn0X
         euAiBqV6CuKr4Seo+9dZ8dwQNqQBICUmIsh0pt+If8zhIRFINYG1no7J/LnRFh+jpSnA
         0haagNyuLmkZuNhbtWLy02k67Jk0t5LZXyJUZRkWUngkMqfkCnY346ISgi5V0JrAsKAl
         dFM2hCV2EH55D2VhY46aDlf/Lo9ZOG1bxDCHa2uO6kAZbDhFaZ5XyTyW/QBE3/ie1fuz
         xJ7w==
X-Gm-Message-State: AFeK/H0pT9QRmRiFvCcd6qtS8KjBr3WdPUsu/OiUuGSHNDKMdCP41AHLLokj7L7bVbvnfGKbYASAflkJS/CZAA==
X-Received: by 10.36.204.137 with SMTP id x131mr11666094itf.35.1489693451884;
 Thu, 16 Mar 2017 12:44:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Thu, 16 Mar 2017 12:44:11 -0700 (PDT)
In-Reply-To: <20170316194110.756ipu7xud2s3w2m@sigill.intra.peff.net>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <20170316194110.756ipu7xud2s3w2m@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2017 12:44:11 -0700
X-Google-Sender-Auth: GQ9K_gYZftd4yC2U3q_YP1MKDdE
Message-ID: <CA+55aFzp_dxevLEbRVWCmbx=zY=8hwqEBKK=Pcs7Au+rdg4pRQ@mail.gmail.com>
Subject: Re: USE_SHA1DC is broken in pu
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 12:41 PM, Jeff King <peff@peff.net> wrote:
>
> Potentially we should just eject sha1dc from "pu" for the moment. It
> needs re-rolled with the most recent version of the collision library
> (and I see Marc just posted that they hit a stable point, which is
> perhaps why you're looking at it).

I looked at it, and even created a patch, and then decided that you'd
probably do it.

But yes, re-integrating entirely (rather than creating a patch against
the previous SHA1DC) might be simpler.

Junio, which way do you want to go?

                 Linus
