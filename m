From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] t/t5520: modify tests to reduce common code
Date: Tue, 29 Mar 2016 17:01:34 -0400
Message-ID: <CAPig+cQ3gaAdKU0M3v4q5AzvQSTciwHYv7fAAdCGTKYoOkJTow@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-5-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:01:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0lh-0001o6-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbcC2VBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 17:01:37 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34687 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbcC2VBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 17:01:36 -0400
Received: by mail-vk0-f68.google.com with SMTP id e6so3928193vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=JYROKiHNEBEuJpjaMz+dH7c2EQ3EBOzGaQDpyfYA7qw=;
        b=DLltBMn7eiwsye3NJY0cKlvUkZ975OTXw2z9tB6A0xKcJYT4QwHmzgSteXYeFyg3B8
         VhAtA1ZO4Jw44TNWk35LNYCFbtOKqZ1ex7AxDGYsKTsKqQedizy9DOk25Hm10EgprCR6
         OIyQC6NOeyI/rxUzi4D9LXUEKeWpdsVXuSUOtE08WXE3YTsU0GfK5r6eNb1X+VD7+4th
         5psEwmBgUwrx+X9YpcBYRETfUFEcw6syQEXF3Htsrl8dbOHp2zuK1BunvXToMhV3q0uM
         9dTlVuwLcbGygf5jTGX/BVOcIZDWf9yOP4u+Y79FwP7BhP4gxwUKc6O0gr6GA+iPCxUS
         mWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JYROKiHNEBEuJpjaMz+dH7c2EQ3EBOzGaQDpyfYA7qw=;
        b=CB/ufemhCv4aS+Bd07okMr1fKewIn6EAhJkezptxybAHyreik3Cp/LNb2ucx/EWeBN
         ENVKnQKsf6hsvzhVeqR40Hav3Je+sfH7y5cO8Vdj4SS8PaSSu4nmvCWm8v1YFfMM1rg1
         zrOj8yPjDiChfvJNNZj45U8QOXsHaX20a2swDHcM683UlFPymorNMYHhu5j8ogSleytc
         97LUb/Y9/K/HEwyWHRoP1eLhhNCxg5NnvGUgjpxRk+4s4M3dNUz3RglpnZ/UgS+NOay/
         vi3YfO82MUa88IPXGTO4U66meov//p9PEqK5UJkSz2bW+VpFLn3jSSrQGZHAGQ2iNKSk
         zi9w==
X-Gm-Message-State: AD7BkJKokp95IiQCS/mZQZGsoD2Zf6NJLqIpibZlzDLtmd/gjfn4bCgv3WtXOSscppBjmohy5Gc9YEiQw4OAbg==
X-Received: by 10.159.38.49 with SMTP id 46mr2581734uag.139.1459285295223;
 Tue, 29 Mar 2016 14:01:35 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 14:01:34 -0700 (PDT)
In-Reply-To: <1459258200-32444-5-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: 5znae2qBJPWIRecC2gPp1S8ISZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290195>

On Tue, Mar 29, 2016 at 9:29 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> t/t5520: modify tests to reduce common code

As this is indeed a patch, "modify" is implied. Perhaps:

    t5520: factor out common code

> There exist three groups of tests which have repetitive lines of code.
>
> Introduce two functions test_rebase_autostash() and
> test_rebase_no_autostash() to reduce the number of lines. Also introduce
> loops to futher reduce the current implementation.

This patch is doing so much that it's difficult to review for
correctness. Taking [1] into consideration, better would be to split
it into at least three patches:

1. Factor out code into test_rebase_autostash() and modify the four
tests to call it.

2. Factor out code into test_rebase_autostash_fail() and modify the
three tests to call it.

3. Fold the two "pull $i (without --rebase) is illegal" tests into a for-loop.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289434/focus=289860

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -9,6 +9,24 @@ modify () {
> +test_rebase_no_autostash () {
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err

In the spirit of patch 3/5 and [1], you could grep for a substring
rather than the full message, but that's a minor point, not worth a
re-roll.

    test_i18ngrep "uncommitted changes" err

> +}
> @@ -256,75 +274,39 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
> +for i in true false
> +       do
> +               test_expect_success "pull --rebase --autostash & rebase.autostash=$i" '
> +                       test_config rebase.autostash $i &&
> +                       test_rebase_autostash
> +               '
> +       done

I don't care too strongly, but I'm not convinced that this for-loop is
buying you much for these two cases since each test already has been
reduced to two simple lines, and the added abstraction of the for-loop
increases cognitive load a bit.

> +for i in --autostash --no-autostash
> +       do
> +               test_expect_success "pull $i (without --rebase) is illegal" '
> +                       test_must_fail git pull $i . copy 2>actual &&
> +                       test_i18ngrep "only valid with --rebase" actual
> +               '
> +       done

You might then ask why I suggested[1] the for-loop in this case but
not for the true/false case. Even though these are also two-line
tests, they are not quite as simple as two lines down to which the
true/false tests devolve. Anyhow, this alone is not worth a re-roll.
