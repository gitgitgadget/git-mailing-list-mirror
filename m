Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F6C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 23:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjBNXbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNXa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 18:30:59 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5D2FCF1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 15:30:58 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 78so11333309pgb.8
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 15:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676417458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDiwIrxC26pgtL9BIdADgi3V6IfdYIpsXzh4giOFDIA=;
        b=VzlxMUZh/VdxguDYnvP5Ze5+d+at02lOxZHbLJyzKkIsEaw3GJNjTdpYzI1Rq8Aka5
         3CtNnBvOeFy9k3i1/MVPrP9c/8V1t0HZO2tkG8rnagOQ84KQyv+B/odKC/K9J5DE+TQU
         jdieNSOB6+rUzE/WBb1blaUD52zPICc9DhL7KSYor75owUa8xme3N+klzBg+2czJEcbj
         nI3hj/XHnZH6D2xg3W7T465nHgmyXdDeQmMgtIp+nJ65Kltod60crnuzQJ/I8pe24kkt
         59OIi+LeFn+4IMgEnlvKH/u69Nx+xAHu9hfcyBWFNU9ANREh/xf0GOwHeaH5gXw5GCER
         qkag==
X-Gm-Message-State: AO0yUKUOyv9Fcf03rfeLggybZZQ3pWBfi+vApFgrg5wwpmbEpMy0FGJ6
        y1lys26xllSuVA0Y1WM1zTbIxBjMKp4kZDlf2J98/DeA
X-Google-Smtp-Source: AK7set+4fcQ0R1rCv5hX4bDW8S6YYur9NLfiA+WuGNUduoiNEsEG71CUw5eBi4DGp6umWbkPdnQ1DxeXVTVymMtamKo=
X-Received: by 2002:aa7:972a:0:b0:5a8:c0e0:3b2 with SMTP id
 k10-20020aa7972a000000b005a8c0e003b2mr798539pfg.45.1676417457861; Tue, 14 Feb
 2023 15:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20230210080110.32983-1-vinayakdev.sci@gmail.com>
 <CAPig+cS-9gbxb3tWqaWtsjfiQR60GQXpfCKM7-neu6AH8rUvcA@mail.gmail.com> <CADE8Naoq4N9EpSfb8=ADPRLeAsmjVhL+ayOzhS=syaZ0PQh71w@mail.gmail.com>
In-Reply-To: <CADE8Naoq4N9EpSfb8=ADPRLeAsmjVhL+ayOzhS=syaZ0PQh71w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 18:30:46 -0500
Message-ID: <CAPig+cQK_aW4m4LToYwDVF7Fw_cHjQVMpg7OS=ptwWjhwUCt8A@mail.gmail.com>
Subject: Re: [RFC][GSoC][PATCH] t9160: Change test -(d | f) to test_path_is_*
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 6:32 AM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> On Fri, 10 Feb 2023 at 16:38, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Feb 10, 2023 at 3:05 AM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> > As with the other GSoC patch you submitted[1], this one is also
> > missing the "---" line below your sign-off, which tells git-am where
> > the commit message ends. As mentioned in [2] you may need to adjust
> > your tools or workflow to prevent the "---" line from being stripped.
>
> I apologise for this mistake again.

No need to apologize. Reviewers point out potential problems, not to
place blame, but to help you improve the patch.

> > The actual changes made by the patch are probably reasonable (though I
> > don't have CVS libraries installed presently, so I wasn't able to
> > actually test the changes).
>
> If by testing you mean running the test file to ensure there are no
> errors, I did do it thoroughly before sending the patch,
> so I can vouch for the changes :)

That's very good to hear, and it's the sort of thing you can mention
in the patch commentary[1] to help assure reviewers that the patch is
sound.

[1]: The commentary area of a patch is just _below_ the "---" line
which follows your sign-off. You can use the commentary area to supply
readers with notes which aren't necessarily relevant to the commit
message itself, but which can help reviewers in other ways.
