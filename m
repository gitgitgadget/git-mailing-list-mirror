Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201DF207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdEBBCp (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:02:45 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33841 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdEBBCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:02:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id v1so52293348pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyioRPGf7UbHQJ8lhoakXQ7/ZnlbIa2fub2T7c3aXKo=;
        b=sm7V+vkP6mNkmVcVFVE99IGPAXvvPRHso5GM+vshK3cN9HpDnQDNZq36sRYnUHifZ+
         5qOv0XPKEBT21tNMiMQYgLuQtnJUN2JtafL0euhZ5BbYHpbBvRGH1aCSXNNPYSizuRW1
         dcepmYvpotmbgEa0ENzyCKGCjCT2/N6eeeYipm/TfVrEb+zeRCEHf5z/4YQf8GCHexg8
         dVvgoK+vYmsp0TsnWGvgQ56SqUUQzUP4srLc8o1nvVpHAMlNKZvLM0ZZGBFLaKttZG1h
         q2OWd6dwDF3TNgQ+uVFVZlsTfErafztH+2uIayLYjua6aqtB+AP+OkYGD6fl3a4EHXWA
         7X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyioRPGf7UbHQJ8lhoakXQ7/ZnlbIa2fub2T7c3aXKo=;
        b=DU0/23rJGtbYHS10wTfbpVeVNVxu3uCE7HClJQrDdy7BwSHdX+LUrTmTvUiIivthBF
         LVyJjNR9w89pOBD+WladhpCiFo4xU9OfTRCNS1vHWmngVP4k4TP61Z/bKWN3V1lIk6pz
         tcuLMqB05YKZbhg4H5Ul7usutXdC2ff10/TiW0RNnNu1NFfU8Rmr85rJfO8paxGpEtDr
         VHqND1GStWsNf0yqDB9cbLIaJpjrfnTt3PQ0FVFlFNxJrskrdk8vvhbA/NFxttvyagTj
         E//wDAJ31US9qiOZM60bNI5RCVF3KuPs5JRl/wG47bvlPLZU0GO1zbU847347zfjfTT8
         CjNg==
X-Gm-Message-State: AN3rC/69+2v3mpSLPtzqP8/mF7R/ctKyF++XV+2EEct1cjsCP2dIC/oP
        ZWmpyF9IwvXQ0xDZ
X-Received: by 10.99.43.199 with SMTP id r190mr9984453pgr.131.1493686964290;
        Mon, 01 May 2017 18:02:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 0/6] changed submodules
Date:   Mon,  1 May 2017 18:02:33 -0700
Message-Id: <20170502010239.179369-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170428235402.162251-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
- few tweaks in the commit messages of a couple of the commits
- use 'GIT_MAX_HEXSZ + 1' as the hint size in [5/6]
- added a comment in [5/6] better explaining the rational for having a quick,
  incorrect check for the existence of a commit in a submodule.

Brandon Williams (6):
  submodule: rename add_sha1_to_array
  submodule: rename free_submodules_sha1s
  submodule: remove add_oid_to_argv
  submodule: change string_list changed_submodule_paths
  submodule: improve submodule_has_commits
  submodule: refactor logic to determine changed submodules

 submodule.c | 305 +++++++++++++++++++++++++++++-------------------------------
 1 file changed, 149 insertions(+), 156 deletions(-)

-- 
2.13.0.rc1.294.g07d810a77f-goog

