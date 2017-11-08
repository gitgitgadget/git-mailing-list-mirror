Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14141F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbdKHApZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:45:25 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:51338 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934172AbdKHApV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:45:21 -0500
Received: by mail-io0-f171.google.com with SMTP id b186so4145802iof.8
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 16:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TflB2ZdMXMStDYbimj1We4Ijc0Yn+06P4alZLjL9L4g=;
        b=WCiqVqVYe8v35U7rzprflMSSn6IC+8Cw6EIZJ9J4SU7n9CHcoLw4Bfitvj83tmo53D
         //FN5rgVLihi9MjqrCLgyE0RNNfP8tYh57o3+fSmMupm0t68h81OBwCYsSjaYXrkbqZ3
         jjm+hPau+ka5TAQhXKcIMo/1wXqkD/uzoAqZScOdzb8K/ULQrHMDpeoR3HnBBhhxM4iG
         wU/dAP1L2DsAD14/KA2HFUriiNEHcUfgp0Cg8Y+JnAUu6NTsMjQfbs1MnBOp4EHqxtkh
         EmXBXgTPrd2QCLrRiLLM1j4+7eMtfFsfrKOI0kBtQMW5N5Fn6BLaR30Olx7BDi5wNsui
         ILzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TflB2ZdMXMStDYbimj1We4Ijc0Yn+06P4alZLjL9L4g=;
        b=C7ElP/FZzEZOpGlXmL3mxoKL2rrLJ/b6pNA0dklx6DD0VCvhIeBR9luIyBVNar9D5Q
         Nh0pDQJ0frlAzV4ZgTCPFSOdLbiua8v0Dr22sKT04md05prMviIQ7PzXW/uRBTbF0jKQ
         MY+CakBqBbjYG813Zt13SwUmB52EmvwJc2nAmtI4OTVgJ3iA5FMLxEUsIGqxKc4BWpHr
         WrclLpmOoZszdRZsS/XpOTAAPrE4XU2U9WiLratjaG9cbKeTLp1lnHq6dVIEV02FlJ84
         GUrqVOREgvApuaM8TvYUaCrFAWWRm4p1c1MSRlLLQ59IB5CHj43wsQjZvVoUWGdlFi8K
         ROTg==
X-Gm-Message-State: AJaThX6hhjMpN0OlZH5CcXzhVmGV1uJLmg9qavJ1XGZN747vgNcGtO3J
        6uxxUomqDp9E1wiNg4W/X370VQ==
X-Google-Smtp-Source: AGs4zMacore11XYZ+3ZbBcHRiA6PP6+ct7Tn2FbA+l4C5QL9MKeb8DfQyZ2o96vi/QVOZKXBi3Uw/w==
X-Received: by 10.107.151.19 with SMTP id z19mr789597iod.248.1510101920901;
        Tue, 07 Nov 2017 16:45:20 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:8df4:1665:e9bb:1ae7])
        by smtp.gmail.com with ESMTPSA id u187sm1180208iod.22.2017.11.07.16.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Nov 2017 16:45:20 -0800 (PST)
Date:   Tue, 7 Nov 2017 16:45:19 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 6/6] pack-objects: add list-objects filtering
Message-Id: <20171107164519.eb49377ce11a6b31ab09bf83@google.com>
In-Reply-To: <20171107193546.10017-7-git@jeffhostetler.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
        <20171107193546.10017-7-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  7 Nov 2017 19:35:46 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> +--filter-ignore-missing:
> +	Ignore missing objects without error.  This may be used with
> +	or without and of the above filtering.

There is a discussion about this parameter (and the corresponding ones
in patch 5/6), to which I have just replied:

https://public-inbox.org/git/20171107164118.97cc65c4030de0922b19ddd6@google.com/

> @@ -3028,6 +3048,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
>  		unpack_unreachable_expiration = 0;
>  
> +	if (filter_options.choice) {
> +		if (!pack_to_stdout)
> +			die("cannot use filtering with an indexable pack.");

I'm not sure what an "indexable pack" is - probably a better message is
"cannot use --filter without --stdout".
