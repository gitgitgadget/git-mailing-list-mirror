Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F20720A30
	for <e@80x24.org>; Tue,  7 Nov 2017 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbdKGKpf (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 05:45:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54929 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbdKGKp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 05:45:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so2811339wmr.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 02:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TrqkpMwZfMHltAloQEQXnod722X9oVJd8Z17eOjVtA0=;
        b=PDbDk5v9Hf3cbqQ9R7qXwT49AtMO9UZ09v7ZWWJIlTbON2mJvFFE1PBXvMSoVthdEZ
         KNcgpvJLSAbMcbla6Rvq4aEnypJvxCAPLxUI3woEDRBqWIieJFZ3W81dLVb0Kfx/ZgVT
         PhoVHtink/ycDQ7zfkRGSBFgvfZUhFBrI8j2ZojTQfYXWpnFX4R6Ayhpy13HidT7MvXt
         IMo9ZmJcGZTP7hWc5QEmYEVHbnCgDw23h7KwmE7QLNUovN/WNyJSqxX+PevqT/B+7RIJ
         b88OI+eXF5wxp4uoNKfEuDpDZ1S8H48B6nISMdTirztNOKmpORmbtculRnu45AQG3hHV
         AyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TrqkpMwZfMHltAloQEQXnod722X9oVJd8Z17eOjVtA0=;
        b=XhjAAc7keNCI0ioNg4NtWjUV6UgqneHGTSmD5lSmjRpcxGqUhlsJN85DJ+p7klvO7Q
         JFnorgY76xgfX4nITwDmhfo2YqyHZBt3qoqOo7cVQqsBKQwraqMjTt5/KHz5jMRZOUi9
         wfxRmfgJV3uCKTegsdwFA92n4lKCWP+b2Qmaahf2nhgIlmZ+k2elX7jW5HmRmdzWfsc9
         d1uERYPT9CILW2pvnQst4FyYTsnBmMM3lZ1X9M5DSVDHvEeUp+34D3uifLwHKk5mj6qE
         VvIgE1ma+XXbQtSk5TuhxuiUsgXYYelsScMXF17Vg/GI/MJ7LXl2xiGk6r6ykuaWakDV
         lmsg==
X-Gm-Message-State: AJaThX4AaqY+/tgxZXsVTdGrEDJrepQmAMm9GSrR/ZR8WEueFPBz/V6o
        xMgGZVp62LhUWYUn436IZHI=
X-Google-Smtp-Source: ABhQp+R/uATpPCqrd8LTCfWlxxJAFjS2ZbbeM5ct8k3TU6lHR9ZvZ64AuTVQEjcmcC6DdOYfOZ2h8w==
X-Received: by 10.28.232.88 with SMTP id f85mr999264wmh.62.1510051528703;
        Tue, 07 Nov 2017 02:45:28 -0800 (PST)
Received: from laptop ([213.123.51.170])
        by smtp.gmail.com with ESMTPSA id p4sm624110wrf.36.2017.11.07.02.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Nov 2017 02:45:27 -0800 (PST)
Date:   Tue, 7 Nov 2017 10:45:27 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 3/7] remote-mediawiki: show known namespace choices on
 failure
Message-ID: <20171107104526.ywnapdat57vi66xy@laptop>
References: <20171102212518.1601-1-anarcat@debian.org>
 <20171106211953.27910-1-anarcat@debian.org>
 <20171106211953.27910-4-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171106211953.27910-4-anarcat@debian.org>
User-Agent: NeoMutt/20171013-21-a9a9c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 06, 2017 at 04:19:49PM -0500, Antoine Beaupré wrote:
> If we fail to find a requested namespace, we should tell the user
> which ones we know about, since those were already fetched. This
> allows users to fetch all namespaces by specifying a dummy namespace,
> failing, then copying the list of namespaces in the config.
> 
> Eventually, we should have a flag that allows fetching all namespaces
> automatically.
> 
> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index a1d783789..6364d4e91 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -1334,7 +1334,8 @@ sub get_mw_namespace_id {
>  	my $id;
>  
>  	if (!defined $ns) {
> -		print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
> +		my @namespaces = map { s/ /_/g; $_; } sort keys %namespaces_id;

Oops.  This was my typo from my original suggestion.  The hash is
'%namespace_id', not '%namespaces_id'.  However, how did this slip through
testing?  I'm assuming you blindly copied this from my example, which although
quick to do, is only being caught because of my sharp eyes...

-- Thomas Adam
