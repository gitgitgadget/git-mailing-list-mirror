Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946362018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbcF1R4Z (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:56:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36335 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbcF1R4X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 13:56:23 -0400
Received: by mail-io0-f193.google.com with SMTP id s63so2781659ioi.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 10:56:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/v2vyuFvlYhXcPn+pEa1jXNe6dBmWaBKV+4kYR3psWc=;
        b=O1Q6H+z0q5p5enKlCtbNMaRVwcEfZvLsvjHADZQo70znci22JEJPpCxGTficpRE8jy
         NE2YA0fhxeS7Hr/Dkp4RVkMcbn0YKQpu4sXI+PCE0TQVannxKr783eJFwhj6ISkWWIty
         jREw+rwbuv71RrszGUtNnq3/Nny8umWUubZKB2nO3BmUVFLBb7Yqkq6qPDn2DG8/zN5b
         j4ixZWW/l3rz97WANG8g7ZU8Y3hc3UMAW/W6pve7DlQ9xq+Sjg0oj1GQSO90HppM7jh+
         K8hAZ/7PxawvUl6ilNQKW7xdYeGZ/20GRA4jE/5N2zBVp2XDttX2LGncJlMi90rbQi9A
         r8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/v2vyuFvlYhXcPn+pEa1jXNe6dBmWaBKV+4kYR3psWc=;
        b=L77GopOj0g9CaM61i3kNz56KXMAYGR/DhUa4t26zv8GCVV88D5JzXShZxi1UevcVoz
         xYZ+3+bm5SI/KTLD+Sses8UKYmrebdS1VAwr5y91ZXp39nr0Gpk3L0Eu7bIIaEoY+34a
         GduK5Dc90Rb83+TRi3QvGHwacw2i8nMbJVIvRNM4NuFanYjfA5ORvdZZ68XoBgSyt6O+
         8tjWnOGcVFfeBoZzKWkiFgeU0VUevhugejyzGriG1LG0qW+b9RDPHQUomFey1rvgGWGW
         dBSi3rYGMtEVIUIfScW+SH5lPesHqBQ4MKytfE3D9bF3yGy7W3+mh/N8fTog91SOFBbp
         TzVg==
X-Gm-Message-State: ALyK8tLFmJbi6cqRCNI5XmuUDRCZpyqadqSl5lcygkt3hDFTRTPsWxoIqhCoOIeCuy8VK3BszZSoqsDZFcW0kg==
X-Received: by 10.107.8.220 with SMTP id h89mr5107763ioi.95.1467136582321;
 Tue, 28 Jun 2016 10:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 28 Jun 2016 10:55:52 -0700 (PDT)
In-Reply-To: <1458739840-15855-1-git-send-email-pclouds@gmail.com>
References: <1458739840-15855-1-git-send-email-pclouds@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 28 Jun 2016 19:55:52 +0200
Message-ID: <CACsJy8CdXxJ6ydZ944sGZetDwpb8TTgNBtv3PLS=4dLT4mbXmw@mail.gmail.com>
Subject: Re: [PATCH] sha1_name.c: add an option to abort on ambiguous refs
To:	Git Mailing List <git@vger.kernel.org>
Cc:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Bringing this up again after I've seen another person accidentally
create a refs/heads/origin/some-branch and get really confused because
"git push" reports up-to-date but the remote branch is not updated. I
don't know how he got into that situation, but I hope we should be
able to catch it and suggest a way out.

On Wed, Mar 23, 2016 at 2:30 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> There are cases when a warning on ambiguous refs may go unnoticed
> (e.g. git-log filling up the whole screen). There are also cases when
> people want to catch ambiguity early (e.g. it happens deep in some
> script). In either case, aborting the program would accomplish it.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt |  3 ++-
>  config.c                 |  5 ++++-
>  sha1_name.c              | 10 ++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2cd6bdd..4172f59 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -522,7 +522,8 @@ core.sharedRepository::
>
>  core.warnAmbiguousRefs::
>         If true, Git will warn you if the ref name you passed it is ambiguous
> -       and might match multiple refs in the repository. True by default.
> +       and might match multiple refs in the repository. If set to "fatal",
> +       the program will abort on ambiguous refs. True by default.
>
>  core.compression::
>         An integer -1..9, indicating a default compression level.
> diff --git a/config.c b/config.c
> index 9ba40bc..79f1ea5 100644
> --- a/config.c
> +++ b/config.c
> @@ -738,7 +738,10 @@ static int git_default_core_config(const char *var, const char *value)
>         }
>
>         if (!strcmp(var, "core.warnambiguousrefs")) {
> -               warn_ambiguous_refs = git_config_bool(var, value);
> +               if (!strcasecmp(value, "fatal"))
> +                       warn_ambiguous_refs = 2;
> +               else
> +                       warn_ambiguous_refs = git_config_bool(var, value);
>                 return 0;
>         }
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 3acf221..a0f0ab9 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -480,6 +480,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
>                                 warning(warn_msg, len, str);
>                                 if (advice_object_name_warning)
>                                         fprintf(stderr, "%s\n", _(object_name_msg));
> +                               if (warn_ambiguous_refs > 1)
> +                                       die(_("cannot continue with ambiguous refs"));
>                         }
>                         free(real_ref);
>                 }
> @@ -537,8 +539,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
>
>         if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
>             (refs_found > 1 ||
> -            !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
> -               warning(warn_msg, len, str);
> +            !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY))) {
> +               if (warn_ambiguous_refs > 1)
> +                       die(warn_msg, len, str);
> +               else
> +                       warning(warn_msg, len, str);
> +       }
>
>         if (reflog_len) {
>                 int nth, i;
> --
> 2.8.0.rc0.210.gd302cd2
>



-- 
Duy
