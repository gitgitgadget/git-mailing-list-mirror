Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735CCC54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 09:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjA0JdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 04:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjA0Jc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 04:32:56 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3377DFE
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 01:32:42 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id u72so5253412ybi.7
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 01:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koodaripalvelut-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSskDvVUZMNoHPLSSE9n5DFF3ZFb6Qi41EBjqRYkgs0=;
        b=d276RU8OC7pMYBcqNYgRcVfQo8eyjNCBTvWP14qPTZ03sFdhoU0i+PgQUCaV56lK/N
         ERSRILGx8dAfaUT0aVtt2bp5hpAmVStE2u0kuB1IpcOph1EprrVyEz5oBluo/4RnUwES
         kWNV3MfxqeGwbB/i3R2tbmpJw5l5BJWJFIMIVHMZe8NtjeGsD19IYZdFkyQxXrXik+ow
         v7FjmhAWskFlIV9F1NvtUZ0eQ56FZ9uspMo6rVv6s0s2rr2mtID/0+GVVGG+ldFZuiiV
         wcLjCR9/7KQXPuBbdTdfyPWcFgfV4JSXLDmhDzlr+Ymw/rmpFg1eqT594xkm0hddbMiY
         up1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSskDvVUZMNoHPLSSE9n5DFF3ZFb6Qi41EBjqRYkgs0=;
        b=l2tVVouXtJZzTqiTYVcgM8KbJbNNOk9NSCDylT1qDVXLfopGVnBl4tJp3y6sh6WoJ6
         fjWLUMnNNtjBwkTlUkkX++VdcvhRmaZ0LtatEpkrQTtU41MBIlug0gIdONnDYbdoeb+a
         CMzexIT8qBGoBnjYxGJhFak5hmgO5PnJdzsA9IyJxPrHjC0tiAqvfRdvIKf7j8IzSeTI
         HweAzgheulo/WyKUEv+GPe7aLoKFIF0EBZ1weS46k321igsmOpvVliGzXFl/9rikE42/
         vQqXKGwo84nWNi80TDgDfuPgQ4UFdurlw7N9YPf4bUjDkBJyqUsaR5oZz5cep2H3/+EK
         c7tA==
X-Gm-Message-State: AFqh2kpJAyq0AwN3zcdQOWBx41pt8B2lrw4VG/yw/weEG3/uNRxddXD2
        PGcG36jo6M/N1vkRKeO6QWFQ4avkgGt792nVn5QxudTQOsD10oHa3Sc=
X-Google-Smtp-Source: AMrXdXsYAqt5ymXqdI+sKg/Sc8k4m6xksNywdGlyXJlPgiqSM17Qn0pQl35pLCtm2/JUXESBFuq5WrcKa+sELfYusIY=
X-Received: by 2002:a25:b57:0:b0:801:418f:e6e3 with SMTP id
 84-20020a250b57000000b00801418fe6e3mr2492092ybl.61.1674811961330; Fri, 27 Jan
 2023 01:32:41 -0800 (PST)
MIME-Version: 1.0
References: <CAN_dfTJY6bo7dBSBJoX7nxQMKt4VwVe2gAW7SEYM4cHffySrAQ@mail.gmail.com>
In-Reply-To: <CAN_dfTJY6bo7dBSBJoX7nxQMKt4VwVe2gAW7SEYM4cHffySrAQ@mail.gmail.com>
From:   Martin Terra <martin.terra@koodaripalvelut.com>
Date:   Fri, 27 Jan 2023 11:32:25 +0200
Message-ID: <CAN_dfT+yLpM6bgUqf8MddVSj3BuY_j3eVrsyntGKj2QoHi4YQA@mail.gmail.com>
Subject: Git submodule commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

We have git repository A and B.

A depends on B.

The team working on B has no visibility to A.

However, team A has visibility to both A and B.

You can think of it as if repository B is outsourced.

Now when team A is working on features and make a change which affects
also B, ideally there would be a single (single index)
commit/pull/etc. across A and B. Ideally, there would be no duplicate
copies of artifacts, i.e., optimally something from B commits only to
B and something form A only to A (think Submodule but with ability to
commit also).

How can this be accomplished using Git or is it a missing/planned
feature in git, or is there a 3rd party tool that helps with this?
Submodule and subtree don't seem to have these capabilities, or do
they?

Currently we have these set up on cvs and committing across projects
works effortlessly, but cvs is in many other ways outdated.

Related topics:
- https://jira.atlassian.com/browse/BSERV-4577


Thanks.

**
Martin
