Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5CE1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKOBBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:18 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33825 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:18 -0500
Received: by mail-pf1-f175.google.com with SMTP id n13so5486086pff.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3oyntv5x/NOliUVudqOp2u30gnSHkT0Vn0+ezmI43S8=;
        b=sS4/cldhPd2fAW6JSfXOm2OIAUy5tj0Ofi5XDilH4q1XJ2zAhLHZy1UtF3NhYlBZb2
         B0djElDhR3GIJyPSim/b4Ut++ZLakWP5UDWh/oJonmuQTfPqtYncS1oATqOJwJG03QWq
         hUrHP8wv5652o8R8t8MMAEX6OwC8SZ4NBwKYsPQjvcM+kWA7i2bHxyrs2IRjR5iKyRS1
         MZfTYvgqjmF6t0GnVkea/fpWAote3oMdWrJA6KIfbupfF1r0Nx0Dhbi8kpX1VH5xH9WQ
         6byr9I4oYiCAOURvamsOwMaDdEmDGoi5O2B1QaT2M9+cmlSDUkwpFZXEVHDvf2uzPx+v
         cYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3oyntv5x/NOliUVudqOp2u30gnSHkT0Vn0+ezmI43S8=;
        b=ueO8If9bIe8s7eoFQNF1m3fIm7sOA1pJNaMn4w9w7x8pNXNU0DiWynPNyjKYoE6fpP
         nFRljSLdzFF7TnezVkZYY+yje2eAg2tREWq81VRNsiJxcofjQF6FaEyTto3lOze5cfVj
         BBCayt/wCNm9GtmzCYLXXGWtTdwrOVmzZPxSfJVlnkvwDVA39bsJiIZ/L+7GWHBYAjx9
         Mj4g67zmGH5vTxJdlaAXoIDjf9zcV5YVl/PlkDUi8rcoj0FyhAvKiemKbmmZDlQI59WV
         vDkCyD5ApcvpEHvopZRlSGaa5NQWyG5hy2WvZI3LTnnuT4vcgiZgX/+Prpdad68hoESI
         +G8Q==
X-Gm-Message-State: APjAAAWUHe7nywnIxQ3EO29sfH7XXQqWFMjY04WcYUKSlaGEtavU5J4Y
        uyk9d+8P6bXfjeyyJu6hdGdP22uy
X-Google-Smtp-Source: APXvYqysx3eyKDCHuWCK90LfuaUPMvtCo28cquVEMXNuCdK2uf50z+tczk5HMmOI5as/TTunHSbgUg==
X-Received: by 2002:a63:b502:: with SMTP id y2mr13139217pge.133.1573779677231;
        Thu, 14 Nov 2019 17:01:17 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w5sm8760604pfd.31.2019.11.14.17.01.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:16 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 19/27] t7700: s/test -f/test_path_is_file/
Message-ID: <70cbd273aec3da27d10e0b08d63a7494321a7b9b.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have debugging-friendly alternatives to `test -f`, replace
instances of `test -f` with `test_path_is_file` so that if a command
ever fails, we get better debugging information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a96e876c4e..1d14ddcbdb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -106,7 +106,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -129,7 +129,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -148,7 +148,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	for p in alt_objects/pack/*.pack
 	do
 		base_name=$(basename $p .pack) &&
-		if test -f alt_objects/pack/$base_name.keep
+		if test_path_is_file alt_objects/pack/$base_name.keep
 		then
 			rm alt_objects/pack/$base_name.keep
 		else
@@ -157,7 +157,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	done &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-- 
2.24.0.399.gf8350c9437

