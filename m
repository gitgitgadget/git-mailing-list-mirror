Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A82C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350196AbiAaRQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350100AbiAaRQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:16:41 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6EC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:16:41 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c6so42609385ybk.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=H0ehjEYk9DctZQuU3kzjgO3G71JnvzD0YfZ79WwWrzk=;
        b=aBoaLawiI+7zYx4y0vp0a0qcY5ApaeAtn3ndsZzty812Hf0nE/mtBHV6MW0/JwnDYv
         6iJ6N8Z+O09wswpFmxwTDFbPXm3q2ubY091B+2+ZC+TKMUQSeTzFxqM1FRlnfU8+rEvD
         5F/zmdULEqOxhd9gp58uKG81KnELVJw4EEF73Mw+EzFA246BSGvF5EzOkfC60BqgdO5h
         7ZLXgcE4xTHWE1+TDwHhx3ino/DPIN3d5MMYmL88A7CVxoKhWeH8X8F+JmOlq6fygRoz
         bxTc3CzRKSAVLXKxJ+hGwum2MdxEVkmPwITYmH//INp/ZxYHC8b1ghjo1nX3zilgIBVS
         K7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=H0ehjEYk9DctZQuU3kzjgO3G71JnvzD0YfZ79WwWrzk=;
        b=PNMFjZkkvCrqGEq9Ba0C4yzT8P8aCcNylM2JQDmojElj4jVLbx8aVBEqQIfOaiTae2
         v7+R/XWgU6HnA66kRMWNX2xHBGgdWG0zbIrrwYSxi4FMrzHOawH5CTUq6Kb361i3stxx
         YOiGgGFDzjz9bQCNmvWz+rI535S7wGQ2gv7u8zp5iGXF04GdmeOMbGn4ZpBghwJe1BJ5
         ABW0KorhSMigfo4ma4AwiaaAXuJn+GJC84MaEnSZGaJ50DiIINcedhz237hg3yqiy+ue
         UrD/eHMsbPpN7CQJ+qTfJDZOgyr2kO/q0aYaZY76aNtXcW9ujOP4qCAvxcCJyg1GttNH
         6XEg==
X-Gm-Message-State: AOAM533NK3+g6scV2hh300CrgBrowfkl1vWs4OROLf2I7Q6f2rjLRbMQ
        94DB913jF9XODK++b08IpIe/1v5Zpvr5q4xiAOcvUp67cls=
X-Google-Smtp-Source: ABdhPJyYJFBvs4E41RyJRdprJWG5MfCVomXyF3lvzcvCGUr1C4p23pAwOUqhw1aE3uEYKvykbKJZMraJS3RqYFrtzdU=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr31685659ybc.427.1643649400049;
 Mon, 31 Jan 2022 09:16:40 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Jan 2022 18:16:29 +0100
Message-ID: <CAP8UFD0SehQ43njmAFyVWvq4KVfiC-HH1PBbk64hmdwKZ=H3Aw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 83
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Sean Allred <allred.sean@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 83rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/01/31/edition-83/

Thanks a lot to Philip Oakley who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/544
