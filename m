Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D548C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiCNGfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiCNGfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:35:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8E1EACA
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:34:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q29so11918547pgn.7
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nw/kSoZP302n4PgI314Zad81/xD9ociAxyC2gTe77Mw=;
        b=WVaP8mBXnSWIaTiq81hTrhMvqpJkC6PCSqR7gb3yrRk1lA8rOrAmzfzJXAZBDJwizp
         sToXximaTZ+EcKFiPZMf9uv/3ZBX3NMmxZMivEb+uEn5UBkp8F50R4xnayEmHyMickJS
         3rpyD9EHb2W+D5Ef+Atw2m9U8RhMic0cbF06DneOcIysu9LZdZxpgLM67hR59+E44abV
         9k1VE33+uMETApqVi7wC5mOmpeUe2DLmibPfD8ZUzwzoYWaEvvvoZ3gcGszvoBxhddk6
         DtkENoZnftcUwnQ+BM20PTitczyXDh+d7snTp1eJnK2u7hQpzicvElbeP88Ms4TRXbYO
         Bmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw/kSoZP302n4PgI314Zad81/xD9ociAxyC2gTe77Mw=;
        b=OPw6ytnQ3Sekpn9oTdopH3OiFG9aY5SPU0jKfJ9+2w1sqlLRw6uXEXvwN/jDjWbZgF
         e+R9E1pX0a6jilOS7wvNZpXeFxuRBhjwKp/xUOWH3Kg4G6JV9Ffv4wyfI1c/WWgA9cw1
         tRjGEMcc9HqZQQ5ewc3F/Fr5OVb8J66kWPJN4Ou2rkv6byU3u+ipBAlNXDjiXYSr3X7U
         GsX3B0iMxzEGwU7vGVR6yVSXWyMJANG3gMhxQlPP09ffoG/wGv9IjZlbImVNXmy0yEor
         NtX6SuZn+PqfVkN3QecEcwuxxUeGK2h+feDLeElS2Ek6Vz0nOf7m7IlWzr1FkTX++oSs
         /EnA==
X-Gm-Message-State: AOAM531uQ2We7VaZTKTgynFIBnmUl9BsxcaI2Ya0IbkOlrODeLG3CMJv
        fLo8PgA0Y3hkWe9/WN6EPiw=
X-Google-Smtp-Source: ABdhPJzjOKa2Er3XRNCu4HFrJpeAWVK4TTQ6KrXKtoeg/hvOeWpw7wuQXNIzsM9/9TlK0Mp5AsoJzg==
X-Received: by 2002:a05:6a00:170a:b0:4f7:918a:1eac with SMTP id h10-20020a056a00170a00b004f7918a1eacmr14216613pfc.16.1647239680600;
        Sun, 13 Mar 2022 23:34:40 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.242])
        by smtp.gmail.com with ESMTPSA id kb10-20020a17090ae7ca00b001bfad03c750sm16466566pjb.26.2022.03.13.23.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:34:40 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     derrickstolee@github.com
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, newren@gmail.com,
        vdye@github.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 0/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Mon, 14 Mar 2022 14:34:33 +0800
Message-Id: <20220314063434.81895-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Updates Log ==

Changes since v1:

 * rebase on Elijah's v2 [1]
 * move OPTIONS to after COMMANDS
 * add two sub-sections under option '--[no-]cone', one for command 'set' and
one for command 'reapply'
 * change the command indicators from this style:

  Use with ['set'|'reapply'].

  to this style:

  Use with the `set` and `reapply` commands.

== Overview ==

Add an OPTIONS section to the manual and move the descriptions/explanations for 
these options from below COMMANDS to OPTIONS. 

[1] https://lore.kernel.org/git/pull.1148.v2.git.1647054681.gitgitgadget@gmail.com/#r

Shaoxuan Yuan (1):
  Documentation/git-sparse-checkout.txt: add an OPTIONS section

 Documentation/git-sparse-checkout.txt | 106 +++++++++++++++-----------
 1 file changed, 63 insertions(+), 43 deletions(-)


base-commit: 4b89a3392b04acccf28f09f90e26715140461373
-- 
2.35.1

