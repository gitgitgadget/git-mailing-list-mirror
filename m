Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EEC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 03:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBF860C51
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 03:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhKCD77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 23:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKCD7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 23:59:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D45C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 20:57:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t38so995650pfg.12
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 20:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3/LlGVNFaPy6U2jRGgPHUZSHYX0EBIBB8VSkPtnRdA=;
        b=mUaFzniTaWPYUjvcy9ActU9S+arHjM5PhCX1oAL5r4KkE2AupnxIbU+76XxPhoiNea
         GSOmVBc7n+l6jtDFWUY01PLdj+RVEkmVJXOqvNnphaJCyxjZ6N1I9HGCLTKAWT2K6m+/
         NO/DfpbKXM6qLNnVRY+B/pIjgyhOPlB5GJsQZN3W897qqj2KsdguZPDK5ea1Hgj4yy7q
         Ouc2JUm0wE+AnHNiSzxNY3ntVfVoH1Xzm2oZJ5aFE+RturLpR9nzPU5KbI84w+R80DsE
         LKpkLJhJiZrvuc+4bizV5vySB4StNXqEeWzU5RfKE/u+vQGmSh6xH+RUw94jns8sM2lD
         dfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3/LlGVNFaPy6U2jRGgPHUZSHYX0EBIBB8VSkPtnRdA=;
        b=J5dVsmrz8ffaimgp+xqzgVe0xxFPJkYuDgHPyVvGQeXn8YNQ3QWXqiB6FYF5kLoyz5
         rRDz+nOyDIjCY0bGRcATbDaxBqiSXWOeKQWAjgA0ZTvm2NeK6nRCxaGMntLn3h2PlBuP
         TtvbmsJ4FjPno/c2MNAyOP85yL3H5sjfAGKecLOTjMZnxX8IW1U7nnHgtLBjQ1qVccAm
         N3cB6tZ1upCoNd8rHYi7b0fR5scROln4iFUHRj0tioP7Lq0g8IvfQE8GwWvm8VQlEDIt
         ogldSF9BKu4wp5KmhCgsM+5AkC5foTQWnnfBfnNJgMe87HPma4Ip1iLiJYH6I2Rv03Sx
         AGow==
X-Gm-Message-State: AOAM532704X1CjDL+S7nOdX1v5kMNJ/Yi4VmAnQT4jT1gK1ntzFtGDVW
        Y4MIl85d0sYYK/ygnZRlQMwGrUyiRZifuGz0MsiH1WCDAAbPeFsy
X-Google-Smtp-Source: ABdhPJywb67popNATDtIDskkCc+gG6Lw2QxuQl8jeEJEUNRv5tGULOEChYgHU/NZ/iD1bqA1Cn9qLAUji+8wArzn+eE=
X-Received: by 2002:a63:8749:: with SMTP id i70mr15685325pge.158.1635911838819;
 Tue, 02 Nov 2021 20:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
 <YYHzDuoJfWknI1XM@coredump.intra.peff.net>
In-Reply-To: <YYHzDuoJfWknI1XM@coredump.intra.peff.net>
From:   Steven Penny <srpen6@gmail.com>
Date:   Tue, 2 Nov 2021 22:57:09 -0500
Message-ID: <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
Subject: Re: credential-store get: No such file or directory
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 2, 2021 at 9:25 PM Jeff King wrote:
> Can you show us the contents of your ~/.gitconfig file?

    [color "diff"]
    meta = yellow bold
    [credential]
    helper = store
    [diff]
    wsErrorHighlight = all
    [user]
    email = srpen6@gmail.com
    name = Steven Penny

> Also, what does:
>
>   GIT_TRACE=1 git push
>
> say about what it's trying to execute?

Aha:

    22:53:19.785297 run-command.c:666       trace: run_command:
git-remote-https origin https://github.com/89z/googleplay
    22:53:20.024042 run-command.c:666       trace: run_command: 'git
credential-store get'

> And finally, does running:
>
>   echo "url=https://example.com" | git credential-store get
>
> work? I wouldn't expect it to produce any output (since you'd have
> nothing stored for that site), but it shouldn't give you the "no such
> file or directory" complaint.

No output, not error, just as you said.

> I think it is not complaining about finding the credential file, but
> running the credential-store helper in the first place. The "cannot run"
> message comes from our run-command.c code.

Yeah, looks like you are right, based on the trace result.
