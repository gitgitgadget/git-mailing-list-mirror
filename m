Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3744E1F454
	for <e@80x24.org>; Sat,  9 Nov 2019 06:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKIGi2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 01:38:28 -0500
Received: from mout.web.de ([217.72.192.78]:32919 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfKIGi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 01:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573281501;
        bh=W8gyuUiAAoTfIqGZ8tUenbMEFzedibQ1E5/AtDcLnJs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TuAw3xV3yKY+w44zucpd6queGBZJl5sQx1v+Qde5L9bUGADon2n8aBIAGrUoYJkaC
         0oaF1fbVWO/yxnk6mO+gnAfuo/CJGjCN7n3GNYkMx5N2U5LGefEZQs9gQSrGLUVfav
         PWSGSkQUvubZQmjMQY8CFdGtX+T24jEauSIbA3sg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mgwhg-1iG2gu3oVU-00M1uD; Sat, 09
 Nov 2019 07:38:20 +0100
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
 <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <08afdbcd-5972-05f9-ec8c-b12bd29d9030@web.de>
Date:   Sat, 9 Nov 2019 07:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijwJ9Xc6j9bbSSLtO/iF0ZbaaCTUsm2iRhihIdGq78u3UkUn5NB
 nRmq7Hu+9MEWll5R2OB7ro4GCWSCskgbHLbob9Y8YzQmHiiCg4oYu65cKqSsNJIa2tcjFSc
 DPuDE4NN4BrvtVPzFiZKauCxcXoM3seRgp6s+M2cthxucYBjhgVfEZEBs7Y2xtMAS78rpJD
 rbEluBgtbKlMJZSxIgmyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pKHhnjc0P68=:DdJUI4GmX+sWLoFFwdiL9c
 blIviD+IBE3lha2G+T2zhKFC2ZnT0CsuB7fAL3WSVTexy+4Q+u5liTRiYkbXWoZfVJ5R6mzbp
 mRF7ZuQmXDZ3miWkX9dqelDKBlobDfB5myRhAYFlYNd1RiP+WtK8YDl8ZiteVguPloSqsZ3sl
 xTPPEpL8VN52bscKzos5B3b5GfEuXpmsb4mp4E3p6IBDbfx5+Ky14RF6MhsJ0mhKvIXbLk7a6
 2YpvcMTv2na350F14uk8sW4H8Hww0IiFkcScn47+s4/CtWUZ+Q38s1SccTYkYZ1L0Ora5nqzR
 StV6dmKHdDTcrfysYEJc2ehPo8kjHltH6Gk5Vda0Z6D+p6Ls3uzIU3pPYiqrkAHFOO5GxYbPe
 1xkHpsbR0+YCSSd5Y5Ve1Nnux1wfFG75FAmVeeu7l3rcE0FSVyYf8rMnTH2r90g0Q9CgeRFTI
 7Eu6diTYQ+4AZVHoNTavml9s1tzsOpi8LGY1sYJ+Edu91Oe/ogH2ziemBIEBeiT+jrMzgtlP1
 9CgnJMtBN0WtyLcxI1EQ12r7IUnzg97Giq2kzpjIdsWVWG11oOsNbfRzkur9Fu1/yZb9nYeiD
 saY0pBwdK2wQtTF0r5YH2dgil/9OhzuXx4M8h7HsA0P5ULePljrQdI7zjttPf8LGc/S6Wux9c
 r8mpPjep931BrmBbW50J8chqKo236mn2hXbiJOctN+cvNag5ct73HqStYNcqIGG8uCWIRmxpS
 cQM0o7huyqGjoTj8ln7oZTQFDnstQJKHAwuxXm8hNZZh9ZIseOOJo1hlvdagVzR9DF+/bPB9N
 rID05j9r7QE4Agw/k/gJYC7q8p9q9mGLipulRoKf9wSs/2xey/O4MBHH11wbTUYmhuSXjCAgC
 D9+mSHULbEWHa/BoRn0yf5EYhDZSehgleXmiV5e325gcOjaafM/b2de3Vq6E2bdSG43rlnaMN
 mOftE6aUTu3A2JNn1S1pbxfQtkfYA36FNo2rk1J11nIf5HItDui3AA4x/aLLKYUXLwRKF/VoK
 0eoysDKHfCtjoFEoofhin8MskCXgo/cCyKN8pnb4uLnClnuDh6tl+fsBFXAgfxrEDPOKYqnx7
 98Eu+xtxSjMzfpDtG14uJM5gL+DHf+yV7ac/0ZJtBEwOxzdJgQ9xstdc0puPqqRYUeKmVe0Ho
 6shSLcFMKsiBg7VtajJU8is+YmNgVTGvPAt3rRyutVkp7wNPwN6D3yXltltKQpc0R7I9NFf6/
 KyUe65idRnxhuFJs7D7SDN/bAGiGnvnm9ToaUyw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.19 um 21:08 schrieb Denton Liu:
> The standard format for referencing other commits within some projects
> (such as git.git) is the summary format. This is described in
> Documentation/SubmittingPatches as
>
> 	If you want to reference a previous commit in the history of a stable
> 	branch, use the format "abbreviated hash (subject, date)",
> 	with the subject enclosed in a pair of double-quotes, like this:
>
> 	....
> 		Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
> 		noticed that ...
> 	....
>
> Since this format is so commonly used, standardize it as a pretty
> format.
>
> This format is implemented as a separate flow that skips most of
> pretty_print_commit() and instead calls format_commit_summary(). The
> reason why this is done is because the other pretty formats expect
> output to be generated in a specific order. Specifically, the header,
> including the date, is always printed before the commit message,
> including the subject. Reversing the order would be possible but would
> involve butchering pretty_print_commit() so it is implemented as a
> separate flow.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/pretty-formats.txt   |  9 ++++
>  Documentation/pretty-options.txt   |  2 +-
>  Documentation/rev-list-options.txt |  2 +-
>  builtin/log.c                      | 30 +++++++++--
>  log-tree.c                         | 11 ++--
>  pretty.c                           | 31 ++++++++++-
>  pretty.h                           |  1 +
>  t/t4205-log-pretty-formats.sh      | 83 +++++++++++++++++++++++++-----
>  8 files changed, 144 insertions(+), 25 deletions(-)

Hmm, that's quite a lot of code to add to the formatting code with its
repeated special-case checks.  Why not implement it as a built-in user
format, like making it an alias for something like this?

   git log --format=3D'%C(auto)%h ("%s", %as)'

We don't have %as, yet, but making --date=3Dshort available as a
placeholder would be a good idea anyway (patch below).


=2D- >8 --
Subject: [PATCH] pretty: provide short date format

Add the placeholders %as and %cs to format author date and committer
date, respectively, without the time part, like --date=3Dshort does, i.e.
like YYYY-MM-DD.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-forma=
ts.txt
index b87e2e83e6..f80eaab439 100644
=2D-- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -169,6 +169,7 @@ The placeholders are:
 '%at':: author date, UNIX timestamp
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
+'%as':: author date, short format (`YYYY-MM-DD`)
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -181,6 +182,7 @@ The placeholders are:
 '%ct':: committer date, UNIX timestamp
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
+'%cs':: committer date, short format (`YYYY-MM-DD`)
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%S':: ref name given on the command line by which the commit was reached
diff --git a/pretty.c b/pretty.c
index b32f036953..76920c91dd 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -731,6 +731,9 @@ static size_t format_person_part(struct strbuf *sb, ch=
ar part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 's':
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
+		return placeholder_len;
 	}

 skip:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..4980ed4c6f 100755
=2D-- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -503,6 +503,12 @@ test_expect_success 'ISO and ISO-strict date formats =
display the same values' '
 	test_cmp expected actual
 '

+test_expect_success 'short date' '
+	git log --format=3D%ad%n%cd --date=3Dshort >expected &&
+	git log --format=3D%as%n%cs >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=3D$(git rev-parse --verify HEAD~0) &&
=2D-
2.24.0
