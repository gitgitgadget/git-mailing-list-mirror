Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC02C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiCGVvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiCGVvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB37561B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so296739wmj.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=WtPGg9WKTkQ9iRRg+A6YF3QXSBg++nNVvZfhuVluol4xpW1TF2Bkx18xg+40QiUnEJ
         VrLdCYahnTSa6m5X+jajsS78d8ampBF00qBZl/KGDxIiF8OL0saCp63tAUL9XRV4RgYo
         o8jwjmCZ/Wl+XbPcAaDKepOQJ97PefC/ww/VeZ0jWtxDNDQ+aRne326j8dylj5zXtGe7
         EDFYD+69znfNgzGZxWpfi+iEFJcyKok7UrdqXPdcOvB4LxqMcC8JX73C9HWxDKKeUZFO
         KCRjZqVQr3awhsoO/fzC3ADwNT/NSrbWqkVpaCHvSgWS5GT10zPl76bw7ZRSGu+t90zO
         h26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=XlaeMhDZyxHf6uArJ+UmmmnfzIN/zZ0nWQSQJDx7UoFGmO9KuJtFQqEttZi3j8sOSX
         bdTSa4FxGEYC0hgsNpcpuYXRyAaaqobwVZyyR+lCcN4snrkjyeJxX3IRc+it0pKC2N79
         ftnnt2C80DGJp+/FPMB4MMoH+wVfTGbuWn5QVFFyTP5ExKa7K0tj34LWR5sxA3VE64fe
         oih/FRCuLpstfaCBBW26sG9GMFCWzwoeUoQKmCDcE71HgYzSaXnQIWKQqbikEYq9bK1a
         RgcLnXfN7+/4h28SxJ8uKNKAFyeMQEXn1KeUdfApMVgzrvSdhDRv6izNPNUESLqAZ0NO
         rIhA==
X-Gm-Message-State: AOAM533KjzHuUuS4HB9Ot1MTNE6DD6O7OXqfj4BeMTgOd5DxtxW+urCC
        Zl60t7CblISmNtFRbDl+5XvgS1Djtno=
X-Google-Smtp-Source: ABdhPJzs7xCzenv8rope5eASW0SAUK7SJnnUFTOEnjG6GnbqGgAoJd0MQg9cchv3SR69u2I68QPd9w==
X-Received: by 2002:a7b:ce0f:0:b0:389:a4eb:2520 with SMTP id m15-20020a7bce0f000000b00389a4eb2520mr822607wmc.9.1646689843331;
        Mon, 07 Mar 2022 13:50:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020adff382000000b001f022ef0375sm11954437wro.102.2022.03.07.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:42 -0800 (PST)
Message-Id: <a1eb4dceb0b1444427c0358948c57bafc513918f.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:29 +0000
Subject: [PATCH v2 01/12] index-pack: document and test the --promisor option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The --promisor option of 'git index-pack' was created in 88e2f9e
(introduce fetch-object: fetch one promisor object, 2017-12-05) but was
untested. It is currently unused within the Git codebase, but that will
change in an upcoming change to 'git bundle unbundle' when there is a
filter capability.

For now, add documentation about the option and add a test to ensure it
is working as expected.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-index-pack.txt | 8 ++++++++
 t/t5300-pack-object.sh           | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 1f1e3592251..4e71c256ecb 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -122,6 +122,14 @@ This option cannot be used with --stdin.
 +
 include::object-format-disclaimer.txt[]
 
+--promisor[=<message>]::
+	Before committing the pack-index, create a .promisor file for this
+	pack. Particularly helpful when writing a promisor pack with --fix-thin
+	since the name of the pack is not final until the pack has been fully
+	written. If a `<message>` is provided, then that content will be
+	written to the .promisor file for future reference. See
+	link:technical/partial-clone.html[partial clone] for more information.
+
 NOTES
 -----
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2fd845187e7..a11d61206ad 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -315,8 +315,10 @@ test_expect_success \
      git index-pack -o tmp.idx test-3.pack &&
      cmp tmp.idx test-1-${packname_1}.idx &&
 
-     git index-pack test-3.pack &&
+     git index-pack --promisor=message test-3.pack &&
      cmp test-3.idx test-1-${packname_1}.idx &&
+     echo message >expect &&
+     test_cmp expect test-3.promisor &&
 
      cat test-2-${packname_2}.pack >test-3.pack &&
      git index-pack -o tmp.idx test-2-${packname_2}.pack &&
-- 
gitgitgadget

