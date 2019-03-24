Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A97D20248
	for <e@80x24.org>; Sun, 24 Mar 2019 10:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCXKE5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 06:04:57 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45785 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfCXKE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 06:04:56 -0400
Received: by mail-ot1-f41.google.com with SMTP id e5so5527154otk.12
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0wcFa5KYZegZCXZ7aAQubb08xBi3I3xkGB6Bcwm3Qg=;
        b=c2ujBz6Ljl7i6wDxxhHN4AgRgvRtYzwFmbznAqxpRvNyF0/tOSLEKrGOcwBLwXnWrr
         GbaiYGIC7Uia8PG2itt9/H1MTBxWUyw86AY7FyomSxQuGuO8Qj9+PYh9DcnAbtu/8wkr
         h+6qjtmLugLbZTUOfy0mZUyhg76DfAxsb53fYoRy9yXM2G5Kqa91sjIufDYz5RbIZU9y
         K4TmYb8VWVrL01RYmogUHmAk1LYeWI1eYa1r5Tqg0Wyr2lxr8YxyrwUs5wmpG/fzbwF4
         Y0V17F0+6Ql+AAnVg1d1Y5Tacor/iIWP5e0Pp/gD+kI2p0hbQm7apBVuiFlsg0PBLZnK
         zeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0wcFa5KYZegZCXZ7aAQubb08xBi3I3xkGB6Bcwm3Qg=;
        b=gXvFSWjfOtjPoEt1XYRMvHALY2/M8bc/L2T8V6rUpOpEaLIcbLeoDoZGKa6U0Yookf
         P8OQgj3UhNpuw++gEluzulqiECgGeZM6Byi6Ai5AsB2MXhflqIY5+p8FPXb6kbGsNEoC
         nVirwYis9qDoDCqAzf1FTZ5itTx9ONXxxiQW+g0uW5pbqWMgkkUcdmpJ99gsvaeuDnNg
         7TAV1r0enb8TKuB5VbAmPmoiJki5RHdFHja6GI4V8bEHKAD566wzRlCPymMJNu95LM+y
         sK1IdHVNukO4cFPMJGlfOT4eMW4Fo5zkzBc3ZQf/U3tVhJc+PoZ82s0mYnV1z7OBAKGg
         byPw==
X-Gm-Message-State: APjAAAVMDtVkuE3IEeeEuLar+JVbV34NYbGm/UKYhgXujJ8PpHyvYcjj
        PHi2M9p2+4Nifxd1utvkbmLMkkUZ4fW7cy4jVsA=
X-Google-Smtp-Source: APXvYqwVa7wKj4zDOU2Or3WA9Z/nVgKG8YzsZc1htc/LtSVHgonoxDxkj3KdQUyI/nHik0Tcy6P7pj6TWG5+uOvDnzQ=
X-Received: by 2002:a9d:7544:: with SMTP id b4mr14092715otl.326.1553421896197;
 Sun, 24 Mar 2019 03:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190322160615.27124-1-jkapil.cs@gmail.com> <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
 <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com> <CAP8UFD0cWSTZPqqVwTFyYL06S+6aT_EiLPW6jUE0AH9puxevmg@mail.gmail.com>
In-Reply-To: <CAP8UFD0cWSTZPqqVwTFyYL06S+6aT_EiLPW6jUE0AH9puxevmg@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sun, 24 Mar 2019 15:34:44 +0530
Message-ID: <CAMknYENJ+U4urtSEtwDSLpdwGe=x=uq_HdSs-cT9Z+PT5ZQiLg@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell scripts
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 2:49 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> The test_language_driver() function used to test the regexps is
> ...
> GIT_TEST_CMP which is usually either "diff -u" or "diff -c".

Thanks.

please provide some insights on the regex mentioned below:

+
+PATTERNS("shell",
+  /* Function Names */
+  "([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\([[:space:]]*\\)[[:space:]]*\\{",
+  /* Words */
+  "([$#@A-Za-z_\"\'][$#@A-Za-z0-9_\"\']*)"),
+

reference mail:
https://public-inbox.org/git/20190324084523.8744-1-jkapil.cs@gmail.com/.
please let me know if the regex is not self explanatory.
