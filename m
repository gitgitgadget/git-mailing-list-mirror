Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD152027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbdCAW4w (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:56:52 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35343 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdCAW4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:56:18 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so3386392wrb.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MlKtixBCFgchx7F9Dzn6mvgzv7aSFP/MayaE8/s780A=;
        b=cFG8vUMv2UihGw+ZVKU5d9UHCC8/IPu/8+xEQGaeRYS9J4dG99kPbNXMVZld0I8Afu
         jFvEhVQRJ/PxPgXsFHwIf6Gqu68knGxjYXShG3wfs2sr8lboka+/HCjGGtywHKTIlGhc
         6pwsDXLPwa5pNDGzQ+zqT/6KRTOSKIhisiopKxH0xrcEnFIQjpjMG9e0xS5vR0zqZnZU
         PYjdE+wqkLuIXRIuTSMpC+BwkluhFsDFHmhJCxt65jAKc31CZwiOFADZlLktuPPfZPV3
         pdDzRtWuC0GEd9PuEIggRGYCj9uHHfpD+3b7XbenfdQqS5zBMv85TiUucMcT+SQGxoxB
         CpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MlKtixBCFgchx7F9Dzn6mvgzv7aSFP/MayaE8/s780A=;
        b=rlShzvJv8GkvLOq1B40sokzESQPypoPa21plSQt8QIRu0P7pKKqwAdZBwprcQtl8H4
         XkB+yZA+Orlk1kXsxH8vKlvC+Po5PsZ3iHjm+9LdmIL2Cd5AS7iyTpCVJJTAmccpVjAp
         oIOpUivrKZ/UOyFMPXuzLdAC6ZDtchfh4fV58hKyoz4p1WjowSJBROmA6doREz/HBv3s
         ImcHQZY+D6G1i071dTF+rTUEDIOdW4F+5ng8OK9MTucYPH+K7n+818Joq6ewL7yFBUu+
         4FZFCSPQrZcf7qE9uzDMlaWUuW2UpJVzvMe5kKi13sAZ2idEejb8JjcIcL+txU5F4UCU
         kW4A==
X-Gm-Message-State: AMke39ktwd92qLbWEyOsNrE07JdSQA0DpgVOctlYyDSIZ0etGjqZEhnHEe7yTpogMvJeXg==
X-Received: by 10.223.132.37 with SMTP id 34mr8611034wrf.45.1488402953560;
        Wed, 01 Mar 2017 13:15:53 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v18sm8136233wrc.41.2017.03.01.13.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 13:15:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] gitweb tests: Change confusing "skip_all" phrasing
Date:   Wed,  1 Mar 2017 21:15:39 +0000
Message-Id: <20170301211540.4382-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170301211540.4382-1-avarab@gmail.com>
References: <20170301211540.4382-1-avarab@gmail.com>
In-Reply-To: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
References: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the phrasing so that instead of saying that the CGI module is
unusable, we say that it's not available.

This came up on the git mailing list in
<4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com> from Jakub Narębski.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/gitweb-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index d5dab5a94f..59ef15efbd 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -110,7 +110,7 @@ perl -MEncode -e '$e="";decode_utf8($e, Encode::FB_CROAK)' >/dev/null 2>&1 || {
 }
 
 perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
-	skip_all='skipping gitweb tests, CGI module unusable'
+	skip_all='skipping gitweb tests, CGI & CGI::Util & CGI::Carp modules not available'
 	test_done
 }
 
-- 
2.11.0

