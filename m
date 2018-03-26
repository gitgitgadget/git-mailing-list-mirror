Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAFF1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeCZS13 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:27:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56268 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZS12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:27:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id t7so17229828wmh.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EmnRi1PA+fVuQzV8twgkpydx+gpswws3leCox34NBA=;
        b=nnjWgruvK/60B0xu3aJe7MFTkYONVrFtjoZPL9GYlNHGNCbzMADg4yJFrZEj3DLYDF
         8tW1HBST6o0BS1r2/HXVCtC1JZNGbNLCr6SUay1zeflJ1IT4sRHcrQqqRT7iwLXm1Cqa
         67oQKUryyL8GbhV4HW32KOFOTcTSrXxlgJcmsfMTgoo96VlHkoYO9vf291wpNapQ8/3J
         youvism3rvPSmPmXc+F+Yk8/jHVrja7rueTk+DpH2pV+bmvwbBGCNCjLhvDWLpeZmf4Z
         7m1ZBeEuSFxIhPXWIq66Bk7Cytjql2Br3i4jr/u4azac8GdLDviqv8nW0NL8l0oYWdEJ
         O2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EmnRi1PA+fVuQzV8twgkpydx+gpswws3leCox34NBA=;
        b=T3i6YrIXglxl2ss4VTTG3s6zWA+eJmren1YqDlvvVgkA9KXC/FlSvyj2LbE4UWwHJn
         FWwS5zMEBUr1ZuwVye61D4ckPX7QzT4S5ksE0lsJ1TCX6wYm85aVDXO51mvn8KprvdRW
         1tojHkV36HVH2ni6Lr2hreRuSKbRSXa8QvtJUmti86cMYHzcYAd6xC2gtv6oEnEVRScO
         nGZgk4f/jFUWswHufJODgUGC7zm6dvDX4NmNiOAxZVWu26s0LfO3ubgNLqWDnY8k6e7W
         vLcmNtD+OuQYy5lzBCDPJWr7PjSuTNnt6HEp4EOeW1+rSonPAzTN4VXJ8kA6b+Wn+UNa
         eV8A==
X-Gm-Message-State: AElRT7FFH+AwfL5KOs2ptG3Nkbc3Umy2xLu2xyE0h24vo0sr4rfrCcZ3
        bC4erQLa4N1OVAbOfQmfwUjYIAJi
X-Google-Smtp-Source: AG47ELsJfoRrcjYiqUCVx0yYv3EVegv5fX3qkBliY8Z7gQDCUZMHDNu9GjTLyV26pbbqIMRrXioR5Q==
X-Received: by 10.28.232.200 with SMTP id f69mr15610577wmi.32.1522088846924;
        Mon, 26 Mar 2018 11:27:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b13sm19085852wmi.42.2018.03.26.11.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 11:27:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Dan Shumow <shumow@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] doc hash-function-transition: clarify how older gits die on NewHash
Date:   Mon, 26 Mar 2018 18:27:07 +0000
Message-Id: <20180326182708.26551-2-avarab@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118
In-Reply-To: <20180326182708.26551-1-avarab@gmail.com>
References: <20180326182708.26551-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "Repository format extension" to accurately describe what
happens with different versions of Git when they encounter NewHash
repositories, instead of only saying what happens with versions v2.7.0
and later.

See ab9cb76f66 ("Repository format version check.", 2005-11-25) and
00a09d57eb ("introduce "extensions" form of
core.repositoryformatversion", 2015-06-23) for the relevant changes to
the setup code where these variables are checked.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/hash-function-transition.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 417ba491d0..34396f13ec 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -116,10 +116,15 @@ Documentation/technical/repository-version.txt) with extensions
 		objectFormat = newhash
 		compatObjectFormat = sha1
 
-Specifying a repository format extension ensures that versions of Git
-not aware of NewHash do not try to operate on these repositories,
-instead producing an error message:
+The combination of setting `core.repositoryFormatVersion=1` and
+populating `extensions.*` ensures that all versions of Git later than
+`v0.99.9l` will die instead of trying to operate on the NewHash
+repository, instead producing an error message.
 
+	# Between v0.99.9l and v2.7.0
+	$ git status
+	fatal: Expected git repo version <= 0, found 1
+	# After v2.7.0
 	$ git status
 	fatal: unknown repository extensions found:
 		objectformat
-- 
2.16.2.804.g6dcf76e118

