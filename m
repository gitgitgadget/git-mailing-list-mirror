Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0BD1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754294AbeD2UVh (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39328 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeD2UVa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8so599917wmc.4
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ypZ1i7vlFJvkFmW2psEXgnH97I1dfIqBx2UQpXYE38c=;
        b=jRG5W2mgl2LMYt8M5otE1JMx85dV9fDg/bHOisN4fk29kOBV0ZgkwTRIB+EM6+BmA6
         B9pwl3DkBO2SvtR5ZvHewyVvf6wHXrxi0RypDGbcPJsRBbRf+CdkHoTybVNME9c1Hkyl
         /Z7DecCW9KtsB2iNLbLjP4gdk7gBOqYHPwzxU1kR3gePXcJAdxR8T/dIMw1cgrt8WVTA
         OlX2kpIalSlA8lP5K5lLVyTdwyxWwttnliHD0Y2YcwZ2Nvf6SDdamZ+g/T4Thjj2KPRH
         s03l3jkWDJsckf8RG8z/tut0kpk95q0bZHaneGOgGjFd98lh80+zXlYH0RP3+cX31wz0
         hXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ypZ1i7vlFJvkFmW2psEXgnH97I1dfIqBx2UQpXYE38c=;
        b=bL9XXsE5S0dEFV0p9SLNVDTLSzhbGDiAeTJ2Vs6SM9Y+VE3dUopHYP45rXYNscVFya
         dr/1NqKkhQLhvdmKhWzPIGpCZS+fauX/nnOuFSSjHgv2flo5udPnr5jHcVRbpQZT5Jwe
         rkSd2Gm5MDjdU7FYL8Y2ESA3MVl+gWJ+gXmu8Kp5Dprr+668Itmx6Zmh4Q8OiS1YrG/W
         Z64R2wxU2KiVbHTgJN5QzgkwYswDa1JPM1ZUoW8YtKrkYAViOmzTUkCMIIsxUugf6KmQ
         HyaF7xsHlRmrA+CrOQWNozCTLxBQzBuMlHWdcj+dfj14kxCZRrjUPl3PCWlaqK0mM6hI
         UANA==
X-Gm-Message-State: ALQs6tBPzpEb0Mrw1WT1YBrRtxUl/ZrdGNXlSlQMcpjl6c4NghjBvfMW
        I/qfunN9yf4DLsm9QeymYQrDVqfG
X-Google-Smtp-Source: AB8JxZqa3hXi1Kww3tWJC0DxIH0apoTgWaKJ5GZlToSPjgQDYjUzUhlf9rOSDr0SzqT7LeXIZ2/uxg==
X-Received: by 10.28.167.79 with SMTP id q76mr6127627wme.131.1525033288740;
        Sun, 29 Apr 2018 13:21:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] fetch tests: correct a comment "remove it" -> "remove them"
Date:   Sun, 29 Apr 2018 20:20:58 +0000
Message-Id: <20180429202100.32353-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a comment referring to the removal of just the branch to also
refer to the tag. This should have been changed in my
ca3065e7e7 ("fetch tests: add a tag to be deleted to the pruning
tests", 2018-02-09) when the tag deletion was added, but I missed it
at the time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ae5a530a2d..9bd2783521 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -613,7 +613,7 @@ test_configured_prune_type () {
 			git rev-parse --verify refs/tags/newtag
 		) &&
 
-		# now remove it
+		# now remove them
 		git branch -d newbranch &&
 		git tag -d newtag &&
 
-- 
2.17.0.290.gded63e768a

