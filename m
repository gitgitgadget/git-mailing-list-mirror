Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A77202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 12:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbdCIMbZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 07:31:25 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33387 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752926AbdCIMbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 07:31:23 -0500
Received: by mail-lf0-f67.google.com with SMTP id r36so4525372lfi.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HdPZyIXdpKp2qNKDCmhp+kHJcsSWLiBiFqy6xrA9vA4=;
        b=jZ5Ls3IvSW1w6kAwXTuCnOJ/BHg16NULGvQ//VsPwqByULO8waTLuYeN+rFaNWJfQ5
         0qqSR/wcgNqbZ3DUiLqWnMe3uxPdmhuto1QxoOOx7OQaWuWEOQzyp6IvIooNJfnRgUOU
         XVF073hlCmeGg4TKnn7PgcOg0oo3k0ipUO5Wy6eZgRSzSLkWcMcbIE2jgcTshKQGsYOJ
         2w7IMERgK9PZNEtt7yaQG996yEd3/8KNAC2hzlnoDtnb0fzWkcnfsnTbNlJY3pSfdMrG
         +9ESJdVITPea9Cu3MEE5JHKA1K2T2eTDSIU70y7lOzBPPg6yyAYJvCaXcVdnJbN1NCp8
         YiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HdPZyIXdpKp2qNKDCmhp+kHJcsSWLiBiFqy6xrA9vA4=;
        b=lUPdDWScaTwDjeQiJpN5fE2czKZ4BbVgtLlVfTXlNPpLIiph0GuCLmueUwsIezc9yg
         fz38J/jujeeJU+zv9nqdQYNSqD37KDZBg28kZfVwUh5lOIugJy47tjeCheOKto8flEK6
         HmJ3Xz6JJls1J3fc+MZM2JvJ5zECJYbxTxS66SuWAMmvzmRMoGJk9amUKHp9qEsgZNz/
         bFVZdQoQ4FiywdNbqsysjg3uzV94lSlv5C28h/fG9WISz1uJ0D479oMxCJ9ZiMQYzVrm
         4xKsXWSj3Ke7owpPuEghy8SwAJ2Ag5n1ZUQn0RDfE1sol1HfBJqRdh8TrfECppS5qbwO
         48Tw==
X-Gm-Message-State: AMke39mBlgYC+3tP7QlsuMwXz0suZNj6+vuEzbxZqd5E9NpZY/j27P3FxvNhjowbyod50k5yjd6nkC19+r84/Q==
X-Received: by 10.46.20.80 with SMTP id 16mr1830285lju.81.1489062645953; Thu,
 09 Mar 2017 04:30:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 9 Mar 2017 04:30:45 -0800 (PST)
In-Reply-To: <0102015ab27c6633-c61f56f2-0504-4af3-badc-34246cf635aa-000000@eu-west-1.amazonses.com>
References: <0102015ab26fcf13-1659be12-a85c-47be-9a77-8f1b0b8a3897-000000@eu-west-1.amazonses.com>
 <0102015ab27c6633-c61f56f2-0504-4af3-badc-34246cf635aa-000000@eu-west-1.amazonses.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2017 13:30:45 +0100
Message-ID: <CAP8UFD19njU30HODYvp1pddpZaVSVGgn7whcTa2rdjMPe-vzYQ@mail.gmail.com>
Subject: Re: [PATCH v2] t2027: avoid using pipes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 10:53 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Whenever a git command is present in the upstream of a pipe, its failure
> gets masked by piping and hence it should be avoided for testing the
> upstream git command. By writing out the output of the git command to
> a file, we can test the exit codes of both the commands as a failure exit
> code in any command is able to stop the && chain.
>
> Signed-off-by: Prathamesh <pc44800@gmail.com>
> ---

Please add in Cc those who previously commented on the patch.

>  t/t2027-worktree-list.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 848da5f..daa7a04 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
>         test_when_finished "rm -rf here && git worktree prune" &&
>         git worktree add --detach here master &&
>         echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git worktree list | sed "s/  */ /g" >actual &&
> +       git worktree list >out && sed "s/  */ /g" <out >actual &&

I still think that it would be better if the 'sed' commend was on its
own line like this:

+       git worktree list >out &&
+       sed "s/  */ /g" <out >actual &&

>         test_cmp expect actual
>  '
