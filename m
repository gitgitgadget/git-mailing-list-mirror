Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18741F424
	for <e@80x24.org>; Thu, 26 Apr 2018 22:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756931AbeDZWwW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 18:52:22 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44715 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756740AbeDZWwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 18:52:20 -0400
Received: by mail-ua0-f196.google.com with SMTP id h15so11881684uan.11
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sC0nip+3e8cviVTWZaxvb9GlRZNcSzmz4VuGxZ+8wdk=;
        b=vhCmwjm/Iyzu2QXhAt18GhSJLJeoHqpFCd49HbKGpKgKpX7vYqzolY0IH/Mfn0o7iY
         gOysOX/OykrjSb3AGoWcAULGaBurSRiAuIenPccQW41MSR/mr6xdNISgsgOWb/pvTY/D
         HNPESyyaDSscS3ZJ6cs2OFh2wOZJ7mI6zw0pTmyxAtqO56Dpfr7UUZuPrwDGkdLzA0Z9
         gg5byN9KjCHE+ubvFK3qHVNCIU8GchbpFpBHDeDwcvHIwW8sD7e5up9k6OybPqHfHywn
         Tp0SnPXe7nsWVF7gleXj2rtqfrwZQiAcAFQydRAgGP99zpZX8XQFJSsRF/5NmSsWBia4
         UFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sC0nip+3e8cviVTWZaxvb9GlRZNcSzmz4VuGxZ+8wdk=;
        b=lqxSB8XtYR3yEHzE5WjoIjx4PtRPChM1PZwWEmPQvmZV4ZfrtkzVfVX40AyQUq3hWW
         UME+AyitCUe+wta7mUqV09VDCIXkOzztJ4fa9yVSfiS2zekTL87Qn03/H9uYk8wQJEZG
         oji9X7/4ihKdBC/3Kk61YruQYQW5xko15w/OA4AOUcxWSNLBjmCRtZaqQJYddVTzU7wU
         aAVnpYPAHVNFNRa1BKm5Qbj2qtaHs4fEYs7HCbS1IEJ/vVNAUuaEj/VIQAt+3sI+80DO
         qgVyzTj+HTWRvW+7Pa7UhgPa4P/2OJRABP5t5uQtA8qQTjGOEqMCZ7UEL16Y5d7ZDRAf
         JrFA==
X-Gm-Message-State: ALQs6tCvevZZduUDmgHDuuepUgUPqcmRCT9vTptkiWydqF0BHXwfpHBP
        5PHnuwxmVd4MjE6NrspVS89FPVMlnZ5r5nHmNFM=
X-Google-Smtp-Source: AIpwx4/z1Ed2BAArRdQmvpbs9RyQlVarfzFjCuqPSBIJEBYViCIhJDakBu7tZMD9U9diKkrna/7QE5/yieyX2UPSwMI=
X-Received: by 10.176.90.48 with SMTP id l45mr19816489uad.79.1524783139570;
 Thu, 26 Apr 2018 15:52:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 15:52:18 -0700 (PDT)
In-Reply-To: <20180426205202.23056-3-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 15:52:18 -0700
Message-ID: <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 1:52 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:

> +merge.renames::
> +       Whether and how Git detects renames.  If set to "false",
> +       rename detection is disabled. If set to "true", basic rename
> +       detection is enabled.  If set to "copies" or "copy", Git will
> +       detect copies, as well.  Defaults to the value of diff.renames.
> +

We shouldn't allow users to force copy detection on for merges  The
diff side of the code will detect them correctly but the code in
merge-recursive will mishandle the copy pairs.  I think fixing it is
somewhere between big can of worms and
it's-a-configuration-that-doesn't-even-make-sense, but it's been a
while since I thought about it.

> diff --git a/merge-recursive.h b/merge-recursive.h
> index 80d69d1401..0c5f7eff98 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -17,7 +17,8 @@ struct merge_options {
>         unsigned renormalize : 1;
>         long xdl_opts;
>         int verbosity;
> -       int detect_rename;
> +       int diff_detect_rename;
> +       int merge_detect_rename;
>         int diff_rename_limit;
>         int merge_rename_limit;
>         int rename_score;
> @@ -28,6 +29,11 @@ struct merge_options {
>         struct hashmap current_file_dir_set;
>         struct string_list df_conflict_file_set;
>  };
> +inline int merge_detect_rename(struct merge_options *o)
> +{
> +       return o->merge_detect_rename >= 0 ? o->merge_detect_rename :
> +               o->diff_detect_rename >= 0 ? o->diff_detect_rename : 1;
> +}

Why did you split o->detect_rename into two fields?  You then
recombine them in merge_detect_rename(), and after initial setup only
ever access them through that function.  Having two fields worries me
that people will accidentally introduce bugs by using one of them
instead of the merge_detect_rename() function.  Is there a reason you
decided against having the initial setup just set a single value and
then use it directly?
