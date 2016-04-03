From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/7] t5520: factor out common code
Date: Sun, 3 Apr 2016 16:05:19 -0400
Message-ID: <CAPig+cS3yhQdTQrX4kC89GjLW==ynEjxatXVFpJo4jkJENOf6w@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<1459619912-5445-6-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:05:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amoH4-0001gd-9O
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 22:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcDCUFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 16:05:21 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36328 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbcDCUFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 16:05:20 -0400
Received: by mail-ig0-f194.google.com with SMTP id kb1so628766igb.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=LTq83owJaqjR/oqLnM1IR8PsxRIdAXGQXPcUZIWjS14=;
        b=oZ/HeSaZDUN18FxOMs35lY/yTkKkTnT+vKi5LZx3eWbWmri/kvDg7Jf+F+NEpMxi1y
         dGMv4gA3sBZ8bVm598NxRbXYOq1ONvPkYivdWkfj8UlNwQITuinMftPomR6wXsSvTbGF
         WWenIUAVSvu1XRhbawhw7xxp8YX5/RyvDJvx0P7JdeR8ADtjwwKJb60j5MlskOcQY0lj
         5ZrIsQ3EzFOeWw14C8Yyl6mNomx3oCt/oin3UDNvDMzmgw9p5Lj6H0Kw0GfEGpT8n/O+
         nfhmoru1K4GlcZTRQH7OTgj6FzNkPgmgYSQuEMRyRNfGB1WzA4zdZMRi3uYfaDQtM2PI
         1EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LTq83owJaqjR/oqLnM1IR8PsxRIdAXGQXPcUZIWjS14=;
        b=Z9kKNfDVN1xQggiD41VF/MvRzK5w0TyqefgI25FNDV1fQ7F/FErATAW9keRI7bXCrV
         mqJfQlC0CKYsrGJ+X1gmZmTpRSGLWjg8MoCnIKl6HO0p8ohrt4/qReMS3g9RdrcqIKbE
         8/c37qRSmG4wXEj3bHVTljWEP3Jc8n+tSjM8FPaK5BFe/eH4dFcehnb+fDHawo5SJru0
         siHdXQm0WjCIAyE7wSwNsy5JI8OV1nWDtaMCUf11AjlYlc/KrBzKDGg3bduSA2jo48EN
         rLKGG1R/1qgfJuRzpdFGy+rbAeTAiHoV9mZ8WXHsuTPuTUPRazFJEsWkxupvohdg5VeW
         bB3A==
X-Gm-Message-State: AD7BkJLxgJTn6CouYjgKbpaj1puuihS4+q4nTZKkeFt+1TZQU5ELgvJ56PZzjCXUwTFJaYg5jOS/hJ5sTzuRvw==
X-Received: by 10.50.138.69 with SMTP id qo5mr7996175igb.17.1459713919424;
 Sun, 03 Apr 2016 13:05:19 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 13:05:19 -0700 (PDT)
In-Reply-To: <1459619912-5445-6-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: veaeD4vkRwzfpq13hOzcLK0Qe48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290649>

On Sat, Apr 2, 2016 at 1:58 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> t5520: factor out common code

To distinguish this title from that of patch 4/7, you could say:

    t5520: factor out common "failing autostash" code

> Three tests contains repetitive lines of code.
>
> Factor out common code into test_pull_autostash_fail() and then call it in
> these tests.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -19,6 +19,14 @@ test_pull_autostash () {
> +test_pull_autostash_fail () {
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull $@ . copy 2>err &&

Nit: Same comment as in 4/7: This could just as well be $* rather than $@.

> +       test_i18ngrep "uncommitted changes." err
> +}
> @@ -277,29 +285,17 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
>
>  test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
>         test_config rebase.autostash true &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> -       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +       test_pull_autostash_fail --rebase --no-autostash
>  '
>
>  test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
>         test_config rebase.autostash false &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> -       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +       test_pull_autostash_fail --rebase --no-autostash
>  '
>
>  test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
>         test_unconfig rebase.autostash &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> -       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +       test_pull_autostash_fail --rebase --no-autostash
>  '
>
>  test_expect_success 'pull --autostash (without --rebase) should error out' '
> --
> 2.7.1.340.g69eb491.dirty
