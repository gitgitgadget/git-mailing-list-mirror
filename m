Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B02C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 05:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBVFT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 00:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBVFT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 00:19:27 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D32D3431F
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:19:26 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id b20so7093621vsu.5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8f4zcfIxZq2RZNMJ5eACSC4zwvVdpmCS1vuhUMfG+Vo=;
        b=ZmFuEavUrYMK8XTu3a5PYCJqRvoZZMQpLuMQvRqoJLgucN8zycN2TnQmpEGZ7peSL7
         spc3n5/9XWJIJa+77h4XGx2NbfkLFfXapmWo0JntIPE4NvtcQs2yLkSZDONYdvZ6IyCg
         3SnBzt+YlQZrY1010ZW4qOzCx5ApiK1xqcmF3x1qiGLTt1ZXsuKdXjv8SpRb11p5MC1Y
         NLPI0uDnhFE5b9VmP+i/lJ0yM7YfXvuZbgBMcFpRtHuno0uR7p29GWRcE9RjhUERFQOb
         PHffhvxHqwW8L7CJkiRQafd3H3JLlgIdXreKoYein1nv0Xf4dTICsvz/dhZB724OQI8U
         x55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f4zcfIxZq2RZNMJ5eACSC4zwvVdpmCS1vuhUMfG+Vo=;
        b=33wTV1LTxROP8uHoChPga/aUb2AYV5MHUI3QJ0JLmxik1uPpKHo6ortPogQwhEFhNJ
         7YVnWLa9EZ5xkwCKQ2CqdPxxB/Es1oDYNwiyrN0ScxMdP883ZnWhMAsrDlFJ+aWqJTeG
         DTj71vR3yXIWCkRj8pP4cWYj267mu33yGd5Ug8hV4IIm/s2TOpqx7GOYZdLXTfuk22QN
         BCb8MSRsmeyOOGFpfcODidcqKlo9fugVLUYC8c8O17ZJ6qL1QUv8nJDFwPE5EuuQGJsK
         kVbsg91EdR+bTYeffvSC/uDrnhQBOt24f4AuMCUpm4fenRD0QV63ZlgOI9O0l6jrzx4H
         nSZg==
X-Gm-Message-State: AO0yUKVAO62LtR4Sz0WyoIIbcwMw9R5SjoywlBdqX+nuwCgatC19HvES
        LdkyblvNCC8xNjsLeHhWF9s9SI+2AQbkktD58+E=
X-Google-Smtp-Source: AK7set+l4bvHqaa1AiRyalpPAdnrZOeudUAOznVH6KpDy6dGOzUQM8Rwc0fZgvFR4Voa0a/dniZxfz6mbK9JcXggge8=
X-Received: by 2002:a67:efdb:0:b0:41e:9957:4262 with SMTP id
 s27-20020a67efdb000000b0041e99574262mr835687vsp.40.1677043165293; Tue, 21 Feb
 2023 21:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20230220235121.34375-1-gvivan6@gmail.com> <38cb184d-e47a-2129-a93e-16ffd2afe67a@github.com>
 <CADupsJNPVm13iSv84SXpqtP8Dhm_-htPTr59yPs_J=aQzs2FwQ@mail.gmail.com> <xmqq8rgqeplt.fsf@gitster.g>
In-Reply-To: <xmqq8rgqeplt.fsf@gitster.g>
From:   Vivan Garg <gvivan6@gmail.com>
Date:   Tue, 21 Feb 2023 22:19:14 -0700
Message-ID: <CACzddJrZ8YdJ72ng3UpMGN9CJx0qW1+fZfyi3q01z2487V8fxw@mail.gmail.com>
Subject: Re: [GSOC][PATCH] t4121: modernize test style
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vivan Garg <v.garg.work@gmail.com>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 1:21 PM Junio C Hamano <gitster@pobox.com> wrote:

> I am not Victoria, but I think
>
>  * You had two (or more) changes in your patch.
>
>  * She found one of them is good.
>
>  * The other one(s) were found lacking.
>
> When a patch is reviewed and found to be lacking (as a whole), and
> if you agree with the issues pointed out by the review(s), you'd
> redo the patch (with either "commit --amend" for a single patch, or
> "rebase -i" for a series with multiple patches), and produce v2, as
> if v1 never happened.  The act of doing so is colloquially called
> "to reroll".
>
> Documentation/MyFirstContribution.txt::[[now-what]] may have more
> details.
>
> Thanks.

That makes sense. Thanks for the clarification!
