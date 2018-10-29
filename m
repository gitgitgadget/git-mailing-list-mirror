Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0951F453
	for <e@80x24.org>; Mon, 29 Oct 2018 08:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeJ2RhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 13:37:03 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:33684 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2RhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 13:37:02 -0400
Received: by mail-lf1-f53.google.com with SMTP id i26so1041145lfc.0
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BqhTb0/KQ0OplMuRbX25gS5liJMvgqXOFCPqrCJzyVg=;
        b=KEVpBn7veuwoQ2QL9JKG1qisOIZsotuv+jd3Yystg4kCXPDGUSvEyf9duiH9cYwmIC
         c9LexRFstAeT0N8/8tfTXSSCfI8x43sMKYhhC3QouiCXugYHHbuXAgahwU5KjJPk21QN
         jwG3mW8S0Ru7UzcZ7Hlm45dIS/HlE9g7iIYsWbn2A8slfk2C6DMKD+XJvTF/vP7kPbNK
         /K6/ObRNnnUdeOQIMjiYDgO5ZtXv5ZvtWAg/i/6HIml7meO4WPDigXhK0bn+QyAjNipc
         08i8bDpwDRtvm1Gi9CZtQ7a8hbWaHLKS0ntQJgpaMkk85AgoHHJVjjjB0kPgPABsS0T6
         hxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BqhTb0/KQ0OplMuRbX25gS5liJMvgqXOFCPqrCJzyVg=;
        b=ftYUZSlGfrs/63PcG9HmSoXu2zHuzHFOcs4Z56oOqoHeG9GV5PuaF2jqtKKskF+IWG
         NbrG6MnA4w1Zt3pZjrCxLepcCPB99bMVpVIRpbG7zOVA/V5ULCziIKSbgOKn0iAy4xgk
         Ci1Y5DYbaBG6II8UzRqjxTY1sqAzh7I5Hum0Sld+CPKZOfCk5zGbYogPK3OCdXHYo254
         qDSnKJBD+xgzGVz7YQjrnoXXm1BSkWWi+1eQN0oprANXoXEACo2n331w1dL/GLBRJ2x8
         iDEgvBH5VliGLNjhuBl/BZmv/6Ngtn1868pCODrILWzKxZT5enUv4+GZX62pgSGB4hfb
         j/8A==
X-Gm-Message-State: AGRZ1gKT/T9wLJDXzdc7aQQIqhJpscaone4MCub7hn0PIWH9ObYRl8hw
        hLRWOXchUyIEE4KEvQnXRt6QUi9TfOMKJo/reEFUYA==
X-Google-Smtp-Source: AJdET5ej06OoS2XvqLWiHRzVxWvMbgbnoIhyvjA5HCNex833dURDFRYUCXjdVt/uPsrk4otQ6RHz44pwuAw+woL0j1A=
X-Received: by 2002:a19:5402:: with SMTP id i2mr7353457lfb.128.1540802960763;
 Mon, 29 Oct 2018 01:49:20 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Oct 2018 09:49:20 +0100
From:   Gray King <grayking.w@gmail.com>
X-Mailer: Airmail (528)
MIME-Version: 1.0
Date:   Mon, 29 Oct 2018 09:49:20 +0100
Message-ID: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
Subject: Lost changes after merge
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

=C2=A0 I have a very strange issue described below:

* Here is the tree before I merge via `git log --format=3D"%h %p %d" -n
20 --all --graph`:

https://upaste.de/9Pe

* Here is the output of `git log --format=3D"%h %p %d" -2 path/to/file`:

a008c4d580 c61f96eb5d
a274b6e7ca 67c1000ca3

* Here is the merge commands:

git merge f087081868
# fix conflicts

* Here is the tree after I merged via `git log --format=3D"%h %p %d" -n
20 --all --graph`:

https://upaste.de/8Bx


* Here is the output of `git log --format=3D"%h %p %d" -2 path/to/file`:

a274b6e7ca 67c1000ca3
67c1000ca3 00bd5c8c89
