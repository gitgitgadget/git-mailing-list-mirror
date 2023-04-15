Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F9C7619A
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 05:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjDOFIg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 15 Apr 2023 01:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDOFIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 01:08:34 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B654C2B
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 22:08:33 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id e9so15822831qvv.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 22:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681535313; x=1684127313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1afbuFWlyxB91mPaF3RJjLm/tOmldXzmxWkFwrfHEk=;
        b=cUkrAM8zfRAqMaaUdsJDMhqCeHw7C/1qmsb/e0GkeUUTESenZOq0cnUAAlNBVEli2W
         aEll58RleDkyIhIPFsXawpKYMT/hBmSmU1oSJVikR8JYNMSQo35ttnGjMpIqFSpnKKEg
         zlWGNpDMQgalhRUsrVXKwni0b9PtUK8w8S7MzaSIr6F+61cjGaZp5mGpzj1w7K5f2wkn
         hEMGb2j3uWzDUuRTWIgVhFb+a+hM+J1pAvvq9pr84WudyFo7YTEYONQC4xxy/MP+TjdD
         ID0K3vhPpyXTSTAM8UIt+76nylFX2yOaNJ879JmB+HMxfNyowyb6pOWOVFEaorT/JUTn
         PPrQ==
X-Gm-Message-State: AAQBX9c3i2ncbouwbR9v13ucUv58dHCpNhkSrEiMVf3sXWyvH36NMtz7
        lefO1qfRlpMgO1Th1HZ1W8R/L5AOkL/UfOEqZpM=
X-Google-Smtp-Source: AKy350ZGyexFuW5o5uRF3zCJr9O5Schm+VDMK01K2nDdOLezG42Yj7j/neG2h9PeV2TyXZN42oyT5xc4mSuQXrigXXA=
X-Received: by 2002:ad4:5c82:0:b0:5ec:b527:61e2 with SMTP id
 o2-20020ad45c82000000b005ecb52761e2mr8905894qvh.48.1681535312742; Fri, 14 Apr
 2023 22:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com> <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 15 Apr 2023 01:08:21 -0400
Message-ID: <CAPig+cQQVby2g+_kfucbYdwOZW5_CEyyyOex=4hXoCJt7TkjeA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 2:13 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add some documentation for AUTO_MERGE in git-diff(1), git-merge(1),
> gitrevisions(7) and in the user manual.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> @@ -1343,6 +1343,33 @@ $ git diff -3 file.txt           # diff against stage 3
> +-------------------------------------------------
> +$ git diff AUTO_MERGE
> +diff --git a/file.txt b/file.txt
> +index cd10406..8bf5ae7 100644
> +--- a/file.txt
> ++++ b/file.txt
> +@@ -1,5 +1 @@
> +-<<<<<<< HEAD:file.txt
> +-Hello world
> +-=======
> +-Goodbye
> +->>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
> ++Goodbye world
> +-------------------------------------------------
> +
> +Notice that the diff shows we deleted the conflict markers and both versions,
> +and wrote "Goodbye world" instead.

Some grammatical problem here. Perhaps s/and both/in both/, or maybe
just drop "and both versions"?
