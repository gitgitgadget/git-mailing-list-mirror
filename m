Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF412021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbcKOR3N (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:29:13 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35314 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbcKOR3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:29:12 -0500
Received: by mail-pg0-f50.google.com with SMTP id p66so68770606pga.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhMYyJSSzpIDCDzcSHxe2QKigmFobt93h4DWmG4zhaU=;
        b=MD63KFkOO4rpKglw5TCTXTsu90lPErhypMbHyl8HUqT820xzOgGmiVu50/8Lx7Ak9v
         WwzaDTUoSyuC+y0dG9Go0ZgZ+HEio2x4lThw5DPWVxr9IvFF8DmPTOY/TuhkZ4HKV83F
         O6t9DnNi2xLGHeaYZGgNl9Bt7EzoxRE7NQLjohSvQBh0PApki2cNpxRClDU+BlRz5ZXS
         NhxkrsnQFLw3Buobykw6VzupyUxardqW6Tpl1PUH7IG/uVbpIrewLAM2o8tUhdBkYRCE
         7wsxIqYKU81w489z8KYhgEkLUXHnNg0rt5gpiyHu2poLRZn43a86nxw5eaT0B6Lo7c24
         NN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhMYyJSSzpIDCDzcSHxe2QKigmFobt93h4DWmG4zhaU=;
        b=UUl17Zjjyq+p3MhZPQRj0CXPZ68vSyASh1o3NDwci0ME7NvSrk9UhZAzsWOnFa0+se
         rnxzTlw3+/zmk4hctbcNXCYi5JNYAGKZssDD9Yex07ATiqzpasFJy/olfeZZS3HtNArz
         MPrNt2MK4RCNlLoExbcZOve9UykOxRtjb1oU+L/9ZepOB+fpsCDYznC69PQCpqn6f3/R
         aBkH/QHdmD879niwDGksD4Z+rzNJMgW08gxUHBdl2LAZA4NW45aNfmfxwGowqvHlz2qv
         AKQluloKQB7OOBS3KeArz4FhHX7o1bcZpuLSLeqckUuFXcH7AwIPnJ+pMJToAyb43h3w
         wabA==
X-Gm-Message-State: ABUngvddHgifwjVSKWNWm6srTAmYi+0khVP56fY6rfRZj2f97iiC3z2xxG3cRbmIN/uVAQwP
X-Received: by 10.99.174.75 with SMTP id e11mr45823518pgp.89.1479230951214;
        Tue, 15 Nov 2016 09:29:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id p125sm25291569pfg.33.2016.11.15.09.29.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 09:29:10 -0800 (PST)
Date:   Tue, 15 Nov 2016 09:29:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] push: --dry-run updates submodules when
 --recurse-submodules=on-demand
Message-ID: <20161115172909.GA66382@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479172735-698-2-git-send-email-bmwill@google.com>
 <4a72ad14-0a8f-ede9-9f54-601fcd37740b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a72ad14-0a8f-ede9-9f54-601fcd37740b@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Johannes Sixt wrote:
> Am 15.11.2016 um 02:18 schrieb Brandon Williams:
> >diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> >index 198ce84..e6ccc30 100755
> >--- a/t/t5531-deep-submodule-push.sh
> >+++ b/t/t5531-deep-submodule-push.sh
> >@@ -427,7 +427,31 @@ test_expect_success 'push unpushable submodule recursively fails' '
> > 		cd submodule.git &&
> > 		git rev-parse master >../actual
> > 	) &&
> >-	test_cmp expected actual
> >+	test_cmp expected actual &&
> >+	git -C work reset --hard master^
> 
> This line looks like a clean-up to be done after the test case. You
> should wrap it in test_when_finished, but outside of a sub-shell,
> which looks like it's just one line earlier, before the test_cmp.

K will do.

> 
> >+'
> >+
> >+test_expect_failure 'push --dry-run does not recursively update submodules' '
> >+	(
> >+		cd work &&
> >+		(
> >+			cd gar/bage &&
> >+			git checkout master &&
> >+			git rev-parse master >../../../expected_submodule &&
> >+			> junk9 &&
> >+			git add junk9 &&
> >+			git commit -m "Ninth junk"
> >+		) &&
> 
> Could you please avoid this nested sub-shell? It is fine to cd
> around when you are in a sub-shell.

Yes I can reorganize it to avoid the nested sub-shells.  I was just
trying to follow the organization of the other tests in the same file.

> 
> >+		git checkout master &&
> >+		git rev-parse master >../expected_pub
> 
> Broken && chain.
> 
> >+		git add gar/bage &&
> >+		git commit -m "Ninth commit for gar/bage" &&
> >+		git push --dry-run --recurse-submodules=on-demand ../pub.git master
> >+	) &&
> >+	git -C submodule.git rev-parse master >actual_submodule &&
> >+	git -C pub.git rev-parse master >actual_pub &&
> 
> All of the commands above are 'git something' that could become 'git
> -C work something' and then the sub-shell would be unnecessary. I'm
> not sure I would appreciate the verbosity of the result, though.
> (Perhaps aligning the git subcommands after -C foo would help.)

I'll play around with it and try to make it look pretty while trying to
avoid sub-shells.  I'm assuming the reason we want to avoid sub-shells is
for performance reasons right?

-- 
Brandon Williams
