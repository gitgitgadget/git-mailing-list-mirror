From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 23/26] t5500, t5539: tests for shallow depth excluding a ref
Date: Sun, 5 Jun 2016 01:09:44 -0400
Message-ID: <CAPig+cSFk65f831Z+U6gwdW2Brs4JOtxj2b9toOKrJAfDZX9iA@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com> <1460552110-5554-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 07:09:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9QJs-0006qV-KY
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 07:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbcFEFJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 01:09:47 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35966 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcFEFJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 01:09:45 -0400
Received: by mail-it0-f45.google.com with SMTP id f67so19744048ith.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UNFY+pmPbyHq8bZQL5UTpucpvw537T/+5PhRqePFKwU=;
        b=lpow2J/t/TCkQUCzGrMEFJzzCh317DBBkAFoKLxcxhgj9fxl0IlyOyVAcy2RuO6D03
         cQozBQTfsIdDy/qpy28n8mocU2kWfUjnRGkBsBgPVaDhAW3wLzqpfYmRBXbdpGS/p31H
         2AExuxkvWOOHEpKUBAdGVgA5JUiU1K7/IFcFqPZjmHpbZcZP/8CNWJZx3AHIt/0yAW6t
         U0DKyJpdj5UkdODcNefF3ORxDw8ZmvZNAB20ngRxUitXunOZUFNkj6BJ72qEbXBwh/Pn
         yMOORYs+u7+AGp+17+9szlKtwh0ScsaBToX0EamnLN0Wh8+n28b3YfZ4haqtV+Td5agR
         4tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UNFY+pmPbyHq8bZQL5UTpucpvw537T/+5PhRqePFKwU=;
        b=krlXjJKQueQXzqIkq5M4KqLFxScn+JXPSSqqablAxkWAEfiZWQ4EWaiBr8rAnv10oQ
         Xn0s+LHRDrkwThk67OMAjpfgRzeg9Cuv0i6gc1ZrurInvSXH4GyI8RlM+LyPAPVMiu7o
         5BW28yE/VIM27TuN0vqxNCdih+2/8GV7vn9zckWxgAdHssIt0kihTw3wExTpJbIfhdML
         J7aMOMRm8/QnTFvysF3LCWycPYa/s7YtmRSFnzonXwXt1Y/YrpaCrb/0zku8JfmoD6Lc
         KtY5vBnfJAoXOGJxGHveFEQlZz2okXgxppMbWsX5srMp/cjleUoeg0tSoHVEGNHeuuqB
         MNEQ==
X-Gm-Message-State: ALyK8tLWUZu9sDurXtVoEnF4Tbr9QtNXB9Z6ICQ6iZlA4dl2LHFobL1J2VkHvzEULYRZgphkNUwK/kFvH5A/Tw==
X-Received: by 10.36.55.138 with SMTP id r132mr8667303itr.73.1465103384645;
 Sat, 04 Jun 2016 22:09:44 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sat, 4 Jun 2016 22:09:44 -0700 (PDT)
In-Reply-To: <1460552110-5554-24-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: KBO8EVUpJJBuNt7Cg03WUuzBkAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296467>

On Wed, Apr 13, 2016 at 8:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> @@ -661,4 +661,26 @@ test_expect_success 'fetch shallow since ...' '
> +test_expect_success 'fetch exclude tag one' '
> +       git -C shallow12 fetch --shallow-exclude one origin &&
> +       git -C shallow12 log --pretty=3Dtformat:%s origin/master >act=
ual &&
> +       echo three >expected &&
> +       echo two  >>expected &&

Perhaps:

    echo >expected <<-\EOF &&
    three
    two
    EOF

or:

    test_write_lines three two >expected &&

but not worth a re-roll.

> +       test_cmp expected actual
> +'
> diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shall=
ow.sh
> @@ -98,6 +98,28 @@ test_expect_success 'fetch shallow since ...' '
> +test_expect_success 'fetch exclude tag one' '
> +       git -C shallow12 fetch --shallow-exclude one origin &&
> +       git -C shallow12 log --pretty=3Dtformat:%s origin/master >act=
ual &&
> +       echo three >expected &&
> +       echo two  >>expected &&

Likewise.

> +       test_cmp expected actual
> +'
