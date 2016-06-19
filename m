Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F1D1FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 06:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbcFSG7n (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 02:59:43 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35494 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbcFSG7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 02:59:42 -0400
Received: by mail-io0-f179.google.com with SMTP id f30so99673409ioj.2
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 23:59:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=smZe2Gq0vRGldLi9oHiw8F1Oux5vd5ycXRfHxUf/+7o=;
        b=VXlU3EZXwHJigf3EwezKLu4GjTf/hPSxNZu1OyEsMQRUF0QvrjM4/m3JatEY/OuFUI
         QZvGcSRIpi0tIdiLAHnU+zQY2WH0GQrfoIdV8SUTeKxvDjv1FCl5NZ7zcKdNQQ4w2g0s
         Sop3cF79dM6mYnYPg5sLEc0vRrxsZ+Kb+svzLKGYH5aClRj+lEEHVu5NittrPNuEtxrH
         mw5HFGHIqT27IBhqPl/TaeleFZhn5AwGk/hrEMdWeDeh0LKX4JkHoPcs+8fuMoBJL364
         z+wYcrJEHJ5VoV0sZK4rKom2cZzRMG3KOoV8N/ehSNdhcuhfBdI3WBJtYwp2/Kh3axNI
         7Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=smZe2Gq0vRGldLi9oHiw8F1Oux5vd5ycXRfHxUf/+7o=;
        b=ZC1TScwesnX7godZBSi0rqHd+nb6QU6Kju4wN46lBPP2e3yjwz0j7dSuE/g3+buYb+
         Y2gUWUS+54ZCrWpf0t5vKLtGOF+ZydY1ZZ+oC+1vzXszhVwvwp6E8TP/ILOyhcVOFmq9
         P/NpOF8nq40lN/HB35gx5Y/t7/xnVO14XWzPeve2SLSJmxxfdTGQMtBBS11s/1wCBVLT
         m5gVSlGYTKB8aQlJ++bcCW1CmL4D+nHWjamJCOkWj/boFCDJsT1U4NhgDsmEYQqSNul9
         rzOVUk/vtME/jgdnwD4Ud8dECQUJATqfzOY4fLB+EbMvQ1se8H75Ii8437oe9NoQCi+J
         4MOw==
X-Gm-Message-State: ALyK8tKrkq+AurwUMN7fx46D7hbLAD+r03iftx+2siAPOC6i+evR9By0L8lk1bD7jS+08btRoWe20eZzv/avnA==
X-Received: by 10.107.47.41 with SMTP id j41mr13593479ioo.168.1466319581355;
 Sat, 18 Jun 2016 23:59:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sat, 18 Jun 2016 23:59:40 -0700 (PDT)
In-Reply-To: <20160618122510.5105-3-mehul.jain2029@gmail.com>
References: <20160618122510.5105-1-mehul.jain2029@gmail.com> <20160618122510.5105-3-mehul.jain2029@gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Sun, 19 Jun 2016 02:59:40 -0400
X-Google-Sender-Auth: dCMncoNrJ6J_-pTKTbKC0a6jfXg
Message-ID: <CAPig+cRZyCZuec1GuxtW0p_8G1VPq1y846USM-TNmP3bbTYxQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] log: add log.showSignature configuration variable
To:	Mehul Jain <mehul.jain2029@gmail.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 8:25 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Users may want to always use "--show-signature" while using git-log and
> related commands.
>
> When log.showSignature is set to true, git-log and related commands will
> behave as if "--show-signature" was given to them.
>
> Note that this config variable is meant to affect git-log, git-show,
> git-whatchanged and git-reflog. Other commands like git-format-patch,
> git-rev-list are not to be affected by this config variable.
>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> @@ -900,6 +900,31 @@ test_expect_success GPG '--no-show-signature overrides --show-signature' '
> +test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
> +       git checkout -b test_sign master &&

It appears that you copied the bulk of this test from the 'log --graph
--show-signature' test and changed it to create a new branch named
'test_sign' rather than 'signed', however...

> +       echo foo >foo &&
> +       git add foo &&
> +       git commit -S -m signed_commit &&
> +       test_config log.showsignature true &&
> +       git log -1 signed >actual &&

... you're incorrectly testing against the 'signed' branch rather than
the 'test_sign' created specifically for this test.

> +       grep "gpg: Signature made" actual &&
> +       grep "gpg: Good signature" actual
> +'
> +
> +test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
> +       test_config log.showsignature true &&
> +       git log -1 --no-show-signature signed >actual &&
> +       ! grep "^gpg:" actual
> +'
> +
> +test_expect_success GPG '--show-signature overrides log.showsignature=false' '
> +       test_when_finished "git reset --hard && git checkout master" &&

So, in the first of these three new tests, you're setting up some
state by creating and checking out a new branch named 'test_sign', and
leaving that branch checked out while these three tests run, and
finally use test_when_finished() in the last of the three tests to
restore sanity (by returning to the 'master' branch) when that test
exits.

This is ugly and couples these three tests too tightly. It would be
better to make each test more self-contained, not relying upon state
left over from previous tests.

> +       test_config log.showsignature false &&
> +       git log -1 --show-signature signed >actual &&
> +       grep "gpg: Signature made" actual &&
> +       grep "gpg: Good signature" actual
> +'

In fact, the original 'log --graph --show-signature' test which
created the 'signed' branch, the new --no-show-signature test added in
patch 1/2, and the three new tests here could all just work against
the same 'signed' branch. There is no need to create a new 'test_sign'
branch for these three tests, or a 'nosign' branch for the patch 1/2
test.

Therefore, it probably would make more sense to add a new distinct
'setup signed' test (or just enhance the existing 'setup' test) which
creates the 'signed' branch and update the original 'log --graph
--show-signature' to take advantage of it, as well as each of the new
tests introduced by this patch series. And since each test would
mention 'signed' explicitly in its git-log invocation, there's no need
to leave that branch checked out, so the setup test itself only needs
test_when_finished() to ensure that the current branch is restored to
'master'.
