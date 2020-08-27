Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F062C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8164320738
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgH0I0R convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 27 Aug 2020 04:26:17 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43490 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgH0I0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:26:17 -0400
Received: by mail-ej1-f67.google.com with SMTP id m22so6470983eje.10
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y47yipD5zy1q0Zt66n/P7Sva4eQ3ztrGV/twvlT9dnI=;
        b=HJRA/vaK0Gr6TOA1d6apHHINejW+CyKTSlc6ucSSOZ5jhh5csOlC3pzmRApe21A+cP
         0ikNmUTLfEpac+FzhhFm047N3tv92m2fzqOEpee0Hn1apNZu1WAd+e/w/uBhL1FpSfC1
         DtpKbrXt8/Nykoxq99L0E6Yj13oJaynmETgGscQQecp9dretap/efIB8f8a5FP9Xl9gT
         Y2CwVlle/9GR3Ba+4djAmHpzbsiPl3UWQcQJ6oFNhDgANbDIUa8yH2jFfwgJYy0cqLUz
         CjdGRLBf55CCr60jqKyOMSmrxiGsyvXl2jbUHAc/JgjMC7PKKuhVkQSITOIEUI0S6yZR
         nayw==
X-Gm-Message-State: AOAM532xWQv2xMzUkfwGFvkkLdUkLklzpjWXS8JxzrzvqPnmHhgA3VXW
        w4PYC2NiYx8JjIYdsHNilEz7+SjEzHivCk9Y3h8=
X-Google-Smtp-Source: ABdhPJypYI9o3wBYbMVCI5cLrHtgzgCGD8FcewnbTwm5OB9LWFnVIV5ggoJaeUrRUf20ewEaPbjK+Ixoz2i37IwEHl4=
X-Received: by 2002:a17:906:4f11:: with SMTP id t17mr17180426eju.371.1598516775392;
 Thu, 27 Aug 2020 01:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbriek39i9NSHRw6DZm0dftk-GkeAYR74c0xyss0vbeDHu1Hw@mail.gmail.com>
In-Reply-To: <CAHbriek39i9NSHRw6DZm0dftk-GkeAYR74c0xyss0vbeDHu1Hw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 04:26:04 -0400
Message-ID: <CAPig+cQgay71ecYpg9P2FWHsXfQJH_23s9DzqXu+TozcKDw1qA@mail.gmail.com>
Subject: Re: git init --separate-git-dir doesn't play nice with linked working trees
To:     =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 12:48 PM Henré Botha <henrebotha@gmail.com> wrote:
> I have identified two potential problems when using git init
> --separate-git-dir with a repo that has linked working trees (created
> using git worktree add).

A patch series fixing these problems has been posted[1].

[1]: https://lore.kernel.org/git/20200827082129.56149-1-sunshine@sunshineco.com/T/
