Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC492021E
	for <e@80x24.org>; Mon, 31 Oct 2016 20:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946728AbcJaUil (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 16:38:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36186 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946596AbcJaUik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 16:38:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id c17so20002362wmc.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=//sIW4Caqvu/8dK1BzYhbuEI+/4iBMya/of1snzcWx8=;
        b=giJAX8TVBTwSljCDV27UIUMgQ9j1rRKRgXTfYnr7mv2gf4Idcgeugyr/bV1bRHiVRk
         pK9fqQS9V+DJ5d5v+1k3MeEXW5SryB4Q71b/xKQ54/iX7we2vCEogth3woRJrOidjgXu
         FqlvNwPCtyxwclm1nmxPD9lCoYwsb6XzsaWDFVwtzE0vdaRe+ka/VnMhz5e0EHX2ZK6B
         uHcKbuQH+uIjYY7zuumz0mWyjLtPhXVFK4esh74KTI4gPMiJojPfMkvjRoeS2WcOhPDN
         +PhGdLx9avrStG5dF5F7C1u4+P9d7Qo+UJRL5tL5ucv2qjaAXmG13KcN9t5rKBMdfUPO
         oPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=//sIW4Caqvu/8dK1BzYhbuEI+/4iBMya/of1snzcWx8=;
        b=l23zqj09yvZoJvpljqkanL3goboF9Ucm35JUSeUEq9o9quJpaQv98LHVBFzwIJL64R
         oLksEQz1fBGag2UMvessgrNWIySsTKqgMT5JhSaxulMIif3RCOuABi2rUEetHrGorSX3
         NvAFfHXjsuA4EXxf+/4rfrxujxvujVx6qSJYXEW1dwyaKUs3f8KUVdV60YGne3ofdkQ/
         iRnI5Hy7oZ23/sUinaXm8ZXLPMhIX0lo9SmEgZgK2oK/tZg/i6L5BL4We0zZLNy4jeMI
         1sW65OU9O1WDQpCkms1O8pJBQwYKJB4qGyVr359CORoRwhU1mQknwVxJdOdZQ432VlnW
         7Wgg==
X-Gm-Message-State: ABUngve25QyKrMfD6LiGhEC9sySGcjh37JRHgXiRRk3OwIJHDY+A2FvBLi+9UsTT3TNDuQ==
X-Received: by 10.194.157.169 with SMTP id wn9mr23327456wjb.195.1477946318311;
        Mon, 31 Oct 2016 13:38:38 -0700 (PDT)
Received: from hurricane ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id a1sm31807395wjl.28.2016.10.31.13.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Oct 2016 13:38:37 -0700 (PDT)
Date:   Mon, 31 Oct 2016 21:38:35 +0100
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kannan Goundan <kannan@cakoose.com>
Subject: Re: [PATCH] push: do not use potentially ambiguous default refspec
Message-ID: <20161031203834.dfavyjzkob2goa5n@hurricane>
References: <xmqqvawcz36d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvawcz36d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 12:25:30PM -0700, Junio C Hamano wrote:

>  * It is appreciated if somebody with spare cycles can add a test or
>    two for this in t/t5523-push-upstream.sh or somewhere nearby.

5523 is for push --set-upstream-to, 5528 seemed more appropriate. Here's
something squashable that fails before your patch and succeeds after.

>8----
Subject: [PATCH] push: test pushing ambiguously named branches

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 t/t5528-push-default.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 73f4bb6..ac103ce 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -98,6 +98,16 @@ test_expect_success 'push from/to new branch with upstream, matching and simple'
 	test_push_failure upstream
 '
 
+test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
+	git checkout -b ambiguous &&
+	test_config branch.ambiguous.remote parent1 &&
+	test_config branch.ambiguous.merge refs/heads/ambiguous &&
+	git tag ambiguous &&
+	test_push_success simple ambiguous &&
+	test_push_success matching ambiguous &&
+	test_push_success upstream ambiguous
+'
+
 test_expect_success 'push from/to new branch with current creates remote branch' '
 	test_config branch.new-branch.remote repo1 &&
 	git checkout new-branch &&
-- 
2.10.1-449-gab0f84c
