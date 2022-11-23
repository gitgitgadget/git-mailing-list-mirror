Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5404C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiKWTOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbiKWTOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:14:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC618B0420
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:14:46 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so44900063ejc.4
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rsYGokz62lFC7cDFdmeLFvkIeZ2jTlrg520pcly9iYg=;
        b=RE7CYKsBxKrMy876wjbAv1BB4HGVtbBmZO/m+ktFCor/TVmRppl70g/uUfgoMyG8a2
         zSDViubnkozbXqFb8Ikj1odjk7AViJIZRIpK2ctjUD80Rmu9ISF/p6MorMoBg/tSGSc/
         /UhH3hf1C1WiE1ZEeovKCIhCyPvQ9smDsVlt72qMuFOYfbK5uOBYTHnk8mNSJDlsaFrv
         G5GiaGLCJK/KkkROFxXRAeXhJiNV58ew0qy3lQns5/5Ts4mC7+10iocH4Vt6Q5jVgWxT
         3QibaaT8bQvZhtlXrqQKrsqXx4+Wpu3xVAPKwf8ooa270wj2PldQvtYExm/K4yT6UJg3
         GleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsYGokz62lFC7cDFdmeLFvkIeZ2jTlrg520pcly9iYg=;
        b=IDFPxpImDfu3DrmB133eHYHXI4wx3dfu37eWwLx+4x/UrDgOFJS5GPsRowB8Y5NlS9
         CfpKSKvoBghpL34ZoaTChLNRk0xfZDQFTWUr+hcerjrWpuQvxW5t2+jSNR5mgG1AJIOR
         BLkqUnYU88gUCVXNFmNPCtmb+dxNo+rWK7GDDvVMdr3JUPcGH9IFjvUuxpcfxIo4jtie
         YpCJlYEk79DhQL8x81lsHp5xj4lYYeiJXpMbxTEHkSTaXqPE1IMqmPeXdtVG1Uu+R/RJ
         F3MHibN+gBmw8uY9v5PRTHN7eBjz/5X0RWG75eIqpiX31UeLQPIqX5zuL6WETpI5n2R4
         WTtg==
X-Gm-Message-State: ANoB5pnksbzsN/67Ss9vh2KdlEuHvlueZ5mlhkQvJgCoH+EpLZnd4lfW
        zgivFyJ6U8XCK149jCxNL2DzpCyJ/W0FkGIPKDyvv0ub
X-Google-Smtp-Source: AA0mqf4aCtRY9zmTsd/8mLxNslzIVJEkqY6kc0teTng4TZzIZXK6eiK44ZZD66uwAT479Nb3EDFFmhQnQj9SPw2ofv0=
X-Received: by 2002:a17:906:2c10:b0:7ad:d051:538f with SMTP id
 e16-20020a1709062c1000b007add051538fmr25373375ejh.401.1669230884887; Wed, 23
 Nov 2022 11:14:44 -0800 (PST)
MIME-Version: 1.0
References: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
In-Reply-To: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 23 Nov 2022 11:14:33 -0800
Message-ID: <CA+P7+xoAh3bFBEvVcRF8Xb-DxxWbbM=R0gWVQ6JsFCWtHy4SDw@mail.gmail.com>
Subject: Re: git download
To:     Vasilij Demyanov <qvasic@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 9:27 AM Vasilij Demyanov <qvasic@gmail.com> wrote:
>
> Hello everybody!
>

Hi,

> I have a need to get just one file from a repository, it would be
> useful to have a command something like this:
>

Ok.

> git download repo_url branch_or_commit path/to/file
>
> Or maybe there is something like this, I just haven't found it in the docs?
>

So this isn't something git itself provides. Various web hosting
services for git provide such access, because they allow viewing the
repository contents. Git can't provide this easily because of the
nature of the commits and trees used to store the contents of the
repository. In order to verify that you got the correct contents, you
essentially have to fetch the commit and all its parents. You can
maybe save some download space by using a sparse clone.. but most
remote repositories may not allow arbitrary commit hash fetching.

If you already have a repository available from some computer/system
you can extract the file at a given version via something like git
cat-file:

$ git cat-file -p <commitish>:<path>

where commitish can be a branch or a commit hash, or other way to
reference a commit, and path is the path of the file.

Unfortunately you will essentially need to have cloned the repository first.

If your project is hosted somewhere using software like github,
gitlab, etc, or has gitweb-like software operating on it, you may be
able to find an API or web interface that lets you extract the
individual file without downloading the repository. This is somewhat
outside the scope of this mailing list tho.

Thanks,
Jake

> Best regards,
> Vasyl
