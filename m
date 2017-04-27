Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49E0207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 17:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdD0Ry3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 13:54:29 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36489 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdD0Ry2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 13:54:28 -0400
Received: by mail-pf0-f179.google.com with SMTP id 194so33683437pfv.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBD8IIeVD7KuQ9Bhx0ndlwFdeZf7QdHUe6ADRRGrsnE=;
        b=HvCBjndAcF+soEi8v6y2bch54+y7JyyIdnegdF2M6OaaFqp343+nRz6XTA8kxfsn25
         ElDt8F5qwtlYHnkT2cnkCByPbzWA3jWme8ccNQSPNL56GHR/jc717uqoPhFxYH7aYZ40
         +lT1w4Fb9D+sjCp0/Tpj9MYhNyHkn4mgKof8VLJkGSGYGSwqCASSoGahS4fK3WsE7Bbo
         0NBtnaWk8IyvDtqnqbo4KGsT38JKl9I73KjBSgUQAysqybEMLDhzkpI3sPPHhNVBXGZ6
         Lu7BQy3peU6xsYU9SfuwDNN+aZITNhRNFicW/qGSjZ445kP0OYbT12/qCRWio/VAJH98
         bt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBD8IIeVD7KuQ9Bhx0ndlwFdeZf7QdHUe6ADRRGrsnE=;
        b=SIPkqBTv1xx3M5X64WtzgbpJeuqtai/l5/JRhIsVHCUmoBfoMjtyLGvpfLIOT36MUY
         5/fEylniTEIN1k0zZAZz3QDIV3FUlc4zELYCd2AcpKUX0TeGKcBT/KjheHW0GK8CfYtU
         LmiE2pY10EICWVPWfNmkLRP5E+cFfeDZj7QfxUrFgcky5ATjcWQpYP76NWTkI3AnNjaI
         9BPnes+DCuOQ36KYWaW1FScN7CNl9tkxp/PjtB51x9kVucEgUBRMBm7IjX70mneEAIAK
         oZ8ZsM2eb8c4tmbfhjhjzP7Bylhno3pf2VjTD5C2WNuclhA+qL0rwfYoTXGgFC0JBLUq
         iZQw==
X-Gm-Message-State: AN3rC/6G1qP8l8+tBXfssW6OH0pUDp/fnRa+LvcOJ4+jPtrPhftMUHv3
        bJA/s6FKTo6e9BZLH7asDnkONEv4FA3H
X-Received: by 10.98.204.93 with SMTP id a90mr7364797pfg.6.1493315667440; Thu,
 27 Apr 2017 10:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 10:54:26 -0700 (PDT)
In-Reply-To: <20170426231236.27219-3-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-3-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 10:54:26 -0700
Message-ID: <CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16YQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] clone: add a --no-tags option to clone without tags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add a --no-tags option to clone without fetching any tags.
>
> Without this change there's no easy way to clone a repository without
> also fetching its tags.
>
> When supplying --single-branch the primary remote branch will be
> cloned, but in addition tags will be followed & retrieved. Now
> --no-tags can be added --single-branch to clone a repository without
> tags, and which only tracks a single upstream branch.
>
> This option works without --single-branch as well, and will do a
> normal clone but not fetch any tags.
>
> Many git commands pay some fixed overhead as a function of the number
> of references. E.g. creating ~40k tags in linux.git will cause a
> command like `git log -1 >/dev/null` to run in over a second instead
> of in a matter of milliseconds, in addition numerous other things will
> slow down, e.g. "git log <TAB>" with the bash completion will slowly
> show ~40k references instead of 1.
>
> The user might want to avoid all of that overhead to simply use a
> repository like that to browse the "master" branch, or something like
> a CI tool might want to keep that one branch up-to-date without caring
> about any other references.
>
> Without this change the only way of accomplishing this was either by
> manually tweaking the config in a fresh repository:
>
>     git init git &&
>     cat >git/.git/config <<EOF &&
>     [remote "origin"]
>         url =3D git@github.com:git/git.git
>         tagOpt =3D --no-tags
>         fetch =3D +refs/heads/master:refs/remotes/origin/master
>     [branch "master"]
>         remote =3D origin
>         merge =3D refs/heads/master
>     EOF
>     cd git &&
>     git pull
>
> Which requires hardcoding the "master" name, which may not be the main
> --single-branch would have retrieved, or alternatively by setting
> tagOpt=3D--no-tags right after cloning & deleting any existing tags:
>
>     git clone --single-branch git@github.com:git/git.git &&
>     cd git &&
>     git config remote.origin.tagOpt --no-tags &&
>     git tag -l | xargs git tag -d
>
> Which of course was also subtly buggy if --branch was pointed at a
> tag, leaving the user in a detached head:
>
>     git clone --single-branch --branch v2.12.0 git@github.com:git/git.git=
 &&
>     cd git &&
>     git config remote.origin.tagOpt --no-tags &&
>     git tag -l | xargs git tag -d
>
> Now all this complexity becomes the much simpler:
>
>     git clone --single-branch --no-tags git@github.com:git/git.git
>
> Or in the case of cloning a single tag "branch":
>
>     git clone --single-branch --branch v2.12.0 --no-tags git@github.com:g=
it/git.git
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I like the option, though I dislike the implementation, specifically as you
brought up e.g. "[PATCH] various: disallow --no-no-OPT for --no-opt options=
".

Can we have an option "--tags" instead, which is on by default
and then you can negate it to --no-tags, without having to worry
about the no-no case.

The problem with tags is that they are in a shared name-space
and not part of the remote refspec. If they were, the documentation
would be way easier, too going this way.

> +--no-tags::
> +       Don't clone any tags, and set
> +       `remote.<remote>.tagOpt=3D--no-tags` in the config, ensuring
> +       that future `git pull` and `git fetch` operations won't follow
> +       any tags. Subsequent explicit tag fetches will still work,
> +       (see linkgit:git-fetch[1]).
> ++
> +Can be used in conjunction with `--single-branch` to clone and
> +maintain a branch with no references other than a single cloned
> +branch. This is useful e.g. to maintain minimal clones of the default
> +branch of some repository for search indexing.

In the future we may want to have '--depth' also imply --no-tags,
just as it implies --single-branch.

> @@ -652,7 +655,7 @@ static void update_remote_refs(const struct ref *refs=
,
>
>         if (refs) {
>                 write_remote_refs(mapped_refs);
> -               if (option_single_branch)
> +               if (option_single_branch && !option_no_tags)

I am debating if this needs to be an || instead of &&, as you would not
want to write the tags with "--no-single-branch --no-tags" ?

Thanks,
Stefan
