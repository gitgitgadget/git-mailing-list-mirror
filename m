Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D1F1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 12:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758243AbdACMDO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 07:03:14 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:32818 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbdACMDM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 07:03:12 -0500
Received: by mail-it0-f68.google.com with SMTP id c20so50283475itb.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 04:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=slQdm7nzhnmh2KuQMXKLVId1XBXx5bBAppJB/NsWrAM=;
        b=kV24BEEh/LEQ1wOQm3jigU+E9JHEYWSi3+vz2w8h9wvt79F1VgBnTH6hDXm9oEsxwe
         nuKJVQXKDff93FjPYifgBfI4NEDgjZgTT/Y6wTCGpYXdAYU39qJfdhjhusfAziJoM6u7
         IDX7jpw7zoz/6UETfC5YMB7t1qCUxgvoJYQe3OGd9d7gTxUlXZrrvL5A4MKw9ePldUXw
         1gFdbRWXo0nPAmSDUGyrNOLaDqx7hYxsIL57Opgir1yh3V8IXy1L6G4whSItl07n8Jj4
         eZE25bMWcXCUSeAnI6qwRnIqH83BA1B3oDstDEEoQDB76e2VLUXH852TfneCzU5gwDmM
         bFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=slQdm7nzhnmh2KuQMXKLVId1XBXx5bBAppJB/NsWrAM=;
        b=dWWrHfyJMYEch3wW0vJNSONn1/3WdaLkyYYOWaAE089on/JuS/brlxGys3Rx7otqjU
         ys5p2qd5ZIFodyBLP7PFuY8n5+zr2hrkEmys/RvdC+E8awqd2A/UIuwXPLD1IjeXsdjB
         0oQnE737PV/T87NI6V1nl+zmz8fMm3zwT2p8iEGM5Ff5Lyh9Vc312/SYA5hXEJzPUiyC
         l5fpiMEBPxYprgdZz1V9UYco0sXHfKPlRQkgqnKi885BJXhEpEubxP+BmafJp5zcW5Lv
         W+ijfPa+DHJ57w3XMbSHK1FuD2/lECmYBIk3rUckd/SRugWikEH0nd87gv3F4jRePXhc
         lozg==
X-Gm-Message-State: AIkVDXKjTcf+yh947URhP0A3e503nywkIiuj+2GYMxqHA/klCekIkGI+DASNHuiuBr5CO5tdwiXqx5BvGkbX2Q==
X-Received: by 10.36.138.131 with SMTP id v125mr40945843itd.3.1483444991560;
 Tue, 03 Jan 2017 04:03:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 3 Jan 2017 04:02:41 -0800 (PST)
In-Reply-To: <1481670870-66754-3-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com> <1481670870-66754-3-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 3 Jan 2017 19:02:41 +0700
Message-ID: <CACsJy8AaRqJ4jaZ19__kFR+pXtjJ4o_Jik8NL_Mk5yaA4aGRBQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] dir: remove struct path_simplify
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 6:14 AM, Brandon Williams <bmwill@google.com> wrote:
> @@ -2010,14 +1987,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>         return root;
>  }
>
> -int read_directory(struct dir_struct *dir, const char *path, int len, const struct pathspec *pathspec)
> +int read_directory(struct dir_struct *dir, const char *path,
> +                  int len, const struct pathspec *pathspec)
>  {
> -       struct path_simplify *simplify;
>         struct untracked_cache_dir *untracked;
>
> -       /*
> -        * Check out create_simplify()
> -        */
>         if (pathspec)
>                 GUARD_PATHSPEC(pathspec,
>                                PATHSPEC_FROMTOP |


This GUARD_PATHSPEC macro should be moved into simplify_away() and
exclude_pathspec_matches(), so that next time somebody adds a new
pathspec magic, they can basically grep GUARD_PATHSPEC and determine
if these code can support their favorite magic or not.
-- 
Duy
