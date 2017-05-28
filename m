Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35E71FD09
	for <e@80x24.org>; Sun, 28 May 2017 17:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdE1Rpj (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 13:45:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35917 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdE1Rpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 13:45:38 -0400
Received: by mail-it0-f65.google.com with SMTP id i206so5524560ita.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7WzrzUKu3sWmTvO8FDR22irvrhojShRF0/JBOP22cSk=;
        b=qESS8sKAJSNl43bP7DQdtl3mTHxNB37IwMi9I8VJ/h//MYi+4Lo7Q+MKTjl8kMYMJz
         AW1NzQSkq/z9SQOWBkWz8vTykpkGOLspSHnkRkpErABhWXu14fOlFz3A61pndXR4scsE
         IScCJl0+4uwEOw0StScrnXk9HSSouxDT/9k9JoPXzaBsyfsKVMHIlTYB7foMPqJbBxxv
         A7hsBustwTU9TCqiHiMobU+PeT/C2GdBC6ACK6lbyyK2oQXmC9bJzL8e67G2EBZQChLu
         1OT9WhbfrXgqV1K0viZf5cU8CF7Y3xF2LlTJfF9QnTgaxwkkgTTdRwOnu8kUOUf2YjbY
         4dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7WzrzUKu3sWmTvO8FDR22irvrhojShRF0/JBOP22cSk=;
        b=aGx+S/bbtp3H0RVvsNXQZf9udxvPvrRXTSh52o0cwbDesah/qfnXgF+AP34Ipo93CW
         7/VE0lSkfzPYsbrw4KsLqXCfimtXcAJ7S9wJ1JDMTserksriKUt93CBP+TNFtFP1kOsN
         nCqiCLoIEyidVHMwxT1gVBLjIZLgVVkoY/d4lEt8GQ8zCr7hZqxzXMae2ZpLRYDVd0de
         YLwTjfPQsvzsUm3UYPGLfrarRrMl+Q6BKqPgF60oxSIliEt7E/XnbXo7HzNf6+uRYlJA
         O7qvkxH2DRM0QA3aOwu6xNh8eXg01X9i8mWsjRVB4vOks6lm7Z9sZkVW0+26TiywkVPO
         0IFg==
X-Gm-Message-State: AODbwcD9Tr+NS+fZOKi/sm9zLDI3jietAKatM1VqQIf0wTYkU2SRb2K6
        h5Ylzf8cvJPAFFhp6Zyq5ysAKYZsNA==
X-Received: by 10.36.138.131 with SMTP id v125mr27111020itd.66.1495993537394;
 Sun, 28 May 2017 10:45:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 10:45:16 -0700 (PDT)
In-Reply-To: <20170528165642.14699-2-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-2-joel@teichroeb.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 19:45:16 +0200
Message-ID: <CACBZZX7vsz9fRg6bggMETqfcK_WWFijQ1+YbLcfFauqa1s1KpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] stash: add test for stash create with no files
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Ensure the command gives the correct return code
>
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 3b4bed5c9a..aaae221304 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -444,6 +444,14 @@ test_expect_failure 'stash file to directory' '
>         test foo = "$(cat file/file)"
>  '
>
> +test_expect_success 'stash create - no changes' '
> +       git stash clear &&
> +       test_when_finished "git reset --hard HEAD" &&
> +       git reset --hard &&
> +       git stash create > actual &&
> +       test $(cat actual | wc -l) -eq 0

Looks fine like this, I don't think there's any actual portability
concern (as with some wrappers), but FWIW you can do this more briefly
with the test framework as:

    test_line_count = 0 actual

Although I wonder in this case whether you don't actually mean:

    [...]>actual &&
    ! test -s actual

I.e. isn't the test that there should be no output, not that there
shouldn't be a \n there? Or alternatively:

     test $(cat actual | wc -c) -eq 0

> +'
> +
>  test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
>         git stash clear &&
>         test_when_finished "git reset --hard HEAD" &&
> --
> 2.13.0
>
