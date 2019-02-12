Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5890A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfBLRUA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:20:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLRUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:20:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so3568581wrx.9
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W19SaJCfqoNKwBLFEO8DMysUIYoCRvSLSc9GFH+ZPO4=;
        b=ByB84Bw4Y/OXgcWn8YigPJAqBicJKKtrkfTClfVR0AtxixJOerPTiZgg3KxCZ0tG9M
         V8JcMGok42nGSRFj0UPAIA8CyPd1gp9b/Ez3RQqYm/1Nihc+nECcdMjgVUO1oY/rVob7
         fg5TmFjKUjv5mbaN+6Tg8+lRK8AG8blp3X4AWBZaI3X+s+84fg6TzNkCKOyzJgl7v7B7
         OcOAmY9eRIqldU94xvwGM04CxmE4nGCeRINw3geTv/BVWOu+MapFPwhEM9e6KK5Q1RFy
         fHqCVxs9eGG/ObhuIWZnOvqFUDgWmoBzs1dD5iKuWDhGlJtNvZYnLnQTb/fXrcUAa0Ax
         lrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W19SaJCfqoNKwBLFEO8DMysUIYoCRvSLSc9GFH+ZPO4=;
        b=or40yO2PQQv4tfOnYLbB/riZbjMF3tgcs8BlVWDlsTspbaGSaLR/hJDl67gYyVrycE
         PIPIRvbuIf/z2XWpKz6CC8miXJ7mVr1iRKvt5GzF/wsoWhYba1ZrUburs8bwB1uIYQWH
         8fh1KnXJksuvMVI/cOoghhodqofiS52IfgMmEn16p0y1iJff7ko/YwPcz8+2q1oFs3/h
         dP692Yhfb+Dpb0pY5DpUCpdjDN8ZAw1eYZtN905rjiNdlwNjkilUTJSrofMIHz66GxM1
         GNEbRAl3VZbWS6v5hdZ/Q3WoLzQ6lnrK5CSj6WIqN0Jo4+i9n5+110ayXI9V1P8oDTbw
         s1hA==
X-Gm-Message-State: AHQUAuashMFiyF2Q5PJJLd+HdI8jqLp9JCa0xjiH+bSC+pFgtah1o/SJ
        i5fTBW4zg4U5fNiuCPc6fmNTggdp
X-Google-Smtp-Source: AHgI3IaUJGlcOEbOvNa2Ab9WMPePfSOlzyFcnhtSxmMv07C7e6zeN6kTaBYe1UI36dcPAnQg/sBGWg==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr3518834wrs.295.1549991998584;
        Tue, 12 Feb 2019 09:19:58 -0800 (PST)
Received: from evil.localdomain ([5.90.75.130])
        by smtp.gmail.com with ESMTPSA id h17sm8843727wrq.17.2019.02.12.09.19.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:19:57 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:19:54 +0100
From:   Giuseppe Crino' <giuscri@gmail.com>
To:     git@vger.kernel.org
Subject: git can't add ignored file if GIT_ICASE_PATHSPECS=1
Message-ID: <20190212171952.GA343@evil.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To reproduce, apply the attached patch and run at the project root

	cd t && ./t3700-add.sh --verbose-only=13 --debug --immediate

Relevant part of the output is

	expecting success:
		export GIT_ICASE_PATHSPECS=1 &&
		touch a.if &&
		test_must_fail git add a.?? &&
		! (git ls-files | grep "\\.ig") &&
		(git ls-files | grep a.if)

	fatal: pathspec 'a.ig' did not match any files
	not ok 13 - error out when attempting to add ignored ones but add others
	#
	#               export GIT_ICASE_PATHSPECS=1 &&
	#               touch a.if &&
	#               test_must_fail git add a.?? &&
	#               ! (git ls-files | grep "\\.ig") &&
	#               (git ls-files | grep a.if)

As I understand this, it's a bug.

Giuseppe

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 37729ba258..62557e6a3d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -91,6 +91,7 @@ test_expect_success 'error out when attempting to add ignored ones without -f' '
 '

 test_expect_success 'error out when attempting to add ignored ones but add others' '
+       export GIT_ICASE_PATHSPECS=1 &&
        touch a.if &&
        test_must_fail git add a.?? &&
        ! (git ls-files | grep "\\.ig") &&

--tKW2IUtsqtDRztdT--
