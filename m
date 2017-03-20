Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A633E20958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbdCTSLX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:11:23 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35743 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755903AbdCTSLT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:11:19 -0400
Received: by mail-pf0-f182.google.com with SMTP id 20so21293710pfk.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sz/nu9rnkTitI20fwbn9nhxl6/0D93gxCMqjMXPZksA=;
        b=msjL17RXW7+Gx7+iZ3Uod8yw2ZITIRHZm5cfQJS0sCM6f0Zo800mgJpdEWMHeC7g/m
         EGQCtgp3jrWeSZ6Rcqu45YCRowiubCnPIUG5Kt/3QzRvxNAo+rNk+06MJBRGNywtAHe1
         hVTm3mEv+R9W8J5x16WVS9YZW2pIaHMMYK9QS/afS50H9VgPyZhRypHy1CgW8RRZLbW6
         obNsKYdDcB0UaCdDu/9/oeu9mN/PRMcKUTa4M2Qyiy+rG7LqemnU5XVdGYbsxPVxTH8r
         jAXnXuxchCAXEB9QhUwcXQX008VDB5oMIo1Zg+HAoiSenFSyE7INJJ2xfZebZHptzhZo
         EsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sz/nu9rnkTitI20fwbn9nhxl6/0D93gxCMqjMXPZksA=;
        b=Cm5iAHyY4NKON+FccD/+b33WmpPtDHIQev7dYn3XesX+dJHBfigR7ZrtNZpsgsAL8r
         t8TZdFn8nZKb18+9Hf1/vUjcIImTLGJ5R5+CjVBWUTzSurkATh2mW2lC2KfbNy/efpmg
         h4WZtnth3BJa11xfA0FFDjAyvZh7ve9IbA0woY7FLNMPP+KaTYKaF4iKXwJsL3vxwp4l
         TW5rNPO80ibFr/txqTs7nwvTSgtytRHGmHmquMBIrmQnaVMeNmn1T1WB+BbiPMz1osGn
         IpnVE6qmIOF3e8BGydtBwAEyl7f10Y8D6RJZlqA5AHf5dqXLFb8kYzUkY1LsgPmdQpLy
         f/5A==
X-Gm-Message-State: AFeK/H2T+F4j6ncdHGtGRIk7FS3YjZnVVxT1RJJYkHUKW9fMzHvvwChIoPrOMFthsiQMVi5RUCQaUFrGDj9j2EOH
X-Received: by 10.84.239.8 with SMTP id w8mr41912596plk.73.1490033477914; Mon,
 20 Mar 2017 11:11:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Mon, 20 Mar 2017 11:11:17 -0700 (PDT)
In-Reply-To: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
References: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Mar 2017 11:11:17 -0700
Message-ID: <CAGZ79kY1g-4c+GXZy3p-q=MsBY94esxsfs2=OPuhOH_o5oGc_Q@mail.gmail.com>
Subject: Re: [PATCH] Correct compile errors when DEBUG_BISECT=1 after
 supporting other hash algorithms
To:     Alex Hoffman <spec@gal.ro>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Brian

On Sun, Mar 19, 2017 at 2:33 PM, Alex Hoffman <spec@gal.ro> wrote:
> ---
>  bisect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 30808cadf..6feed8533 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -131,7 +131,7 @@ static void show_list(const char *debug, int
> counted, int nr,
>                 unsigned flags = commit->object.flags;
>                 enum object_type type;
>                 unsigned long size;
> -               char *buf = read_sha1_file(commit->object.sha1, &type, &size);
> +               char *buf = read_sha1_file(commit->object.oid.hash,
> &type, &size);
>                 const char *subject_start;
>                 int subject_len;
>
> @@ -143,10 +143,10 @@ static void show_list(const char *debug, int
> counted, int nr,
>                         fprintf(stderr, "%3d", weight(p));
>                 else
>                         fprintf(stderr, "---");
> -               fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
> +               fprintf(stderr, " %.*s", 8,
> sha1_to_hex(commit->object.oid.hash));
>                 for (pp = commit->parents; pp; pp = pp->next)
>                         fprintf(stderr, " %.*s", 8,
> -                               sha1_to_hex(pp->item->object.sha1));
> +                               sha1_to_hex(pp->item->object.oid.hash));
>
>                 subject_len = find_commit_subject(buf, &subject_start);
>                 if (subject_len)
> --
> 2.12.0.399.g9d77b0405.dirty
