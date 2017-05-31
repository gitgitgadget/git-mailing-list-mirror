Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4741FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdEaWo0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:44:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35480 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdEaWoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:44:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so4623744pfd.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Mqzn/z624eFpCJWa2AMxJOsaf4Peu7ePu3dCmnR0PU=;
        b=in+5u8VMqX68W9rcIj4pebi/L0pptmxDzfHWdVAQpjhiMmDiDXIvgIdrH1l+0wkpFU
         OK8D9kA4G5zSka4BJLi9y+I7HJsQt5Houw0e7Sej1+nwY0+3G3tykiQqI3w64fhD1aMV
         gnZRO6Uvkr1iNA19uiMrYpc8INWM0gejZE51fJ1eYfBMiGqesbPx0bjaefglUMXfnAC0
         0SXiI92meaL3jLma2Kck217wtMJ1L8arlvBvvwkhVKHcXL52dnGAgcFewRhoj+uvRUxp
         z8i4avva1a6lVjt2rHYIzLNzTl3nirxCy4XLKe2oiTrKJu6IkY5GM97gcAgwUvZEw01x
         gdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Mqzn/z624eFpCJWa2AMxJOsaf4Peu7ePu3dCmnR0PU=;
        b=rm+5ajzilK4kwRRwS5NbtPEO1b93fU1S9k0eID1uFq/4PbqgN6ggIwOaLr2w88GQQ1
         LxOTRpyCK6PQutYr9Iqr69sNDmaw5bL0ckhjjQIx5Ex0CdQUsqEjZz/cOCHENNjNKiqx
         xzsdXnUqIwd6UEposyN0imkiFWM0ZBBiwg5LSNxkVQjE1LyYMtIFzZo7d0ESQKvLtmHx
         MJQBFDzWewDqlw6WiaF+RuOUlvYR6wid53AXsn8HfGxhw9AQxmLl2aq1296wd/i09ENx
         Dyo3cRgM5W/IhjIeuT9Y3JpiJRl3FEhdAg4WPV2JLmbRWh7XmLXU76VWtWKQX87Qi3+0
         je2A==
X-Gm-Message-State: AODbwcBMd5oH4iiTwiYGuXaOQEeOfJ4/EBv2ujpzIECEhPap4zvqEphp
        SfYTdots4hOpIUJ24hU=
X-Received: by 10.98.16.215 with SMTP id 84mr32706740pfq.210.1496270658915;
        Wed, 31 May 2017 15:44:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6469:e172:b5f4:6d97])
        by smtp.gmail.com with ESMTPSA id a78sm35313509pfk.122.2017.05.31.15.44.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:44:17 -0700 (PDT)
Date:   Wed, 31 May 2017 15:44:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     git@vger.kernel.org, Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Brandon Williams <bmwill@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: Net::SMTP::starttls was introduced in v3.01 (Re:
 [BUG] git-send-email broken: Can't locate object method "starttls")
Message-ID: <20170531224415.GC81679@aiede.mtv.corp.google.com>
References: <20170531222455.GD72735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531222455.GD72735@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: send-email: Net::SMTP::starttls was introduced in v3.01

We cannot rely on the starttls method being present in the copy
of Net::SMTP shipped with perl until v5.21.5~169 (Update libnet to
CPAN version 3.01, 2014-10-10).

Reported-by: Brandon Williams <bmwill@google.com>
Reported-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Eric,

Eric Biggers wrote:

> There seems to be a bug in 'git send-email' caused by this commit:
>
>     commit 0ead000c3aca13a10ae51a3c74c866981e0d33b8
>     Author: Dennis Kaarsemaker <dennis@kaarsemaker.net>
>     Date:   Fri Mar 24 22:37:32 2017 +0100
>
>         send-email: Net::SMTP::SSL is obsolete, use only when necessary
>
> When running git send-email I get the following error:
>
> 	Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.
>
> The perl version is 5.18.2, and the Net::SMTP version is 2.31.

Thanks for reporting.  Does this patch help?

Regards,
Jonathan

 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0d90439d9..3441e3cf5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1354,7 +1354,7 @@ EOF
 		}
 
 		require Net::SMTP;
-		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
+		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("3.01");
 		$smtp_domain ||= maildomain();
 
 		if ($smtp_encryption eq 'ssl') {
-- 
2.13.0.506.g27d5fe0cd

