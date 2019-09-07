Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8A71F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395322AbfIGXn2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:43:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39501 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfIGXn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:43:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so7917032oia.6
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMUUgKY7Okfo0jV33IskxaJGN7jtj9PycYqANtmUQJo=;
        b=r/u+3UR9MGAtD/j0bdfr2Jy5tqYkhfMnKcBbguqvoq4BljvE4xp/VN1BzWdsSD5Tyy
         Wv/liaq/uIXAQ8nnrRfo8LxVBX80bqP2VO82XTm5Vz4tK0xUyYQAqhfs/6ZwxOLj+uJ6
         JBnVt2nypxUyKB3fx0etr/0mH3DPIlz7o/S6BpTxLfbua8Cpg37PHwa/ze0AQHruRjsS
         stoitDnPZ9oYuq4PDIcCca6EvY7kJTxRSZXMVryzeshFTqiS0Y6SLqfTSyj/Ud+lnjvC
         vM638+uI+RgKuozKVHYatKOEBJW5ePVbtAvQmk+IvD6HJHyzOUsZD8OwqLm/Pr+y85br
         pnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMUUgKY7Okfo0jV33IskxaJGN7jtj9PycYqANtmUQJo=;
        b=OzZQCld7u2oKLEw6ubf22qFcj5xQx4lvUBmeSC6FPP6X8J4BgfFufgEw0o0MKddfpO
         mCwb79XsWMcE41Fzz/PUM36Bil2B7CGoCD8E7H3Gkk2qy8rDnpyWIrf4BfetUcP32bYx
         WmWXLqYHNzawgpg1nRYiSBjFfrQteympWb5HSBifdkdqnPx5ct552v8vEvOXJigMYPtb
         j5LFbY4+x+QVTCGU+re1dV7jcLi6JZx8Z/jF2NgHXOOQZ0e5iGQ7MWS89BZoXp0SAeKr
         fyQTAC5c/K8CYcoqoHAYm5KHX5gJUNZPbjcsuGiEptXC1siS943zru/NrbIBsnxFZlmh
         5sTw==
X-Gm-Message-State: APjAAAUtFs/vFw9Gb7jZOLzIZGm9Mf7INgzmC930Sv86lHg14EltXb6z
        i88yFhqXwJ28sN+Cryc0W/c=
X-Google-Smtp-Source: APXvYqwSkvg09ZOUTOLU3u/XKMYl4nXCNQqGWqRgK/cFGcSt8qGNM8zCtt9SbKrI4IXzpjpZ0tas2Q==
X-Received: by 2002:aca:3141:: with SMTP id x62mr12454102oix.158.1567899807514;
        Sat, 07 Sep 2019 16:43:27 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:8a10:1290:ccab:112b:24b3:bd34])
        by smtp.gmail.com with ESMTPSA id 19sm3344668oin.36.2019.09.07.16.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 16:43:27 -0700 (PDT)
From:   Warren He <pickydaemon@gmail.com>
X-Google-Original-From: Warren He <wh109@yahoo.com>
To:     phillip.wood123@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, phillip.wood@dunelm.org.uk, pickydaemon@gmail.com,
        sandals@crustytoothpaste.net, wh109@yahoo.com
Subject: Re: [PATCH] rebase: introduce --update-branches option
Date:   Sat,  7 Sep 2019 16:43:05 -0700
Message-Id: <20190907234305.1524-1-wh109@yahoo.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <713b055b-aaf2-4294-12d3-2941d53eac16@gmail.com>
References: <713b055b-aaf2-4294-12d3-2941d53eac16@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip, thanks for the comments. Indeed other branches that are not in the todo
list are still not updated.

I'm collecting the arguments about deferring the branch updates and issue with
worktrees for discussion along with Johannes's review.
