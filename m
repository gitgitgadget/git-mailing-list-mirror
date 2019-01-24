Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037071F453
	for <e@80x24.org>; Thu, 24 Jan 2019 22:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfAXWPC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 17:15:02 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:47179 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXWPC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 17:15:02 -0500
Received: by mail-yb1-f202.google.com with SMTP id j74so3566532ybg.14
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kwGuvBg9oXZWtrVBa0pAeqC9eCODndZuDLAO7NPoF1g=;
        b=OiMImNbXEitYPmdh2Cp1gNVuN0GjSOkN1EDcAJVjwBdDolViK0YjqD0GwEiooZsFbZ
         GBwE6lQvb148i5MaZrSa8x6ZhRM7rnbAASRT+Ngjt864ybIK1BMveTWHZ5vrfeXS6k2r
         HULyvm7HS5p2FnsMfrPYzCv8NU7zKcUAhY6o6tTvlR0dvtskkRGc3+Bq0Knx2WhVzzFF
         J7Ir+CqAY0X8W8KH6pJgdYgjPntbaXmh5MNEKjqlI4+mSZHmPhZ6ITy98GiVBY2JQFGm
         N785/IFPgm4xZ9OkzPXhs3C4AkBnmPKnSsXo9q6ELaatD3pCEPcIPKieWIBw796xfWnt
         Gtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kwGuvBg9oXZWtrVBa0pAeqC9eCODndZuDLAO7NPoF1g=;
        b=gpnoYbKj1sSWz8hrynnNg100UzKfu9kJdoYNWVZXrq7OOUEr+ZN7jyr/CQSSSlQerS
         MJCMxdXf5Fiua+wX/JdPklu0qpjfJ/6fpmiUaNSARBfsNBz9YVLn+ev5A88UjR4Z5z17
         3DD5NVA3hJUQ4EzyzTorLSWHdIGB2wkIwc+Fg2jCGdNa6rG5CGp+9QbTscXqRY2+ed6G
         2g08ERGpwPgYNttLwILOSJEcz7bbr9cU6QGnr8FXUFeZn5MwzwNU2PAox7ocq7n3hlcm
         pd8mH312QjJkaLT1b5hubv+ip/ohtIC2MOrXa5v95vvvuLFB5vC9MqdXq30p/HdmQFBD
         GqQQ==
X-Gm-Message-State: AJcUukecPKY8MjEInLUK85aznvVLsXKb6ISQ8vEzSZyhfPprSOsMQCrX
        aZ9zFdXTv03vy9ltK9AuPQ7UhMtbwaQWZ98qt9tO
X-Google-Smtp-Source: ALg8bN4PrISa/W+m9NDNX8qoBys86ODalmXNCndIFTFz6IwPOBoGiWsohwJFl1unrV3xj55C/7TpuY9fW/FslIMu97wu
X-Received: by 2002:a25:c601:: with SMTP id k1mr4164362ybf.96.1548368101721;
 Thu, 24 Jan 2019 14:15:01 -0800 (PST)
Date:   Thu, 24 Jan 2019 14:14:57 -0800
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
Message-Id: <20190124221457.11062-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.92.v4.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v4 00/10] Create 'expire' and 'repack' verbs for git-multi-pack-index
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Updates in V4:
> 
>  * More 'verb' and 'command' instances replaced with 'subcommand'. I grepped
>    the patch to check these should be fixed everywhere.
>    
>    
>  * Update the tests to check .keep files (in last patch).
>    
>    
>  * Modify the tests to show the terminating condition of --batch-size when
>    there are three packs that fit under the size, but the first two are
>    large enough to stop adding packs. This required rearranging the packs
>    slightly to get different sizes than we had before. Also, I added 'touch
>    -t' to set the modified times so we can fix the order in which the packs
>    are selected.
>    
>    
>  * Added a comment about the purpose of pack_perm.

Thanks, the interdiff and patch 10 look good to me (I already reviewed
V3). I also verified that in the last test, if there is no .keep file,
the test fails as expected.
