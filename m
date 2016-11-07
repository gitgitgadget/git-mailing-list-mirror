Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFB82022A
	for <e@80x24.org>; Mon,  7 Nov 2016 23:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbcKGXvw (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 18:51:52 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35163 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbcKGXvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 18:51:52 -0500
Received: by mail-qt0-f169.google.com with SMTP id c47so97823524qtc.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 15:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=31zizIFu8VvJHMmIajct8fy2etkDIk7KI+asYaNrOzs=;
        b=gRgtybujt1eBPtW/ZL6nFxhZ60S5NGiGx1ezWU90PqCXoihsjl1MKCGZVHx0sjQpG/
         q3/j6H6uzI4TyFZ4ftogS70s+kVSkaHyhjmagfenXCmHpOWsqwJTVhoRr6VcCBarH/Ei
         /un35o53ExtTTLvNcqz6nPqSwnfJn/3AqTlMkgmkIEvzkSkPQFQnMZEPkuJ3Xme5Ppwl
         T96PS3ODs8M4maG2hFOM+p49GqBZrI3uQBr+9sWsRb0wX4W+HrBaRiEfIB6Nn4nN7Dkm
         pkGWlYJ+7Ziw4nRU+xjnenOipDo8B/WLt4kF/LL51rTlNvDieGK61MML+j0hz3WRkGsy
         YlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=31zizIFu8VvJHMmIajct8fy2etkDIk7KI+asYaNrOzs=;
        b=KEsrMkPPMUlN5CBUxasRhvd994eQgkOJhpB17v45d5o7m0f0/R/WdgthS7kt2eBYIp
         ZPJ9qfzSN8oruL3h+ibuXtQFBDcJlJwfTdJLurado0TFkKDqYQPvtZSrX2Rs7C+zANNk
         v5OWHHL5pl/KF2xhf0y5ajUUjU4B9KBPGWdXBeYCutHJSwOH77tLZQeIzvELsj8hABmi
         pJNWXqAX29YPJU+NA1aw74zvbyLLxNTwPBVYRJ0MwR1rWehFJ0/kv0LZlISB/1ycneW4
         yO3UhCq+COX/x0xiH5T/THyD4g73AvMXIY5adZ2Qg4sgkI3WLmD9pMc4iOxjjYza2JTB
         XgTQ==
X-Gm-Message-State: ABUngvdr7SLFvVmY6A2rXNPd8+BnDg77s/oBcs35xpGqNm52r6vU811a52Ls5KwzrYxT87Il/tvkbdNi0dkyqoZM
X-Received: by 10.200.54.244 with SMTP id b49mr9695107qtc.93.1478562156287;
 Mon, 07 Nov 2016 15:42:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.34.175 with HTTP; Mon, 7 Nov 2016 15:42:35 -0800 (PST)
In-Reply-To: <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 7 Nov 2016 15:42:35 -0800
Message-ID: <CAGyf7-HWAMF8S+Bw3wcwJCS1Subc28KHjpSCc1__0qn-GSMyvA@mail.gmail.com>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> When we add a new alternate to the list, we try to normalize
> out any redundant "..", etc. However, we do not look at the
> return value of normalize_path_copy(), and will happily
> continue with a path that could not be normalized. Worse,
> the normalizing process is done in-place, so we are left
> with whatever half-finished working state the normalizing
> function was in.
>

<snip>

> @@ -335,7 +340,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>         }
>
>         strbuf_add_absolute_path(&objdirbuf, get_object_directory());
> -       normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
> +       if (strbuf_normalize_path(&objdirbuf) < 0)
> +               die("unable to normalize object directory: %s",
> +                   objdirbuf.buf);

This appears to break the ability to use a relative alternate via an
environment variable, since normalize_path_copy_len is explicitly
documented "Returns failure (non-zero) if a ".." component appears as
first path"

For example, when trying to run a rev-list over commits in two
repositories using GIT_ALTERNATE_OBJECT_DIRECTORIES, in 2.10.x and
prior the following command works. I know the alternate worked
previously because I'm passing a commit that does not exist in the
repository I'm running the command in; it only exists in a repository
linked by alternate, as shown by the "fatal: bad object" when the
alternates are rejected.

Before, using Git 2.7.4 (but I've verified this behavior through to
and including 2.10.2):

bturner@elysoun /tmp/1478561282706-0/shared/data/repositories/3 $
GIT_ALTERNATE_OBJECT_DIRECTORIES=../0/objects:../1/objects git
rev-list --format="%H" 2d8897c9ac29ce42c3442cf80ac977057045e7f6
74de5497dfca9731e455d60552f9a8906e5dc1ac
^6053a1eaa1c009dd11092d09a72f3c41af1b59ad
^017caf31eca7c46eb3d1800fcac431cfa7147a01 --
commit 74de5497dfca9731e455d60552f9a8906e5dc1ac
74de5497dfca9731e455d60552f9a8906e5dc1ac
commit 3528cf690cb37f6adb85b7bd40cc7a6118d4b598
3528cf690cb37f6adb85b7bd40cc7a6118d4b598
commit 2d8897c9ac29ce42c3442cf80ac977057045e7f6
2d8897c9ac29ce42c3442cf80ac977057045e7f6
commit 9c05f43f859375e392d90d23a13717c16d0fdcda
9c05f43f859375e392d90d23a13717c16d0fdcda

Now, using Git 2.11.0-rc0

bturner@elysoun /tmp/1478561282706-0/shared/data/repositories/3 $
GIT_ALTERNATE_OBJECT_DIRECTORIES=../0/objects:../1/objects
/opt/git/2.11.0-rc0/bin/git rev-list --format="%H"
2d8897c9ac29ce42c3442cf80ac977057045e7f6
74de5497dfca9731e455d60552f9a8906e5dc1ac
^6053a1eaa1c009dd11092d09a72f3c41af1b59ad
^017caf31eca7c46eb3d1800fcac431cfa7147a01 --
error: unable to normalize alternate object path: ../0/objects
error: unable to normalize alternate object path: ../1/objects
fatal: bad object 74de5497dfca9731e455d60552f9a8906e5dc1ac

Other commits, like [1], suggest the ability to use relative paths in
alternates is something still actively developed and enhanced. Is it
intentional that this breaks the ability to use relative alternates?
If this is to be the "new normal", is there any other option when
using environment variables besides using absolute paths?

Best regards,
Bryan Turner

[1]: https://github.com/git/git/commit/087b6d584062f5b704356286d6445bcc84d686fb
-- Also newly tagged in 2.11.0-rc0
