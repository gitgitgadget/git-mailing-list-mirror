Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C2E20281
	for <e@80x24.org>; Sat,  4 Nov 2017 10:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbdKDK5Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 06:57:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:49592 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbdKDK5P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 06:57:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id g90so4523514wrd.6
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I8XPFuo5gs4Kh02zhSbHJmpjtXeTGrIHW8qq63gP5R8=;
        b=qRoioi8bzQ9NoPgVzmPECsD85KUNWMJIGJ0cc9xkP1xmwcYnReTmXaAAEXTluWUjDC
         8QB8NG6mszCCtRONfgHC63B1Lf6f2AARQawB8REYwHwm7ACvlQVRt+cphCxBh5M7BFMO
         583kLG51EiQtQFcp/tIrGkIb9389VLiGQlpFHFHkDBqarTvtYjLp9YwUGqWqBX23zwEd
         Pi1icj1SXdrbY5KKRWRxxCg6DO0+fBnV4O9ar2pOJn0Ir6NapMruqZ0LThoIkIgXlTw5
         leP8+VH9B1CyIUGmhNMaY9A4Ys0sNI3hlUj9E66Ghe4J5tmJG3dH/mZuMnmvgjJGcYKF
         cnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I8XPFuo5gs4Kh02zhSbHJmpjtXeTGrIHW8qq63gP5R8=;
        b=pCfyXe12Yidmkxw0sdVIjtaWDcCCn5y51MlSmNSVFbIjYZU9KdS21R6OE28KR+iE63
         we9ARzoLVNPGUwbusVndR/c6SfBUBTwajH2a9HRNshp/x4dXB8hbP9/5ebDZVn++XYbH
         Gt0IfpDzj4sdKx3H5vo9yXexIebO6jvq25yWq05fU4ZgPn0RVMLwRi15qTG1demCR+UD
         YZCcG/78r+e9dnh/QAJZ0YDug/lsGuZ6uQ/dfQIOAoqMSy4soKttpEu6VpQ9CtdO1bpZ
         tDxb/zcqVF5W3eifELPFztNFDNSyZVwxSjKrKjdSRKbTb7m08aj77UMl2UD+VLW8ER5Q
         WE8w==
X-Gm-Message-State: AMCzsaUNcdZQbjL3pxNLLU1KE24puPVBEIVT2txMvP01/OstMCGDiSwB
        VvmpnazXaTU5/TozO9orlTiqdAZP
X-Google-Smtp-Source: ABhQp+TKeytDTypiNulFYVp6HwlMvJ6170QLr45B6EOSnzHE3stCrBija4URhybyib0woJEAOmvIRQ==
X-Received: by 10.223.163.215 with SMTP id m23mr7475936wrb.32.1509793033790;
        Sat, 04 Nov 2017 03:57:13 -0700 (PDT)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id x185sm5637238wmx.12.2017.11.04.03.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Nov 2017 03:57:12 -0700 (PDT)
Date:   Sat, 4 Nov 2017 10:57:12 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] remote-mediawiki: show known namespace choices on
 failure
Message-ID: <20171104105712.m5zhj42nxvkhlc55@laptop.local>
References: <20171029160857.29460-1-anarcat@debian.org>
 <20171029160857.29460-4-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171029160857.29460-4-anarcat@debian.org>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 12:08:56PM -0400, Antoine Beaupré wrote:
> if we fail to find a requested namespace, we should tell the user
> which ones we know about, since we already do. this allows users to
> feetch all namespaces by specifying a dummy namespace, failing, then
> copying the list of namespaces in the config.
> 
> eventually, we should have a flag that allows fetching all namespaces
> automatically.
> 
> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index fc48846a1..07cc74bac 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -1334,7 +1334,9 @@ sub get_mw_namespace_id {
>  	my $id;
>  
>  	if (!defined $ns) {
> -		print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
> +		my @namespaces = sort keys %namespace_id;
> +		for (@namespaces) { s/ /_/g; }

I am sure we can improve upon the need to process @namespaces twice:

    my @namespaces = map { s/ /_/g; $_; } sort keys %namespaces_id;

-- Thomas Adam
