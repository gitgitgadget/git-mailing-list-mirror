Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F05C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 23:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKCXFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 19:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiKCXFF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2BB1F601
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 16:05:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2196770wmb.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i65fCnOmQPFRDhf01XDHyInLnFpziJrntzGVUJlcjBo=;
        b=b3DbTOSyq5ykhi8Wxg1DJhi22ERKIj6WXYL0T8FU6tmsLjaGEXas80bu0nJK217X0x
         mEgrNRCpsMyVcDZb1lOmkchfXCe54jqxlVZif5N7lsEr1J+N94ImGZn3K4bu/jGjisDI
         wbszkubXldPaau9vqzc+JWX2s33nww3ZDlA9Y4VxXbfCfwuH2d5gbAAGxo8/e9oTjNRS
         PNzqeWDBo2KwePavuGaiC6C5nt2mdAS3NwJxGkM5rDF7udVvmPKIbX62j0JPYD6mSfDh
         NadYHxTynvZoqVLTiT/iy9FWFKnHixul8tnocEldSmnMPBXPdqfTEgexorbGWEfzLGki
         2JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i65fCnOmQPFRDhf01XDHyInLnFpziJrntzGVUJlcjBo=;
        b=6qnj6pp4DgHmnkQ9r4SaTMnYg0T6rN2yL5mRqIZY4dAO9Ur8fGI3ajJp35bJzvOEwA
         Y9H+JLBD40fz9diVFlXxjOGzyZEIhWXQt3wD/HmXe78q7gxGOSYd3FPZoedm7kQ84oaN
         wBqnXo7bKbq1gy+y3RaUSsPSVO4W8YM1pDfm4DxTUkRtHsadTam8j/lBhaC4I7hkSb9a
         UpFzPoKjQ/YrNOVkNp1rqrNzhex/QFpjc35W5wv9/RRYd5QSPmQd3umAEgVewrilNWuZ
         alk5mod5YEPFbOZLA+mSH8qASdQXuViM8Q30hDPcT6womnsEYuQ+0yZhaJ2BO/2zAq7I
         JOKg==
X-Gm-Message-State: ACrzQf1J0Xhu+zKW0mc2SBICNl3MOYPS4NMxy7j3hhIlUJw0I0RPiW3z
        Watyb6D43d7AA38kuV8M+x2snPiKEo4=
X-Google-Smtp-Source: AMsMyM4pzhOW6Uk8falLLeP42dE1e/nHSVIXy3zhnksTqqmGGlXdCYwo1Q/hkMQfu3XbMXqztIs5Yg==
X-Received: by 2002:a05:600c:1d91:b0:3cf:7b89:669f with SMTP id p17-20020a05600c1d9100b003cf7b89669fmr12660357wms.155.1667516703237;
        Thu, 03 Nov 2022 16:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7-20020a056000136700b002356c051b9csm1864518wrz.66.2022.11.03.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:02 -0700 (PDT)
Message-Id: <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
In-Reply-To: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
References: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
From:   "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 23:04:59 +0000
Subject: [PATCH v4 0/2] index: add trace2 region for clear skip worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Anh Le <anh@canva.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In large repository using sparse checkout, checking whether a file marked
with skip worktree is present on disk and its skip worktree bit should be
cleared can take a considerable amount of time. Add a trace2 region to
surface this information.

Anh Le (2):
  index: add trace2 region for clear skip worktree
  index: raise a bug if the index is materialised more than once

 sparse-index.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)


base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1368%2FHaizzz%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1368/Haizzz/master-v4
Pull-Request: https://github.com/git/git/pull/1368

Range-diff vs v3:

 1:  d0d9f258b08 ! 1:  33e9b2afd91 index: add trace2 region for clear skip worktree
     @@ Metadata
       ## Commit message ##
          index: add trace2 region for clear skip worktree
      
     -    In a large repository using sparse checkout, checking whether a file marked
     -    with skip worktree is present on disk and its skip worktree bit should be
     -    cleared can take a considerable amount of time. Add a trace2 region to
     -    surface this information, keeping a count of how many paths have been
     -    checked and separately keep counts for after a full index is materialised.
     +    When using sparse checkout, clear_skip_worktree_from_present_files() must
     +    enumerate index entries to find ones with the SKIP_WORKTREE bit to
     +    determine whether those index entries exist on disk (in which case their
     +    SKIP_WORKTREE bit should be removed).
     +
     +    In a large repository, this may take considerable time depending on the
     +    size of the index.
     +
     +    Add a trace2 region to surface this information, keeping a count of how
     +    many paths have been checked. Separately, keep counts after a full index is
     +    materialized.
      
          Signed-off-by: Anh Le <anh@canva.com>
      
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
       		return;
       
      +	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
     -+											istate->repo);
     ++			    istate->repo);
       restart:
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce = istate->cache[i];
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
      +			path_count[restarted]++;
      +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
      +				if (S_ISSPARSEDIR(ce->ce_mode)) {
     -+					if (restarted)
     -+						BUG("ensure-full-index did not fully flatten?");
      +					ensure_full_index(istate);
      +					restarted = 1;
      +					goto restart;
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
      +
      +	if (path_count[0])
      +		trace2_data_intmax("index", istate->repo,
     -+											 "sparse_path_count", path_count[0]);
     ++				   "sparse_path_count", path_count[0]);
      +	if (restarted)
      +		trace2_data_intmax("index", istate->repo,
     -+											 "sparse_path_count_full", path_count[1]);
     ++				   "sparse_path_count_full", path_count[1]);
      +	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
     -+										  istate->repo);
     ++			    istate->repo);
       }
       
       /*
 -:  ----------- > 2:  91ad7973307 index: raise a bug if the index is materialised more than once

-- 
gitgitgadget
