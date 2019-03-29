Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9AB920248
	for <e@80x24.org>; Fri, 29 Mar 2019 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfC2Twv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 15:52:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54775 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfC2Twu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 15:52:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so2542094wml.4
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zIfSAJR/CShnmsnYgNPcIvb0ijJiECM0N0wi1+W4TPw=;
        b=lh8/K/jONaIj/m6ddeOTzFa4cQNo1oh8dlje1+CgdPSuRpVt85NQkbMtdqAJFVTqeX
         O+qHO9+5qTqmdui64C37KFWbpd8iNM5BuMhiIvBT2DunA6LYwk3RbGp8AMUOuHdMAyZb
         6GN0G/Lw9EODiSMuVFP5Kys/x9NLyIod7JTkeJvFaZNOdxJeuibVD+xJFwmlCLvTHnXJ
         sRbplNRccKnbA6yamtVYVXspwsxD0RVt09gNpmAj2hUHXyLDrrT6Gl3TP1B7WCtPh7Qd
         oXK6hb8jHaas4Mk1PROJcZWFzz8BaWiAlgwaKmSXg6ePMMD17e/eOGM8vH8+vKm77H9U
         8Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zIfSAJR/CShnmsnYgNPcIvb0ijJiECM0N0wi1+W4TPw=;
        b=nTZaC4iKAeeuh1XEVZJkVd1Aa+vlh1C1DJUANgL0Uctgp/p60/0259s4XphRpXXg/X
         tE6Q3ilGYOpOoV5Pp5IKotoZHB0tIODAfP8DkTRQOlpEVScuLxdGq5Fp6zzLfyzZW5oe
         CASBf8yLwSIHF34+++J5vDzVMiCJofVdBULchQSM+uuNKrIs53iVCuVwyG5pSxLlcK5m
         USKcr0uqd7J+eIROKo3LBu9thVhfa7IhczOIKFx2R7Kg9Yt1TZl181gCNAiZ81UNJXyU
         XMRb1wp7fcBUI63iMlWC4rZfoOjwOEAnHUw0Nt7GGjMmITSYRZS9jxd799RpfxQWrXoQ
         pOSw==
X-Gm-Message-State: APjAAAW8+ucgqgaq6GDjH65RoI71KE4GjECYyXJnLAexE6rz6LAgnj03
        9qQHswWy3d/O6ri6LkogfwQ=
X-Google-Smtp-Source: APXvYqxpQHrc8RqNKX7Mb+GluvZi9nHwWM7iJSdwMqgLuML4o2NDveTGhKItygDg5jIS52SqJ6756w==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr4922277wma.35.1553889169290;
        Fri, 29 Mar 2019 12:52:49 -0700 (PDT)
Received: from szeder.dev (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id h7sm1550583wmg.34.2019.03.29.12.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 12:52:48 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:52:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3.1 5/6] ci: stick with Asciidoctor v1.5.8 for now
Message-ID: <20190329195246.GH32732@szeder.dev>
References: <20190324215534.9495-1-szeder.dev@gmail.com>
 <20190329123520.27549-1-szeder.dev@gmail.com>
 <20190329123520.27549-6-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329123520.27549-6-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 01:35:19PM +0100, SZEDER Gábor wrote:
> The release of Asciidoctor v2.0.0 two days ago broke our documentation

Well, what happened "two days ago" when I sent v2 is now seven days
ago...  Let's just say "recent" instead.


  --- >8 ---

Subject: ci: stick with Asciidoctor v1.5.8 for now

The recent release of Asciidoctor v2.0.0 broke our documentation
build job on Travis CI, where we 'gem install asciidoctor', which
always brings us the latest and (supposedly) greatest.  Alas, we are
not ready for that just yet, because it removed support for DocBook
4.5, and we have been requiring that particular DocBook version to
build 'user-manual.xml' with Asciidoctor, resulting in:

      ASCIIDOC user-manual.xml
  asciidoctor: FAILED: missing converter for backend 'docbook45'. Processing aborted.
    Use --trace for backtrace
  make[1]: *** [user-manual.xml] Error 1

Unfortunately, we can't simply switch to DocBook 5 right away, as
doing so leads to validation errors from 'xmlto', and working around
those leads to yet another errors... [1]

So let's stick with Asciidoctor v1.5.8 (latest stable release before
v2.0.0) in our documentation build job on Travis CI for now, until we
figure out how to deal with the fallout from Asciidoctor v2.0.0.

[1] https://public-inbox.org/git/20190324162131.GL4047@pobox.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 76ec308965..52a44c690a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -56,7 +56,7 @@ Documentation)
 	sudo apt-get -q -y install asciidoc xmlto
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
-	gem install asciidoctor
+	gem install --version 1.5.8 asciidoctor
 	;;
 esac
 
-- 
2.21.0.539.g07239c3a71.dirty

