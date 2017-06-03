Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876A1209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 23:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbdFCXp5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 19:45:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34472 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCXp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 19:45:56 -0400
Received: by mail-pg0-f68.google.com with SMTP id v14so2048802pgn.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oXdZCLnTDFBjQSvHDxRm6l+V3wjNwACXHlXeIFEZHAY=;
        b=rOxrZdYdWrFbU8rVH2kUIOIVnzI9Jb7AHsvz17NUVuSwq5Vxswy9sUnLLWubQ0NPdX
         EbHMJ/lxLvJU02rHueofd5O4qklDmNJuoPIXox0DEjvtZO/5MHGENlcYyIOxraYSXur0
         97uww2/Y6NJEEuD+/0BAD04Bue7LX2l9PR6S28YY0VoRftEt1GReakimk1eS7hCltRaT
         2xCqa9kzx5CDfOmzypserRkyDLKhFvehLCaXeKOT15lhmwi9T1DVwAkHvfPqs+vKviMN
         SGcZV6sMw/Y84zvfY/b5GkISusR0jHLE/A/jQXuaAgGpMXSlGuk9BqCZdLqbjO2gTUSY
         5Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oXdZCLnTDFBjQSvHDxRm6l+V3wjNwACXHlXeIFEZHAY=;
        b=MHrOX4RI7O5RobtVNPZm1xoKeCM0NkmKUlpG5TWtxedhM0fqZ1otVJQAHTaUph/bNy
         UlWx2kdptETitnxc/DIRvu1be0uRGw0MHzK7KaiR5JEyLa5idPFBJzWAU7MRi6PLwsI3
         nacFfPawp2GuV1GgbDJsrdM3AVLxh6jTEQZihCklnu6O1pDXqUuLWuau3InBnd2iqOCn
         KNfdBdJ2wmgbJ/Utv7JcmzP7RxqnZec13WUtc6YG47Z4lCmMDNItWkalRaU8e/G2OY73
         wpjzRz6iZwgAWRr6AR69fAR2XB4slmRicLjChPABXmN/i05qYObJ78N+FPH+jht1YckQ
         aVsg==
X-Gm-Message-State: AODbwcBsG59g0gNth/3vLtPnbzm/HB9coK1b8YX8f2DmFNc6eY5J5GTX
        HHsW0eIAeifRXQ==
X-Received: by 10.84.130.1 with SMTP id 1mr7151301plc.242.1496533555768;
        Sat, 03 Jun 2017 16:45:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id x80sm49451603pff.105.2017.06.03.16.45.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 16:45:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/2] rebase: turn on progress option by default for format-patch
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170531150427.7820-3-kewillf@microsoft.com>
        <20170531221151.pxdikxgxy37g7zub@sigill.intra.peff.net>
Date:   Sun, 04 Jun 2017 08:45:54 +0900
In-Reply-To: <20170531221151.pxdikxgxy37g7zub@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 31 May 2017 18:11:51 -0400")
Message-ID: <xmqqmv9ows7h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> That explains why you want to pass "-q" in the other hunk; to
> countermand the explicit --progress here. But if we separate the two as
> I mentioned above, you'd want logic more like:
>
>   if test -t 2 && test "$GIT_QUIET" != "t"
> 	git_format_patch_opt="$git_format_patch_opt --progress"
>   fi

This looks like a sensible line of thought.  Kevin, do you want to
try this again with the "explicit --progress option" approach?  I
think the gist of the v1 review is that everybody agrees that the
end goal of showing a progress eye-candy from a long-running
"format-patch" phase in a "rebase" is a good idea, but it is dubious
"format-patch" should show it in cases other than when --progress is
explicitly asked for.

Thanks.
