Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D93B1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 12:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeFGMmM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 08:42:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41903 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeFGMmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 08:42:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id az12-v6so6066202plb.8
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XvhVqfRSM9pYyPY/+OkvIkVKh2ce+vXSmXD2DXFQBps=;
        b=oIKVjgeBijD43sM7t5YL43On58EZGtO57QAiYe1FBSY3t0aQQDCQH4xeux2sK5nfKw
         Cg4wLgnQpnznfvuAZtlRMPEynJfB+utOwvx6ifN2bA60j2brTGM2ATJlwVdWDGByvNJc
         9o1gI4CmWgq08FJX89jk9kR9WMgK+Yla+0yxICTWUuPFKIW2x8e4qzbPydnCiu63bdD2
         KwSJuO21Q12l4nVF8DBE24cFbE/Gk0+POBjViHMmpBAHFnsezNlIO5gjhUM09A2muD08
         X3DHQQnA6s9wxo7inJxEfqKPPEKhGBpm2qyCW0SxrJAK7/oBkaUxjDq+efAT4pWQThqv
         9TAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wol.ph; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XvhVqfRSM9pYyPY/+OkvIkVKh2ce+vXSmXD2DXFQBps=;
        b=GWGmr/wAI2eRHhrgj5CX12WcPfEV6J3B9zzb9dK2dcqeOgwuscFdevoiZfRmC8HQ74
         KxxZlGTgdM/0BU0Zk7/H+72rQlOX7iH8o/3YfpHOgmay9zNym3veZCrHixqewM8oYn+X
         +Kbxmj226L6nfGmF7Ul/umI/mgMVATyLF0mM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XvhVqfRSM9pYyPY/+OkvIkVKh2ce+vXSmXD2DXFQBps=;
        b=Robe9P1JTbuo8e6Vq9gyP8+Yd5w2Tx7yMhMcLOQMSTRixmRXpKsh4hcFUqV2PiNKD+
         YXxu5m5m/bxoMmGSPF3+X7DsQPbDdA8y/cbDjbYEdNT+nNElNT1tA5DW+/qXhnWc3i/C
         JVb9fKkwydMuOezQ6Plbl3VDCBAcaGCxg+qYHiM1gPQUiA9mmG4KsrvQDAB/3Reh1DV7
         cLuJlik/3VdS9EpQEXgz8oLu3GMcpuWpuSZPQ+osaddSpChI/a5uPLKNy022C4E0iY0b
         a4U65UN84vf8C+ys+u4UEMD249pG/5TkNRNFk5dbeF+zCrxQKckS8TNpdgq02Ax3rMmw
         /fKw==
X-Gm-Message-State: APt69E1VfurT/kZOHY25ohevVkagFNOOHal4fUsIp4vyNMdRlsgTm5H/
        lHEQIaitO0SOWbu5+/O0hWCnS57AIvkskxpYp2U=
X-Google-Smtp-Source: ADUXVKL15ZLwEN6cLL/ilXBOxVrcOi3dXqlpRv8SBWOmNz1+oanWL9r1QHEDg2Okhws8Yg2uX+0LKn60l/PrL67mw8o=
X-Received: by 2002:a17:902:b60b:: with SMTP id b11-v6mr1939932pls.330.1528375328017;
 Thu, 07 Jun 2018 05:42:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:8906:0:0:0:0 with HTTP; Thu, 7 Jun 2018 05:41:47
 -0700 (PDT)
In-Reply-To: <20180607054834.GB6567@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com>
From:   Rick van Hattem <wolph@wol.ph>
Date:   Thu, 7 Jun 2018 14:41:47 +0200
X-Google-Sender-Auth: DxeAQqBgRlJW_qUxjectNLuuSQE
Message-ID: <CAJAwA=z2cwy7A3oG=0RPCrh4i41NxPk6jAFhjtisAPvndOKC9Q@mail.gmail.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The zsh script expects the bash completion script to be available so
that might be the issue here.

To reproduce this is what I do. First, a sparse checkout:
# mkdir ~/git
# cd ~/git
# git init
# git remote add origin git@github.com:git/git.git
# git config core.sparseCheckout true
# mkdir .git/info
# echo contrib/completion >> .git/info/sparse-checkout
# git pull origin master --depth 1

After that I simply link the zsh script to _git:
# cd git/contrib/completion
# ln git-completion.zsh _git

And add the following to a new .zshrc file:
autoload -U compinit; compinit
autoload -U bashcompinit; bashcompinit
fpath=3D(~/git/contrib/completion $fpath)

And that appears to be enough to reproduce:
# git<tab>
git/contrib/completion/git-completion.bash:354: read-only variable: QISUFFI=
X
zsh:12: command not found: ___main
zsh:15: _default: function definition file not found
_dispatch:70: bad math expression: operand expected at `/usr/bin/g...'
zsh: segmentation fault  zsh

~rick

On 7 June 2018 at 07:48, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> SZEDER G=C3=A1bor wrote:
>
>> Other Bash versions, notably 4.4.19 on macOS via homebrew (i.e. a
>> newer version on the same platform) and 3.2.25 on CentOS (i.e. a
>> slightly earlier version, though on a different platform) are not
>> affected.  ZSH in macOS (the versions shipped by default or installed
>> via homebrew) or on other platforms isn't affected either.
> [...]
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -282,7 +282,11 @@ __gitcomp ()
>>
>>  # Clear the variables caching builtins' options when (re-)sourcing
>>  # the completion script.
>> -unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\=
)=3D.*/\1/p') 2>/dev/null
>> +if [[ -n ${ZSH_VERSION-} ]]; then
>> +     unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-=
9_]*\)=3D.*/\1/p') 2>/dev/null
>> +else
>> +     unset $(compgen -v __gitcomp_builtin_)
>> +fi
>
> As discussed at [1], this fails catastrophically when sourced by
> git-completion.zsh, which explicitly clears ZSH_VERSION.  By
> catastrophically, I mean that Rick van Hattem and Dave Borowitz report
> that it segfaults.
>
> I can't reproduce it since I am having trouble following the
> instructions at the top of git-completion.zsh to get the recommended
> zsh completion script loading mechanism working at all.  (I've
> succeeded in using git's bash completion on zsh before, but that was
> many years ago.)  First attempt:
>
>  1. rm -fr ~/.zsh ~/.zshrc
>     # you can move them out of the way instead for a less destructive
>     # reproduction recipe
>  2. zsh
>  3. hit "q"
>  4. zstyle ':completion:*:*:git:*' script \
>       $(pwd)/contrib/completion/git-completion.zsh
>  5. git checkout <TAB>
>
> Expected result: segfault
>
> Actual result: succeeds, using zsh's standard completion script (not
> git's).
>
> I also tried
>
>  1. rm -fr ~/.zsh ~/.zshrc
>     # you can move them out of the way instead for a less destructive
>     # reproduction recipe
>  2. zsh
>  3. hit "2"
>  4. mkdir ~/.zsh; cp contrib/completion/git-completion.zsh ~/.zsh/_git
>  5. echo 'fpath=3D(~/.zsh $fpath)' >>~/.zshrc
>  6. ^D; zsh
>  7. git checkout <TAB>
>
> and a similar process with fpath earlier in the zshrc file.  Whatever
> I try, I end up with one of two results: either it uses zsh's standard
> completion, or it spews a stream of errors about missing functions
> like compgen.  What am I doing wrong?
>
> Related question: what would it take to add a zsh completion sanity
> check to t/t9902-completion.sh?
>
> When running with "set -x", here is what Dave Borowitz gets before the
> segfault.  I don't have a stacktrace because, as mentioned above, I
> haven't been able to reproduce it.
>
>         str=3Dgit
>         [[ -n git ]]
>         service=3Dgit
>         i=3D
>         _compskip=3Ddefault
>         eval ''
>         ret=3D0
>         [[ default =3D *patterns* ]]
>         [[ default =3D all ]]
>         str=3D/usr/bin/git
>         [[ -n /usr/bin/git ]]
>         service=3D_dispatch:70: bad math expression: operand expected at =
`/usr/bin/g...'
>
>         zsh: segmentation fault  zsh
>
> Here's a minimal fix, untested.  As a followup, as G=C3=A1bor suggests at=
 [2],
> it would presumably make sense to stop overriding ZSH_VERSION, using
> this GIT_ scoped variable everywhere instead.
>
> Thoughts?
>
> Reported-by: Rick van Hattem <wolph@wol.ph>
> Reported-by: Dave Borowitz <dborowitz@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> [1] https://public-inbox.org/git/01020163c683e753-04629405-15f8-4a30-9dc3=
-e4e3f2a5aa26-000000@eu-west-1.amazonses.com/
> [2] https://public-inbox.org/git/20180606114147.7753-1-szeder.dev@gmail.c=
om/
>
> diff --git i/contrib/completion/git-completion.bash w/contrib/completion/=
git-completion.bash
> index 12814e9bbf..e4bcc435ea 100644
> --- i/contrib/completion/git-completion.bash
> +++ w/contrib/completion/git-completion.bash
> @@ -348,7 +348,7 @@ __gitcomp ()
>
>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n ${ZSH_VERSION-} || -n ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
>         unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0=
-9_]*\)=3D.*/\1/p') 2>/dev/null
>  else
>         unset $(compgen -v __gitcomp_builtin_)
> diff --git i/contrib/completion/git-completion.zsh w/contrib/completion/g=
it-completion.zsh
> index 53cb0f934f..c7be9fd4dc 100644
> --- i/contrib/completion/git-completion.zsh
> +++ w/contrib/completion/git-completion.zsh
> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>                 test -f $e && script=3D"$e" && break
>         done
>  fi
> -ZSH_VERSION=3D'' . "$script"
> +GIT_SOURCING_ZSH_COMPLETION=3D1 ZSH_VERSION=3D'' . "$script"
>
>  __gitcomp ()
>  {
