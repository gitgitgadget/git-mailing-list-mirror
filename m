Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8864C1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeDFS0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:26:13 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:33269 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeDFS0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:26:12 -0400
Received: by mail-pl0-f45.google.com with SMTP id s10-v6so1133791plp.0
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BXWE4yiJjZGApnWVDirPAfmaS3cOViw67Y/tW9w3gkA=;
        b=jlqPFRzncHHxgmRwfygkxI08AJH2a/ROLWzBxyoI3QQ8Aepe6hbfKBrcA2zopT2Qe8
         r5mK1TLoEoT1dSqtBvvB2rNQ7WDYRJmp3ls6HdCFTitmHaUa7YQfpRLWEW9aOksz3B7H
         0ljYjN0iRWsUTpSiF8g11T2QhKNstzHmnw0Kmenovpjcz3iJ6Aed7FZxIXzGBrw+7Zn/
         4+4XpqGWWaSlYoz3+rZd555Ct51CbmdB8honKdgdsIPbEHnEXQVOCrRXZ+KuSI7DXLJr
         4xX019nNjpB+5UEzIE8RuqdRsoTNth4TJj5K7gI+rJARReT2jTvNqRsgqPOIhPNElQMx
         qKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BXWE4yiJjZGApnWVDirPAfmaS3cOViw67Y/tW9w3gkA=;
        b=V0xV63+Wt/Quv9rH3OPfTyiUU56VGKq++DUdnjmKBLlBIhaOJtyefvMxW4z7weLhd5
         DOfbBq+5he5JzQ1pHYduabmsD8h1Mzvks989O5Pb++ph8tiTuRW2SaxuaKm8lxbCsqvZ
         X+5T/9+/+hJCpVA+DIjqu7+yEe594ZHgi2xI/eQ6iLJOrqTkQTRz38VBNlfhwiVcisNT
         SEwuRT/ctqx9ZHLWZL7fFy/bKZH5CyWWPZNvA7GflITDIvYKbVNf/EBGWRnFbQ6eLcNe
         UkIxtcFhwS7W+L5qGzrQDUf2s5uzgazTqaasV79AuZpGy2r3G8fZT2rxmRn/z2y5kcg8
         u0+A==
X-Gm-Message-State: AElRT7HOydCEI7eqH45O3eTqxeMA0DIch9W1j63Yofy3fhGDC1bLbPv6
        i+G/b4SM8jNRWAWYkdpH1lEReO2HhswT4K6X2IVa9UuQ
X-Google-Smtp-Source: AIpwx49a1h38uFwE0jQC06XURx7UOzzdqwFIzLmUHoIjxozwicA5soThGIPRhMLpyyFPXX74F/ggge6aptNSEsxLRKw=
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr27966855pld.273.1523039171621;
 Fri, 06 Apr 2018 11:26:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.149.77 with HTTP; Fri, 6 Apr 2018 11:25:51 -0700 (PDT)
From:   Satya Prakash GS <g.satyaprakash@gmail.com>
Date:   Fri, 6 Apr 2018 23:55:51 +0530
Message-ID: <CAJZK4X4-AZ6uEoVbAtQ9ErdJ2guKj9puXcpdX_3igBNPdQNp5A@mail.gmail.com>
Subject: reg. fatal: The remote end hung up unexpectedly on NFS
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We have a distributed filesystem with NFS access. On the NFS mount, I
was doing a git-clone and if NFS server crashed and came back up while
the clone is going on, clone fails with the below message:

git clone https://satgs@github.com/fs/private-qa.git

remote: Counting objects: 139419, done.
remote: Compressing objects: 100% (504/504), done.
Receiving objects:   7% (9760/139419), 5.32 MiB | 5.27 MiB/s
error: RPC failed; result=18, HTTP code = 200 MiB | 96.00 KiB/s
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

On NFS server crash, it usually takes a minute or two for our
filesystem to failover to new NFS server. Initially I suspected it had
something to do with the filesystem, like attributes of the file
written by git weren't matching what it was expecting but the same
test fails on open source NFS server. While clone is going on, if I
stopped the open source NFS server for 2 minutes and restarted it, git
clone fails.

Another interesting thing is, if the restart happens within a few
seconds, git clone succeeds.

Sideband_demux fails while trying to read from the pipe. Read size
doesn't match what is expected. If there are 2 parts to git clone
which is fetching data and writing to local filesystem, is this error
happening while trying to fetch ? Since it succeeds if the restart is
done immediately, has this got something to do with the protocol
timeouts.

Please advise on how to debug this further.

Thanks,
Satya.
