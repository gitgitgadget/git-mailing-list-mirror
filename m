Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8852E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 06:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeDKGVO (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 02:21:14 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33920 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDKGVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 02:21:13 -0400
Received: by mail-wm0-f43.google.com with SMTP id w2so24261595wmw.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LtzK8tmWFgv/VXKRCFNzjJUD35YAxLnjdftUh8i2phI=;
        b=TcpP2CyKm0vmnuRqrY/d6ngm32eWizCsxcx/GPrnnS+MYH7Wv25hqr9rUVKORp88VM
         TQMWJIfNdT4MZ2tGU2eXJtDZKMBiD3Tp2B9h2+WboZFFDg2YjbyzB081UyXDq7KeHhoC
         Eo3Au6zFZfiYYB3KYLiCh8uguaVi3eLGFsHXSDhn/aI/N6wM6ceWDVjrQxnZCYbdnn75
         5c9VTilv5Om8Ge7UynrW/gZ6hWtceaNM3us6u2KAVYgDAX7n0Cxgd0O011F3EVGjGgli
         2iGccC5bwXlOPetSixUCi873Ew0lnysxLdEnigyFEiEhW/JjQcF2fVl7Br1pNq4dFIYq
         pMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LtzK8tmWFgv/VXKRCFNzjJUD35YAxLnjdftUh8i2phI=;
        b=hMfrzxM2gN2gtjntFcV2rgUvSaA8GDIIW7Tksgda9VHdmaZhL9M3YqohX4echs4zBt
         0gyNa0wbH+iV3gkgLrB3F8mqd1i5GJwGlwNOcUm/k5EuR2Xqg4c7XYl72ksbnuB9JY8q
         76Te/4W3O73inRnj6ghuC1//fFAYsK4yBb2pBTLwMEvM0qHvDJs1gB4mAmbvg2xueBx0
         I2MEzIw/d1irmatZldF23rXbgU5GLdq3Y6b5o9qE3TD7bZ3oFkj6kRx9zgaq7f+37H1S
         A3aZ9AF5hGEjLfmzrh5eKZHe+CVEJwWouTR78GEVFd71EkzXZ6okHLfr+xxQ+91dx09k
         YPag==
X-Gm-Message-State: ALQs6tAPHNYCHJUt11ft/wDto/sKTYB/2TazAyuluHXKO0lxgsGMXUpX
        sseJGykOImSsbgb5JeY8gsWCKpwh
X-Google-Smtp-Source: AIpwx4+EHad6qIUwqzoQxm9oo65qcfqENxB6vgA5hNZUHjr1bra9WiTcXvzUXIJWzbE81VuY/Zgm3A==
X-Received: by 10.28.215.147 with SMTP id o141mr1565782wmg.28.1523427672141;
        Tue, 10 Apr 2018 23:21:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m62sm1481983wmc.25.2018.04.10.23.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 23:21:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v8 0/5] RUNTIME_PREFIX relocatable Git
References: <20180410150546.38062-1-dnj@google.com>
Date:   Wed, 11 Apr 2018 15:21:10 +0900
In-Reply-To: <20180410150546.38062-1-dnj@google.com> (Dan Jacques's message of
        "Tue, 10 Apr 2018 11:05:41 -0400")
Message-ID: <xmqqvacy4621.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> This is a minor update based on comments from the v6 series.
> I'm hoping this set is good to go!
>
> This patch set expands support for the RUNTIME_PREFIX configuration flag,
> currently only used on Windows builds, to include Linux, Darwin, and
> FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
> ancillary paths relative to the runtime location of its executable
> rather than hard-coding them at compile-time, allowing a Git
> installation to be deployed to a path other than the one in which it
> was built/installed.
>
> Note that RUNTIME_PREFIX is not currently used outside of Windows.
> This patch set should not have an impact on default Git builds.
>
> Previous threads:
> v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
> v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/
> v3: https://public-inbox.org/git/20171127164055.93283-1-dnj@google.com/
> v4: https://public-inbox.org/git/20171129223807.91343-1-dnj@google.com/
> v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/
> v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/
> v6: https://public-inbox.org/git/20180319025046.58052-1-dnj@google.com/
> v7: https://public-inbox.org/git/20180325205120.17730-1-dnj@google.com/
>
> Changes in v8 from v7:
>
> - Add Johannes's Windows patch series to the end (see v7 thread).

Wonderful.  That gives me one less separate topic to worry about ;-)

> - Fix more typos and formatting nits.
> - Rebased on top of "master".

