Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7952202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdJWVda (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:33:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:49072 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdJWVd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:33:27 -0400
Received: by mail-it0-f66.google.com with SMTP id c3so7648962itc.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fnV82m16lGSSRMUWg5Dh8o+dA0d3aCDN2F3sd5f0UYc=;
        b=OzqZMCONl/VTiF3VbREy2b7KsL7GcWXkHPYVP5Oj+/ZRyYt81/SiBfV5461G5r4xH7
         wj1CwHPtJ9dSNjXOIW1vAltOcjh6PuPpPsEbsQKGsv2hLO6XFEDa1Mvsmn2ze9Q78G3G
         HCAT4EH06usuq04bTf54TR4Yo6WHBXYmIy3QIhDw4xOYQDPjM1j5/BQMXihelWwFHCuW
         BNuHJs38cWyPoqH9TcqhmA6yHnGMeOu+wpSl2Qb1UsfItimF09kxPyYmu6iH1A9OACrO
         tfQn7veZlem8dWbGo2Gxzxmde7V3quMgQ9yiGKYXht+MT0WBlZmlGBwuzqJuaKLulO8R
         DAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnV82m16lGSSRMUWg5Dh8o+dA0d3aCDN2F3sd5f0UYc=;
        b=ARPwFN/zh+P4B3rzpeuCA3zT4bks/Wb50VdFFKv4xDgY9HWR0eYdFAbFhWV4w3Z876
         Vnp15DfvYJ6spIPSZCyMgLcccwZ8KPJXA5LY//IBuBJNXvPmuQA3+ZcKUq5Cl3FzbiVw
         0qk3+mmNvkLfTaz9Iuz4EKpr2+Mv9DYAtcr2SyhuLheeSWwa7sCep+/007StwWG0UBqo
         UG62iXNzstGnaZPUnCpjkPql90/wWVR0QNLWu0xwvDh+WOdAZSrpY0mYRex7QFXCY3cd
         gVoP/wnshMlTrLOTILni/EI5HmVCJhTtN2E1idGdkhCEz1mf2IPa1K0pvxTa97CZ1Q7+
         jJHw==
X-Gm-Message-State: AMCzsaUWHYVZGRYa1mOS0Ee4Gt68ToNU4HZNKu2G/Dri02vWdsMsViLH
        KhYJ0wou2QV9tLbV4/qFdLnzokO3
X-Google-Smtp-Source: ABhQp+SwUngr/F+I0JvM9HgQ8ov88IWHp7mWHzXCUzUNq/p/ztDb5+zlP7NYYpguPH7GjUOgSEmt9A==
X-Received: by 10.36.124.72 with SMTP id a69mr11849134itd.135.1508794406654;
        Mon, 23 Oct 2017 14:33:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e68sm467082ite.0.2017.10.23.14.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:33:26 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:33:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com, William Yan <wyan@google.com>
Subject: [PATCH 5/5] ssh: 'simple' variant does not support --port
Message-ID: <20171023213324.v3tm5eiir4gmkqbz@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trying to connect to an ssh:// URL with port explicitly specified
and the ssh command configured with GIT_SSH does not support such a
setting, it is less confusing to error out than to silently suppress
the port setting and continue.

This requires updating the GIT_SSH setting in t5603-clone-dirname.sh.
That test is about the directory name produced when cloning various
URLs.  It uses an ssh wrapper that ignores all its arguments but does
not declare that it supports a port argument; update it to set
GIT_SSH_VARIANT=ssh to do so.  (Real-life ssh wrappers that pass a
port argument to OpenSSH would also support -G and would not require
such an update.)

Reported-by: William Yan <wyan@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

 connect.c                | 15 ++++++++++++---
 t/t5601-clone.sh         | 10 ++++++++--
 t/t5603-clone-dirname.sh |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index a1c0ba1b3a..98f2d9ce57 100644
--- a/connect.c
+++ b/connect.c
@@ -952,11 +952,20 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 	if (variant == VARIANT_TORTOISEPLINK)
 		argv_array_push(args, "-batch");
 
-	if (port && variant != VARIANT_SIMPLE) {
-		if (variant == VARIANT_SSH)
+	if (port) {
+		switch (variant) {
+		case VARIANT_AUTO:
+			BUG("VARIANT_AUTO passed to push_ssh_options");
+		case VARIANT_SIMPLE:
+			die("ssh variant 'simple' does not support setting port");
+		case VARIANT_SSH:
 			argv_array_push(args, "-p");
-		else
+			break;
+		case VARIANT_PLINK:
+		case VARIANT_PUTTY:
+		case VARIANT_TORTOISEPLINK:
 			argv_array_push(args, "-P");
+		}
 
 		argv_array_push(args, port);
 	}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index a672fc1e08..11fa516997 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -375,12 +375,18 @@ test_expect_success 'variant can be overridden' '
 
 test_expect_success 'simple does not support -4/-6' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
-	test_must_fail git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple
+	test_must_fail git clone -4 "myhost:src" ssh-4-clone-simple
+'
+
+test_expect_success 'simple does not support port' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
+	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-simple
 '
 
 test_expect_success 'uplink is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
-	git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	git clone "myhost:src" ssh-clone-uplink &&
 	expect_ssh myhost src
 '
 
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index d5af758129..13b5e5eb9b 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -11,7 +11,9 @@ test_expect_success 'setup ssh wrapper' '
 	git upload-pack "$TRASH_DIRECTORY"
 	EOF
 	GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper" &&
+	GIT_SSH_VARIANT=ssh &&
 	export GIT_SSH &&
+	export GIT_SSH_VARIANT &&
 	export TRASH_DIRECTORY
 '
 
-- 
2.15.0.rc1.287.g2b38de12cc

