Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6101F597
	for <e@80x24.org>; Wed, 25 Jul 2018 08:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeGYJsX (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 05:48:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39845 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYJsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 05:48:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so6841215qtp.6
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4SqKv6RhEOJKQKrUNL+Ie+U1NUa6MjW13pvWxGzzhX4=;
        b=IixU8gbECn2iG6vaDUHKo5RIzOqboXQCkYmYCiMf1sAAs/3FmwiFs8AcRlroe5mwMH
         h3eUzyeufdt7RngbJ35hiO2WBStB08/AshkmNN6d2odEzLJMAfcDYUmboBS58XzET4Zt
         wOgBDdGBlhyANbtTaRXyDXPGpSW+bTKc+k7eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4SqKv6RhEOJKQKrUNL+Ie+U1NUa6MjW13pvWxGzzhX4=;
        b=Vcom1kr9HGL24mzzE7ym42Ug9MQ1DdZIVKR0ftldMWIa8zY4xXG8dF2+YPJ5BMehiS
         cgzL6vlMaw8bwKkrLfQnGx6dYe2fZAlJRqf2IyxEmG2wVnaotJZdBsjMGtbWLQdU00YG
         +P3esDvqh8b+8CG31iu3JHX7W7/E1YyPxPjvzXXfSvdA8jXafAxlfZR18iHrXDtjTZHN
         ii8CiOlqJBkV18x5h72DyYr4cFlsoRQ755vdszHbiesYvOTMLkGLIPTuC6Q1Q7PRB3IR
         EIaN0pEmDlOJDWmPERziPYcnpKzi9K78kgjOJj+E/rfEQz2rfVMwT3T9BYMAa3W/H0Wg
         UQCg==
X-Gm-Message-State: AOUpUlG5IuMGJUQLtU/KgnKa60L2aY4eW7G0jzd5iuo8D/GDTYcLxNOv
        oKlDdvqThpLP2Rd9Xz90qK9sB42giMN7xbT/jG8e2Q==
X-Google-Smtp-Source: AAOMgpdxdebmKloCW2OR7tczQqmwiknBjghWKpYXXMASeUHetyl2oQ0Pd4daKRUgZxXGe/UFOEb39V/Wmg5FK8hMB0o=
X-Received: by 2002:a0c:8af5:: with SMTP id 50-v6mr18246035qvw.219.1532507864261;
 Wed, 25 Jul 2018 01:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3763:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 01:37:43
 -0700 (PDT)
In-Reply-To: <20180723112736.15088-1-chenbin.sh@gmail.com>
References: <20180723112736.15088-1-chenbin.sh@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 25 Jul 2018 09:37:43 +0100
Message-ID: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     Chen Bin <chenbin.sh@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 July 2018 at 12:27, Chen Bin <chenbin.sh@gmail.com> wrote:
> Hook pre-p4-submit is executed before git-p4 actually submits code.
> If the hook exits with non-zero value, submit process will abort.


Looks good to me - could you add some documentation please
(Documentation/git-p4.txt).

Thanks!
Luke


>
> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
> ---
>  git-p4.py               |  6 ++++++
>  t/t9800-git-p4-basic.sh | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index b449db1cc..69ee9ce41 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2303,6 +2303,12 @@ def run(self, args):
>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>                       (len(commits), num_shelves))
>
> +        # locate hook at `.git/hooks/pre-p4-submit`
> +        hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "pre-p4-submit")
> +        # Execute hook. If it exit with non-zero value, do NOT continue.
> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
> +            sys.exit(1)
> +
>          #
>          # Apply the commits, one at a time.  On failure, ask if should
>          # continue to try the rest of the patches, or quit.
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 4849edc4e..48b768fa7 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>         )
>  '
>
> +# Test following scenarios:
> +#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
> +#   - With hook returning 0, submit should continue
> +#   - With hook returning 1, submit should abort
> +test_expect_success 'run hook pre-p4-submit before submit' '
> +       test_when_finished cleanup_git &&
> +       git p4 clone --dest="$git" //depot &&
> +       (
> +               cd "$git" &&
> +               echo "hello world" >hello.txt &&
> +               git add hello.txt &&
> +               git commit -m "add hello.txt" &&
> +               git config git-p4.skipSubmitEdit true &&
> +               git p4 submit --dry-run | grep "Would apply" &&
> +               mkdir -p .git/hooks &&
> +               : >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-p4-submit &&
> +               git p4 submit --dry-run | grep "Would apply" &&
> +               echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit &&
> +               git p4 submit --dry-run | grep "Would apply" || echo "Abort submit"
> +       )
> +'
> +
>  test_expect_success 'submit from detached head' '
>         test_when_finished cleanup_git &&
>         git p4 clone --dest="$git" //depot &&
> --
> 2.18.0
>
