Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13091F404
	for <e@80x24.org>; Wed, 28 Feb 2018 12:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeB1M71 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 07:59:27 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34494 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeB1M70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 07:59:26 -0500
Received: by mail-lf0-f52.google.com with SMTP id l191so3378439lfe.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=QeE+pDJRLUwsP+NMtNJSgG7VPoZHkGnfV+P5amQ2fDU=;
        b=f74v7GzsjeCOnIS4gACwujLxpiZLozg9RuDnzffSFCa6mddlPNj2uJcvvD5NEEjGxE
         OzUOIlh+ToGY+mEWWc9lA0z7pvsg5/JCFLAzK3IhZVu3ZDn5pltttRtuMNVjlotRpS9k
         eWx+m+S6UNNx030rVedTw8mdPTqPiq1CnGMinX31QEQYc9gRHT17SJfLfgM5DyBYoV+I
         YKFoUL3kHEB+/z7YuT3KAyAWzjED0umUNfmRVIRY+wwzhkg/Lqs3JzJHHYmuynZAhBfo
         ETkibyHuana8GGJEal8D67cC+fWUpf5RWlG3RDmGm/EECnucP3OZprWZZ/c2aB5HWNze
         oiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=QeE+pDJRLUwsP+NMtNJSgG7VPoZHkGnfV+P5amQ2fDU=;
        b=Hjena8q4Ww4WXTaMiznu/GqPMBNd+oba+LOsLBIHva93QS48mzqJIuczUjQntRdhob
         V0S7iLLgCTZ8gQrjIlVWDGCFGdBOQ6hLJ0LXdzm61estwxa2VPjEZXA5xixdLQuEn6HU
         /CNJIZ9AZK678yol7nT2KDT/W6lkh9Yk4kFLOSoeRZ3wZeQNklknixNrea5IMxWYHYXv
         cYzFfibC44q26xTbWNZV/Uk/7G3etsL+skmKISKE7Fxg4mekbEbPNZvCYdXa2PNdfVgx
         /rDkrw3t/N8PBHqXqFXfSFsGnS7pk2+lT53O6mCADm2VSk5POcSEpYFV1bnaOXASsbTJ
         IOKQ==
X-Gm-Message-State: APf1xPDUkwA5B2w0zQtuQUhtEJkZY5f66h09pUeE3WGYPIvBUAouBPer
        ukpOsmaOjDQYtzHv6Fv2mKzc1nE69OAqfJFPOmyWUAt3
X-Google-Smtp-Source: AH8x227rOhu6Gg0to0UgoRLFpljzijf8PDdsX9+vfH7trRza5FpnFDZWI9x2ny03rvZFQaM37uAUGk225CAo6BHHX6M=
X-Received: by 10.46.77.197 with SMTP id c66mr13446677ljd.116.1519822765413;
 Wed, 28 Feb 2018 04:59:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.80.67 with HTTP; Wed, 28 Feb 2018 04:59:24 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Wed, 28 Feb 2018 13:59:24 +0100
X-Google-Sender-Auth: W4-l6Ei_T_sXdQC8BOKKxBpSg78
Message-ID: <CAGr--=Jgk==eQ4H8hiOU5x_P53gugXStORkFfTH6iPUrm43VRQ@mail.gmail.com>
Subject: [FEATURE] git-gui: Staging path(s) should re-select a new path in
 "Unstaged Changes"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a path is selected in "Unstaged Changes", it can be staged
(obviously). When it is staged, the path goes to the "Staged Changes"
list, and no (new) path is selected. I propose that this action should
re-select a new path, from the list of paths in "Unstaged Changes".

Steps to reproduce (in git-gui):
1. Open git-gui in a repository which has two or more uncommited, changed files.
2. Select a path in the list of "Unstaged Changes"
3. Click CTRL/CMD+T to stage the file.
4. Observe how no (new) path is selected, forcing you to re-select
another path if you want to stage it.
