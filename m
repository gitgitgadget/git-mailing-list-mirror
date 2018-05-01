Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010EF215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755160AbeEAMHo (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33590 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755145AbeEAMHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id o4-v6so10643222wrm.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UQdPsTBGQbTNiDbTfJb9hKPMhB/WVrDiYWmoKicFm6w=;
        b=CNyka1z1xts5Lvvy+M7vS7Kfyr7sgR6M3Y/tCBiMW/c8igqjz1STFbZkfd9BKrIfeJ
         Wk8osZf4TWX6AiqysHsV0hypVz1/D5lboKWisJiAegK9VnoUoxYqhp+1NYoVMrgrl4FU
         K7er7aY3ke2Lre3gSAvfKsWZg84rzJpATle5MorkMB5ClVFN341DPVFsSTE011QfsT0z
         PpzHyXwKLz5UiOqsRZEESInU3F4b9+gVzehPiz/YtWReTTfLFJkekqaVlrwZ2aXB2YAR
         6U6XCio9ybAhoQE94uMDEJR0v1g61gbJyL7TOxjncV+4uVOHGYWGNwqYgUc5uxwr0FhS
         R6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UQdPsTBGQbTNiDbTfJb9hKPMhB/WVrDiYWmoKicFm6w=;
        b=tiNZDvXUNkvA7m9dEC9wwZYOH/mhPUSo+cq40QeGNU5Yihl2vz07USCf9HbrQ8mLqC
         Jxm9w8RF14z3CSJ/Q7bPKSjrwbozZxycl7Ge5gvIjA4bPtZwggymDhcF7fxkuyGZtYOx
         E3C5W5mOmG35ZuuoWHO7oS2fQp5vhs77w7dMdbD64qNva/mX1qB6yqA3Up0yWro/ArUS
         YBTbLvX1KYUxWOr1X9e03iyhXq/Z8umnthpBgedvZn+1fL62AEirkhlpyIuDBFxGLflM
         KuJcmS0mTHMPWo+HexrXFOC7Gybmf77jMcT3ZgVHrGub6JjdlN3A7+iJmukdQD3I/NXA
         Xa9Q==
X-Gm-Message-State: ALQs6tBpcaVHQ1nVXy7/woFrbici6QDBUTCUmXX3XCojmq50s3iUH8tm
        Y+OWwcaC8oP4h2r2UuOmjpXDQyqD
X-Google-Smtp-Source: AB8JxZr2mKYTsTxxgLpKOrg6KasNBrHpAapXWs9gstOOhut+SzX9ePlWPHWWsU/pD7D23ri324FNbg==
X-Received: by 2002:adf:8607:: with SMTP id 7-v6mr11323273wrv.255.1525176461172;
        Tue, 01 May 2018 05:07:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/12] config doc: document core.disambiguate
Date:   Tue,  1 May 2018 12:06:50 +0000
Message-Id: <20180501120651.15886-12-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.disambiguate variable was added in
5b33cb1fd7 ("get_short_sha1: make default disambiguation
configurable", 2016-09-27) but never documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..14a3d57e77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -910,6 +910,19 @@ core.abbrev::
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
 
+core.disambiguate::
+	If Git is given a SHA-1 that's ambigous it'll suggest what
+	objects you might mean. By default it'll print out all
+	potential objects with that prefix regardless of their
+	type. This setting, along with the `^{<type>}` peel syntax
+	(see linkgit:gitrevisions[7]), allows for narrowing that down.
++
+Is set to `none` by default to show all object types. Can also be
+`commit` (peel syntax: `$sha1^{commit}`), `committish` (commits and
+tags), `tree` (peel: `$sha1^{tree}`), `treeish` (everything except
+blobs, peel syntax: `$sha1:`), `blob` (peel: `$sha1^{blob}`) or `tag`
+(peel: `$sha1^{tag}`). The peel syntax will override any config value.
+
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
-- 
2.17.0.290.gded63e768a

