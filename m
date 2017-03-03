Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7677620133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdCCVWB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:22:01 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33045 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbdCCVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:21:59 -0500
Received: by mail-pg0-f68.google.com with SMTP id 77so1002717pgc.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+RpgYL3Gj5hFZFCK/SsiUqOQqaVSMO27wxzjSiiikw=;
        b=o1jgkOF62WkikeAep4k+RQp4fmKUaMamTzy338gDWe96OfZ/J2a9YYMwEplZIv/f3q
         1kdvGX0n5El89ctdPyAtSvZ44XMNwniuafcgbs4rXzfBSAXzK9UEULWsLKeFfRafJ/6+
         nnqy8ninPDUT4BemUNN1Fm4hlPxn7Dv/cNRzXt5zwpRPAUNda4argKTtbmwmyXj65Ooq
         RfIYpMyJ7sqHF6aivfWwqB3ggbeKw4z2iI/97zlpAfUNsGLiEGwsaKyInbK+YvgCTSW1
         MaJiffe20kaKkYRCLiQqmMYbfTNWBZYUf6H6QRLVYe1XEVZnaDnwUcaBvgE+F6NTf2Bf
         IjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+RpgYL3Gj5hFZFCK/SsiUqOQqaVSMO27wxzjSiiikw=;
        b=DaytVH1hqJKAk+EeOR2A2CMPlzsjBJUpVZsB0WZGtfJQvlhk8HK4gYbF6KrqwUsnHR
         htBMnwPMIFtLL0GMqWpj65ndgwZGNd/qCGCeq0F4ZkHzfr8WQmclbXCN6scypF6tEvxe
         g6AXLuejxxaJTVGW0rGVkIcUNAOhRG5IYx2R030e3Qwekos3lzYYqLwm9hZwHuGfQPVw
         mguosJS6/U2J+7cp07ql5/TBUkO6O5/mGrJig0rKLT6alaLHyfMG/kN3vHuBpekedoH1
         pPujIWbglhJk6Bu80htRwk9pMbkwDqSsPLANaBBKe9O7bg+eOnzc/MhAsJ5/mPmN2J7p
         YCMA==
X-Gm-Message-State: AMke39kJd9AhvuM0mBKMzZV7zueIz+x0BmGTNihGJ+HSaQrgC3z5VkVpbTF98mN0n9nCqQ==
X-Received: by 10.84.136.135 with SMTP id 7mr7205317pll.149.1488576113429;
        Fri, 03 Mar 2017 13:21:53 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id s13sm25148072pfk.26.2017.03.03.13.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 13:21:52 -0800 (PST)
Date:   Fri, 3 Mar 2017 13:21:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 2/5] Use -y where possible in test t7610-mergetool
Message-ID: <20170303212150.GA13790@arch-attack.localdomain>
References: <20170303134022.GA6258@arch-attack.localdomain>
 <xmqqd1dy880d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1dy880d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 11:39:30AM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > In these tests, there are many situations where
> > 'echo "" | git mergetool' is used. This replaces all of those
> > occurrences with 'git mergetool -y' for simplicity and readability.
> 
> "-y where _possible_" is not necessarily a good thing to do in
> tests.  We do want to make sure that both "yes" from the input and
> "-y" from the command line work.  Changes to "-y" done only for the
> tests that are not about accepting the interactive input from the
> end-user is a very good idea, but "replaces all of those" makes me
> worried.
The 'custom mergetool' test case seems like a good place to introduce an
interactive test. Would the following patch to my patch work?

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b6a419258..71624583c 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -135,8 +135,8 @@ test_expect_success 'custom mergetool' '
 	test_expect_code 1 git merge master >/dev/null 2>&1 &&
 	git mergetool -y both >/dev/null 2>&1 &&
 	git mergetool -y file1 file1 &&
-	git mergetool -y file2 "spaced name" >/dev/null 2>&1 &&
-	git mergetool -y subdir/file3 >/dev/null 2>&1 &&
+	( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&

> > -	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
> > -	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
> > -	( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
> > -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> > -	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> > +	git mergetool file1 >/dev/null 2>&1 &&
> > +	git mergetool file2 >/dev/null 2>&1 &&
> > +	git mergetool "spaced name" >/dev/null 2>&1 &&
> > +	git mergetool both >/dev/null 2>&1 &&
> > +	git mergetool subdir/file3 >/dev/null 2>&1 &&
> 
> The reason for the lack of "-y" in the rewrite, in contrast to what
> was done in the previous hunk we saw, is not quite obvious.
> 
Sorry, it was my mistake. I had forgotten to replace the '-y'. I have
corrected this for a future revision.
