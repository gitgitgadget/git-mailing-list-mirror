Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586FC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiGYVIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiGYVIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:08:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB51237FC
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:08:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c131so22226475ybf.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6CuI1VV0lHzmZMqAZe/Fl7+BKoGO7ErwuNdGItNh7BY=;
        b=VJqhvxNucz1h5uuENmUrFRyOYOFdpupUkFO3vxFsDzNNf0nvPL/3RnOUiHZxU68luk
         bcKE+gAA3BU/NAXp+6DoASfX1NpKpFJGC3SnYMsTaqJUAuQCUzXP/a/gqty6oS3TqpS8
         mvuGV7w7GrK23euUbYwfEt4m38N9gaerN1mNqs1pJqeYkRLhYQZ1ETUE04O7fTTCd1bN
         YIxbdohgb7ZWOeDAEtiKoxGWObtV/dS+xmyU2SL+6fLCSogVwj35EYGkAwHP8SjqwEpy
         5VsELlrQ1iGjtQPW1hABHubypzx9nyCBdME2aFaTB4KfQ1EPw8kJ5XZleg2nPKxBdhlR
         JzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6CuI1VV0lHzmZMqAZe/Fl7+BKoGO7ErwuNdGItNh7BY=;
        b=6m/6i6NybBgOjy4AGsiNrcL3wRHeanijgVy6m1vsMb0Y0wLfJs++LoU9bUfVHPzA7h
         J8h5//eq2Fh+kafnYgMh98teH8ZFzw30oYxNxXk1uR6NC36FyZwTg/awJwOIWUECUu6j
         mjhrJn+OGsuDU3XwDMmi4rHd9MAvcldxPILS7oZzEz3lcWDNV9QLT+IwL+lbXXOrIJtY
         /mZFJGW0+/fXsUozID3BElDjOUVS1ZXpnAmwbvA8Ae3GQlgR5OFb3VMCGZeIvudeHUU2
         9tVvQeNW+F9N94h6qPNO61osuQTFAtD1JyrYKUUCFOeLzwnQTdqKoq9wmXwQsUwmVb4y
         mJ0A==
X-Gm-Message-State: AJIora9KdTFYT5/vAgPiqtoT/XnqNfImbLRmmSt2wTjJgH7OLF2ssY4T
        38Z4jpHNqgc7yLmJ8Pfa9QBIbTUsK4DK3KxlE0FYxBxCem4=
X-Google-Smtp-Source: AGRyM1u3NP4VqdIRxjeWrbxnQRsmFDqbw8IffhRZMYbFpQoo3BnI9lnjHYU8SZW6eunGv+ECtPefApk5lUWvc7df24M=
X-Received: by 2002:a25:c008:0:b0:670:98e5:e424 with SMTP id
 c8-20020a25c008000000b0067098e5e424mr10956047ybf.150.1658783293780; Mon, 25
 Jul 2022 14:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFWJc9_QM1CQ69yXCOHTi4KSZJffhty5s=egUUx-6RTjUVF9+w@mail.gmail.com>
In-Reply-To: <CAFWJc9_QM1CQ69yXCOHTi4KSZJffhty5s=egUUx-6RTjUVF9+w@mail.gmail.com>
From:   Elie Obeid <elieobeid7@gmail.com>
Date:   Tue, 26 Jul 2022 01:07:40 +0400
Message-ID: <CAFWJc98dciS9wZ359PJjMeNhiG_+xy2otkz4a79MoPCRK-Mxew@mail.gmail.com>
Subject: Re: How to specify a remote branch in git worktree?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The regular clone (without using --bare), works excellently, with no
issues, I just tested it,
added workspaces and all is fine.

Best Regards.


On Tue, Jul 26, 2022 at 12:51 AM Elie Obeid <elieobeid7@gmail.com> wrote:
>
> Hi, I have two remote branches prod and beta, I want to create one
> worktree for prod and one for beta.
>
>
> mkdir app && cd app
> git clone --bare repo .git
> git worktree add --checkout beta beta
> git worktree add --checkout prod prod
> cd prod
> git pull
> Mege conflict
>
>
>
> As you can see, I get a merge conflict  right after I clone the repo,
> create  the worktree and do a git pull, maybe the worktree is trying
> to do a pull from master, I have no idea
> How to fix that?
>
>
> Best Regards.
