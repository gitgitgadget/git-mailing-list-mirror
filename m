Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52403C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BACC61400
	for <git@archiver.kernel.org>; Sun,  9 May 2021 07:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhEIHbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEIHbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 03:31:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B709C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 00:30:42 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i81so12967540oif.6
        for <git@vger.kernel.org>; Sun, 09 May 2021 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sc3d.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kXyUx6sgluLqzGLkhpx06LRqaN3koMmNWGlCgp6aGaE=;
        b=dZmLTH/4q850q8m9X36UUj64/Z75uKArpTGiyMcGpheGvINbuxOV7cfUNXEm847pWz
         AFVHJhuMrAnoakKIGcLjppGe2FFegzzhScQW8UY+vmuR5kGh8ISlYH7SldSCOd3N9USg
         nSzrUtmjXK0GwagmYIUK333h+8/qThGj5PMVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kXyUx6sgluLqzGLkhpx06LRqaN3koMmNWGlCgp6aGaE=;
        b=eXW+LvIi+7Yh0ocUJQPJ4XOhq0FoGeCuISmo6DSEVdqkwGxH+X4mP+AJMeiHvlDh1O
         6+c4kFRb5Lmn4/MP8sW/3BSnKDG3EBCo2f+5HIQfuf7toNKza0xGMmbNp0mtzFf2NSsL
         p8Wxe7VzJf936q7u5ep2hla3tNtOhxAL1Z6nKYZh8FA6VURDoymnqHvAe4Ul8HnQ7vXb
         RETg0bdcMQJ4oYQLO1QRSM5FAeS0upX15N2tVJLTII/QEtP4LLi2yamo2+VSruZmicXW
         CyAn3TeFeY5/hrDt5JxKDqCgCTfNIuUEXLYsV97a0B77ege6YWwiJx+uLVEZbfUBMPc0
         RIgQ==
X-Gm-Message-State: AOAM531ERMRv1kNfRM8zGNIHK7uG7hJr1O0dAWzeSGJvrmD0iqxVkBpB
        GE67jM3SeK8HRf1vjA0CWZEKXHNz9O6SQIrKhT26fouqHKE=
X-Google-Smtp-Source: ABdhPJy9je74hoyLpGHZgD9/+OJOvLxiqBzEXJYwc66b45KlUCfRudbxCu3kBA/WLlhnclFQkUVwpAdYuF5AaI7c9qM=
X-Received: by 2002:a05:6808:d50:: with SMTP id w16mr5701751oik.62.1620545441797;
 Sun, 09 May 2021 00:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnWdogqShYMmZLAYvGnKVLdxPj8fYy4a2BZ-Mhe-kSKqQhv9Q@mail.gmail.com>
In-Reply-To: <CAOnWdogqShYMmZLAYvGnKVLdxPj8fYy4a2BZ-Mhe-kSKqQhv9Q@mail.gmail.com>
From:   Reuben Thomas <rrt@sc3d.org>
Date:   Sun, 9 May 2021 08:30:31 +0100
Message-ID: <CAOnWdog6k04pPdK1+n45x=+dXpSsqC_FUZhCBJqcAEd=n4dZpA@mail.gmail.com>
Subject: Fwd: git-cvsimport documentation improvement
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-cvsimport docs say:

WARNING: git cvsimport uses cvsps version 2, which is considered
deprecated; it does not work with cvsps version 3 and later. If you
are performing a one-shot import of a CVS repository consider using
cvs2git or cvs-fast-export.

However, I can find no trace of cvsps version 3. The latest seems to
be 2.2, which is marked as a pre-release, and cvsps 2.1 seems to be
the most commonly packaged version.

I understand that it's still better to use other tools than git
cvsimport, but perhaps the warning could be better worded; for
example:

WARNING: git cvsimport uses cvsps, which is considered deprecated. If
you are performing a one-shot import of a CVS repository consider
using cvs2git or cvs-fast-export.

-- 
https://rrt.sc3d.org
