Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7781F404
	for <e@80x24.org>; Thu, 22 Feb 2018 03:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeBVD32 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 22:29:28 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:47012 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVD31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 22:29:27 -0500
Received: by mail-qk0-f182.google.com with SMTP id 130so15329qkd.13
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 19:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SCpQa9Ds1dNFBPV3M8rtu1+UpknOIRfEqwCTRdfgAb4=;
        b=l2XGm6UqaI7dyUrm1NLkfoS+CS2LQpMymdskqvb+Z/OxbPeeHNV5dLd9BZ+ls49DI1
         3eaphMTzt9fVwzyWl00KZqmqh+CRriHvgd8G0sEucI6/6N7u2p+xTCPgqsdfGmQQKLll
         JmR+I31/6B7h21OmLISkCh30n10qvW4lNXTeigs9pzW8PlIhuXbIvrapYMfaY/dZevzI
         v0/uQbNQakXhev+7wujt+iRNZ/RwdvoCUKAntdVY+AuVqBBFaI6R921ZhFrKCPQFy3J6
         9p+8N1lbUE3PykK2e7NMyk4EdzWc/QSDRn6LqsNHs5g/I9nEilj21EI3fYuGgqCaUVls
         KxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SCpQa9Ds1dNFBPV3M8rtu1+UpknOIRfEqwCTRdfgAb4=;
        b=dXJOqkj8BLOym20vMTdWqduJ8Kz7QRb+1K3uK/bJlofMPV1ZVWfIJrtxVSYWAzjRL2
         7lgvn0KSmF0Q1BwMT6Jr6AuKe5smKPOQNnngpANAH1lDm2yEEzY3uETeRl2usSSuSuwS
         mhCHdTro423j4ozOGCohM3ma+8fikTeZ5UMSqi37ZctIB4WB/OOoWP4StjJgaw72JPwx
         hAZzSZfL7hHEkEow6WYHqEFPNU9msFS1d2d3CG2fSvlisUUTHOIJ2X8+ijtWvXqliNkQ
         xTgnMi8X7YtNYxNsTmk+qS9cDaJ8l/AdAEBsI7Q6CePCMaCLo+JA5/v+E8tgbvYMbeE/
         tkXw==
X-Gm-Message-State: APf1xPDOvzaDyWlg+8477v9gYi0eSUeiCvLJp6QS5tzccgI1DIQ70rjp
        cJOCN0eJ/o3AY+6I8YUzYTqO35mRCivIYNuoalNDPw==
X-Google-Smtp-Source: AH8x225lzVAEOwhjbt1uDzdotpKDGQWx7cSnscIdnEEL3zSTkmofHUMsx6fYSKDw1suCFs//Xtr4iNboPFBjbgEgjsI=
X-Received: by 10.55.176.195 with SMTP id z186mr8858637qke.140.1519270166531;
 Wed, 21 Feb 2018 19:29:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.18.181 with HTTP; Wed, 21 Feb 2018 19:29:26 -0800 (PST)
From:   Raining Chain <rainingchain@gmail.com>
Date:   Wed, 21 Feb 2018 22:29:26 -0500
Message-ID: <CAPaSTm=Vhg+S0Cf7rkcvXKH1eaEbw5aGOfCmtU7K3D+1kc-pGg@mail.gmail.com>
Subject: Bug Report: git status triggers a file change event
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows 10, git version 2.16.2.windows.1, running the command

git status

will trigger a file change event to file C:\myPath\.git  "Attributes changed."

This causes problems when using scripts that detect file changes such
as tsc -w (Typescript compiler) and using softwares that regularly
call git status such as VisualStudioCode.

Thanks.
