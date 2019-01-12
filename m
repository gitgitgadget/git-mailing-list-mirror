Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6A7211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 20:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfALUQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 15:16:19 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39810 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfALUQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 15:16:19 -0500
Received: by mail-oi1-f180.google.com with SMTP id i6so14984263oia.6
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cPnyLAVu5htPGANS+mYW+4fx5ESApWh9jINbuCkPYKw=;
        b=Tg0M8jGr2lQqjYg7tHp42CXnNv1xUnxJZ5AeV1+0p9mJJe4msjTgIoPTl7g/brrm7s
         ALu1uGoH9fIdJQ4+Wdt/jCNj9f6cZyn4rTErwO0lERbGWoGiZjLZQ0suKnbGYyjASP6u
         2hu6BMFPi4OWx3q6hUC1qYe/y5994F6H/BucinSHPY/P/O3pgO/2uj66V+wwihKrbMjw
         lCON4jlU6jLUUZy3SVKgORz+UxpopoydVpPEoVVrDoL43lVT15J3uBWZVBbChvWt41Mo
         xrIUpBfBFP9RiwJaYmKV3diMpyrsEFQl9QfIQy1RckIBIX7e6qneD7DwdvM1tPrg6i4G
         ZboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cPnyLAVu5htPGANS+mYW+4fx5ESApWh9jINbuCkPYKw=;
        b=bCeYnKgoYOi0g92FbOWOUfxrtPqkUT8z/4L8svnzH/Tx7U7mx43Zz77UgvZ3yZ73hH
         TKIzSNsmqCFKKvwBS0sGcSeIvt6njEXTEfy3R5PgGKxLDglr9SSggeHmCZsi/gBCj0me
         MHbLS5poGLhtJMw1SXgEJteQL/qTIOa4sJcJH4TA3SboPFGoEI6YQFGpYQQLa79UILa4
         PaKgSURPZQWndQ7PUVDeQQRAqBx1SODsVqQDNJIl2RM+2Pag7mLyY/O/WosNckzU4DSd
         hOc0eMUxcok1dRrD3TMFROEMnN8uK8/EJlD4cnRkBMMnJou8Tsicnd6K9REUph91Glpx
         s8OA==
X-Gm-Message-State: AJcUukdgI7YWUSyLVFQ7pp+a6AwB/qRFSHKcnNOHzmLndhPJ5dGsSAKK
        /GpYhwS//LC0kzU61A8o6OyyOmMu0qglWK6p4S555b9Y
X-Google-Smtp-Source: ALg8bN4TI9BggQ3m/qrJgqDS1b7hdzoJ6zo+A8QiuerLckTu2Q7/cJK8e8M9IOyKt1XiXl4IZrIg41ZEgKIE1FYGUJk=
X-Received: by 2002:aca:bc42:: with SMTP id m63mr11735505oif.323.1547324178143;
 Sat, 12 Jan 2019 12:16:18 -0800 (PST)
MIME-Version: 1.0
From:   Maris Razvan <razvan.alex.maris@gmail.com>
Date:   Sat, 12 Jan 2019 22:16:07 +0200
Message-ID: <CALZbgSQti+t2dA4nm+DCDGxQjsvNJy3UDdqAya16v+Mv5O4Xdw@mail.gmail.com>
Subject: Gitignore documentation
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I was reading the gitignore documentation
(https://git-scm.com/docs/gitignore), especially the following
paragraph:

         "If the pattern does not contain a slash /, Git treats it as
a shell glob pattern and checks for a match against the pathname
relative to the location of the .gitignore file (relative to the
toplevel of the work tree if not from a .gitignore file)."

From that paragraph I understand that if I have the following
directory structure:

        .gitignore
        a
            f

(the root of the repository contains the file .gitignore and the
folder a, while the file f is inside folder a)
where the file .gitignore contains only the pattern f, when file "f"
is tested whether it should be ignored or not, the pattern f in
.gitignore is matched against the "pathname relative to the location
of the .gitignore file" (which is a/f). Because "f" (the pattern) does
not match "a/f" (the pathname relative to the location of .gitignore),
the file "f" should not be ignored. However, if I test this scenario,
git ignores the file (this behaviour is consistent with the examples
from the rest of the documentation and other explanations on the
internet).

I looked at the history of the "Documentation/gitignore.txt" file on
the github repository and I saw that initially the paragraph looked
like this:

        "If the pattern does not contain a slash '/', git treats it as
a shell glob pattern and checks for a match against the pathname
without leading directories."

This old version of the paragraph is consistent with git's current behaviour.

Then I saw the following commit
https://github.com/git/git/commit/81c13fde379c46cad6b6e4a03ed7ee4f686c030f#diff-7fea460d44f92f185e7add8aa5620305,
which changed that paragraph to the current version.
However, I cannot see how the two wordings (the original one and the
current one) are the same.

I would really appreciate if someone could explain how to read the
current version of the paragraph such that it is consistent with git's
behaviour.



Thank you,
Razvan Maris
