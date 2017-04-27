Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FFD207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 16:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755602AbdD0QhS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 12:37:18 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33679 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937273AbdD0QhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 12:37:12 -0400
Received: by mail-pf0-f173.google.com with SMTP id a188so31910203pfa.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9JqnH4x0Wrt0kf2rzFVOiHCCOxHeHC+vPZhh9HPCRxQ=;
        b=JrfEO3MTrmEAL58+H8oxT3bnR6tVz9gxEzXO+iYcDC3wzG16wB/eC7/hR7tulyJEzi
         TMRRjXu0z02Azk5TqospyBuU1cPDqFiETupqoCFbQhS8hSNgljAtX5T6bMjmW269ZMDd
         wmM6f3Qy269x1XZeTbZNe+v7cMGAV0q8+HKNforVTYFlwzHtMTU226VUwBkEa47C0K0s
         GHygca1nvKNDbIQ1vKIFxvkcIrQsMyuwGqMDEfban9ALo2weeoZq3p3heNCmswnrVWK0
         4Pz9wyo3/mn3pv+ci0aXOnjVoDIj4uRk9/KfzjEGlJJSEL3XbYfdLntPS4YLLu5k5ugF
         4UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9JqnH4x0Wrt0kf2rzFVOiHCCOxHeHC+vPZhh9HPCRxQ=;
        b=hg/5ClSMKx4LsAsCZKkkEbb6j1ZElwy26o2bkI0u7y6lLn+OYRBTAd7rgzEke23fBa
         ZyVoe3PaHdGJnigcaA7m+h/Z18zDZtrNco6OobgfRf7tT0MwN/Q6Ieyh0PMRPXQbS5Oi
         esihdSS/zXpHl/rhNu7iokxlywcCcFZv4N4PxbF8MrC3EPNBDEDQb0k8O1JTOU1tmOcw
         6CMX9jbaAqgCf+WEC5csuSF9ghmGXwasYirvS487mNs9ZeU7qlvtL17pWZ2mAPfU6Y63
         MVqLeGP1XIA+/NJeFipmI927IGVQbpVV+rjUfu1zv2URtUXRYHp2Vydz2sNdgEUV367t
         AyGQ==
X-Gm-Message-State: AN3rC/72R3svBgogjZUhyC9iOfqLtaswcOgmFL80iDOpE6KhBsUwqY/H
        5/lWO2yiezlq5UmgyZ9Xez1xrEyTiNE4
X-Received: by 10.98.90.6 with SMTP id o6mr7063521pfb.101.1493311031517; Thu,
 27 Apr 2017 09:37:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 09:37:11 -0700 (PDT)
In-Reply-To: <71692231-0a76-99f7-3577-9076b0f2e8ad@suse.cz>
References: <bbcbdf11-5065-8fcb-d78e-74db03814781@suse.cz> <CAGZ79kY2dmec17qdbpTqOx7Uro7X_UAyo0be5a08bdZyykA2nw@mail.gmail.com>
 <71692231-0a76-99f7-3577-9076b0f2e8ad@suse.cz>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 09:37:11 -0700
Message-ID: <CAGZ79kZ7eHO+Uv1xk1UXpO39uqCEGkpnxOCMARqJP9hAtqC1gg@mail.gmail.com>
Subject: Re: [PATCH] Add --indent-heuristic to bash completion.
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 2:09 AM, Martin Li=C5=A1ka <mliska@suse.cz> wrote:
> On 04/26/2017 09:38 PM, Stefan Beller wrote:
>> On Tue, Apr 25, 2017 at 4:37 AM, Martin Li=C5=A1ka <mliska@suse.cz> wrot=
e:
>>> Hello.
>>>
>>> The patch adds BASH completion for a newly added option.
>>>
>>
>> The looks good, though the format is unusual. (We prefer the
>> format to be inline instead of an attachment)
>
> Good, adding inline version.
> I've read Documentation/SubmittingPatches, can you please help me which
> maintainer should I CC?

cc'd Junio (the only maintainer in Git, are you a kernel developer, where
you have hundreds of maintainers?)

Thanks,
Stefan

>
> Martin
> ---
>  contrib/completion/git-completion.bash | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 1150164d5..8fb25594c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1395,7 +1395,7 @@ __git_diff_common_options=3D"--stat --numstat --sho=
rtstat --summary
>                         --quiet --ext-diff --no-ext-diff
>                         --no-prefix --src-prefix=3D --dst-prefix=3D
>                         --inter-hunk-context=3D
> -                       --patience --histogram --minimal
> +                       --patience --histogram --indent-heuristic --minim=
al
>                         --raw --word-diff --word-diff-regex=3D
>                         --dirstat --dirstat=3D --dirstat-by-file
>                         --dirstat-by-file=3D --cumulative
> @@ -1482,6 +1482,7 @@ __git_format_patch_options=3D"
>         --not --all --cover-letter --no-prefix --src-prefix=3D --dst-pref=
ix=3D
>         --inline --suffix=3D --ignore-if-in-upstream --subject-prefix=3D
>         --output-directory --reroll-count --to=3D --quiet --notes
> +       --indent-heuristic
>  "
>
>  _git_format_patch ()
> @@ -1681,6 +1682,7 @@ __git_log_common_options=3D"
>         --min-age=3D --until=3D --before=3D
>         --min-parents=3D --max-parents=3D
>         --no-min-parents --no-max-parents
> +       --indent-heuristic
>  "
>  # Options that go well for log and gitk (not shortlog)
>  __git_log_gitk_options=3D"
> --
> 2.12.2
