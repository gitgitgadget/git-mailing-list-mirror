Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8D01F731
	for <e@80x24.org>; Thu,  8 Aug 2019 06:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfHHG4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 02:56:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35067 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfHHG4R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 02:56:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so43559738pfn.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iOWPfO7+k7WZFo6gDL8eGCJQ1ImB/Xxegnaeu4SOe3g=;
        b=ksY1GxIRLLJjwsJ8z6PNukeYHuNef+NlFk5dojfDCIrcfxDs8B3cGrSoVAj7KLKZNl
         fU/Rl1dXZa7ebTY+HGSYfIeepRGS0Ju6/6ksy5TC0DE7oQd9u42jpBdjbt13Av1ufHHv
         Wv2oZxUY3un4S0Z/5w1o2d1QdaOXjGfBlmj8x+4L5AnRGX+9h/23H0z2uQALzT7oZVy0
         j2khCn6eVkskRkiggwPrnHTOu7Fi6e8nHzAydndfp/fC/CJltdELFG5HrsJ+NOQVRC2V
         1d2OK9brtkHZ8cSgWFiWWozB2db5wDVEEfFggjbbOEZteMeG9oQCv1WgV3zFxNsX7kvl
         km3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iOWPfO7+k7WZFo6gDL8eGCJQ1ImB/Xxegnaeu4SOe3g=;
        b=uae5zNQNjCTCUFkcqHpLZXWG/EctS2SP7Bf9pbheaHapohyfmupb3rwa4eBcRQfawE
         Gr7+aeT1eE2Lhujc9pcoaVNvElXssWMekAEZZV/Ls8KjNwFprdGZmm3NPxYgyohtwQMT
         dByfff0J/r+7Wudof44ZLTNetv+2k87X/LC90ssGqwxPQSxGa9oMVv/Kukx2jBvVLVw1
         ZmF9GhnlWA6kJpdGbZmcC/MCMxsS2wEfN3T1xoVXm/v/R5b5El+HaAoA9m6SxKaL3bA5
         WmKatAANlhuFgW2ylJI3m3cpEl+lqAYW80F/2lrc1Ll1i5gx/CEkDZxh91llqHwRJ8RO
         rr5Q==
X-Gm-Message-State: APjAAAV1BdI/7ZJ1mBnqJEugirwtIzry3kohY+HiZTodKHNdPQPh3uRp
        ZAysrrp4wYKTf+DYLt8K+IvFyYYf
X-Google-Smtp-Source: APXvYqzZlaoQNLdRG3AylS5HvrZyQXOUbPDsa14+N960YAoAjnKiGn9uVxZOsvfcW9/ocGV+x4lfUA==
X-Received: by 2002:a63:505a:: with SMTP id q26mr11108543pgl.18.1565247376614;
        Wed, 07 Aug 2019 23:56:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f3sm153502082pfg.165.2019.08.07.23.56.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 23:56:15 -0700 (PDT)
Date:   Wed, 7 Aug 2019 23:56:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH bc/hash-independent-tests-part-4] t: decrease nesting in
 test_oid_to_path
Message-ID: <20190808065614.GA209195@google.com>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
 <20190628225928.622372-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628225928.622372-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t1410.3 ("corrupt and checks") fails when run using dash versions
before 0.5.8, with a cryptic message:

	mv: cannot stat '.git/objects//e84adb2704cbd49549e52169b4043871e13432': No such file or directory

The function generating that path:

	test_oid_to_path () {
		echo "${1%${1#??}}/${1#??}"
	}

which is supposed to produce a result like

	12/3456789....

But a dash bug[*] causes it to instead expand to

	/3456789...

The stream of symbols that makes up this function is hard for humans
to follow, too.  The complexity mostly comes from the repeated use of
the expression ${1#??} for the basename of the loose object.  Use a
variable instead --- nowadays, the dialect of shell used by Git
permits local variables, so this is cheap.

An alternative way to work around [*] is to remove the double-quotes
around test_oid_to_path's return value.  That makes the expression
easier for dash to read, but harder for humans.  Let's prefer the
rephrasing that's helpful for humans, too.

Noticed by building on Ubuntu trusty, which uses dash 0.5.7.

[*] Fixed by v0.5.8~13 ("[EXPAND] Propagate EXP_QPAT in subevalvar, 2013-08-23).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib-functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7860491660..de58e8b502 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1337,7 +1337,8 @@ test_oid () {
 # Insert a slash into an object ID so it can be used to reference a location
 # under ".git/objects".  For example, "deadbeef..." becomes "de/adbeef..".
 test_oid_to_path () {
-	echo "${1%${1#??}}/${1#??}"
+	local basename=${1#??}
+	echo "${1%$basename}/$basename"
 }
 
 # Choose a port number based on the test script's number and store it in
-- 
2.23.0.rc1.153.gdeed80330f

