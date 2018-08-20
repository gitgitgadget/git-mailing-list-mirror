Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3181F954
	for <e@80x24.org>; Mon, 20 Aug 2018 22:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHUBTd (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 21:19:33 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33628 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHUBTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 21:19:33 -0400
Received: by mail-yb0-f194.google.com with SMTP id d4-v6so1284891ybl.0
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AR0oLLJZXdQG4cYzZkff6zsQgXLpNNJwz0JsxpTsv8k=;
        b=DGJymw8hTPXDKfLSz+KuikuvaDI8qdP9HG0u8N464liN+q5RLbQC+DNULUH8YsC4E2
         S7znLIr7iRwgAPbNEL+b6VPQZ5TFCPx5f7N8bSNoHdAI5+HQ5snKI7myIwF9twW9eHf2
         jWATsgnaZvshUKD1gYrX4qBR7EfGFgh99wRJmuBMlCT0ESk2gc7ATwi2169wqqmTlexR
         PmQWKmOcQXCwNt7hwBY8riFPD/fin4qZWmOP53fSMxULwCKTu0gNkQTb7IswFo3mbaHX
         Ee0qGkVW0qrVvpgrmMLc1TbR6LbBNZsaRi/D01Sn+iE1/xfZgdUhWyPQGXKupCPscU8y
         jFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AR0oLLJZXdQG4cYzZkff6zsQgXLpNNJwz0JsxpTsv8k=;
        b=QxCXTszCwcisTMS/mVSTeCPrK21kfeB89SLGM8tlAeqVtNCu8grCYIALr7zvigecbG
         9i1fcZXCbFk/LOHQ8FJI8EgqKTuNESb5Klti1UXoyatJNfHJrxo4HCjBJMw65fcyHZrO
         SLBtLwDXNtSqJbWJ32lgW+Gzg8VLVO1ASzBc2kH2vanW36Yk86sWxgZkBDmB2deRBLqg
         +yD6XbKIP4OMV0T9W8jN4FZs5BcwnJDyGZRUkhI5u2397tB2M7ypqWSCHrQx3K/jCm4h
         fLpbPWpPFEJZAZumfqGl/TWk5oDt6ZuK81YKcDAIMl9SRM+fQf+lcaETYv3C+yOApgLf
         wgWQ==
X-Gm-Message-State: AOUpUlEpQz/704W18qf1TlusUra/0o874wYoT8inFZBBNNfBoJrfTuho
        kzHPIhjxONbouzhysbb45sCPIIMWNVRfkb/oYKUtQQ==
X-Google-Smtp-Source: AA+uWPxgdNCScQ8WeDHHWUB2ad6HstTx2Jgtgl8DuJJJKsa/esL87ZBXi1+b6tBwctw2Yp/U5KMcKb2bK0IdKZbGV3s=
X-Received: by 2002:a25:842:: with SMTP id 63-v6mr26943821ybi.425.1534802530580;
 Mon, 20 Aug 2018 15:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180820165124.152146-1-dstolee@microsoft.com> <20180820165124.152146-8-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-8-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 15:01:59 -0700
Message-ID: <CAGZ79kZFXof091d4qXUVyLJ9wGPL0sfs9XruZ-3Hjoq74-tjCg@mail.gmail.com>
Subject: Re: [PATCH 7/9] treewide: use get_all_packs
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 9:52 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> There are many places in the codebase that want to iterate over
> all packfiles known to Git. The purposes are wide-ranging, and
> those that can take advantage of the multi-pack-index already
> do. So, use get_all_packs() instead of get_packed_git() to be
> sure we are iterating over all packfiles.

So get_packed_git shouold not be used any further?
Do we want to annotate it as deprecated, to be deleted
in the future? Or even remove it as part of this series
(that might be an issue with other series in flight).
