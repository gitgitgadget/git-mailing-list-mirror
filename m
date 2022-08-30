Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E136CECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 06:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiH3GxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3GxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 02:53:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16713BD10B
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 23:53:13 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3321c2a8d4cso250627907b3.5
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kqt0q2lPnmxk5+PmpgRsyPD7kN6OG+vFZaPwTlfOfKI=;
        b=BeKeFnR9n2HupU0t0AChI3TgPZPkdmAr5TN/c3E+/sUf8rvw0WqymMU0rIMME0fS2r
         P98LFI7s8DNpbIjviTgbejybizf1dOsAm9zLfwLsFAOniv+F5V3LFSZYwn6vHvVwil7D
         YT4UVy37WNbg8DaKcHk0MkjaHI5/BgkeIQE2l34bS+PnM9a0a69ENm1bW5Y5rw7g40ut
         tE/CG4eQrharKQfR6hePX080Xrx1EUwqSt/8dF5zkRkt7U2dq9xtMuWjL7HRIiMEDz2U
         Ws0cC8RQxZUrgxkECe+Kg0OOafV1c5wF88oS9unu2PIAM0I3vSHBK2kB45lOOWi/wJa/
         0EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kqt0q2lPnmxk5+PmpgRsyPD7kN6OG+vFZaPwTlfOfKI=;
        b=xdoqB0iyliwbX//R9P9tM/WrLUTBFuitxLJGXtr8P82tsTbjlK/ntj3TyD2K1H1BTF
         ekg9pVtvaUnCYUReHV+BPS1d2IXuChDQUi9kskIO3MlwA3FsNLJo+cUQ99LOjlPeSpzw
         kegxUuwJZHiCYnG/ZR0lk5tnRQsxDbIHtN/HG12I6ca3b+RgyPl5LYHBFLzbzoWTysL0
         pn49tWXL9QHe3G3lFTrxdDJXOKEnGDr4HttY7oLxT+L3+y3dHI9OIi+bIEAc1aOVpUGq
         oUiSsgo7SrZrzD1wpzJYkzoGeaacxC+3zamCTDRoY+8rsgOSyVSNjyj58j/R89wYTxJn
         sYgg==
X-Gm-Message-State: ACgBeo0QpG0Qfpgtxq3I4Trs+fnq96aKbJLP59JTohKvEv6ddyfy9+QM
        hTYqBF81C7j5vydu3+x/5rsRIW1QPIr+j5OnuvDbnkhr8VyqaA==
X-Google-Smtp-Source: AA6agR7NYv0Y+2vEsC+o+mIV0xVALB5aKebUiAFkYYmA6ORRw+SvDLlyKr2BcTAvVdxYFymcaXFzqQwow8XHCfTX/yI=
X-Received: by 2002:a25:8d0e:0:b0:696:489e:ab40 with SMTP id
 n14-20020a258d0e000000b00696489eab40mr10684353ybl.494.1661842392214; Mon, 29
 Aug 2022 23:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <Ywzv7Dl6n+LcY//n@nand.local>
In-Reply-To: <Ywzv7Dl6n+LcY//n@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 Aug 2022 08:53:01 +0200
Message-ID: <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
Subject: Re: Git in Outreachy? (December 2022)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Aug 29, 2022 at 6:57 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi all,
>
> Christian and I both got emails from the Outreachy organizers asking if
> we are interested in participating again this year. Last year we
> submitted projects, but ultimately did not select anybody from the
> program.

Yeah, let's hope we get more people applying this year.

> I think it would be good to participate in this year's December cohort.

Yeah, thanks for your email about this.

> September 9th is the initial community application deadline.
>
> If we're interested, the project submission deadline is September 23rd
> By then, we'd need:
>
>   - Volunteers to act as mentors
>   - Updates to our applicant materials on git.github.io (project ideas,
>     as well as potential microprojects).
>
> If folks are interested, I'd be more than happy to answer any questions
> about participating, and overall logistics of the program.

I am interested in mentoring and org admin.

Yeah, we need to update our microproject ideas on git.github.io. About
project ideas, we need some, but I think we need to add them into
Outreachy's website. It would be nice also if we could discuss with
Outreachy organizers, and ask them how we could increase our chances
to get some good applicants.

Thanks,
Christian.
