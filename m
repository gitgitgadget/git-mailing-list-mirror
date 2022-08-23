Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E956C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 03:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiHWDGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 23:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbiHWDEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 23:04:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975B2AD0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 20:03:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g21so9388334qka.5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 20:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+0ockHHSbp0PKWr7qWrgMdIu2VQPQpGofgv32V1C3hg=;
        b=obSVvl3HtsTS0SfBfCDNukhnT4Sguv8WmKFvop5pXoWyOEjxTs8MNeRC3A+2qREYJu
         nVKZFQZH/nevwnX0kY2BQSTFc5nk13+/DWj2B6c2SD93DcX9ssudj0wwPbpd6Udnxelj
         9SXppWN63geSBuDmOP5kNrVzeL20BGr+Cm+3aJLBAy3qQyKtYSJ+FbWY6e7JZATbqhgd
         NqxawVsCkm3Cvl/NwN2IblTexuGJTdfCub5VzmHDR7Qas3qD1sxiH0+ZhMLJYYwz1JzY
         uOmxjXHntsgrExEDA7Vxxil9Gi/uq28MRJGGqdvJzmajS67v3afHQ5KW1Y7ECxcUEhPn
         HTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+0ockHHSbp0PKWr7qWrgMdIu2VQPQpGofgv32V1C3hg=;
        b=BGmkG9XIAfPbEYmvAt0gWxgBEQADN0691YhapJls/MRdrq1pBYmn7dnjxbL6OFAQz6
         8z3tUBFJDSjYDOUcokp2cyR/PnrMgYF9GFOx1306qcBINO4gVEjy79TWw3IPCjizhIK2
         4Ddnmw+PLIEGBUvSTlDAaEfcRvj2gTpIx1FoNTWq6iYzWwvwj77QnrLxyzesZqYeGaRN
         /ja8Skprbol22GktpJaQCq1MT7eVjGknC8zHSaDBTMua0PKi65QWaE+qLDyAQ7ZB8SZi
         BS2L2JcPbiloXUu7nJHVUNUWGiIPIBzSSdduGK9dzFjYt2f6GuiyK9nqjJsJO0/nxJrc
         b/xg==
X-Gm-Message-State: ACgBeo1SAMFcySOn3ftu6zVMtrcmnkslwJ6/tBPq9DuN2LAAg3bWYeiC
        S5Du4iiNpC30MP4KXyz+Zw/UWE7cZR8qIJfIMX8=
X-Google-Smtp-Source: AA6agR4jViA1IbiiqUlw+iX1c2P3OamDVGhJeRrbdmIBaShcBB+0dbG0PvQLbHhGtwYxTzvtnrc3MN50HWcrGKsUEiI=
X-Received: by 2002:a05:620a:444b:b0:6bb:238a:2454 with SMTP id
 w11-20020a05620a444b00b006bb238a2454mr14569912qkp.183.1661223791408; Mon, 22
 Aug 2022 20:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com> <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Aug 2022 20:03:00 -0700
Message-ID: <CABPp-BHcRQatt9F2Hj4ygUsS9y8_BmfN3K=YFrLEnCn+2WLz9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Miscellaneous merge fixes
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 7:42 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> While working on other things, I noticed a few miscellaneous issues in
> builtin/merge.c. Here's a few small fixes to address them.

Sorry, forgot to include a high level summary:

Changes since v1:
  * Fix play/apply typo, spotted by Eric
  * Almost completely rewrote patch 2; it's now merely a "code cleanup"
  * Added a third patch, just a very minor code simplification
