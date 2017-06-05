Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9FA1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 23:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdFEXMb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:12:31 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35707 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdFEXMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 19:12:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id l89so15270732pfi.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OGxatueKCGyhevgEHVvU9NdL9U+hfKHJqEVpJVIcFmI=;
        b=BOv9NLUgT0yKydQBt/fOf1zx/c8OLLOHcjAlKJ41cUSPWMwwRfU92+ueKH4N5w7y1b
         qvUTzylLKY6epE0jkwT+Oj5pQhP532/26COM/+wb9bTBGefk9trIDjdoViyhhZ3kD1qf
         xb9IbbosX5x0SvLv8OhhjIQRvpxweL2mNEWwKZQwi7KqygYz3+XH8Ws5lHIS1eYbJvCH
         8yAPOrSGeptvn0egjZRuOl2U8duK1FT3IfiXmuAmS4dstSoFWhkH3/10oJIzkuRW0CqP
         yQt7M1YZI69UBsBVFB9NhnX6KV8GXbShWe6C4rQXEI9nVO5LVM/p1tV42dpTMtey3n21
         Qjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OGxatueKCGyhevgEHVvU9NdL9U+hfKHJqEVpJVIcFmI=;
        b=ODb1FFviI5bjAxSXpBmps1UrcVrjnKP8VDnumieMRXJLbiPI1olZTr1lEe/WzBIOdJ
         ClfVcD+N+UdulU2fIvDBMBRF9mQrsKGpLinHhAAXkp+PXWQb4ea1BhIKUZLldPNEaB0W
         AyhpkSbd/LdTlM8xCqcw9/segk4oGZvx2WA8hsuPApikoDdvPCVlo128u0Ud/mmYbdtu
         Y/aCX7NvRIAq0dwvO4Rzkg+U484501DPMrEMxrckRKrnnk9QA6xrG4k5ahefD8tp9Von
         3FtFYkJY83nmX6cPjGCjX3WRVBrQ+wdAVvvd50JiRpcF7T7R66R/e9NPQ7chMcIEamus
         Ak1g==
X-Gm-Message-State: AODbwcBLnZ6fusCB5yF7xH0rj7MJeRN0Wo422wYSCl9KTrQPzEEYKHLi
        htuaqUvREP+8sj1aLD5N8Q7k8tEkDK+e
X-Received: by 10.98.34.8 with SMTP id i8mr10158823pfi.194.1496704349736; Mon,
 05 Jun 2017 16:12:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 16:12:29 -0700 (PDT)
In-Reply-To: <20170605202529.22959-2-pc44800@gmail.com>
References: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
 <20170605202529.22959-1-pc44800@gmail.com> <20170605202529.22959-2-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 16:12:29 -0700
Message-ID: <CAGZ79kZW=B1kd91y6VCushz5tqk1jYW=WzHheHi1pSiMWMQ4iQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 2/2] submodule: port submodule subcommand status
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 1:25 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule subcommand status a builtin. Here
> 'status' is ported to submodule--helper, and submodule--helper is
> called from git-submodule.sh.
>
> For the purpose of porting cmd_status, the code is split up such that
> one function obtains all the list of submodules, acting as the front-end
> of git-submodule status. This function later calls the second function
> for_each_submodule_list,it which basically loops through the list of
> submodules and calls function fn, which in this case is status_submodule.
> The third function, status submodule returns the status of submodule and
> also takes care of the recursive flag.
>
> The first function module_status parses the options present in argv,
> and then with the help of module_list_compute, generates the list of
> submodules present in the current working tree.
>
> The second function for_each_submodule_list traverses through the list,
> and calls function fn (which in the case of submodule subcommand status
> is status_submodule) is called for each entry.
>
> The third function status_submodule checks for the various conditions,
> and prints the status of the submodule accordingly. Also, this function
> takes care of the recursive flag by creating a separate child_process
> and running it inside the submodule. The function print_status handles the
> printing of submodule's status.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version of patch, function print_status is introduced.
>
> The functions for_each_submodule_list and get_submodule_displaypath
> are found to be the same as those in the ported submodule subcommand
> foreach's patches. The reason for doing so is to keep both the patches
> independant and on separate branches.


Maybe keep it even in a separate patch, such that
the status series becomes:
  patch 1: introduce for_each_submodule_list and get_submodule_displaypath
  patch 2: port print_name_rev
  patch 3: port status

whereas the foreach series (and other series later) could
re-use patch 1, and build on top of it.

For reviewing patches, it is fine to have the
get_submodule_displaypath is both series, though for applying
patches it for less complication/deduplication from the maintainer
I would think.

> +
> +static void print_status(struct status_cb *info, char state, const char *path,
> +                        char *sub_sha1, char *displaypath)
> +{
> +       if (info->quiet)
> +               return;
> +
> +       printf("%c%s %s", state, sub_sha1, displaypath);
> +
> +       if (state == ' ' || state == '+') {
> +               struct argv_array name_rev_args = ARGV_ARRAY_INIT;
> +
> +               argv_array_pushl(&name_rev_args, "print-name-rev",
> +                                path, sub_sha1, NULL);
> +               print_name_rev(name_rev_args.argc, name_rev_args.argv,
> +                              info->prefix);

... with the suggestion given in the print_name_rev patch, this would
become a one liner. :)


The rest looks good to me :)
