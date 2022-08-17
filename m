Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61840C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiHQGdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQGdw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:33:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485755722C
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so3333220wrq.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=XamFfe9m2oJ8n6Pb15A7D77lObBiioxBXlljhTJ8Uh4=;
        b=WMw5oH8RujNBCswsQ85TmqbIi2NngfH0yA7pSKCEH/ksmELCYWPUO4F6GI/k51K7xU
         j/Mxlm2SI5JY1mnKfaqVsoaDFAvCpV/128lyYvKydp2Vufp/Ieoj5Y4saTxObwYhK0az
         kzAdd3CzsJ3kmbssR4WnjDA9JFJmLwCzNaH2/EayGpbdbnBpvOttRQAtaVVqg0XX9UgW
         jomg1WdBIOyopbRAUafMKwlvNJJLCy28CXHPQvG4UWLm6W4gVzrjsPbc9lLced4PTYrS
         Mu+OsH29TiBiPFa/hFgPVqV/VR9JGHW52NXH25aIpyXJ5lB9jSDca08V9PFISQ0+wpRP
         aJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=XamFfe9m2oJ8n6Pb15A7D77lObBiioxBXlljhTJ8Uh4=;
        b=c1nOH1NlBN1+xnGveeZYdgx61irmZzH7zxhHvhMgB04BVxvpgsfKs+kT+B3WKu2Y9r
         Ci3+AZ0FbIqcRZna28MEEdeJkeCk45QI7Lv5nBw7hJ3kIvwuL5KXF6IF9f/sXw1loyZa
         5ZhjwtINAD3zBcqaVYMlx4PxQiKkWUnDaEnlHcK+ID7WCTFIVEtvzRMQBjIE2Rf9za13
         CK0AzPMUh/zdstudR9jzqRx8fgE4Sxk9ey6pYCZvkJJhmR4rg0HKp7+GCubuW5E3kfTP
         jR3GFTbzZQbigtTL/UxZRVqeZYLxqSwBBwhH2XlIpCcGRVrjyNXiFwNYUt4urBV0Lmtf
         KTIw==
X-Gm-Message-State: ACgBeo390lClb2Q3h0b/HNSrBdibHwCBDrc1yP05wMvsoi7meGvVPqRa
        e1BPY7gQXgNGMBKnMQ9vi2ZCFSQ+kWg=
X-Google-Smtp-Source: AA6agR7uqlnjHRzKC/55HwzVUaokyQ7gKBdgjQyDx0Nl7bFMlPNJbYoF/ZczA3WRRS51l/YMc599JA==
X-Received: by 2002:a05:6000:a09:b0:220:638f:3b4a with SMTP id co9-20020a0560000a0900b00220638f3b4amr13393527wrb.626.1660718029588;
        Tue, 16 Aug 2022 23:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d52cf000000b0021f73c66198sm11997175wrv.1.2022.08.16.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:33:49 -0700 (PDT)
Message-Id: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 06:33:45 +0000
Subject: [PATCH v2 0/3] Fixups for cw/submodule-merge-messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few issues I noted in cw/submodule-merge-messages (which
merged to next a few days ago). Sorry for not responding before that topic
merged to next; I caught Covid near the end of my vacation and it took me
out for a while. So here are a few patches on top instead.

Changes since v1:

 * rebased directly on top of Calvin's patch, allowing Junio's patch in
   cw/submodule-merge-messages to be dropped.

Elijah Newren (3):
  merge-ort: remove translator lego in new "submodule conflict
    suggestion"
  merge-ort: add comment to avoid surprise with new sub_flag variable
  merge-ort: provide helpful submodule update message when possible

 merge-ort.c | 104 +++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 70 deletions(-)


base-commit: 4057523a4061092e9181220d54dca9eadcb75bdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1325%2Fnewren%2Fsubmodule-merge-messages-fixups-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1325/newren/submodule-merge-messages-fixups-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1325

Range-diff vs v1:

 1:  46c9b48871b ! 1:  374278c6a1d merge-ort: remove translator lego in new "submodule conflict suggestion"
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      -	}
      -	strbuf_reset(msg);
      -	strbuf_add(msg, tmp.buf, tmp.len);
     --	string_list_clear(&msg_list, 0);
     --	strbuf_release(&tmp);
      -}
      -
       static void print_submodule_conflict_suggestion(struct string_list *csub) {
 2:  269714da706 = 2:  340c0f46f74 merge-ort: add comment to avoid surprise with new sub_flag variable
 3:  010cf4ff344 = 3:  80207d18334 merge-ort: provide helpful submodule update message when possible

-- 
gitgitgadget
