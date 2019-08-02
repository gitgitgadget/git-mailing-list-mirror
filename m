Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D215B1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391454AbfHBJu7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:50:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39602 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405395AbfHBJpR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:45:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so33481704pls.6
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43VZVwfwEq8Vk5BVGDca+vx87efoaqtHqs5fwHDoPrI=;
        b=PSa44qeC9tznpHjKdAoz/OqxMUZIZtlaEG31K8IOHq+2N9cMhpqUicRq7xqQ99APJX
         DFpCK2EdQEx3fI2AaaYu5L8XK7MoU7KanuJjY0YckkOnIViZKO2eESj103VGKgp9NXQD
         eqI5KKDXWcVUJJtI8K8jBC5F7b4ovp0YAIX0e3LzFsiCbZq+NMAXkPx4OaBeJ7NanvbB
         9Z/iaic1ZexrANM7LnrDTjKsuQnca4Sn8lQdaQcfffMYh3+8LaHC3A6TAfTjdRJfHRaP
         AkffEFj+4K/wtcL2LBYPkORzXB+7mjKsh2Ms2/swIpMTl1g9XnQP81B6aMQ1p/k44U50
         YXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43VZVwfwEq8Vk5BVGDca+vx87efoaqtHqs5fwHDoPrI=;
        b=ZiRrQ/3oB651HvZ03smENaGIslncyjcsI12Pt21un6uhzpO6xferVdMpr3n+D4+mgg
         XVS5wH2i6z+JyAkCLtGt4AYl5NvT5Hkux4peZIuMxXkqcdzwJQ66rotFVkjXBilLix4T
         1oBRUjsmP8BH+kQDfgvD34bQXppX3+i4yzcUCyXFwg/Aez7vuHEXwNe/RfQROqr7yEgN
         Zcdye58HovNglYk3TnhCzC8aYqzqjSiij6QGewt+vZwtVZhkXc8DIevYepGgEZaTr5Sg
         DuoaXVMnDifKNzLXQhOvjiPxK3DGF34AfcqAb6g+pzySkRQnzP8R0pKN3t6ogaoYB1di
         IrvA==
X-Gm-Message-State: APjAAAVX0XsMxJCay6o9SaDJzd7u222sZ8U31ZG8+supGHg4PDg96sx/
        mMcJ+g4GuTWidJO9jRs6mkvIXukMUiH3NHuo60W4mw==
X-Google-Smtp-Source: APXvYqxps2hnvi5ZA88DobYjlwYqYLwtjkegwlB12IgsU0ls81NI65lBQZJ3Xfg6fQClSmmevLrk+NVGMR/9wtfXoj0=
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr131775806plb.79.1564739117019;
 Fri, 02 Aug 2019 02:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com> <cover.1564695892.git.steadmon@google.com>
 <61b989ff16eadfd0508e10f71c9b318eb15ce2a7.1564695893.git.steadmon@google.com>
In-Reply-To: <61b989ff16eadfd0508e10f71c9b318eb15ce2a7.1564695893.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 2 Aug 2019 11:45:05 +0200
Message-ID: <CAN0heSo30-ng223sJTvz5_Go+-Yu=h=qvFg0KOhguLsFVE7b2Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] git-merge: honor pre-merge-commit hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2 Aug 2019 at 00:20, Josh Steadmon <steadmon@google.com> wrote:

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 82cd573776..7c4c994858 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -103,6 +103,13 @@ The default 'pre-commit' hook, when enabled--and with the
>  `hooks.allownonascii` config option unset or set to false--prevents
>  the use of non-ASCII filenames.
>
> +pre-merge-commit
> +~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by 'git merge' when doing an automatic merge
> +commit; it is equivalent to 'pre-commit' for a non-automatic commit
> +for a merge.
> +

I'm not sure everyone understands what an "automatic merge commit" is.
(Is it an automatic "merge commit", or an "automatic merge" commit? Or
sort of both?) And I'm not sure exactly what to infer from the
"equivalence". I happen to know that the statement about the default
hook can only be half-carried over. And I'm not sure what to infer from
"All the git commit hooks are invoked with the environment variable
...".

Is the below suggestion 1) correct, 2) readable?

  This hook is invoked by linkgit:git-merge[1], and can be bypassed
  with the `--no-verify` option.  It takes no parameters, and is
  invoked after the merge has been carried out successfully and before
  obtaining the proposed commit log message to
  make a commit.  Exiting with a non-zero status from this script
  causes the `git merge` command to abort before creating a commit.

  The default 'pre-merge-commit' hook, when enabled, runs the
  'pre-commit' hook, if the latter is enabled.

  This hook is invoked with the environment variable
  `GIT_EDITOR=:` if the command will not bring up an editor
  to modify the commit message.

  If the merge cannot be carried out automatically, the conflicts
  need to be resolved and the result committed separately (see
  linkgit:git-merge[1]). At that point, this hook will not be executed,
  but the 'pre-commit' hook will, if it is enabled.

(If you use this or something like it, notice how this already mentions
`--no-verify`...)

> +test_expect_success 'root commit' '
> +       echo "root" > file &&
> +       git add file &&
> +       git commit -m "zeroth" &&
> +       git checkout -b side &&
> +       echo "foo" > foo &&
> +       git add foo &&
> +       git commit -m "make it non-ff" &&
> +       git checkout master
> +'

You got rid of loads of "> file" in patch 1/4, so it seems unfortunate
to introduce a few here. ;-)


Martin
