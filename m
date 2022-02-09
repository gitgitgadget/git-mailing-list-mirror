Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE7C4332F
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiBIClb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiBICel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:34:41 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CCC0613CC
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:34:40 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id ay7so1099910oib.8
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z3XmV3PRuhl2RiaDp8a2+dKuC6KwG/KVsBxygpmdfBI=;
        b=XyY8RD3LCejgrhrNKBaytGG1D0WzqWJ+vDWm8iUKB31J2H53uTDdicJ817pyxSY/wQ
         L75i/TCPDsuCo359LKvwQDGG/kPPiASMO/mtFlqaPDA9e4uf1ICIsnpW90eANDweSOnJ
         du8SOxoHgCeWl85eC9o+dg5KRLLcX5Q88ridtp7lcTULAj4ZwaFwl/s+bFiTwhQeEQl2
         FaAwTm8GEqlv0l2NMzLMW0MM+dqcsG69byrU/fAwg92ycHP0TcvpDitCjlu9kKFxVlCC
         Xo6kg+PeGr+n2Lyd4ATE+KQawi/TK2gFJThd4SLYaUNVhnN28yXPcbVVimQx5HN5Kq50
         mgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z3XmV3PRuhl2RiaDp8a2+dKuC6KwG/KVsBxygpmdfBI=;
        b=RDSW+cpgNp1r581RG2i07dfu54jbsaaMMN0k2hGrz1h/ruytUW3ozdZ3Ls7bmVk9FQ
         cX3hVVw8f6b0/X3VE2DHWFZSS4o4u6JM/Ru7eC6DI2bpqQ+EFZiT/QObxKsNLtyCqF3n
         49FHTlaZMaIhZ2hBRdKlSHOv8tku+DbKDz25OmzQrMUxVR2jpH7evGzEd0plmy1pVUL7
         NR8T7KiG1OZC8MZWOkbxPlqQUrNmaMg2KXGC3qL9N+FyypZUmT66ENv3XN76IUr3g1Jf
         gjGj4rsdYv2Oq10kDSCB4XMy+eWYtQFaB5y2my9q6fBitJYjsyr5YhsuJN+FaYhkpjU+
         aJbQ==
X-Gm-Message-State: AOAM531zl8p45gcmJrta/3jJbkel82uL/9rSd7AJqVMJRVY7rHSFhKj6
        E5MzLklg3IMa0p8Pp2H1MXc=
X-Google-Smtp-Source: ABdhPJy+XsBIVOqejLp2v8uxHH/beEOv6PINzOu2r9vlId/3Z1Pzzzi+0150JqaZdzhffuk7nXyrbA==
X-Received: by 2002:a05:6808:13c8:: with SMTP id d8mr420732oiw.286.1644374079550;
        Tue, 08 Feb 2022 18:34:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:999a:e20e:62a:aacd? ([2600:1700:e72:80a0:999a:e20e:62a:aacd])
        by smtp.gmail.com with ESMTPSA id z17sm5868053otk.62.2022.02.08.18.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 18:34:39 -0800 (PST)
Message-ID: <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
Date:   Tue, 8 Feb 2022 21:34:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
 <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
 <xmqqo83hatm1.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqo83hatm1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2022 5:20 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
>> index 4e23d73cdca..bccaec7a963 100644
>> --- a/Documentation/config/extensions.txt
>> +++ b/Documentation/config/extensions.txt
>> @@ -6,3 +6,34 @@ extensions.objectFormat::
>>  Note that this setting should only be set by linkgit:git-init[1] or
>>  linkgit:git-clone[1].  Trying to change it after initialization will not
>>  work and will produce hard-to-diagnose issues.
>> +
>> +extensions.worktreeConfig::
>> +	If enabled, then worktrees will load config settings from the
>> +	`$GIT_DIR/config.worktree` file in addition to the
>> +	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
>> +	`$GIT_DIR` are the same for the main working tree, while other
>> +	working trees have `$GIT_DIR` equal to
>> +	`$GIT_COMMON_DIR/worktrees/<id>/`. The settings in the
> 
> The mixed use of "worktree" and "working tree" in this paragraph
> might confuse readers into thinking that the paragraph is being
> careful to make distinction between the two.  All references to
> "working tree" in the above paragraph should actually be "worktree",
> I would think.

I generally agree. This was changed in the most-recent re-roll
based on a request by Eric [1]. I'm happy to take whichever
version the two of you settle on.

[1] https://lore.kernel.org/git/CAPig+cS-3CxxyPGcy_vkeN_WYTRo1b-ZhJNdPy8ARZSNKkF1Xg@mail.gmail.com/

> 	Side note: "working tree" is in the glossary-content.txt,
> 	but "worktree", which is one "working tree" + repository
> 	metadata (i.e. ".git/") that may be partially shared with
> 	other "worktree"s of a single repository, is not defined.
> 
> This is a tangent, but I wonder why we chose to use a different
> filename (i.e. not "config" but "config.worktree") for this.  If we
> were redoing multi-worktree support from scratch, we would not reuse
> the $GIT_DIR used by the primary worktree as $GIT_COMMON_DIR, so
> that all worktrees would share a single $GIT_COMMON_DIR and
> $GIT_COMMON_DIR/config that has stuff that is shared among all the
> worktrees, while per worktree stuff is in $GIT_DIR/config even for
> the primary worktree.  But that is all water under the bridge now.

Right. I think that since the primary worktree uses $GIT_COMMON_DIR
as its location for base information (like HEAD) it also means that
its worktree-specific config file cannot be called "config".

Perhaps there could have been a way to split the worktrees so the
primary worktree got its own directory within ".git/worktrees/", but
my guess is that the design optimized for backwards compatibility:
Git clients that don't understand worktrees could still interact with
the primary worktree.

> Other than the terminology gotcha, looked sensible.  Migrating
> automatically and/or noticing a suspicious setting may be needed to
> help end users, but that would not be within the scope of this step.
> 
> Attached is a "how about this?" glossary update suggestion.  Most of
> the existing mention of "working tree" are fine as-is because they
> only care about what is in the "working tree", but some should be
> changed to "worktree" to stress the fact that they care not just the
> "working tree" part but also the repository metadata part that is
> associated with that single "working tree".  The first hunk says
> worktree but it is clear that it is interested only in the "working
> tree" files.
> 
>  Documentation/glossary-content.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
> index c077971335..d816512c6a 100644
> --- c/Documentation/glossary-content.txt
> +++ w/Documentation/glossary-content.txt
> @@ -312,7 +312,7 @@ Pathspecs are used on the command line of "git ls-files", "git
>  ls-tree", "git add", "git grep", "git diff", "git checkout",
>  and many other commands to
>  limit the scope of operations to some subset of the tree or
> -worktree.  See the documentation of each command for whether
> +working tree.  See the documentation of each command for whether
>  paths are relative to the current directory or toplevel.  The
>  pathspec syntax is as follows:
>  +
> @@ -446,7 +446,7 @@ exclude;;
>  	interface than the <<def_plumbing,plumbing>>.
>  
>  [[def_per_worktree_ref]]per-worktree ref::
> -	Refs that are per-<<def_working_tree,worktree>>, rather than
> +	Refs that are per-<<def_worktree,worktree>>, rather than
>  	global.  This is presently only <<def_HEAD,HEAD>> and any refs
>  	that start with `refs/bisect/`, but might later include other
>  	unusual refs.
> @@ -669,3 +669,12 @@ The most notable example is `HEAD`.
>  	The tree of actual checked out files.  The working tree normally
>  	contains the contents of the <<def_HEAD,HEAD>> commit's tree,
>  	plus any local changes that you have made but not yet committed.
> +
> +[[def_work_tree]]worktree::
> +	A repository can have zero (i.e. bare repository) or one or
> +	more worktrees attached to it. One "worktree" consists of a
> +	"working tree" and repository metadata, most of which are
> +	shared among other worktrees of a single repository, and
> +	some of which are maintained separately per worktree
> +	(e.g. the index, HEAD, per-worktree refs and per-worktree
> +	configuration file)

I like this addition, except that I don't understand the "per-worktree
refs" (other than HEAD). Are there other thins used by features such
as merge and rebase that would appear as worktree-specific? Of course,
some state for these operations is stored per-worktree, I just didn't
know if any were actually "refs".

Other than that technicality, which could be completely correct, this
is a good idea to include.

Thanks,
-Stolee
