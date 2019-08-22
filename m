Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD8B1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbfHVQHH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:07:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbfHVQHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:07:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so5979935wrn.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pHM4DZ5TSk8Kg0ZGhAolSd4JjLJUAMeZeRXRxs41HI=;
        b=DKC+StAZV7PHtOGxVpGBufHGg3ptQxF8uZ5fDZLOQgJhdh+ewfAo/wUfZ6m1Cr0oj+
         Qx7dx3HOuK6inurdI1+K317viPEG2XISB62vD0YpjXZF2qRR7SYGnot1Yle0o9gjEiR3
         duVfrdosGMJ5JqlhdJspCacc6MvvbS3MAhYBb9zUhDLWw9aEZ5pCbrF78ZhGX/bJG/0+
         4IvfXGI7UnEUq4IbU4y3iHaUTQIUcoX0WMIKpQtfneNPdzEccecIfWKyF+gX8ZOHjY9X
         TnyX/PsO5NX81CQsYn/frZoxWYSK8X4JFHD6ux8z8F/oZJNgeYH1QoJcwYZy7b+ycGk7
         MoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pHM4DZ5TSk8Kg0ZGhAolSd4JjLJUAMeZeRXRxs41HI=;
        b=a5MF4ZeNu9OK+tSHvdDN4d0ugCFspIp6pjZISL3+g2eZ8rpcnzHSUXLgq/XwEX/hPZ
         jxNO4DMBHAzKtosVdOcrpitoQZyWiuwse3ri/cFDlQGiNt+oEW3qhQdThrJxCE/pRbor
         VEnQTdjXE7iKrMIAtUETxO2CRft/opCDNZ9Els+wubNoeKfTf9sNdV3ExkDhaDrIT5uU
         Um9AzgVFipASh6Go3rR5iglrhYl8pIFqjPdIdcw0BPJcRb4Q02rQGDLW7ZtgN9OL3cGI
         6pzJ0eBxodL+rlV5ecY1pyC/QTfdIdy3Oddhbah7YYiZhzK6CEMSFCw3X0VjynnkmUoy
         Ftpg==
X-Gm-Message-State: APjAAAWPn9xhJyg2J6zdO3v7tI+gVB9D9VXOQMi5s3Z38/59Aoo0picw
        fNKi+0h5kE+wHWtwiCPr+80=
X-Google-Smtp-Source: APXvYqyI8wlSI0WOUPCzttkWCp8isiOAdGztJguUK06/R2ddUU9ZurRD9TJlyXGvyvAiBazKmpGJLA==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr22230505wro.47.1566490024942;
        Thu, 22 Aug 2019 09:07:04 -0700 (PDT)
Received: from szeder.dev (x4d0c08c4.dyn.telefonica.de. [77.12.8.196])
        by smtp.gmail.com with ESMTPSA id t8sm35795wra.73.2019.08.22.09.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:07:04 -0700 (PDT)
Date:   Thu, 22 Aug 2019 18:07:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Charles Diza <chdiza@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822160702.GD20404@szeder.dev>
References: <20190822141928.GA3163@323642-phi-gmno-clahs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822141928.GA3163@323642-phi-gmno-clahs>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 10:20:08AM -0400, Charles Diza wrote:
> By 2.22.1 at the latest (and continuing into 2.23.0) there is a
> problem with the display of progress indication during `git pull`
> (and possibly other commands, I don't know).
> 
> I'm on macOS, and this happens in both Terminal.app and iTerm2.app,
> on both macOS 10.13.6 and 10.14.6:  In a standard 80-column wide
> terminal window, cd into a git repo and do `git pull`.  The chances
> are high (though not 100%) that one will see this:

I noticed this today when pushing to GitHub (I suppose they have very
recently upgraded?) from Linux, so this is neither specific to 'git
pull' nor to macOS.

I'm sure the culprits are commits cd1096b282 (pager: add a helper
function to clear the last line in the terminal, 2019-06-24) and
5b12e3123b (progress: use term_clear_line(), 2019-06-24) with the
added complication of communicating with a remote.

If the standard error of 'git pull/push' is connected to a terminal,
then it will tell the transport helpers and in turn to the 'git
upload-pack/receive-pack' processes on the remote to produce progress
output.  However, since those processes run on the other side of the
internet, they don't have any idea about the local terminal (smart or
dumb?  how wide?) their progress will end up on, and, consequently,
they assume the worst, i.e. standard-width dumb terminal, and use 80
spaces to cover up the previously displayed progress line.

I'm not sure how to handle the situation.  A few ideas to consider:

  1. Update 'git upload-pack/receive-pack' to use some kind of magic
     character or char sequence instead of a "real" line clearing
     sequence, and update 'git pull/push' to replace that magic with
     the line clearing sequence appropriate for the terminal.

  2. Variant of the above: leave 'git upload-pack/receive-pack' as they
     are now, and declare that those 80 spaces indicate when to clear
     progress lines.  Update 'git push/pull' to catch those 80 spaces,
     and replace them with the line clearing sequence appropriate for
     the terminal.

  3. Update 'git pull/push' to explicitly tell the remote what line
     clearing sequence to use.

  4. Revert, and go back to calculating how many spaces we need to
     append to clear the previously displayed progress line, and hope
     that we don't mess it up (or even if we do, it still won't be as
     noticable as this).

I suppose this issue affects other git clients as well, so (1), (2),
and (3) might not even be an option.

