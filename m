Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99B92036B
	for <e@80x24.org>; Fri,  6 Oct 2017 08:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbdJFIFM (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 04:05:12 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:46284 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdJFIFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 04:05:11 -0400
Received: by mail-qk0-f178.google.com with SMTP id k123so13594602qke.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dam.io; s=arbre;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/svJpYO3Ssz9Wz3Xa/xkeYdKUby+G8246WjyAzl8yYM=;
        b=kRUC1v4h6vMuQUtg5cHM/sL2Nz7ejTU/lYBAXciddPKbBDyHt040xGIt9sbhSauqjE
         ckMsOEwLi0jJiuAxfiaXKqNEABPD7VnO2MUwdvUagmcdjzVabNlLiBlBbROe+f389YFg
         Ddm4gk9o5TN1X53SiiKsCePV/ErJQSAKHJM/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/svJpYO3Ssz9Wz3Xa/xkeYdKUby+G8246WjyAzl8yYM=;
        b=P7FfeGpfxISlNncahlIvUGEm2qBkMeR9aoZ7PzlBocmFYTcI0qOTlyUfqcEXMQsVo9
         h8vUs7tQFxrqJELzoII0pMDauqOGcLPFu63oMTqndwJW9aIrXXOP0pWDgZbsViUuS0/B
         9eE5AoQX7/TE1ALqBp+TUPyhvD+8sAnEHYmZmeHgNtmIy+1b+Vl8kO3uaCWPuQ2p2tIA
         DlENUTvkmyq9/WMwXi756d2yUlaYImdd0E8Fk92WGN+UmSbihSjBUUotJRX7wgw+pkVH
         lTyGq21ce5P7ta9zUp/v80+y+044jh2afY/O0yN07A9L5+D/2wWRRI53hZeWRezPtDMp
         DIxQ==
X-Gm-Message-State: AMCzsaWdB0MYUOAa5y2vKwDQEDOSDVCfsDFwsGD9G7oMLufVSnbHqFKu
        LMljKrQYZBCWUhqcwVHwuyuqdAYI
X-Received: by 10.55.137.198 with SMTP id l189mr5061694qkd.169.1507277110156;
        Fri, 06 Oct 2017 01:05:10 -0700 (PDT)
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com. [209.85.220.174])
        by smtp.gmail.com with ESMTPSA id r189sm552506qkd.86.2017.10.06.01.05.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Oct 2017 01:05:09 -0700 (PDT)
Received: by mail-qk0-f174.google.com with SMTP id 17so17063808qkq.8
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 01:05:09 -0700 (PDT)
X-Google-Smtp-Source: AOwi7QBn5UeQ+Ni/S0VWr9OXHDZvr+z1yNEGTMv9IpVD4Ij+LNh6BVnx4WopbBPHvtN/3ESD/g+9MeVhlwcw+9J885A=
X-Received: by 10.55.124.71 with SMTP id x68mr30901986qkc.10.1507277109426;
 Fri, 06 Oct 2017 01:05:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.149.67 with HTTP; Fri, 6 Oct 2017 01:04:48 -0700 (PDT)
In-Reply-To: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
 <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
 <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com> <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
From:   Damien <damien@dam.io>
Date:   Fri, 6 Oct 2017 10:04:48 +0200
X-Gmail-Original-Message-ID: <CAAQ5yihg2+BNVG-Dpvq8-qV21uX8xLsDmQpvhUzD5nSvMRFyyQ@mail.gmail.com>
Message-ID: <CAAQ5yihg2+BNVG-Dpvq8-qV21uX8xLsDmQpvhUzD5nSvMRFyyQ@mail.gmail.com>
Subject: Re: [PATCH v2] run-command: add hint when a hook is ignored
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the help, a new patch is coming with those fixes applied.

On Fri, Oct 6, 2017 at 7:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think it is easier to reason about if this were not "else if", but
>> just a simple "if".
>
> And here are two small suggested changes to the code portion of your
> patch.
>
>  - break if / else if cascade into two independent if / if
>    statements for clarity.
>
>  - give the "ignored hook" advice only once per <process,hook>
>    pair.
>
>
>
>  run-command.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 0f8a5f7fa2..0e60dd2075 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -5,6 +5,7 @@
>  #include "argv-array.h"
>  #include "thread-utils.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>
>  void child_process_init(struct child_process *child)
>  {
> @@ -1170,19 +1171,25 @@ const char *find_hook(const char *name)
>         strbuf_git_path(&path, "hooks/%s", name);
>         if (access(path.buf, X_OK) < 0) {
>                 int err = errno;
> +
>  #ifdef STRIP_EXTENSION
>                 strbuf_addstr(&path, STRIP_EXTENSION);
>                 if (access(path.buf, X_OK) >= 0)
>                         return path.buf;
> -               else if (errno == EACCES)
> +               if (errno == EACCES)
>                         err = errno;
>  #endif
>                 if (err == EACCES && advice_ignored_hook) {
> -                       advise(_(
> -                               "The '%s' hook was ignored because "
> -                               "it's not set as executable.\n"
> -                               "You can disable this warning with "
> -                               "`git config advice.ignoredHook false`."), path.buf);
> +                       static struct string_list advise_given = STRING_LIST_INIT_DUP;
> +
> +                       if (!string_list_lookup(&advise_given, name)) {
> +                               string_list_insert(&advise_given, name);
> +                               advise(_("The '%s' hook was ignored because "
> +                                        "it's not set as executable.\n"
> +                                        "You can disable this warning with "
> +                                        "`git config advice.ignoredHook false`."),
> +                                      path.buf);
> +                       }
>                 }
>                 return NULL;
>         }
> --
> 2.15.0-rc0-155-g07e9c1a78d
>
