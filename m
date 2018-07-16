Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C1F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPXfR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36967 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:17 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so23967447itc.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ie3FuFSeGnQzxp/gG6RvU/39LViknC8R4Q5i5KJEG/8=;
        b=JvuQbufTCqaaMV6zclaDEBQjrH+Nah0FXdTWhJU34kSbNwMgSv8mMJ/SlWkzALWrem
         yHxf4rUrj5aBpfREt7OBdrMTTG5uQYWbyM0D5GbcLKE4jUINGnK/YuKk/i/MZjek+zeK
         FWXXUl9XqrMnEQnbpT7xStPKhWF/kovMHGc4oksHJAFqu0H8U/dCNUsp5CZDH1yhIRLn
         OkMSJ/u3cNn5IavXvunYtQb/oEtMGOfyHAV6wpsxlT2Zadmt0A/MJE+ERLZh7O0dX5JH
         kHxbGN2gZeUCTWS08OdiScNFN0a2Jpb5L3L00OkOVR/Q10hmldtwwktk6RcIXa8S0UZH
         h3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ie3FuFSeGnQzxp/gG6RvU/39LViknC8R4Q5i5KJEG/8=;
        b=fziv21bcBiOT9hkNJwmJi3PIY9ITeM6baZz+NkCHbiRX4Gxt9ur9JP6KLMM9Enjqgk
         nAin6ZIpiWwZIPBn771xRTl+Jniq5VRXo/j/iQbx0xOlozDdwKmT8wPJoxFQUagGYh9f
         vG24uKLMRmieXWt4CkS7L6p2VYdbQ8psR/h/BnnusOIQD5eJsfcz3x5wpiu2xrJvjAFI
         nWRLtIRwCB1nuRLFKNSyoFODbFK1b0e7R759NsnGxuBVePuKYbJ7tVBkPX1zFtjkbfh+
         QoOIVGk64ZDNyvYPmwmoLLHukeEUqBmdMJEiW8opvHEabBJu1oQAQ/MflUG7uYDsf+xn
         4TwA==
X-Gm-Message-State: AOUpUlHYjhbwbyzH1lQmTwwHefwj15ogLX/BYlI95g8bOGB4rGNF+PSq
        csFbF23sCkR4wOme4sJMOuw=
X-Google-Smtp-Source: AAOMgpcWWZJud1UpJuBjouJb4a9ap0XDlwR0gZxOpk75ufD/QARk5/j2mRMLjX6lbObNBDIetsG1Gw==
X-Received: by 2002:a24:4612:: with SMTP id j18-v6mr14449610itb.65.1531782342274;
        Mon, 16 Jul 2018 16:05:42 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id e18-v6sm16815318iof.23.2018.07.16.16.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 16:05:41 -0700 (PDT)
Date:   Mon, 16 Jul 2018 19:05:35 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure
 --force" test
Message-ID: <20180716230535.GA49654@flurp.local>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-12-sunshine@sunshineco.com>
 <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet>
 <CAPig+cRFeNt9FVDGnbGcp8Bvfh0ohay+p+tLhfx=EFvJg=Q1Sg@mail.gmail.com>
 <xmqq7elusvz7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7elusvz7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 02:37:32PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Mon, Jul 16, 2018 at 11:51 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> On Mon, 16 Jul 2018, Johannes Schindelin wrote:
> >> > > -           git submodule add --force bogus-url submod &&
> >> > > +           git submodule add --force /bogus-url submod &&
> >> > This breaks on Windows because of the absolute Unix-y path having to be
> >> > translated to a Windows path:
> >> > I could imagine that using "$(pwd)/bogus-url" (which will generate a
> >> > Windows-y absolute path on Windows) would work, though.
> >>
> >> Yes, this works indeed, see the patch below. Could you please squash it in
> >> if you send another iteration of your patch series? Junio, could you
> >> please add this as a SQUASH??? commit so that `pu` is fixed on Windows?
> >
> > So, this SQUASH looks like the correct way forward. Hopefully, Junio
> > can just squash it so I don't have to flood the list again with this
> > long series.
> 
> The topic already has another dependent topic so rerolling or
> squashing would be a bit cumbersome.  I'll see what I could do but
> it may not be until tomorrow's pushout.

No problem. Here's Dscho's fix in the form of a proper patch if
that makes it easier for you (it just needs his sign-off):

--- >8 ---
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t7400: make "submodule add/reconfigure --force" work on
 Windows

On Windows, the "Unixy" path /bogus-url gets translated automatically to
a Windows-style path (such as C:/git-sdk/bogus_url). This is normally
not problem, since it's still a valid and usable path in that form,
however, this test wants to do a comparison against the original path.
$(pwd) was invented exactly for this case, so use it to make the path
comparison work.

[es: commit message]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7400-submodule-basic.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 76cf522a08..bfb09dd566 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -171,10 +171,11 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-		git submodule add --force /bogus-url submod &&
+		bogus_url="$(pwd)/bogus-url" &&
+		git submodule add --force "$bogus_url" submod &&
 		git submodule add --force -b initial "$submodurl" submod-branch &&
-		test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
-		test "/bogus-url" = "$(git config submodule.submod.url)" &&
+		test "$bogus_url" = "$(git config -f .gitmodules submodule.submod.url)" &&
+		test "$bogus_url" = "$(git config submodule.submod.url)" &&
 		# Restore the url
 		git submodule add --force "$submodurl" submod &&
 		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
-- 
2.18.0.233.g985f88cf7e
