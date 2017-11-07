Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF9B20281
	for <e@80x24.org>; Tue,  7 Nov 2017 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbdKGHIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 02:08:12 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:49122 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdKGHIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 02:08:12 -0500
Received: by mail-wr0-f170.google.com with SMTP id 15so10882317wrb.5
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 23:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PWMEONFLJCAGcIpiO7VsjX6XapdXwZilV52b9OUstG4=;
        b=dACq/aHQ8iy0YUc0O/BCsqraZD0MYoXdJCpt9oYFT9gqtKOF/V9X3zLLh7rQjQyoDh
         fa0wkTV0R/jqr6qtI1aihlEw0LrZxkCY1QSeF5DdSZs3wZSbVi30J5TVbrFR0GgKO7na
         tQfnV5QB++4UE+9p4d1YeFRHHLXukBmiMYH2RxQPiwemnoI/Z43YxRLim1hpTGEB5hmJ
         ZVJX7XD10n0iOPPcym/SzX7oqTseV54QeKCPa7/cnGmzOZRs42PIP0Ccm389I30IukJ6
         E3THiitGSXrzR29j5MdqOCJIGtfF2i6DKLEGoH24/LcMNaVDAUasy2aOhMLpCuI5G7ew
         vNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PWMEONFLJCAGcIpiO7VsjX6XapdXwZilV52b9OUstG4=;
        b=sL2OOlz39Yjvu1+1B8g7fC0Dg2a5JQ5QphZZiEFAXknTsvZBPPHoPdOjlvHCNkB0v5
         t2gUFxYzJuI2NeAHojXcwYb2rapb45mynRHX20ho14ggn144PhY8tTFmH8LpddqJWPTV
         8hGjTCteWiHAcJCq2MH1ItsqQXU+un0Kli79Vr5cHYguhCQ3gx7Zoxbyfy4ZKUHkg3c4
         6V6LlakO76sDRPnq8SHbI90QywNcKfP5EPwC4WSU/8VrMx4DNgatpHAWS1fBGrJqmhrE
         v/x0cU/uuY6SljNuGheUrxy9Cq+QOGTmiXQf6fJTnjdqxYe2oIAMCvCKhshv652tmWGT
         VrZA==
X-Gm-Message-State: AMCzsaUzdX37pgeXAK3YLC07E9xIvVvVyMs1dAVnhvdZjWJuOSKbFLRK
        uLjRjng7BwZQNAm0AGCGjGs=
X-Google-Smtp-Source: ABhQp+SBKue0XPPKhWPOCxhgc6NneLQSiCY4XP7/1XaGK9x8Q+gVgtITeZF1Y+GjTGMOan2vxdpa7w==
X-Received: by 10.223.184.230 with SMTP id c35mr14097233wrg.18.1510038490951;
        Mon, 06 Nov 2017 23:08:10 -0800 (PST)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id n14sm874575wmh.37.2017.11.06.23.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Nov 2017 23:08:09 -0800 (PST)
Date:   Tue, 7 Nov 2017 07:08:08 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Ingo Ruhnke <grumbel@gmail.com>
Subject: Re: [PATCH v4 2/7] remote-mediawiki: allow fetching namespaces with
 spaces
Message-ID: <20171107070808.q7zz4i73mkffomcb@laptop.local>
References: <20171102212518.1601-1-anarcat@debian.org>
 <20171106211953.27910-1-anarcat@debian.org>
 <20171106211953.27910-3-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171106211953.27910-3-anarcat@debian.org>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 06, 2017 at 04:19:48PM -0500, Antoine Beaupré wrote:
> From: Ingo Ruhnke <grumbel@gmail.com>
> 
> we still want to use spaces as separators in the config, but we should
> allow the user to specify namespaces with spaces, so we use underscore
> for this.
> 
> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index 5ffb57595..a1d783789 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -65,6 +65,7 @@ chomp(@tracked_categories);
>  
>  # Just like @tracked_categories, but for MediaWiki namespaces.
>  my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));
> +for (@tracked_namespaces) { s/_/ /g; }
>  chomp(@tracked_namespaces);

Depending on the number if namespaces returned, it might be easier to convert
this to the following:

    my @tracked_namespaces = map {
    	chomp; s/_/ /g; $_;
    } split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));

This would, once again, avoid creating @tracked_namespaces, and iterating over
it.

Note that this isn't about trying to 'golf' this; it's a performance
consideration.

Kindly,
Thomas Adam
