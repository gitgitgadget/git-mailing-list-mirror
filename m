Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA61202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 19:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbdGFTih (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 15:38:37 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35345 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdGFTig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 15:38:36 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so5671975pfk.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6tLAGLUv4+B3VjiujvIQ6eFWCfM+jkHQXwsXhgUFCjo=;
        b=bLyOpgqAB+B5r2afodpzobkoYOXQsFXiA74HbUuxPHOFxHmhHQGpeiuHfAEPNRYTGm
         ERMe4J2s+6meDFdr0U5hbUVKHwRYUMCpOMbELfQs/pFNAZr2epH8uXaZ92aaQpY0OBCU
         qz8PEsiG9pXarQSHdLdGDkztqkawUMn9IJGgp2k2iN4ob6QtRgibDBmAHreClyTrIyVh
         sJW8MaW8koWLoEZD34owZEUOa1VSsbi/JTvhOa2a26HmN6MqJUCR2OEbLLOkMTb/L7d/
         xu0nhH9mlzsxOpFj94W4dChJIu47nD7OXCKOYF15J/o5D9iTqffuE+cblyd2s7WH3UO0
         uFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6tLAGLUv4+B3VjiujvIQ6eFWCfM+jkHQXwsXhgUFCjo=;
        b=ogPVz/r+0Bf4Llrx2fCOJRm8fgi//+QKV5ws5kjubad89Qi0K9pj20brvuahmJASs9
         9xeZPCeir3SY41/h8gWdh3sb5k8ohV3DKzpx4hbRbZe92ywF1onSw4rjjs0azu05c9tf
         KPs8bPVZNnN7+9SnQgo6Wd52Lc93sEAmqy97l3lfplXlvJtqVSZeUXQJzL8TGeIthEUV
         3eGyFHWYJd8IAxbXwLpGws0IHBLAWbGdMM4yCoXU2WcmUW3aXVV+jTr4v4R72ou6/qY5
         eRgqraBpb4noPycghNHSn+bilPxuoH2xuOcbR9RZ6MZnPZpzT7GvaXGLVqgmQcdoQ06V
         LXeA==
X-Gm-Message-State: AIVw112Xl3BErMFub/DvnNGtMtc2ISqaO05MJ0dPKF6wnymT+wN57Pm5
        KpmBu13Io7OrndztuvMUL80bWXsC7Ap4
X-Received: by 10.98.112.137 with SMTP id l131mr27451339pfc.194.1499369915216;
 Thu, 06 Jul 2017 12:38:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 6 Jul 2017 12:38:34 -0700 (PDT)
In-Reply-To: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
 <1n47so5.9e6qvf1bbqww4M%haller@ableton.com> <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
 <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
 <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
 <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com> <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Jul 2017 12:38:34 -0700
Message-ID: <CAGZ79kbCo3EjRGR_iE=6CJ2ou=4gMv3=t+s1ctGhUbZg8UDixA@mail.gmail.com>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 6, 2017 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "git push --force-with-lease=<branch>:<expect>" makes sure that
> there is no unexpected changes to the branch at the remote while you
> prepare a rewrite based on the old state of the branch.  This
> feature came with an experimental option that allows :<expect> part
> to be omitted by using the tip of remote-tracking branch that
> corresponds to the <branch>.
>
> It turns out that some people use third-party tools that fetch from
> remote and update the remote-tracking branches behind users' back,
> defeating the safety relying on the stability of the remote-tracking
> branches.  We have some warning text that was meant to be scary
> sounding in our documentation, but nevertheless people seem to be
> bitten.  cf. https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/
> for a recent example.
>
> Let's disable the form that relies on the stability of remote-tracking
> branches by default, and allow users who _know_ their remote-tracking
> branches are stable to enable it with a configuration variable.
>
> This problem was predicted from the very beginning; see 28f5d176
> (remote.c: add command line option parser for "--force-with-lease",
> 2013-07-08).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is a bit overdue safety fix that we should have done long
>    time ago.  If we had this, I do not think it makes it riskier to
>    forbid --force and tell people to use --force-with-lease.
>
>  Documentation/config.txt   |  5 +++++
>  Documentation/git-push.txt |  5 +++--
>  builtin/send-pack.c        |  5 +++++
>  remote.c                   | 16 ++++++++++++----
>  remote.h                   |  2 ++
>  send-pack.c                |  1 +
>  t/t5533-push-cas.sh        | 19 +++++++++++++++++--
>  transport-helper.c         |  5 +++++
>  transport.c                |  5 +++++
>  9 files changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 06898a7498..2f929315a2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2588,6 +2588,11 @@ new default).
>
>  --
>
> +push.allowLazyForceWithLease::
> +       If set to true, allow the `--force-with-lease` option
> +       without the expected object name (i.e. expecting the objects
> +       at the tip of corresponding remote-tracking branches).
> +
>  push.followTags::
>         If set to true enable `--follow-tags` option by default.  You
>         may override this configuration at time of push by specifying
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 0a639664fd..1fa01210a2 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -212,8 +212,9 @@ must not already exist.
>  +
>  Note that all forms other than `--force-with-lease=<refname>:<expect>`
>  that specifies the expected current value of the ref explicitly are
> -still experimental and their semantics may change as we gain experience

This indicates that this feature is not 'experimental' any more, but disabled
(for safety reasons as described below). This implies we will not change the
heuristic for push.allowLazyForceWithLease easily.

Upon reading this documentation and the safety issue, I thought
one could have used the reflog to make it safer as well:
 "I have (manually) inspected the remote tracking branch
  just before lunch, so now I can safely push with lease after lunch"

would translate to e.g. "--force-with-lease-safe--inspection-time=1h",
which would make sure that no reflog entries for the given branches
exist in the last hour.

Just as food for thought.

>  test_expect_success 'push to update (protected)' '
> @@ -78,7 +79,6 @@ test_expect_success 'push to update (protected, tracking, forced)' '
>         (
>                 cd dst &&
>                 test_commit E &&
> -               git ls-remote . refs/remotes/origin/master >expect &&

This seems unrelated, so ideally it is a separate commit?
Fine with me though.

> @@ -91,6 +91,7 @@ test_expect_success 'push to update (allowed)' '
>         (
>                 cd dst &&
>                 test_commit D &&
> +               git config push.allowLazyForceWithLease false &&

Here I thought

    test_config -C dst ...

at the beginning might be useful, though ..

> @@ -103,6 +104,10 @@ test_expect_success 'push to update (allowed, tracking)' '
>         (
>                 cd dst &&
>                 test_commit D &&
> +               git config push.allowLazyForceWithLease false &&
> +               test_must_fail git push --force-with-lease=master origin master 2>err &&
> +               grep "lazy force-with-lease" err &&
> +               git config --unset push.allowLazyForceWithLease &&

.. here the -C is not useful, so just using it once above may
not be a good idea. For more dense and readable tests
(also faster?), have you considered using passing the option via
-c instead of setting and unsetting it?

Thanks,
Stefan
