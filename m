From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 16:01:27 -0500
Message-ID: <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 21 22:01:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXb8H-0003qH-Mq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 22:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbcBUVB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 16:01:28 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34947 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcBUVB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 16:01:28 -0500
Received: by mail-vk0-f51.google.com with SMTP id e6so113932856vkh.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=28jv7Cx1RGhD+qCsCpxs8iS9KTq9xXTbhnh77zlaBho=;
        b=OxYrczDPsI2abEjIwmcEozkc60nueqyadWpF6Xp8+Se10qxd7KLNf99P0xV9VadXUz
         MGjAQgLvrET31adMTvgvcUJjnNWhnc+xwt0S+fkvnBIRP24SSOwOXNWtiu7OoeSgYAUO
         SjZOGWzb9GOOaJcCfCKML+1bK2aSRDJEzM72kAwsI1fHCzu0MkuqolsLvE+j9ElRTH6N
         p5+dpKlyXD0z+4aag0I2rEhy+yzFP/Z/uhgWF86VsWMGKwwUouqZssjePDvCi+sypy82
         L5geRHlR2poxZbAtvttt4cUDlAYsQnbXEQrlC7yb/uajqPUnxOQN0je8mxztAnCOYStp
         tD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=28jv7Cx1RGhD+qCsCpxs8iS9KTq9xXTbhnh77zlaBho=;
        b=gpZuGTtdcmFzeYM7ZiXZDifnlSyY1nEN1KpCN8htRMZ5daV6IXDKT2uxuMhFUU63Ye
         WZFLPlXNypWUE4jdNGwqqclm7Lwdo1411Enu322s+eRmlk3Sr3yn9NF487FDODT3Vnsd
         Q7Pr5WvZuKtj3G2c/be5X4Q0g7bUUbnXq42DzxAjYpxEaBbdRYePW2XalkYABpx8bB9a
         BTjbMSaF9F8zlOlRYQFnDlG8qPPOQqpqvnGFd5c7osU0nZlhOL1vBfgGXktcLt01wtYg
         FURl9RDHtKA36OHgIDHjCraPvZPWNzDl5Kdc9/11g9FKNA8SQHX/9vWpui7j97Mm3Rxw
         K6HQ==
X-Gm-Message-State: AG10YOQt3BTJiS8XrWRHslgl4JpHdjJromASSyFNwaKjL2xjlWRxZWbH2rKbW/W3QKCV14L9cdQlDDhVJEfBaQ==
X-Received: by 10.31.146.2 with SMTP id u2mr17605159vkd.19.1456088487380; Sun,
 21 Feb 2016 13:01:27 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 13:01:27 -0800 (PST)
In-Reply-To: <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
X-Google-Sender-Auth: GHKdZW_PlCguG95f1ppaZ6SmCWM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286830>

On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
> GNU grep 2.23 detects the input used in this test as binary data so it
> does not work for extracting lines from a file.  We could add the "-a"
> option to force grep to treat the input as text, but not all
> implementations support that.  Instead, use sed to extract the desired
> lines since it will always treat its input as text.
>
> While touching these lines, modernize the test style to avoid hiding the
> exit status of "git blame" and remove a space following a redirection
> operator.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
> @@ -35,8 +35,8 @@ EOF
>  test_expect_success !MINGW \
>         'blame respects i18n.commitencoding' '
> -       git blame --incremental file | \
> -               egrep "^(author|summary) " > actual &&
> +       git blame --incremental file >output &&
> +       sed -ne "/^\(author\|summary\) /p" output >actual &&

These tests all crash and burn with BSD sed (including Mac OS X) since
you're not restricting yourself to BRE (basic regular expressions).
You _could_ request extended regular expressions, which do work on
those platforms, as well as with GNU sed:

    sed -nEe "/^(author|summary) /p" ...

>         test_cmp actual expected
>  '
>
> @@ -52,8 +52,8 @@ EOF
>  test_expect_success !MINGW \
>         'blame respects i18n.logoutputencoding' '
>         git config i18n.logoutputencoding eucJP &&
> -       git blame --incremental file | \
> -               egrep "^(author|summary) " > actual &&
> +       git blame --incremental file >output &&
> +       sed -ne "/^\(author\|summary\) /p" output >actual &&
>         test_cmp actual expected
>  '
>
> @@ -68,8 +68,8 @@ EOF
>
>  test_expect_success !MINGW \
>         'blame respects --encoding=UTF-8' '
> -       git blame --incremental --encoding=UTF-8 file | \
> -               egrep "^(author|summary) " > actual &&
> +       git blame --incremental --encoding=UTF-8 file >output &&
> +       sed -ne "/^\(author\|summary\) /p" output >actual &&
>         test_cmp actual expected
>  '
>
> @@ -84,8 +84,8 @@ EOF
>
>  test_expect_success !MINGW \
>         'blame respects --encoding=none' '
> -       git blame --incremental --encoding=none file | \
> -               egrep "^(author|summary) " > actual &&
> +       git blame --incremental --encoding=none file >output &&
> +       sed -ne "/^\(author\|summary\) /p" output >actual &&
>         test_cmp actual expected
>  '
