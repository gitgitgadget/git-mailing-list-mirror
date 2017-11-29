Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6520D20C17
	for <e@80x24.org>; Wed, 29 Nov 2017 03:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbdK2DMG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 22:12:06 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44537 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbdK2DMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 22:12:05 -0500
Received: by mail-pg0-f50.google.com with SMTP id j9so872972pgc.11
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 19:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=XAJfUZDF1SmhAJnMINUaEm8+f4Uxf3QV/MlY3wEWJ2w=;
        b=DVsfjMTFpXqyX3f0RDzDnn0ZZRtFYR1fe4p/rNHoVPqkDmZ4G7xcY1Mf+p6L21Mh4i
         5fvbAHb8xKk1NdA73YiUG3Gf3HwdE+kcNKGhdtFg4cgw9/lNjNuj3E1lEnyaRKXZEeOx
         h73UVdxsGvVqHvqPkVVYghkZiiEdFjp87ulnhJ+m/zIXTN1HPBUxM8hQMdxvGDFZPweZ
         zKniy4PTQ6xQLHkAvkTGc3Mv6jJikCQrkdujRLaYogGwtDtP91dU+OVZKqLYNKcaw8Ew
         dtPxULaLdCStamggvBh/tgJeJPXARXLBVrvKU9l1RM2gwnVoiD7e7fDD/AOkFLCwyzkQ
         e8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=XAJfUZDF1SmhAJnMINUaEm8+f4Uxf3QV/MlY3wEWJ2w=;
        b=g51ZTLK1plt9Ne9AM0MIOcFc8V+TdMddZ+ySejy1zdqC6NauR+pL2ZmCy9GBD3mX9/
         4t4Ao3+er7loOVPcEird0AMm6rJ9EZZtCC2DkNUwYuSl9iYXJTxx/5fFnfOGrCReBWgf
         chqcZGYe8gueu8TanRIF+v3cA8CkY4RLKgEWnbT/CCFgm4EHDRbzdbiUra+aL13TXU5V
         D6lHIbyZgYpHwZ/579Qz+TRUDngQZG0qjTr55Cr3UZA+2XhKY7FyNQDhWAle74kFxfKK
         qAMNUKHFNxjtonEg42y5o3WSpc19uEzUeojjIKZTtnGkgKouNGVZsfuDL4YtM1D51swm
         bUSg==
X-Gm-Message-State: AJaThX5g4iBOSGk3bwlT4CWYD01WbaLtjeKzn66gEfq7G66dfaIl3c+a
        HE1nMgpIrTPTEzL61n7uxqg=
X-Google-Smtp-Source: AGs4zMaFpEubchhzGUBQCmpJq9UAO+bavdz7zLJfGthZr+w+dUTX5PXaS0XeOAEwV5HtIcaZbVEh+A==
X-Received: by 10.99.142.73 with SMTP id k70mr1399290pge.426.1511925124650;
        Tue, 28 Nov 2017 19:12:04 -0800 (PST)
Received: from unique-pc ([117.246.25.0])
        by smtp.gmail.com with ESMTPSA id h69sm637121pfe.107.2017.11.28.19.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Nov 2017 19:12:03 -0800 (PST)
Message-ID: <1511925118.2486.2.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase: give precise error message
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
In-Reply-To: <xmqqzi7654hx.fsf@gitster.mtv.corp.google.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
         <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
         <xmqqpo8387hz.fsf@gitster.mtv.corp.google.com>
         <1511877882.10193.2.camel@gmail.com>
         <xmqqzi7654hx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 29 Nov 2017 08:41:58 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-11-29 at 09:10 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > If <ref> is the correct substitute <branch>, I could try to send a
> > patch that fixes this.
> 
> I do not think the above is a good change in the first place for at
> least two reasons.  By saying <ref>, the updated text says "not just
> branches but you can also give tags and remote-tracking branches".

I used <ref> as you could actually use tags, remote-tracking branches
and even "notes" (i.e.) any kind of <ref> for the <branch> part. That's
how the code for rebasing works currently (specifically the elif part),

	if git show-ref --verify --quiet -- "refs/heads/$1" &&
	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
	then
		head_name="refs/heads/$1"
	elif orig_head=$(git rev-parse -q --verify "$1")
	then
		head_name="detached HEAD"
	else
		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
	fi

Which means that you could not only do,

	$ git rebase origin/next refs/remotes/origin/maint

You could even get creative and do,

	$ git rebase origin/next refs/notes/$something

It just works (of course, I couldn't understand what it did)! I didn't
want to lie to the user. So, I used <ref>. So, should we just update
the <branch> part of the doc or should we update the code for 'rebase'?
I'm unsure.

> In reality, however, it can take any commit-ish, as the "no we are
> not rebasing the current checkout" form of the command is merely a
> short-hand to check it out first [*1*].  It gives appearance that
> the change is making it more broad, but not making it broad enough.
> At the same time, more than 90% of the time, people give a branch
> name there.  Saying "branch-or-commit" for a short description of
> the command line (which is what synopsis section is) does not add
> that much value.  The body text of the description where we refer to
> the <branch> parameter of course need to be updated to say "in
> addition, instead of a branch name, you can give a commit-ish that
> is *not* a branch name.  When you do so, instead of checking out the
> branch, the HEAD is detached at that commit before the history
> leading to it is rebased."
> 
> And because we have to say "it can be a non-branch commit-ish and
> here is what happens when you do so" anyway, I think the current
> synopsis as-is would be better than making it less clear and more
> scary by replacing <branch> with other things like <commit-ish> or
> [<branch> | <commit-ish>].
> 
> 
> [Footnote]
> 
> *1* As my "log --first-parent --oneline master..pu" is a strand of
>     pearls each of which is a merge of a topic branch,
> 
>     $ git rebase -i master pu~$n^2
> 
>     can be a handy way to make a trial rebase (after double checking
>     the result of "git tbdiff", I may do "git checkout -B topic" to
>     overwrite the original or I may discard the result of rebasing).

