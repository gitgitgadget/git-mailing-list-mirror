Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4E71F404
	for <e@80x24.org>; Tue, 13 Feb 2018 00:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeBMA2L (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 19:28:11 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:36760 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeBMA2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 19:28:10 -0500
Received: by mail-pl0-f53.google.com with SMTP id v3so5799757plg.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q17PJ6h2zwmnYcCV++1ui4XVArVO6zELaE9urD+GXu0=;
        b=GafIY0WL5CUwHqExM0x4Y80kcMjVqbLXcEqKKdt7KVPkj9pMXw+69f2lhTJL+CcGao
         gKDa/G1fSlfYaE20yqtKgmkoCVRutao2kO4XqY648UVkexbSdLGHzOSxokDMFhg5OEhj
         unQBp8MG9TABX5Ng838N5gt07Efp7Pmd0PPpUinNZ6uipOJMrVj5ehqDF/GiUD+RrLM/
         +O4Zkfc+7VB6yWQ2cYqCuJLW1IrMovnPlxSJ8EKCEZ7ANjKI56us2CeSttpnGxz3vUKH
         4ezdz886v5ilIL5pxMm6yxOtlBiFV5gyo+/05lhCO+qqDqQHK2cgn4t3KDfQXsIIlUNV
         biQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q17PJ6h2zwmnYcCV++1ui4XVArVO6zELaE9urD+GXu0=;
        b=uE+zVupfTBptgSUJjc/ArVgyEfE67cUlNiPT1CTCxyJeB8eKcAfa2oCq41VlDIfqr0
         h8asiESABtTbo+3RF8mAtgYfwk3PQdT1/FQzyortfb0+4/SdZXJ7e6gXWoge6mYfsBfD
         ebVYh59R2X01utzKMMB5BubBJPw9Vy5vuBWFq6t5bUgv4CtSb9cw2bGNl9MmOtx6SfRK
         qlIsGF6hT5VYXLpiWz/zEpdJuy4ew6gKUSGAiBbEu9MrwopDxyDOpQu9EFzkvAJTOOgM
         6eeCNvVWzQxlM7Ni2WNl1Lxo9jpEUWihEX2uwFoyLitIxMJzvALjpBq5HONWCA2Ygj+D
         LOpA==
X-Gm-Message-State: APf1xPBFufi6eCLxft9Dc9AEllwBJfPCfW5NIQkMmnhwr1qNsm/EQRNt
        TzbSUigkRtLQ8TwcSZBXAPQ=
X-Google-Smtp-Source: AH8x224yUjh7VWwOT0bhvXHdOHqbSeIHAdDe6DM6WP2yVLJLvoHHn9qEajqz9/CnYAoFmrfkZ9bRLg==
X-Received: by 2002:a17:902:820c:: with SMTP id x12-v6mr12531893pln.103.1518481689521;
        Mon, 12 Feb 2018 16:28:09 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id m4sm16279254pfh.150.2018.02.12.16.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 16:28:08 -0800 (PST)
Date:   Tue, 13 Feb 2018 07:27:58 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
Message-ID: <20180213002758.GA9274@duynguyen.dek-tpc.internal>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
 <20180206021313.GA26323@sigill.intra.peff.net>
 <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
 <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
 <CAN0heSpxcm1a9KN3etWAD5Vc_gkabQmEppa_1P4soZSZOnP8pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpxcm1a9KN3etWAD5Vc_gkabQmEppa_1P4soZSZOnP8pg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 11:15:06PM +0100, Martin Ågren wrote:
> On 12 February 2018 at 10:56, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Wed, Feb 7, 2018 at 3:05 AM, Martin Ågren <martin.agren@gmail.com> wrote:
> >> On 6 February 2018 at 03:13, Jeff King <peff@peff.net> wrote:
> >>> On Mon, Feb 05, 2018 at 08:28:10PM +0700, Duy Nguyen wrote:
> >>>> I learned SANITIZE=leak today! It not only catches this but also "dst".
> >>>>
> >>>> Jeff is there any ongoing effort to make the test suite pass with
> >>>> SANITIZE=leak? My t2038 passed, so I went ahead with the full test
> >>>> suite and saw so many failures. I did see in your original mails that
> >>>> you focused on t0000 and t0001 only..
> >>>
> >>> Yeah, I did those two scripts to try to prove to myself that the
> >>> approach was good. But I haven't really pushed it any further.
> >>>
> >>> Martin Ågren (cc'd) did some follow-up work, but I think we still have a
> >>> long way to go.
> >>
> >> Agreed. :-)
> >
> > Should we mark the test files that pass SANITIZE=leak and run as a sub
> > testsuite? This way we can start growing it until it covers everything
> > (unlikely) and make sure people don't break what's already passed.
> >
> > Of course I don't expect everybody to run this new make target with
> > SANITIZE=leak. Travis can do that for us and hopefully have some way
> > to tell git@vger about new breakages.
> 
> Makes sense to try to make sure that we don't regress leak-free tests. I
> don't know what our Travis-budget looks like, but I would volunteer to
> run something like this periodically using my own cycles.
> 
> My experience with the innards of our Makefiles and test-lib.sh is
> non-existant, but from a very cursory look it seems like something as
> simple as loading GIT_SKIP_TESTS from a blacklist-file might do the
> trick.

Yeah my first throught was something along that line too. But maybe
it's nicer to mark a test file leak-free like this:

-- 8< --
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 459f676683..1446f075b7 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -2,6 +2,8 @@
 
 test_description='test git worktree move, remove, lock and unlock'
 
+test_leak_free=yes
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 8< --

And we can run these test files with a new option --leak-check (or
something like that, we already support a similar option --valgrind).

Most of the work will be in test-lib.sh. If we detect --leak-check and
test_leak_free is not set, we skip the whole file. In the far far far
future when all files have test_leak_free=yes, we can flip the default
and delete these lines.

It would be nice if test-lib.sh can determine if 'git' binary is built
with SANITIZE=yes, but I think we can live without it.

> I could try to look into it in the next couple of days.

Have fun :) Let me know if you give up though, I'll give it a shot.
--
Duy
