Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E0C2BBFD
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3A220692
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBohGevR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgDKMS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:18:57 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33144 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgDKMS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 08:18:56 -0400
Received: by mail-wr1-f46.google.com with SMTP id a25so5084207wrd.0
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:in-reply-to:date:message-id:mime-version;
        bh=7SrWXjDRehGdf63l5raWflRhowHotGar6xFFe++20o0=;
        b=fBohGevR9teE6OX2/98CX0ZcXHQaCvEMpHOcpOXbHlhIck0gM7xhEd9vwuSZW75WR2
         5ugSZLWtir5hnz5hcFdbw9IeR6a0dy7Fz4UsDelv6NNuI79dU+5uHq4hQ/cGTrKEs/6t
         cTOFD2cSM1Nstb24BfnFzohrCjwm3Qxyk6jRvm3ib2zgqCHASZYoaCRsxctR258VdxIB
         cNX4RC5UtzLg89xA/xbvYcStlsRwe3RlGz1TL+spMztQPs/bHUXu7XOM1Kcu+QF71l0t
         wTvZh/2ohNsGiGstLkHHSy9QX1dmtMALonKbsXjjm/XFvGForHD+rnLRUEjG3MYS3tNE
         012Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=7SrWXjDRehGdf63l5raWflRhowHotGar6xFFe++20o0=;
        b=rjIjHMenNf0wFPQbgV3IOozZtSTS1/0dUx7VJqvGzb5wsx3IZqFtYLy11yCMsJ1xmP
         WcOs8TuIZwmo0Z0S7gNrJPzybJzwT8EgCMlWC/dHddvoXu+EhlYpi419Fd0J33ppMlXX
         qISXTtQnT9iTryX9yZz79onFFltzRkCDoX+EQQC/OjaCMQF3VbPM2K/B6c7yH/9Amz9n
         Fdk5OT0Jdd53g+va+7CS6F80XTTWrq/DFPPJKLn0NU9vsiOZ1CIXcs5XG/Jyae9ikzN8
         ezfveOHTJxslAn099gDu0M3EwMMV2aB1ypJFG+Y1h3hkrDv20WN8AcfgzSgf4P/oxivI
         PzeQ==
X-Gm-Message-State: AGi0PuZJtD0VpFD/628Mt02CIKPvJE0jr5tFyjbmF9GBG5CcLcQMkn5O
        rF/LUFpzpDf/T7q8yvjq4ipT1No7
X-Google-Smtp-Source: APiQypL0UQwWON/9qgQx/r8hfI+FeUzn122yJckCpFaGds/ebBAE3KC0DaOSiFK8z8rYuElpI0JR2A==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr9170129wrw.93.1586607534579;
        Sat, 11 Apr 2020 05:18:54 -0700 (PDT)
Received: from delllaptop.lockywolf.net ([95.85.18.95])
        by smtp.gmail.com with ESMTPSA id w7sm6961855wrr.60.2020.04.11.05.18.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 05:18:54 -0700 (PDT)
From:   Vladimir Nikishkin <lockywolf@gmail.com>
To:     git@vger.kernel.org
Subject: When will this patch be merged?
In-Reply-To: <1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com>
Date:   Sat, 11 Apr 2020 20:08:21 +0800
Message-Id: <20200411120821.7675-1-lockywolf@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When will this patch be merged? It is 2020, and git submodule is
barely usable with my internet provider, since outbound connections
are randomly shaped to 10k/s. At the moment I set up updating
submodules for the night, hoping that it works. If this patch was
accepted I would just see at which attempt the stream is not shaped
and reissue the command if it is.

-- 
--
Vladimir Nikishkin (MiEr, lockywolf)

