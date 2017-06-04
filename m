Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B339D1F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 09:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdFDJ4G (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 05:56:06 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34101 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFDJ4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 05:56:05 -0400
Received: by mail-lf0-f46.google.com with SMTP id v20so27293066lfa.1
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=XcQheIKWiodkdkV7HfftnglQqNqmgaxE1S/gdCwU0eA=;
        b=oYU79xg096D3fsKbtgwFOdnfDudIJ6qV6254p+j2O9mwPRRPpZ3ZgzuQEJFCorBcWt
         dJEwGvAjis1rCFNWRhPTxWm0V21dLKcfAI/+dWNKTfUr0QL1DFIa3+HoHbQTiWr0CyBC
         eYI2LoPqPFZ7usC/vK2hAye2q6HJzg9RoU24zicgcFlJGb5qN3dzV0kucznGiXULGqp9
         /FfO1NKFJRUstzGkP4ccuD6UpMp/HsyD7gcBUDa6LV6KYmPXvVc+OrotDzp7a2PnYjic
         Q7rXNS4YulpMCs8lgphRjFclATEf/yQl7JJgHjYw6fIsPyKyiw40y+w81vAbKrm5OAe0
         TB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=XcQheIKWiodkdkV7HfftnglQqNqmgaxE1S/gdCwU0eA=;
        b=TNZZIBArvWgshxnljCT8Ah6Q855guHZM/4r0zPjZYmvRCsibaQ8u3XmcZ9FyZutXES
         4VzcvyldNiMH8VGqu3eQ2QEhrgHWJ5FDPENDxPdGiCPqXTWRNk4fg0MKV6h7MDCmHH59
         oaMsZ29aBugxO8um+/xcW6YTFEyphUeyS3EEmDlmeHsVYC6nNDoHBH8SwWfDfZZpOm/i
         39Z/wKwolk7+A2GTAPSOvBkjGszfGOfqBCYZgcggSwKp4nXt+0KyPzM3g2MhWAeJd654
         ov2pC9UN4ktkG3EPCs54VDvTWNOMvGgvmQDlejvtzvJJOZBCfyxcfz0lZU6OLjoWoZ5V
         mGcA==
X-Gm-Message-State: AODbwcC8MzV6vjUF9K1Sz8nyRqI6DCDUaykQY+IOQkDbkISwNE3oQyfy
        szo3Q3/0dtbHpRXEhP5iPIe+zsJ+szWSRVE=
X-Received: by 10.25.234.147 with SMTP id y19mr1903218lfi.25.1496570163611;
 Sun, 04 Jun 2017 02:56:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.14.9 with HTTP; Sun, 4 Jun 2017 02:56:03 -0700 (PDT)
From:   =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Date:   Sun, 4 Jun 2017 12:56:03 +0300
X-Google-Sender-Auth: m4dj6lpeu0IY1glOJHJaPf2VTws
Message-ID: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
Subject: Git p4 sync changelist interval
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My goal is to sync the repository from p4 using an interval of
changelists so that the first changelist version of the repository
would be considered as an initial commit.
So I used the following command:

 git p4 clone //depot@cl1,cl2

And when it finished, the files, that were created before the cl1 were
not in the HEAD.

The problem, as I see it, is that before syncing changes in the given
range, p4 task does not sync to cl1 version of the repo, and applies
commits to the empty repository.
Is it a bug or my misunderstanding of how git p4 should work?

Regards,
Andrew Yefanov
