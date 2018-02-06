Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDEA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeBFTtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 14:49:15 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:37894 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbeBFTtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 14:49:14 -0500
Received: by mail-pg0-f50.google.com with SMTP id l18so1521469pgc.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 11:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eluvio.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=tsfHSRRotTiOgLSAeUYxBSyGSzzPcxJNiRRXZrlQyEE=;
        b=HofvuKcVa43zUjUC5qmIlUu4+/981J/vzP+V0VgtaTW9uTCulsmbcqd/J6FeiV14j9
         R5+E5sFpxhfvGipWjR4UhjXrkiWrCKlHIvwnyBMpoRnCdOY12Y+twLuehDCbW9Q1jHGI
         VEMbXXkrADLS3qIZBQp9LjuKjQRPtVOJQnwdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=tsfHSRRotTiOgLSAeUYxBSyGSzzPcxJNiRRXZrlQyEE=;
        b=i10H4Vgr4Rb9MNQXpG3YJoDVV1VjjvFd/z+LSiPxNldOTQPOr+okg/ONaUi0jKdnDz
         tWfjhxDbNwn5N9PkCbk/X+8Si77Vu7MoDee51V3+1Zc0UxHASLMPpI5dvHxx8D/YHP9e
         76j/Vaxt0R1+aacJhMc/ZO/sw0JvcFVm+9PqzICMDj11U2T0babphG5heekB6YvVK2he
         KuI48wCuTyLd3v7m+M89yIIVYZ4Y2FUqWu/jNJgm2Cl5rrIQtm3cbr84qY8/+utT1jne
         pmQUT7gHLC0aAwE5SeS7yboL6r+MP5Qra2WmVCJc586/wqVhs19R0Wl1HElXWYe+9ywZ
         Y+5Q==
X-Gm-Message-State: APf1xPD/Wnc+5n+M4/u8IPuk+pyKRQ/QCHcrfYnh+DRbRXJLBwa/5wc6
        pB7n02Jv2LbQL2yiL4y1LhwghW1VUPE=
X-Google-Smtp-Source: AH8x224AjvmBoE8hVQXKOmrYmRllPNNkNCv4TL6G7nb6FETnGVELxui3MtNXbm/WpnXNtv6ft7LSeQ==
X-Received: by 10.98.73.157 with SMTP id r29mr3510502pfi.218.1517946553886;
        Tue, 06 Feb 2018 11:49:13 -0800 (PST)
Received: from [10.235.220.255] ([216.9.28.192])
        by smtp.gmail.com with ESMTPSA id k20sm13184186pfh.49.2018.02.06.11.49.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 11:49:13 -0800 (PST)
From:   Jason Racey <jason@eluvio.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: "git branch" issue in 2.16.1
Message-Id: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
Date:   Tue, 6 Feb 2018 11:49:12 -0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After upgrading git from 2.16.0 to 2.16.1 (via Homebrew - I=E2=80=99m on =
macOS) I noticed that the =E2=80=9Cgit branch=E2=80=9D command appears =
to display the branch listing in something similar to a vi editor - =
though not quite the same. I don=E2=80=99t know the technical term for =
this state. You can=E2=80=99t actually edit the output of the command, =
but you=E2=80=99re in a state where you have to type =E2=80=9Cq=E2=80=9D =
to exit and then the list disappears. It=E2=80=99s very inconvenient and =
it doesn=E2=80=99t seem like it was by design. I=E2=80=99m using zsh in =
iTerm2 if that helps. Thanks.

- Jason=
