From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t1500-rev-parse: rewrite each test to run in isolation
Date: Wed, 13 Apr 2016 00:54:16 -0400
Message-ID: <CAPig+cT8oD1jJdDrk+YPoquGfTh6m3m-ha0J+er42jOoxnVxzg@mail.gmail.com>
References: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
	<1460200767-32864-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 06:54:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqCop-0007OD-BD
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 06:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbcDMEyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 00:54:18 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36622 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824AbcDMEyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 00:54:17 -0400
Received: by mail-ig0-f196.google.com with SMTP id kb1so5087297igb.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hRlOz2Iv4Fc/mXJtO6NLXXELU/v5+ErIuDiVHf1GhD4=;
        b=nkjGpn6t3wq8AoKbw1qsU2a0NSp8YNXke8y01sDF1Gvc/cyEJVas5gGzNukApNPmeW
         04gdFkeUbquF4Pl9I+ajLOmtnMxOnfacCNb4QATOYejBUrtBWT4PUpsPN1XT9PeM8x8w
         JJ6OLxsD6fJ0KFGGQPexAebUGHHqpGOMID3L0FKdtaZ+D6+9CPVTDhDobSQZe1mFhwGe
         T5cWyFQ5HoCPnIQ4kgehDTI03SXcjJ8ahLte2b4vg2MwZr/huSTtIz0puElyBnGFEIVI
         7n6J2c+QFXPEBsVFCyKNJMK/+/bRe+ZSlS0CA6Efz0x2W76twema/a+63XY3PbYiuW6I
         uVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hRlOz2Iv4Fc/mXJtO6NLXXELU/v5+ErIuDiVHf1GhD4=;
        b=kwxi2WnVWaIgPYkXRxgCycIp1ImGL+QHyDY+8N4xRJuxwS4n7r/a5d2Mc7n82N+nX9
         DZdeZGSxnSRT/d9t3vXYefm2i22iAbDJ/YTsxfnb3srWWxpGe+mNGyIGZ2aWHpCdBSmi
         sEcwqJwH8aLO19ch/su0iYP58qISrlDzSIIWPXxF/nKVvXN6Ck6sF1C7rKImYYLvxyZB
         t95v0p+Zccg72DQdTl6e6nCLOHG0HxXPrhxBtwlbU33d1UvZBcB1UHC3J+r1V6XwZJf8
         S4sK+Su7ALV3AhWVNqGbjsR4HWFB9C4zhzk37AYplGFTfMtj3Z+D5qnPnh7qx+GWoOl0
         re/w==
X-Gm-Message-State: AOPr4FWsM2YR0xahy8AXcQF2+YMwYxCTgMXKemYZ6cAyJqbFV/0sHm8YOS8uZNXGv1Zapwmv+ShnV4qenT79rQ==
X-Received: by 10.50.40.101 with SMTP id w5mr8065608igk.17.1460523256980; Tue,
 12 Apr 2016 21:54:16 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Tue, 12 Apr 2016 21:54:16 -0700 (PDT)
In-Reply-To: <1460200767-32864-2-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: oPIQrkzvGT102Wx1jjXCq9ZB24E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291368>

On Sat, Apr 9, 2016 at 7:19 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> t1500-rev-parse has many tests which change directories and leak
> environment variables.  This makes it difficult to add new tests without
> minding the environment variables and current directory.
>
> Each test is now setup, executed, and cleaned up without leaving anything
> behind.  Tests which have textual expectations have been converted to use
> test_cmp (which will show a diff when the test is run with --verbose).

It might be easier to review this if broken into several cleanup and
modernization patches, however, some comments below...

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> @@ -3,88 +3,571 @@
> +test_expect_success '.git/: is-bare-repository' '
> +       (cd .git && test false = "$(git rev-parse --is-bare-repository)")
> +'
>
> -# label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
> +test_expect_success '.git/: is-inside-git-dir' '
> +       (cd .git && test true = "$(git rev-parse --is-inside-git-dir)")

Simpler:

    test true = "$(git -C .git rev-parse --is-inside-git-dir)"

> +'
>
> -ROOT=$(pwd)
> +test_expect_success '.git/: is-inside-work-tree' '
> +       (cd .git && test false = "$(git rev-parse --is-inside-work-tree)")

Ditto.

> +'
>
> -test_rev_parse toplevel false false true '' .git "$ROOT/.git"
> +test_expect_success '.git/: prefix' '
> +       (
> +               cd .git &&
> +               echo >expected &&
> +               git rev-parse --show-prefix >actual &&
> +               test_cmp expected actual
> +       )

Likewise, you could drop the entire subshell:

    echo >expected &&
    git -C .git rev-parse --show-prefix >actual &&
    test_cmp expected actual

> +'
>
> +test_expect_success '.git/: git-dir' '
> +       (
> +               cd .git &&
> +               echo . >expected &&
> +               git rev-parse --git-dir >actual &&
> +               test_cmp expected actual
> +       )

Same here and for many subsequent tests (which I won't quote).

> +'
> +test_expect_success 'core.bare = true: is-bare-repository' '
> +       git config core.bare true &&
> +       test_when_finished "git config core.bare false" &&
> +       test true = "$(git rev-parse --is-bare-repository)"

Simpler:

    test_config core.bare true

and then you can drop 'test_when_finished' altogether. However, even simpler:

    test true = "$(git -c core.bare=false rev-parse --is-bare-repository)"

which allows you to drop 'test_config', as well.

Ditto for subsequent tests (which I won't quote).

> +'
> +test_expect_success 'core.bare undefined: is-bare-repository' '
> +       git config --unset core.bare &&

    test_unconfig core.bare

> +       test_when_finished "git config core.bare false" &&

Why does this need to re-instate core.bare?

Same comments for subsequent tests.

> +       test false = "$(git rev-parse --is-bare-repository)"
> +'
> +test_expect_success 'GIT_DIR=../.git, core.bare = false: is-bare-repository' '
> +       mkdir work &&
> +       test_when_finished "rm -rf work && git config core.bare false" &&
> +       (
> +               cd work &&
> +               export GIT_DIR=../.git &&
> +               export GIT_CONFIG="$(pwd)"/../.git/config
> +               git config core.bare false &&
> +               test false = "$(git rev-parse --is-bare-repository)"
> +       )
> +'

Same comments about -C to avoid the subshell and -c for configuration.

Also, you can do one-shot environment variable setting for the command
invocation, so the subshell goes away, and everything inside the
subshell collapses to:

    test false = "$(GIT_DIR=... GIT_CONFIG=...
        git -C work -c core.bare=false rev-parse ...)"

Additionally, I'm confused about why this test "reverts" the
core.bare=false by setting core.bare=false in 'test_when_finished'.

Ditto for subsequent tests.

> +test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-bare-repository' '
> +       mkdir work &&
> +       cp -r .git repo.git &&
> +       test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&

If 'cp' fails, then 'test_when_finished' will never be invoked, which
means that the cleanup will never happen; thus 'test_when_finished'
needs to be called earlier. Ditto for subsequent tests.

> +       (
> +               cd work &&
> +               export GIT_DIR=../repo.git &&
> +               export GIT_CONFIG="$(pwd)"/../repo.git/config
> +               git config core.bare false &&
> +               test false = "$(git rev-parse --is-bare-repository)"
> +       )
> +'

Closing comments:

By using -C, -c, and one-shot environment variables, you can ditch the
subshells, and most of these tests should collapse to one or two
lines.

There seems to be a lot of repetition here. To reduce the repetition,
have you considered encoding the state which varies between tests into
a table and making the tests table-driven. Or, by encoding the varying
state in some nested for-loops? The nice thing about driving the tests
from a table or for-loops is that it is easier to see at a glance if
all cases are covered.
