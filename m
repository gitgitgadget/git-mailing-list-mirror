Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017A01FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 18:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031506AbdDTSVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 14:21:07 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35091 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969272AbdDTSVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 14:21:06 -0400
Received: by mail-yb0-f175.google.com with SMTP id 6so33126874ybq.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cu+cWlBPlYI8xIPOYGBtHIZH6kUKez4Ojo98DMQsFho=;
        b=Fj760VVwf1R+96nt0y/OgNkNnCm4lsFpbqhQ6K6QF3Fys34grOUV/Q7ATnN4yAupuP
         cRKtd3Sjbal/ULEoqXoPDF/U9c8ZUx4Foy2aPM7/rsywojQD/Vg3oAHv/F93SdrtNl5a
         txfVo3iDsExYYbDXsG1+LGIw5ggVJ7nMywZsyNVkRr6nEwyFag18LLEQ+NV1cyYonlta
         opknMfPafAhNHUsi1qO9+7sXXk+mV5kbc8dsSgdXn/PNXZVxPRHIfQMGkLssFxVE0Tk1
         6QZozh7Z0TRHSE0jy7vejd8zP7SepnlIU2hmlw1N2Jrl1N2YHLrNw26MbYWWBSo9rb8O
         y01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cu+cWlBPlYI8xIPOYGBtHIZH6kUKez4Ojo98DMQsFho=;
        b=GJduR5WpeYxlUyr5t5q6+PljfomLXcK5cxDaNNFbaF0SXbKHJNeUYpMVZcP3IpUVWL
         i5c58eWFaq8AwLBEy+pbfxcIa0zOU/c6CkVriPMcjFTYXmD8GvwJHZnvKWLGIOfODjVe
         gdQmclGOC5eOLqkgQc6xknblh/Z/wr4hjYFMY6HW/ENe5F5XrIL77/4/36NVmI3QU6wB
         fxazvu3Xi6QFX0ZCLAW1I5cC3RgnJ853mMRmjRGqUJWU2k5gC53z+WgJsD4XUgec6aCD
         hOs7EtYo0D2zhcVIgJfkcr4Kav2e/0xXslxRbeQkSu4x+9ofk2YigLsm5SDBWhzOatss
         fUfw==
X-Gm-Message-State: AN3rC/5Bq+13eBzersCXT2tta4qUrMx6H3SH9btD171HU/Lm4ebMgVBs
        ZipfY7m7ipeaVkuquzuJCn5MECJkiBdBjfc=
X-Received: by 10.98.24.195 with SMTP id 186mr8964824pfy.35.1492712464729;
 Thu, 20 Apr 2017 11:21:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 20 Apr 2017 11:21:04 -0700 (PDT)
In-Reply-To: <20170412200037.18752-1-sbeller@google.com>
References: <20170412200037.18752-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Apr 2017 11:21:04 -0700
Message-ID: <CAGZ79kYTqh=Qa+Pt1+MojrcYFr05HQgbPRcc=DvjCkUWsjP5Uw@mail.gmail.com>
Subject: Re: [PATCH] refs.h: rename submodule arguments to submodule_path
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Junio

On Wed, Apr 12, 2017 at 1:00 PM, Stefan Beller <sbeller@google.com> wrote:
> In submodule land we carefully need to distinguish between the path of a
> submodule and its name.
>
> The path of a submodule is the path that is recorded in the working tree
> of the superproject and describes where the submodule is bound to the
> superprojects tree.
>
> The name as introduced in 941987a554 (git-submodule: give submodules
> proper names, 2007-06-11) exists to track submodules across renames of
> submodules. It is also used for the internal path in .git/modules/<name>
> to store the git directory of the submodule inside the superproject.
>
> When looking up ref functions to use, I was confused which of the two
> submodule properties are meant in the argument of the ref functions.
> The context in which the functions were used however revealed it is the
> path of the submodules.
>
> Rename the arguments to clearly describe what is expected as an input
> argument.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/refs.h b/refs.h
> index 3df0d45ebb..451f92958a 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -86,7 +86,7 @@ int peel_ref(const char *refname, unsigned char *sha1);
>   * successful, return 0 and set sha1 to the name of the object;
>   * otherwise, return a non-zero value.
>   */
> -int resolve_gitlink_ref(const char *submodule, const char *refname,
> +int resolve_gitlink_ref(const char *submodule_path, const char *refname,
>                         unsigned char *sha1);
>
>  /*
> @@ -204,16 +204,16 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
>  int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
>                          const char *prefix, void *cb_data);
>
> -int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> -int for_each_ref_submodule(const char *submodule,
> +int head_ref_submodule(const char *submodule_path, each_ref_fn fn, void *cb_data);
> +int for_each_ref_submodule(const char *submodule_path,
>                            each_ref_fn fn, void *cb_data);
> -int for_each_ref_in_submodule(const char *submodule, const char *prefix,
> +int for_each_ref_in_submodule(const char *submodule_path, const char *prefix,
>                 each_ref_fn fn, void *cb_data);
> -int for_each_tag_ref_submodule(const char *submodule,
> +int for_each_tag_ref_submodule(const char *submodule_path,
>                                each_ref_fn fn, void *cb_data);
> -int for_each_branch_ref_submodule(const char *submodule,
> +int for_each_branch_ref_submodule(const char *submodule_path,
>                                   each_ref_fn fn, void *cb_data);
> -int for_each_remote_ref_submodule(const char *submodule,
> +int for_each_remote_ref_submodule(const char *submodule_path,
>                                   each_ref_fn fn, void *cb_data);
>
>  int head_ref_namespaced(each_ref_fn fn, void *cb_data);
> --
> 2.12.2.603.g7b28dc31ba
>
