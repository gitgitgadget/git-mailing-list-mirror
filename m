Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530F11F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 22:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdFEWub (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 18:50:31 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34084 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdFEWu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 18:50:28 -0400
Received: by mail-pg0-f42.google.com with SMTP id v18so16832433pgb.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TWdxckt+87jfyinGIE03DOdauEBm3ZhKSKM9jzabcRY=;
        b=BBvz+2y5LloSLnh5C7uTyEYLzyILqowaN77gLdtIoNskjRuYec7WQTL4SvggaSRkAh
         X8UbTwIYrl82oqIgaHkCh/DmAIFuuq5yrlurKavMDPQRHYJ8JFhzFhwGNQKQBicutGTz
         VHIOC2nCW83IdHHWVGaG4Ir1u/NSgi6JWQGeRws0YvfG8dwptmbGULy81F/mEyGM92ZK
         UyFulo8HRycxnuaTnrs1vRBD4H/H0y9kKbXHjis8TkEdlCvKigDZiRHeZZS+x03BVeF9
         vPE2GS2MOGiqiL9MgQ7yjmFE27x0aUsDO+fAo7iJIrF61M+T2sSiTDozlxMWPEyHRf6e
         nKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TWdxckt+87jfyinGIE03DOdauEBm3ZhKSKM9jzabcRY=;
        b=qny/f/tQlnRV0T9gprAGVUWHEErm+YjCDimmHhh/gw9sn1y3hST2gN+aeNgLIHoqPp
         goHvlmBaDY4CzsM9jXeGHbJUQfesX3n7a5/O2oKKdk9xX3d5Pm1aCVY5tgyrwxeQ8waV
         Kf97UjKYNteeDAm/tuLFj08ZXrtz3HnWpbxd55zry8+O16tsVJB+Oo1+a4s4jYFqax+H
         wJV4kHoM9xYxSKg9ItQYZpF/qABDQiq6oIBofuLHiVF9ti4MFgTF38iiTuHYTmbKW1qB
         W5hVadtTwsFEk5rjEutI22OELMS+OOJgpqLtsQD1Lr+ExPb720W1BVa/qkjcelYS6Imh
         c9sQ==
X-Gm-Message-State: AODbwcB6QnTXRlxTcjMRjzRFDRrAjz0+mfKJoAOI3er0np6jAblTDkH3
        BC6l1xAn1xmyIXjoBH1I020UATzfyfor
X-Received: by 10.98.68.156 with SMTP id m28mr17339722pfi.48.1496703022814;
 Mon, 05 Jun 2017 15:50:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 15:50:22 -0700 (PDT)
In-Reply-To: <20170605202529.22959-1-pc44800@gmail.com>
References: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
 <20170605202529.22959-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 15:50:22 -0700
Message-ID: <CAGZ79kZv_Jw1n6z=5sDOtiJecyJmQ-NEzYN6kPL_uCCHTKE0bg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 1/2] submodule: port set_name_rev from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 1:25 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Since later on we want to port submodule subcommand status, and since
> set_name_rev is part of cmd_status, hence this function is ported. It
> has been ported to function print_name_rev in C, which calls get_name_rev
> to get the revname, and after formatting it, print_name_rev prints it.
> And hence in this way, the command `git submodule--helper print-name-rev
> "sm_path" "sha1"` sets value of revname in git-submodule.sh
>
> The function get_name_rev returns the stdout of the git describe
> commands. Since there are four different git-describe commands used for
> generating the name rev, four child_process are introduced, each successive
> child process running only when previous has no stdout. The order of these
> four git-describe commands is maintained the same as it was in the function
> set_name_rev() in shell script.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 16 ++---------
>  2 files changed, 69 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 566a5b6a6..3022118d1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -219,6 +219,72 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>         return 0;
>  }
>
> +enum describe_step {
> +       step_bare = 0,

Do we rely on step_bare to be equal to 0?
(This is the hint I am reading from '=0' here.
If we do not, please omit.)

> +       step_tags,
> +       step_contains,
> +       step_all_always,
> +       step_end
> +};
> +
> +static char *get_name_rev(int argc, const char **argv, const char *prefix)

So we split up the functionality into two functions.
get_name_rev, which does the heavy lifting work, and
print_name_rev, that is a wrapper around having to deal with
going from shell to C and back.

One of C strength' compared to shell is type safety,
so maybe we can tighten the contract that get_name_rev
offers to its callers and make it

  get_name_rev(const char *sub_path, const char *object_id / sha1)

and then have print_name_rev call it via

  get_name_rev (argv[1], argv[2])

(which coincidentally is right after checking for
argc != 3, which reinforces that the contract of the
wrapper is "just making sure we have valid input" and
this function "just does heavy lifting, assuming input
is valid".

> +{
> +       struct child_process cp;
> +       struct strbuf sb = STRBUF_INIT;
> +       enum describe_step cur_step;
> +
> +       for (cur_step = step_bare; cur_step < step_end; cur_step++) {
> +               child_process_init(&cp);

(minor nit, personal opinion, feel free to ignore:)
Alternatively, you could declare cp inside the loop assigned to
CHILD_PROCESS_INIT.
Same for strbuf sb as well, such that you only declare the iterator
variable outside the loop.

> +               prepare_submodule_repo_env(&cp.env_array);
> +               cp.dir = argv[1];
> +               cp.no_stderr = 1;

cp.git_cmd = 1; as well?

Thanks,
Stefan
