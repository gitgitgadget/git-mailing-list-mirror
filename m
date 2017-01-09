Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E3720756
	for <e@80x24.org>; Mon,  9 Jan 2017 09:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbdAIJLJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 04:11:09 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33583 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbdAIJLI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 04:11:08 -0500
Received: by mail-qk0-f195.google.com with SMTP id 11so5433946qkl.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 01:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pFN5ba2KVubyOR6S7XlAMLWuDg9tvucUNIf0BMxRNuY=;
        b=hP7AFfIdRQ0vzP/2k7rqjpX8SCoeHfcIG9IKACpTUG4XynE5WfCbUUQYZtnD1OsiJk
         FXfHZfVlXVVqaOZAf0kX+xCNbO/Ln2lhqoIdjUZQC1NA0k3B4nSTA0veWlHN6yRMLsvN
         u6+kUwbKAdGQZsV5dPFINH6UTDYompzMtANRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pFN5ba2KVubyOR6S7XlAMLWuDg9tvucUNIf0BMxRNuY=;
        b=gYtcH2FIaOdAzuOHWLym+X20+5QhhIcfOtnwdcg2ds3p3zs7cuqt60a4668qkpu8m3
         6USvnbscEduQW1hHJTV3qock5rLCgCigRdyIFS5JjzEkESfWcTXO2mijIeY94IXwIwJo
         ++hhkV4WZ8JYNEzgex4076PJVoEECNSTTV4Vsw+UUlV0B1l2tJTX1O0NhJV2eDUHFyb5
         NeY2PVN+lm6RNrPClTcP5yRg9TA1DlJY/G6Jq7B6SF8DpmJBX/tNOUtTtk5dr0YZdPAn
         dYzIquGnvTZjJ1gQbOIXb4ufRdJcsA2h7r8NSOneHaFV/P6A7u/ipqt4CFmpIBFtkCRh
         I3dw==
X-Gm-Message-State: AIkVDXJ5dYQHY2p7RAUP86XW7MeWVkSp/NgNHfPp80Wa4hBzjuLs5t0T1E9gwXMxHK3XtguIe49ox1N/7/IPKA==
X-Received: by 10.55.104.83 with SMTP id d80mr15626948qkc.286.1483953067288;
 Mon, 09 Jan 2017 01:11:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.62.179 with HTTP; Mon, 9 Jan 2017 01:11:06 -0800 (PST)
In-Reply-To: <010201597f0179fb-fc4c0240-5ec7-466b-96b9-59f4840954d7-000000@eu-west-1.amazonses.com>
References: <010201597f017978-356bf9e9-ee78-498b-926b-5c00466b1d9e-000000@eu-west-1.amazonses.com>
 <010201597f0179fb-fc4c0240-5ec7-466b-96b9-59f4840954d7-000000@eu-west-1.amazonses.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 9 Jan 2017 09:11:06 +0000
Message-ID: <CAE5ih7-mAfezTwdbWrAWFOSoCf-z_NJOic+FQdCmHbCyR8ng9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] t9813: avoid using pipes
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 January 2017 at 16:55, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.

Looks good to me, thanks!

Ack.

>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t9813-git-p4-preserve-users.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
> index 76004a5..bda222a 100755
> --- a/t/t9813-git-p4-preserve-users.sh
> +++ b/t/t9813-git-p4-preserve-users.sh
> @@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
>                 make_change_by_user usernamefile3 Derek derek@example.com &&
>                 P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
>                 export P4EDITOR P4USER P4PASSWD &&
> -               git p4 commit |\
> -               grep "git author derek@example.com does not match" &&
> +               git p4 commit >actual &&
> +               grep "git author derek@example.com does not match" actual &&
>
>                 make_change_by_user usernamefile3 Charlie charlie@example.com &&
> -               git p4 commit |\
> -               grep "git author charlie@example.com does not match" &&
> +               git p4 commit >actual &&
> +               grep "git author charlie@example.com does not match" actual &&
>
>                 make_change_by_user usernamefile3 alice alice@example.com &&
>                 git p4 commit >actual &&
>
> --
> https://github.com/git/git/pull/314
