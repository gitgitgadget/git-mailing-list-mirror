Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8414F1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 06:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933221AbdDSGt1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 02:49:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33358 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbdDSGt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 02:49:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so3154958wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QC08NH+xXy1tLcvvI7drkGZbSw7pyGGIxhXjF7Ecnoo=;
        b=VHU5jaiarh+QKGPjXoSMH1ToUAHZedCz+AWGNUO3kbzd5PYP6zvp6dxdizV0lFI7Ye
         2cX2sqgIgGEl+/Xlj+sKbjPAnCkhOpOzsFEoqMCZQgTvNdhGaljbJj6E9H6FuJ403EKn
         I/rYzwwXYJROV3ZXuf24MG0bE5cC1iBxOdmOu9VasSkEQX1lZoR5cyPT4nq+3NTF/wkN
         4BMZhqQa0+j6OiVNbUz3HwVmDqzppWSRlH9uIGF7GqexujJVNyoFcNkH1s1U0WkLbxn4
         pEkN5/t+rErqpxq7eP/RMrYmvUa+Mu8gMgT8E5bOiHoibp6HYA9lpxwWnH5GrLzjYIyn
         +nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QC08NH+xXy1tLcvvI7drkGZbSw7pyGGIxhXjF7Ecnoo=;
        b=ISDNcbJdxRdhnJz1Q3P/OEQ5uI2NXUGyi9E7mpZT3RjeCKzwBCqKShPFvKgEQxrNzP
         auc1KaI7ViNUSCl3usOf83s69JLPt1L5neJcnKz9sUCrDYgISN/Z1IIXImYm7MxLfMR9
         LgtfK89Vi5BqytEoL0j4yXW8O0zt5N8YC3UuhISXnDtycO11/adlRdDKMwdsMdGxI4qT
         ECgXdNS/E94YoMUJwKgfW/ffSFn3lp4zg0FuPAyDA8sF1VUk0+TPuOKU4U4aWottKua4
         DmNkNd+t9HZXCFyHJSJ+6lgmJTpbmc+YKAzcVXq+cjrvUVihIkFKhLd3pjPfKzIVCxY4
         bcFw==
X-Gm-Message-State: AN3rC/5gQZPcOQ5j0GI4FVScJY1jg6GWdF0sAjA8NEbTemrHm0FyFdmK
        /XO1ggbCmwMZZA==
X-Received: by 10.28.135.4 with SMTP id j4mr16565428wmd.107.1492584565665;
        Tue, 18 Apr 2017 23:49:25 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id o1sm849795wmd.16.2017.04.18.23.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 23:49:24 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] gitweb: tags feeds
Date:   Wed, 19 Apr 2017 08:49:14 +0200
Message-Id: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.822.g5451c77231
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A smallish patchset to implement RSS and Atom feeds to complement the
tags view, accessible as verbs `tags_rss` and `tags_atom`.

(I actually made this some 5 years ago, and it has been running on
http://git.oblomov.eu/ since, but for some reason I forgot to submit
it for upstreaming.)

The patchset is also available in the git repository at:

  git://git.oblomov.eu/git gitweb-tags-feed

------------------------------------------------------------------------

Giuseppe Bilotta (2):
  gitweb: infrastructure for tags feed
  gitweb: expose tags feed in appropriate places

 gitweb/gitweb.perl | 126 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 35 deletions(-)

-- 
2.12.2.822.g5451c77231

