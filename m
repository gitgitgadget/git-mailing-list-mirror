From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] t/t5520: use test_i18ngrep instead of test_cmp
Date: Tue, 29 Mar 2016 16:27:39 -0400
Message-ID: <CAPig+cSLD2hKpckKU_tn=AhK8ZDgW13D2YMAf2p9Q-CpwOAM4g@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-4-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:27:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0Es-0004kl-1a
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbcC2U1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:27:42 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33818 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbcC2U1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:27:41 -0400
Received: by mail-vk0-f66.google.com with SMTP id e6so3813767vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=D0K/OjSXSRw7LHZ9qNVPBt6BO/2VZWH6Ja0tQUucOEc=;
        b=naDpxsw/CX8kuxIODVAwYp2GadzKc29khmvpg8TZfHFtSjJIS4WTgILEk25FwoD3gJ
         hzukLWVylzpMJCw9PHI0HQk5IaH+iekERF2d7yQfSkDtVO8ORi3xWSpPV9vXdnO6S7Vd
         uZ9djAawFoJbEV6K2eRpY2ZSr+YIjb7EukB4wwb8DaefJSEiEU6Kc/4G0jzwt20BPmOm
         AvWnAlDrFE6gE6wHWGvm0qFbzYTqA+fRpbSLjNicJjmdODhI8K3YM7GGbwsM+GDMBtPs
         jxI4FECFGzKKwvJy5YgjNswYTE2C5t2lH65I7VtE2a4b+VSw3igRr/Gaac1WYTd+l7Do
         FVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=D0K/OjSXSRw7LHZ9qNVPBt6BO/2VZWH6Ja0tQUucOEc=;
        b=dvFS/xuv7tG7vZjnZfxabvaUe4xugELifov1VEoDJG6kfqWTOsCXWhFDjCF390nsep
         XWiLJVrag1srXAeIOSfPvTurai+MhmdOC8fCFTxhbECYA3BO3MkWQEP418UA8mdfZlBW
         lOnqwaJkUvnc+0G4Ip+d9/DBMsVauKzYO1nC7AeX/RbaNmpDsPj26m7qedyVQ0USsr3v
         LniHZSdkv2Kbfn5+zg9kT1WkHEj/01hRWNn2wMPfGtrHH7OoZAv0OkvyXDT8QVHMNXLp
         aKNznKDW1ZtCA3KsA0YonMGWLcf/hg/wq/i/zmwvqkFPhP7bfaN8dXdCKwPRHuWa6xCt
         P1hw==
X-Gm-Message-State: AD7BkJJlIFbJ/mTgJIK0rS5LaQv1578Pqrena84PDB0z0xxkLeRBYacA4seix/POoF2rW9uUb0+DVEyWRH9ZgQ==
X-Received: by 10.31.150.76 with SMTP id y73mr2728063vkd.84.1459283260017;
 Tue, 29 Mar 2016 13:27:40 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 13:27:39 -0700 (PDT)
In-Reply-To: <1459258200-32444-4-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: AogRwSOEhfSSabmEss5lo7GoED8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290189>

On Tue, Mar 29, 2016 at 9:29 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> t/t5520: use test_i18ngrep instead of test_cmp

As mentioned for earlier patches, this is too low-level, whereas it
should be giving a high-level overview.

> test_cmp is used for error checking when test_i18ngrep could be used.
>
> Use test_i18ngrep to check for the valid error.

"could be used" is not sufficient justification to explain why this
change is desirable. See [1] for a good explanation of why this change
should be made.

The patch itself looks fine.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289077

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  t/t5520-pull.sh | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 9ee2218..d03cb84 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -317,15 +317,13 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
>  '
>
>  test_expect_success 'pull --autostash (without --rebase) should error out' '
> -       test_must_fail git pull --autostash . copy 2>actual &&
> -       echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
> -       test_i18ncmp actual expect
> +       test_must_fail git pull --autostash . copy 2>err &&
> +       test_i18ngrep "only valid with --rebase" err
>  '
>
>  test_expect_success 'pull --no-autostash (without --rebase) should error out' '
> -       test_must_fail git pull --no-autostash . copy 2>actual &&
> -       echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
> -       test_i18ncmp actual expect
> +       test_must_fail git pull --no-autostash . copy 2>err &&
> +       test_i18ngrep "only valid with --rebase" err
>  '
>
>  test_expect_success 'pull.rebase' '
> --
> 2.7.1.340.g69eb491.dirty
