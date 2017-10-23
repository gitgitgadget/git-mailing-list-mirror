Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843D9202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdJWXTw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:19:52 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52351 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdJWXTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:19:51 -0400
Received: by mail-it0-f68.google.com with SMTP id j140so7939986itj.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ne/M8HWrvyMIZVtXEa/kX5DcfisBQSvpMtOAEoGqo1E=;
        b=kxXnlqrO3g8ZMOVOpEkeDaXbjjaq4NoM1iOgZrqsR9d2YSGnRSPAlT3AWveOVZQjwC
         OQWgrHE9mEissj/laOmPlEdHkWqLCHDf0pjDvRcWM1P/kszQtqQ9ATvP4ShLoaM42upP
         s4k3KAdTEFmx6E3J1NmnIt36S69zBMHITvD0j1GemeqUQzB5NUHJ0R+dWRp+omK/Pztd
         c9Hjg+STnoCwv1dVsu+Et+uC7MqGa+oCIc5BApVQmbpqCEhvi0Z87pPN0wnjo4uRPzrP
         d87BxhcGhIKrq2M+Nf3PTPV38KIMPjuNZSCug1Wzi39HPSlJYF/mbQTsclz4z5VKcKsM
         SbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ne/M8HWrvyMIZVtXEa/kX5DcfisBQSvpMtOAEoGqo1E=;
        b=thDvnwaP3x5BkUXQvBquy9JvaeW3v1uRF51fzXNEQv7/EA8/ycLoBIcbJ1uTlyTjpD
         /PtrQs82/2PjE7y09XMZLvxCt9B9kDXCOPGpIxzwds0kTInI+eP6U7fMzjGuk67ckOqB
         cL2MqdOheh5A+15zCVjeAUU9BnTSZv3swgfXnEVq7edZ0Leupc3HFxpD3Bb524gT679G
         QVfEvEEBw8d0AqT0276vvxkL1P9kdSdyiuLwwG1cqLCYtvAonnXE04r1uHgMlt1wwvWX
         FsJ+s1ZdiYaFGJHu3Zy9cUzx8M1VUCX8s/RCpqgbgx/e3VE5ybIISEvV64WfoMw3Q7uX
         xEzA==
X-Gm-Message-State: AMCzsaWztH/uKxXXwqoGzxai9ziS51mnWxpVRmO0s3iguE2hstPOQuIi
        duyE6wZSGjj9wYuGtSmbuJU=
X-Google-Smtp-Source: ABhQp+Rjp/Oj1J40pXxz8zWm0RhPtDDCXDxfiHvId7Y291sr5YYwalzHoNCfJn/D10a1FTF7SZsmEg==
X-Received: by 10.36.123.74 with SMTP id q71mr10468413itc.97.1508800790730;
        Mon, 23 Oct 2017 16:19:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b133sm2869210ioe.73.2017.10.23.16.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 16:19:50 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:19:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: [PATCH 5/5] ssh: 'simple' variant does not support --port
Message-ID: <20171023231948.5jltnftktu5bmny3@aiede.mtv.corp.google.com>
References: <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
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
Acked-by: Stefan Beller <sbeller@google.com>
---
That's the end of the series.  Thanks for reading.

 connect.c                | 15 ++++++++++++---
 t/t5601-clone.sh         | 10 ++++++++--
 t/t5603-clone-dirname.sh |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 9c64e8155a..06bcd3981e 100644
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
index ea401cec1f..f9a2ae84c7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -381,12 +381,18 @@ test_expect_success 'variant=auto picks based on basename' '
 
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

