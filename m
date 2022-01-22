Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A5C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiAVImP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 03:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiAVImP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 03:42:15 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4024C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 00:42:14 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id b16so21178406uaq.4
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+cLzd4l0hL9+x/0HQdzi0aCHSVikmECAgIBkn07Jl4w=;
        b=OXoRMDxmSvaxWFBfWrodkphQPP/HFP0JnnaGDF3OLwXF+0l0WmVlKZaG3CXey3BSbp
         98kgIehFjkwBGW8gayAwIrjZgBMd/HL3dWyCmlvDJt7kHGrXa6W66UFfvjPrYYNMEePU
         F9MRujZhTFzMLoaYXG1LBYcYxWua15y0ORzIBbBdQdO4ZQP/2tFLcjR1kI3j3BlfPStK
         yUtOm69zbOtFr4YbthhyIUuShSLe00RCsNlHMBgMFi/keaInsj3CMQQCQTO8VLmmq4zW
         LiUXP2LWDzTIOD4k+e5tmb5dM0S6XCbELfA4zB0HQoGihmOc/VX0Etjv6VO6s8bB+DbN
         C+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+cLzd4l0hL9+x/0HQdzi0aCHSVikmECAgIBkn07Jl4w=;
        b=in9rdiK5aJVlCozxn4QbeYJ3MhFHKx7mZZRselqQSjhusGQPqEY79CbvvmGiUuJ2ZN
         T2t2ZtGz39uxw19LElUd5261dk+AEpIQVfElghuviN8mQ7Moke+U2ArvI+msTF5wExXH
         FfVH8U6Rc9T7ob169YMaRONAl9UTdmFWgyRb9a+NryMvpAcW1NLjIVMyQoPn5I77cWqp
         g//U0pcdXZ8gtDMw6A9xdc4HmxGEx1sk+CsOUcM5HTCosqky2f10xBsqtqq74MLz8AM/
         WTaX9Dyv9anjlgEZGAgcPHu4uDmFjmhibvBKIZYKxbhpQdv/fJH/7Vaw04fNIlNpHYXg
         ujkw==
X-Gm-Message-State: AOAM530LV2k+RH4hZZPbAW5sXiZDiqI+uYIB8cmTI7zhxQE5yfN8Ej9I
        cB/qte4RoznQswJjkDduyMo7JAWXlnikVFtftY+dgmCXeiv9OM92
X-Google-Smtp-Source: ABdhPJzDmwbm91ONWHK6mOVCCThidwStaDxR5kTfdXUrtAp2z4ZIcKkItZjOSn/7EFZTfZO1TqI2AUez4R18tEb5Wc8=
X-Received: by 2002:a9f:364c:: with SMTP id s12mr3156911uad.60.1642840934048;
 Sat, 22 Jan 2022 00:42:14 -0800 (PST)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sat, 22 Jan 2022 16:42:02 +0800
Message-ID: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
Subject: Some sub-commands can't be completed by TAB key.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Ubuntu 20.04.3 LTS, I use the following git version installed from
its apt repository:

$ git --version
git version 2.25.1

I find that there are some  sub-commands can't be completed by TAB key:

$ git <TAB>
add               cherry-pick       fetch             latexdiff
 pull              restore           status
am                citool            format-patch      log
 push              revert            submodule
apply             clean             fsck              merge
 range-diff        rm                switch
archive           clone             gc                mergetool
 rebase            send-email        tag
bisect            commit            gitk              mv
 reflog            shortlog          whatchanged
blame             config            grep              nbdiffdriver
 remote            show              worktree
branch            deborig           gui               nbdifftool
 repack            show-branch
bundle            describe          help              nbmergedriver
 replace           sparse-checkout
checkout          diff              init              nbmergetool
 request-pull      stage
cherry            difftool          instaweb          notes
 reset             stash

As you can see, there are some sub-commands which are not listed in
the above list, for example, the following ones:

$ git ls-remote
$ git ls-files

Any hints for this problem?

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
No. 473, Quannan West Street, Xindu District, Xingtai, Hebei province
