Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D420E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 14:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeEUO7D (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:59:03 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:36810 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeEUO7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:59:02 -0400
Received: by mail-ot0-f173.google.com with SMTP id m11-v6so17183373otf.3
        for <git@vger.kernel.org>; Mon, 21 May 2018 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bn4OL//hhh590I6LkMqgQV8ZbD7dyV4FY3o0hW8KBzw=;
        b=Y+V4A3rlxQgF+/95dsZaXRAiDxFeIW4+4Bu9zfImq2dhDD+/shzJvNxg0XS0ykEvw8
         D4z72weowtpzf5aS0ZWwVpvpaOQWoq6ToY4jejCCHk1wajD03NTf4YtOjuvL3HRKFZxQ
         Lwjtu9VBi9m2BxYj1BEaOpXyE8iysP4ZtVSN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bn4OL//hhh590I6LkMqgQV8ZbD7dyV4FY3o0hW8KBzw=;
        b=Jyqv5a+jTb4p4yWVVqRofhFs0kvCzDHrsTyjSdAcU3QxMJsmK7I8dYKNkLFPjh6JRW
         GXLKE76Mj3V3pNKjDFY61ifiDyk240D5k4E7ApnhqQ2GY7qvuhLPZWan7F0QIBimw7s4
         qrJ5Kv920VQQRk3fqbTAIXkKL8J/+M+VhPtT1f1Hj3TTfXis1WIbFu5INsOV8kU1lQq0
         J6Sm9I7CEuXwD3JHgdQwJCOEEzOzIgh0w+mXornhr0D+izn+BFi9AB3DofLxS+k2fsME
         RYr9RxwWMqVmif09eXirf9QjO4GcmpuzovLa6CRujWWuJ8lXuOXroEuHr7OUwpdSS0Lr
         K26w==
X-Gm-Message-State: ALKqPwf364DU0JNfeJqnDwKxgRpYvKP1G+0UflS6IbWt+0qo3piZlZfS
        OGb3/kLzp4G3n6EFMzhdz+QzGezKBSz/4tp1zFom0w==
X-Google-Smtp-Source: AB8JxZrx0FNQxFamOUo/l3v00RwwrqYI13k20P8ETjreOof0KNLj+HuRFGPeMlsJ0DdgPgF38E4G3Lkn07+CXGiVRsQ=
X-Received: by 2002:a9d:3f90:: with SMTP id r16-v6mr307241otc.289.1526914741819;
 Mon, 21 May 2018 07:59:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Mon, 21 May 2018 07:59:01
 -0700 (PDT)
In-Reply-To: <xmqqd0xp1o85.fsf@gitster-ct.c.googlers.com>
References: <20180520144916.5064-1-szeder.dev@gmail.com> <xmqqd0xp1o85.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 21 May 2018 15:59:01 +0100
Message-ID: <CAE5ih7-yW89W7zrZkGBAhEY3=WgK_CdJQYucP4URpqk43DqOKA@mail.gmail.com>
Subject: Re: [PATCHv4 1/1] git-p4: add unshelve command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 May 2018 at 08:07, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
>>> new file mode 100755
>>> index 0000000000..cca2dec536
>
> ... in short, I'd queue a fix-up on top like this to be later
> squashed after getting an ack?

That looks good to me, thanks! Ack.

Luke

>
>  t/t9832-unshelve.sh | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> index cca2dec536..3513abd21a 100755
> --- a/t/t9832-unshelve.sh
> +++ b/t/t9832-unshelve.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -last_shelved_change() {
> +last_shelved_change () {
>         p4 changes -s shelved -m1 | cut -d " " -f 2
>  }
>
> @@ -17,7 +17,7 @@ test_expect_success 'init depot' '
>                 cd "$cli" &&
>                 echo file1 >file1 &&
>                 p4 add file1 &&
> -               p4 submit -d "change 1"
> +               p4 submit -d "change 1" &&
>                 : >file_to_delete &&
>                 p4 add file_to_delete &&
>                 p4 submit -d "file to delete"
> @@ -120,29 +120,14 @@ EOF
>         )
>  '
>
> -diff_adds_line() {
> -       text=3D"$1" &&
> -       file=3D"$2" &&
> -       grep -q "^+$text" $file || (echo "expected \"text\" $text not fou=
nd in $file" && exit 1)
> -}
> -
> -diff_excludes_line() {
> -       text=3D"$1" &&
> -       file=3D"$2" &&
> -       if grep -q "^+$text" $file; then
> -               echo "unexpected text \"$text\" found in $file" &&
> -               exit 1
> -       fi
> -}
> -
>  # Now try to unshelve it. git-p4 should refuse to do so.
>  test_expect_success 'try to unshelve the change' '
>         test_when_finished cleanup_git &&
>         (
>                 change=3D$(last_shelved_change) &&
>                 cd "$git" &&
> -               ! git p4 unshelve $change >out.txt 2>&1 &&
> -               grep -q "cannot unshelve" out.txt
> +               test_must_fail git p4 unshelve $change 2>err.txt &&
> +               grep -q "cannot unshelve" err.txt
>         )
>  '
>
