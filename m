Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E2C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50EC22B2D
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgLDPAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgLDPAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 10:00:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41826C061A52
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 06:59:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i2so5612999wrs.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lyMGTIcAwMKCLGQxmgUWBsQFKQq4LVBsXRCxfpktFRQ=;
        b=m3yDyGTkCgkfIe8WyLTbRBsTu8VIMGp3H/gaM8/7JIOv/OfXX35cAUvOOVwZ4PBOBF
         HWqKhrI4AgWxg8UwVnyTYk+RCieEENiw//fVUlOSKm5ye0GWwlhQewS8e9/AzqYriGTD
         zri0UWp/0lxVxrLnU1wH/oPtokDDy94h3voEcutLExcWB09awok2xFwW8QbGODi0R8Vm
         vEQ8h3AB/+Q49wXXtj/7OnA2OoZ3fPW3MkpQSvCFT2TshhodFcGrvfJh1d16As1WFNIR
         iGRtmyn4dY2/QL5mLKDXArk5jWf9J6i7Qxx9r+HbodkC98zvmU0qXOCOG0jPqK/gCB7Y
         ehNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lyMGTIcAwMKCLGQxmgUWBsQFKQq4LVBsXRCxfpktFRQ=;
        b=XxlzLtOxe/nXbcEKAy4ZKrjxEi+vzXF7eUwaCXWggmgOBeHHN2PbdNnV/FtEg35CPT
         duYWl96jGY7ryjDqPDlLSZipqDgwPoo+aX3ZjST8bsMJsDUCO/gclaG98bGUvo4nOnMj
         3RXMI72bOiWrjQeX9S8ABLGyog0DLPn7Tjy5NL3Iu0uJP4aYYR1gzmCobXvKtlTLfWVD
         YC+pTtYOPEc3PTJ0ZpEMpYOnGvrm5VHIM/Fl19X3+ebkTogj+OZ0q0R2PZD+55ib5RCB
         qjQ+m9ajWxk1tw1CeX7g/R9NioVi/FRgF5Ng3c5XaNR6fDOaFliHdJKLHD/DQ6NS+2Cu
         sH8g==
X-Gm-Message-State: AOAM530ib7CIYvKjbONTfdKyeo2nTUj+VnIVdtB007N/TLky+GeVyHBQ
        mriGDCxX7b28aDCrzwtiasNaYBJVJjWt+zXP8Nju8RVCqUcOVw==
X-Google-Smtp-Source: ABdhPJzPH2EvhOBA+oRFXtAmuk/pU84CWp0kZmO09Dgas9qUypV4qf/P8yiecA+U2G4PJzc1XbGk5Uz/Wujd+WjzXPA=
X-Received: by 2002:adf:9b9b:: with SMTP id d27mr2579147wrc.125.1607093979714;
 Fri, 04 Dec 2020 06:59:39 -0800 (PST)
MIME-Version: 1.0
From:   Sofia Syria <sofiasyria@gmail.com>
Date:   Fri, 4 Dec 2020 15:59:03 +0100
Message-ID: <CAOsoBv7ors39UzVgq5VcqEwoaEbkXb5ApEf5NqW4bo_fymdruQ@mail.gmail.com>
Subject: diff-filter can't identify renaming if not done directly
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

quick question about using diff-filter in linux. In the scenario
that in my repository, I first copy file1 to file2, then move file2 to
file3 and delete file1, "git diff" returns:

diff --git a/file1 b/file3
similarity index 100%
rename from file1
rename to file3

 but running "git diff --diff-filter=r" doesn't return anything. Only
flag "t" will return the change. Can this be considered as a bug?
