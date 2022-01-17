Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3181C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiAQOkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiAQOkf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 09:40:35 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79FC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 06:40:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id v6so21791970iom.6
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 06:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLH9CFOF/Z29Q8KwR7or2NuNHLYDgbeUE6kQLrTTnIc=;
        b=Zuf0EmHyQl6GhPTMM6BLM2cFfHjdssF6ecpaGs10OpP7j4TxUDhGMPwKt/a57g7fzq
         sBbNxAzz+U5QhgqPiDUOwgRGHy4f7KjRBC0v7dddh+4p1m2kfmjrjKrdXtmm3KwvdPOo
         pw/P1d2a817KRqEm7kosKw4eQwQNtXFFWkrS//6ejKANVe0SLR1GT3oNUdELdXucfs4U
         ct9fhCEWP+ZrNY760mc3PmvYi8wJnfJmPiXZZiezLrOLYAPQxYfLRlPJs4Fs4BsJ+ske
         5CsLsUjz9TDHaDQWg10NcU8FgFp3YM7GRMqxUoSZ8KVVdHzgzAX/IcDmSlJbIKpTxag4
         D4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLH9CFOF/Z29Q8KwR7or2NuNHLYDgbeUE6kQLrTTnIc=;
        b=MKVFjoB7xNoCr+c+jLyLVIlLIefPjGAmWdh/jeupmFHsh8kuJWbGi4sBeJoQsoWxDK
         ZOc7V8VOT6rvkk2LYSPgw8ySU3mR3fHFhcNlMINxgGvAZQP9Z5BbaFIfenjrr9md6yYo
         q/UsgXs27HAxIOUIpmHQnWNu5ZWqfIf1Cm/hw5YTiYh0mUFcTeD+5TGBjzhNh49R87Pt
         fMycd+zsr4p5WKca/Hn6P1iXKNjC06a/DucXwhjzfcevVFOwu0rMcdRtYF9pQqEYNaYj
         0Ywd7/LSsspKK2n1C1zNW58K7Cou7ohrHb8OqFSt1DIvrJjj2T9ZRwiMwh/3AUpFT1YQ
         kTUg==
X-Gm-Message-State: AOAM531W4N+XeDl9T+G+EuASEso/VGo1ioJr0njp+nHkQUg+ETCbtE7U
        ciZjKGlDnscXQ85JN3Kam+yt+6sy0o9Xt9FbmL7ZniGR
X-Google-Smtp-Source: ABdhPJwIUl2dxutJOuXkQrWKv+SnaDMzpOXHqucnGeQ7Db09gn3XGXcwZlTi0DQD6QzkbDhLn4lUdQcJQzvUhwIl4v0=
X-Received: by 2002:a05:6602:1688:: with SMTP id s8mr6432956iow.206.1642430435290;
 Mon, 17 Jan 2022 06:40:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGr--=JiCv3XTrxP=foy+FrxbiYeMf=11eG_6kGBFmBr+P-=Jw@mail.gmail.com>
 <CABkJDHF6gS+j6LmT0hr2Z23izb0uBj7cs+XU_14O8wB8yTEpZw@mail.gmail.com> <CAGr--=+_MvsbGYMzufhSDTpc1YMvfbOSDTArMbuGZ1rnxy2otg@mail.gmail.com>
In-Reply-To: <CAGr--=+_MvsbGYMzufhSDTpc1YMvfbOSDTArMbuGZ1rnxy2otg@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 17 Jan 2022 15:40:24 +0100
Message-ID: <CAGr--=LVPcJfdKQ-fP-e0EXwyJ=m37Xkcn139G8J_fWNkFi-Tg@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Sashank Bandi <bandi.rao999@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

I think I found the problem. Should be okay now.

Thanks, again

On Mon, Jan 17, 2022 at 3:33 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> Thanks a lot for trying to help me, Sashank. There seems to be an
> issue with the code. I had to take a little guess at where the actual
> line breaks should be, maybe I messed up?
>
> I pasted the code here: https://github.com/prati0100/git-gui/issues/64
>
> Can you take a look?
>
> Best regards,
> Birger
