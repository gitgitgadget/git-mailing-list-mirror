Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6EC433FE
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 13:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhLaNEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 08:04:40 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:40484 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhLaNEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 08:04:40 -0500
Received: by mail-il1-f172.google.com with SMTP id c4so14567408iln.7
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 05:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ub+/RYGJioAG/aZflF/QLyFsbtuE/89F7rymR/hEb0=;
        b=cu//oTqfMEIPWJG68CK4l3b8BuNqSpABOpK39UyN/B26Cu1Hh29UDqxxiFNZh2rikB
         JQa/r2CPajsaomHFUIaL6tV3f3Rw9mf6j77oIV6kyvtQvv0+h4iev7aPCcWqA0rPTvss
         ZSIsVtZAUYRYhUHiAN5MG99NuBbA5eu+3TED72cBrrveNzIcSUhSKG+aTWQol4lWd1Ob
         4h8N/vTqnmIjOR7MrubLJBlAgNLQdARRNS2ly2nMCW7psRpo4mNzLeHqG6Q+9n819HPt
         869rhBXsZ/2o2zX8AqJs0H5kD5nkCX52iweBVT8rY6BpjgonH9SPCSTTp2Dmm+excmnz
         yyfw==
X-Gm-Message-State: AOAM5308ZvlottzvurD5wBpmific7xRTIz0toN/yfgGd9z57z2/Wk4BP
        zAZLy3VPRyJ2dHETpJjJPTMVKzYS3tY+F6laDc0=
X-Google-Smtp-Source: ABdhPJzg5CW3iiLIyDOscl1VCi8cqXKEwUNh5rWbdeVFtiPmR7rcjZ9oB8/urNz6Weqt4eqh+J4Sr9j10yjuchXFYSE=
X-Received: by 2002:a92:c685:: with SMTP id o5mr15618304ilg.152.1640955879930;
 Fri, 31 Dec 2021 05:04:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHo1AWxzPsnLuT8JRWovtaRrGvRS8+0NyucU5K8VEnaL1xxW3Q@mail.gmail.com>
 <Yc4YKG+taXOuf6Kx@camp.crustytoothpaste.net> <CAHo1AWwC325etDTgwWvKLojrCnETjr_xPHTSVBi5RD_XH1uCsg@mail.gmail.com>
 <CA+JQ7M8iqaeG-FOFfunz1trR=Z6seFEjYLjrmBcCXHDTqNx42Q@mail.gmail.com>
In-Reply-To: <CA+JQ7M8iqaeG-FOFfunz1trR=Z6seFEjYLjrmBcCXHDTqNx42Q@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 31 Dec 2021 14:04:03 +0100
Message-ID: <CA+JQ7M8U7Ocsk0JO=GmMyf5S6CnodTYjG=zAHGL4Bco8cfVBHw@mail.gmail.com>
Subject: Re: [Question] : git 2.33.1 asks every time password
To:     Jean-Louis FLOQUET <jese.jlf@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > > I had to create a 'config' file within '.ssh' directory to support my
> > > > rsa key (too old format ?). Instructions according to
> > > > https://stackoverflow.com/questions/35233777/git-error-unable-to-negotiate-with-xx-xx-xxx-xxx-no-matching-host-key-type-fo

But perhaps I misunderstood.

If your question is why authentication is falling back to username/password
See my answer at SO
https://stackoverflow.com/a/70434510
for a similar issue with Git/AzureDevOps server.

TLDR:
Git for Windows 2.3something updated OpenSSH to 8.something
This changed default behavior of which SSH encryption algorithms
deemed cryptographically safe.
Not all services allow more sophisticated keys,
in which case you may override to OpenSSH defaults
