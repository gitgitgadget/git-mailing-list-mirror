Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E3E1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761900AbdDSLa3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:30:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35321 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760774AbdDSLa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:30:27 -0400
Received: by mail-io0-f196.google.com with SMTP id d203so3022101iof.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=niJIzY+sWpvkevaAew6I1RRqxdT5Ng/ake27x2H/2Eg=;
        b=gPuQk9nAsGCHYD/GIHjCOJMO/vkuLG6ko0r1DJOkM+5ex+lXKIoW1ArtP1PL7n1Bgq
         Vv0B4T+1OROTel0l5ba9MhGjCpRvmI3nmfxPsgtc4ghi9uZonzpm0zLGkve9B0BVnIWj
         0glTABIKk0YwL4LTENDTWhYKTs6ywMWRgW3rF8exBXEp+hM9qwzbkyRPpRT5njL71bbF
         MqyWiZ5K6NLyarxS10n5ztAXubZ0+FNpRf4t9HUTCTLeOl+2XUA078fthG/Y0WNo3pDC
         62iC8bfoNEuFb+TB470wUp/Z9RuCK5kl+A1sAue+h00w9sonG0d32v9BSYunAOYG+PVH
         C9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=niJIzY+sWpvkevaAew6I1RRqxdT5Ng/ake27x2H/2Eg=;
        b=aDFUM7nJTlhcPSBn/jDzbr551qXX7WIyck6T0li1g04tkZBpjptpIc+BTsvtquXZSh
         IgwTFfL+Ke6Pz9KRzrm6Wnm3zIQ+3zCshaWDz3aJUsrBp2esVW+7ue9EoGROGIz5LMiv
         yg/lWUMQm2vjwcKz++BwuIfcN/2ZSC5x7GGmEM6qHMKUkuvEXqb3QhVGgCWUCD5edgXj
         xesf21Yh74wifiCcn6InGggNIHGGfpp61mYogfU9iyw19gpB/Z40DDhfNVFeRLt7tsBl
         7cxcmDZkK/jc4AY99Wmx2wGEVQ7QTwRDajihjsKgEgCRIzt97UnjJcG/Cj7TyobYg/VO
         YTwg==
X-Gm-Message-State: AN3rC/4Zp19RYPvac0D2TIprZnHPGpwhFrtACVozb6vhZX6TR4HeM1yc
        oTPBVzvXKRR+IU2lkxsDXROpAK7NDQ==
X-Received: by 10.107.35.200 with SMTP id j191mr2801967ioj.33.1492601426298;
 Wed, 19 Apr 2017 04:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 19 Apr 2017 04:30:05 -0700 (PDT)
In-Reply-To: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net> <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 19 Apr 2017 13:30:05 +0200
Message-ID: <CACBZZX5goUsb4JTn6aGkJ-_S4W0Ymg7-HTzryDjC=AJBiLC3Fg@mail.gmail.com>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Vadim Eisenberg <VADIME@il.ibm.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 19, 2016 at 10:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Stefan, I think it might be worth revisiting the default set by d22eb04
>> to propagate shallowness from the super-project clone. In an ideal
>> world, we would be asking each submodule for the actual commit we are
>> interested in, and shallowness would not matter. But until
>> uploadpack.allowReachableSHA1InWant works everywhere, I suspect this is
>> going to be a problem.
>
> Yup, something like this on top of d22eb04 to be merged before
> v2.9.1 for the maintenance track would be necessary.
>
> -- >8 --
> Subject: clone: do not let --depth imply --shallow-submodules
>
> In v2.9.0, we prematurely flipped the default to force cloning
> submodules shallowly, when the superproject is getting cloned
> shallowly.  This is likely to fail when the upstream repositories
> submodules are cloned from a repository that is not prepared to
> serve histories that ends at a commit that is not at the tip of a
> branch, and we know the world is not yet ready.
>
> Use a safer default to clone the submodules fully, unless the user
> tells us that she knows that the upstream repository of the
> submodules are willing to cooperate with "--shallow-submodules"
> option.
>
> Noticed-by: Vadim Eisenberg <VADIME@il.ibm.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-clone.txt | 5 ++---
>  builtin/clone.c             | 5 ++---
>  t/t5614-clone-submodules.sh | 4 ++--
>  3 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index e1a21b7..c5a1ce2 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -192,9 +192,8 @@ objects from the source repository into a pack in the cloned repository.
>         Create a 'shallow' clone with a history truncated to the
>         specified number of revisions. Implies `--single-branch` unless
>         `--no-single-branch` is given to fetch the histories near the
> -       tips of all branches. This implies `--shallow-submodules`. If
> -       you want to have a shallow superproject clone, but full submodules,
> -       also pass `--no-shallow-submodules`.
> +       tips of all branches. If you want to clone submodules shallowly,
> +       also pass `--shallow-submodules`.
>
>  --[no-]single-branch::
>         Clone only the history leading to the tip of a single branch,
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ecdf308..f267742 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -40,7 +40,7 @@ static const char * const builtin_clone_usage[] = {
>
>  static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
>  static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
> -static int option_shallow_submodules = -1;
> +static int option_shallow_submodules;
>  static char *option_template, *option_depth;
>  static char *option_origin = NULL;
>  static char *option_branch = NULL;
> @@ -730,8 +730,7 @@ static int checkout(void)
>                 struct argv_array args = ARGV_ARRAY_INIT;
>                 argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
>
> -               if (option_shallow_submodules == 1
> -                   || (option_shallow_submodules == -1 && option_depth))
> +               if (option_shallow_submodules == 1)
>                         argv_array_push(&args, "--depth=1");

Very late reply, since I'm just looking at this now with the --no-tags
opti,n, but that == 1 makes no sense anymore, and should just be `if
(option_shallow_submodules)` shouldn't it? I.e. this used to be an int
for the depth, now is a bool, but the current == 1 check is left over
probably from an earlier version where the depth was configurable.

>                 if (max_jobs != -1)
> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
> index 62044c5..f7c630b 100755
> --- a/t/t5614-clone-submodules.sh
> +++ b/t/t5614-clone-submodules.sh
> @@ -37,9 +37,9 @@ test_expect_success 'nonshallow clone implies nonshallow submodule' '
>         )
>  '
>
> -test_expect_success 'shallow clone implies shallow submodule' '
> +test_expect_success 'shallow clone does not imply shallow submodule' '
>         test_when_finished "rm -rf super_clone" &&
> -       git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
> +       git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
>         (
>                 cd super_clone &&
>                 git log --oneline >lines &&
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
