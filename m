Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A7E7545E
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbjJCSeC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 3 Oct 2023 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbjJCSdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:33:53 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199783
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:33:50 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-664bd97692dso8167766d6.0
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 11:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358030; x=1696962830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDyDrPaRe+SWNWmceG3Q28TNyp4ikk5JxrfVqYITZNI=;
        b=cmQRPlsee0cJpcUX3gsir7xGVaClYi5AkpGzfZU/3Dun/hZ56N9mltG88q/T8DgLx1
         3cDVltJZKaS5IrDwQUpXw0deATsNKPTPTQSZ1nUED0dvMjThNS7LTUVKaIhr8JpED9Nt
         P+bt7abjc+QDwaNDQkQVklfeRCHOjg/1mLkW4wY3v8gDejiiFeLo4amBEB1K5iK0a8MK
         v0dBMW8hqojqoIJNU/SOT87REDmE0gFe2D3XEkJSj8cM8kEimgQFZPj7iBi4uicoW3+o
         il8ovEFvevKMjLVjt1pGM25NB8HdWRMjaXFLEpoz2RjgCt9fJdi33HkvRBYq9J9CeKhi
         Ku8Q==
X-Gm-Message-State: AOJu0YxXxR2Pamfx85pyJXAQVPwaG6h6Tv5crProsJgQXmYv6tY0w+Z+
        ZoJ9YCSnG7gVQXqRvBC8p1TgfN4lUoouOoOl6vQ=
X-Google-Smtp-Source: AGHT+IHhUec92aAh/SJIIA6Ac39jwnIFdzrEIdszL1tnKJFHiDF8cgxdcikeBgnRe9gXUisHssEum7eZXOwsbvy8UwM=
X-Received: by 2002:a05:6214:459d:b0:658:8f94:5921 with SMTP id
 op29-20020a056214459d00b006588f945921mr175414qvb.59.1696358029935; Tue, 03
 Oct 2023 11:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231003082107.3002173-1-stepnem@smrk.net> <20231003082107.3002173-3-stepnem@smrk.net>
In-Reply-To: <20231003082107.3002173-3-stepnem@smrk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Oct 2023 14:33:39 -0400
Message-ID: <CAPig+cQHAK2_LEG0-6MTF52t2D8b_SRxzB51B_4N35ujtGeb6Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] git-jump: admit to passing merge mode args to ls-files
To:     =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2023 at 4:28 AM Štěpán Němec <stepnem@smrk.net> wrote:
> There's even an example of such usage in the README.
>
> Signed-off-by: Štěpán Němec <stepnem@smrk.net>
> ---
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> @@ -9,7 +9,7 @@ The <mode> parameter is one of:
>
>  diff: elements are diff hunks. Arguments are given to diff.
>
> -merge: elements are merge conflicts. Arguments are ignored.
> +merge: elements are merge conflicts. Arguments are given to ls-files -u.

Should "ls-files -u" be formatted with backticks?

    Arguments are passed to `git ls-files -u`.
