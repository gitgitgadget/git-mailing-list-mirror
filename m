Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08592023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdCCJxE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:53:04 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34970 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdCCJxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:53:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id 67so5083049pfg.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/WGBu++WvPMk2uLrxlvMY5xJLRt2m87eYWFzGdMO60=;
        b=l3vjdgySLEqvkjyO7yZBxHTGmw6++9rNgSeidugROBvqhkYYGf901RcStaEoAoBn/f
         TMu9AaB8xoBVa1/udq7PWp5yrmEiuBxO/xcaEogWoBkHdJt9Rev5F91nogtbiCJDnH6j
         xgn5KyFAx7+Q5Nt1YYf6KtAB0eW6qmJRomvwi9Ve95kH8lsmW5d6vVZ1NqjV/keDoun8
         YP4QCxDpVymVTnt+UnwemjSj5mSFU89x/OHtDb+O+zuCfS3EtWF9yOMUtvUVcm0Qjp9L
         Nu8JkP//6wpJfDBhINbDlAgA9TXSmdBzvXrL8tv30Rp+JoRpgWZuqHxIll/WdxoHsHkt
         VoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/WGBu++WvPMk2uLrxlvMY5xJLRt2m87eYWFzGdMO60=;
        b=gjUlChXQG0+k2D5pxUy9xMXM/Fks4PT+w9TYy9/GsMQnGNq5b84Ls2B6Y0wGTgl7CR
         11b9x7lQidhQ/KiqWeJLGAfgSb3TRF3sUJc5Dckbb96Z2IJwZJmw0ycocd3EMSNg2QtG
         jw4jVcd9AK0TjVIITuC3SeKgOFUvXIC14IuOJKI8CuN3WICuoiuS5GrVJG64IUlrL9xF
         V6QiiIkXXrHSSTglsYI7iAg5QZvzIwhvFrmOZE0OW7Oy2KMNNwM80RSv1A/D2RfIOSRP
         t2qijKXuIrqfkEZ66BCcayKx4VC3vTNtRB8GlgGqmxWG9jXUSkrelQAapBvnEa0pXfmV
         vpmw==
X-Gm-Message-State: AMke39nUuuwH/XnPjB8CXkujOJ3/rNMgCa9CiR8XzaUNXhExVT1SUq5Rt3LkSniHjpF9yw==
X-Received: by 10.84.248.79 with SMTP id e15mr2950731pln.133.1488534780949;
        Fri, 03 Mar 2017 01:53:00 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id h3sm22191388pfc.82.2017.03.03.01.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 01:53:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Mar 2017 16:52:52 +0700
Date:   Fri, 3 Mar 2017 16:52:52 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
Message-ID: <20170303095252.GA12072@ash>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
 <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 01:33:29AM -0500, Jeff King wrote:
> For those following on the mailing list, there is some discussion at:
> 
>   https://github.com/git/git/commit/484f78e46d00c6d35f20058671a8c76bb924fb33
> 
> I think that is mostly focused around another failing in the
> error-handling of the config code, and that does not need to be
> addressed by this series (though of course I'd welcome any fixes).
> 
> But there's a test failure that probably does need to be dealt with
> before this graduates to 'next'.

The patch to fix it is this

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f0cd2056ba..e833939320 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -102,7 +102,7 @@ test_expect_success 'config modification does not affect includes' '
 
 test_expect_success 'missing include files are ignored' '
 	cat >.gitconfig <<-\EOF &&
-	[include]path = foo
+	[include]path = non-existent
 	[test]value = yes
 	EOF
 	echo yes >expect &&

Junio could you squash this in?

A lot more explanation is in another series [1] I just sent. Not sure
if we want to repeat the same in this commit's message.

And this series without that squash, when combined with [1], will fail
this test even on Linux. Good thing imo.

[1] http://public-inbox.org/git/20170303094252.11706-1-pclouds@gmail.com/
--
Duy
