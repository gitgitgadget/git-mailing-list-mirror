Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A34C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 14:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhL2OwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 09:52:03 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:34601 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhL2OwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 09:52:03 -0500
Received: by mail-il1-f179.google.com with SMTP id d14so16755475ila.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 06:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dr6Yxy/oDlkdHbVd7s6C13LxtWoLCaxBiNPKDczNhYA=;
        b=AgZwBxo7htOOEu+7qIh4EP3D4CAJ9K7zWOfAEtMhWYIFz/FnoQKKo08LqG/wcGF6je
         LXO8SADgmS1GyLuyMCIvpUuN/z5YfjrLudUYSNNVWQsgVWpo5ekBtM7/2tNBbz9YDPD5
         F21fk/Duj6WkA8IElJh46ikFdJJ1DhQKtzd51LWkWrPzsV2LlVxiqCAhn1xCyCVN3l5i
         jS9AnA7RgPxytizEGLqrA+SPw3NOqhJpkvn4UXbhRCytXGGP+RTSiERcotEq9Wx78xtU
         M/mHI66hoZvE/XQDiKVnZ2PGnoDJOjTmLxx4sNmG0PsSJD3WNkcwcIkIJ19lR3+NImQm
         ytOQ==
X-Gm-Message-State: AOAM533zMBxkiHgmV/eBGbCS44Oy0iO+L0xXh9s0AZbs9anUMzbrvlYh
        Xba5WFiKD5i3L/r4PZpL3/RevLG5XAeSL1vRWnYjKlfOSfA=
X-Google-Smtp-Source: ABdhPJzi8m08Q1Xhc7T3X5GYiXB73cH14y+cTThYNc7woUdRsB/2jN2808qLUDUyIwlOHm0jT6Z+VUCV7X1iMgeOFOg=
X-Received: by 2002:a05:6e02:92d:: with SMTP id o13mr11743968ilt.49.1640789522430;
 Wed, 29 Dec 2021 06:52:02 -0800 (PST)
MIME-Version: 1.0
References: <3e1548ab-5e20-9555-bd10-d6cbf2ffbce4@gmail.com>
 <CA+JQ7M-By65FVPnMFnwE8zx3T4O7DV3_5Kf2P6eZhP4Zcemorg@mail.gmail.com>
 <a8f3246f-2b50-e713-16c3-1d23b80a42a1@gmail.com> <CA+JQ7M9Ht5vSfDDEuYyK7pBPBvgjzi7L6jEYX8dkP4PMFK-M2Q@mail.gmail.com>
 <CA+JQ7M-gornjkB78Dgx-bHW7Ps=C2936vDNUakQ-VG8KAyZ=YA@mail.gmail.com> <fffeed2f-c956-d34f-ea5f-73f52e2d2be4@gmail.com>
In-Reply-To: <fffeed2f-c956-d34f-ea5f-73f52e2d2be4@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 29 Dec 2021 15:51:26 +0100
Message-ID: <CA+JQ7M9ANzeiZC7uLPoe671hT8wGDyO7tWu7+YxfDB0QE6YR5Q@mail.gmail.com>
Subject: Re: request: allow passing -X <strategy-option> to git checkout
 <path> to auto-solve merge conflicts
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 2:35 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>
> This is exactly what I tried to avoid, since Git already seem has all
> the needed under the hood to prevent such disaster..

It'd be neat if you could specify -X ours/theirs/both
But I'm not sure I would describe the current situation as disastrous
