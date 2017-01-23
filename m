Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7212D1F89C
	for <e@80x24.org>; Mon, 23 Jan 2017 11:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbdAWLqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 06:46:38 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34263 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdAWLqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 06:46:37 -0500
Received: by mail-qt0-f175.google.com with SMTP id l7so119657623qtd.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 03:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+++926Hbk4j2O55VIQ8W6Q3pWhkxb9JepVargB0v0vA=;
        b=Dmxpd48kcX8BA8KmGUOTHFHqYKVDm0YDkIX66aFP/DJCJ0owVKUzxVgfl8Y45K7YDV
         +2VvurUjFL9/VUvvjiomGq3L+q/wjRLG8HtDSBTHCVYCFdQ3T4952r2tVj+25N524U+S
         ToO+2kTGKz20a38rJxMB/fZS/CSuNAXuNl5dumzuYwo3tMnIbiKLeCPnurIu/4BHJqGS
         BjAk0OVp/I+wce78pk219tbUmIyhE3At5ml5ug5rvcs+tKc7eQVdv/s1nxTuJa9mChH0
         tw9S7/DR6t7ugpl6ihCWroDerdM0TqRoW8GINBnNW3VWZjpPXlp13IyNfNxRx+AwO+dG
         Wr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+++926Hbk4j2O55VIQ8W6Q3pWhkxb9JepVargB0v0vA=;
        b=h+QY3r/Hd51ldsoFTUjCok/ESfN3/95qSJtUejrt+VEKAKd0y5eeUe+7NX63favZ2w
         AycK43yQKHwdXBXNa79k+8vLZeS8nRH6yuK98YgzyaD9aicbY5JOsJEE6n4R7we+4FBK
         0yxx1mDvmkM4Tyxf50XW1gDBeMfkmG0loeqNF9yGbdlfuM4aUtlc7szP+R59zleh3Pav
         6nJ0ZtvLpExN6O4wkrM6URlaN4n7CFUvg/Ca1K1V8GUqEPDcTQTP4AazxLI7XJAGKsWZ
         WtimW3N3xYzqf2TscqCtG3TIWJ9PRnpgpxzP1aqRg8DfX4tzHUBoLhFBOidjSuot3Hp8
         IZ6g==
X-Gm-Message-State: AIkVDXIDQWAeSOlIKvD0raBXbRPxEFAn2yy1KCIYjfDrYle4Pj3UiFc8uyZvrZ6yxl0PTNAv0dmSEp3hFemfGQ==
X-Received: by 10.200.45.111 with SMTP id o44mr24686848qta.138.1485171996481;
 Mon, 23 Jan 2017 03:46:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.93.1 with HTTP; Mon, 23 Jan 2017 03:45:56 -0800 (PST)
From:   Tushar Kapila <tushar.kapila@gmail.com>
Date:   Mon, 23 Jan 2017 17:15:56 +0530
Message-ID: <CALNyQkyy_prP60kp_DpMzG9+affqPW0-z6F81R4OSgHg0QFc+g@mail.gmail.com>
Subject: sparse checkout : ignore paths
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we clone/ pull with : config core.sparsecheckout true

We can specify paths to include. Would be good to explicitly specify
paths to exclude too. So I can include want/
but exclude want/bin/

Similar to .git/info/sparse-checkout can we have a
.git/info/sparse-ignore-checkout optional file?

Logic would be to see if a path matches that is in
.git/info/sparse-checkout then see if its flagged in
.git/info/sparse-ignore-checkout , do not download if blocked in
.git/info/sparse-ignore-checkout. If the file does not exist, then
nothing ignored.

Regards,
Tushar Kapila
