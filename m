Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46FFE1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 19:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfHITuh (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 15:50:37 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52883 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfHITuh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 15:50:37 -0400
Received: by mail-wm1-f53.google.com with SMTP id s3so6786488wms.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lv4LqnUCrrVKCHx2aBsWvYUJ6JiC9Ws/sVtUF9qHRcA=;
        b=SLyFydIAg4lByeuzl4CBll8IhBMZo0UwlhOXF3diTLYfXEz+ifHzrKRBG19qB73j59
         X7VAmasggsru5Q+2OsIoNVyCiqc5sA7L7MeY2wGXwLO8Ti9gt6LxmZ4CqAtjfPaO+GHp
         5R2yr7u/nyCK42uejZ3Y15kt9ejlcvmZagxwnR5BAfWL+LbSP4n0FqB2IaS1V6zCkoRR
         q0l+9KvjWCSKfSpXlY6fhWEDsI8x9AlQpdgUdfZs/SyR7PvEFf2DYdjx59QAuxZHEnZG
         XtKWJw5s41RURCy0pJN53UeJ3GjtiKrL1AsYIaUaqtVdpXktUQv09gWCWfcka/WDb4zy
         2l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lv4LqnUCrrVKCHx2aBsWvYUJ6JiC9Ws/sVtUF9qHRcA=;
        b=F+zxSdwLb0/2K25Oru3XVc20EUhLTlADbkI122e9AS+HfKxpGXhe8/TQyo3Sk73xEM
         Huh5grmwByIDJFRifzCV0DExUibKIQi8JksXOBCdyMjpH9siRCNlJLQGF8M5+gEdvB9o
         K+yrhtsAReCU7+mRT/ODVSBagNQLvNBBSlP3Q7DpRVOLidHBJ7IQCUjfKAcipKO7vfJm
         yKr3LpUjDX6ZB4I/Aevy/lFXUtsGOAwEMonVT/QuJmjcLOYQMUDkOItgtj/CDiPOxbTL
         Q193yDirJvaZgdaxswGVNtUmScHWXcYJzZA6TRvg/Svz1XybKgqiJrrtP8JhhHkuQ0Dw
         eJlQ==
X-Gm-Message-State: APjAAAXi1/5cKsz5z5VCKLXDWkcZV8mZ+rtxHKm5OXM79lMvBLSv9l4f
        hC4xDjPH/UP0S7M3qo5Xmqo041q0
X-Google-Smtp-Source: APXvYqw2OiXssnqGNyjSjQRGsSac8qTDFj0pH03JuzitOUDroje3n0HvO0ls8l1gEQfcJyGCx/UvdQ==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr12325237wmb.119.1565380235064;
        Fri, 09 Aug 2019 12:50:35 -0700 (PDT)
Received: from szeder.dev (x4db31839.dyn.telefonica.de. [77.179.24.57])
        by smtp.gmail.com with ESMTPSA id h14sm97096190wrs.66.2019.08.09.12.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:50:34 -0700 (PDT)
Date:   Fri, 9 Aug 2019 21:50:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Cliff Schomburg <clisc@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git log" does not display refs info when executed via C#
 Process class on Windows
Message-ID: <20190809195031.GK20404@szeder.dev>
References: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 07:36:19PM +0000, Cliff Schomburg wrote:
> I have an open Git for Windows issue here:
> https://github.com/git-for-windows/git/issues/2285
> 
> "git log" works as expected from the command prompt.  But when I execute it via C# Process class and read from Standard Output, the refs are missing.
> 
> Is anyone familiar with this issue?  Any idea why the output to CMD and STDOUT would be different?

Decorations, like color and refs pointing to a commit, are for humans,
and humans read the terminal.  If the command's output doesn't go to a
terminal, then no such decorations are shown by default.

Try invoking 'git log --decorate'; or, better yet, use your custom
'--format=', especially if you intend to parse the output, 

