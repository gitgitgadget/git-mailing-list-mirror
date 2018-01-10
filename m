Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F861FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeAJJHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:07:40 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:44336 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeAJJHe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 04:07:34 -0500
Received: by mail-pg0-f42.google.com with SMTP id i5so10338295pgq.11
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 01:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MO63HspkSoS+8puOzku9MZ9Vc3XS54AOWdYo+DDrqeA=;
        b=bDZi6ZN1Dp/CeZvbOK8Z2B7i0GRnxaPVaETBoY42lhSZykELZYV0I3del/QT910jfG
         A0Cv0BOAk6E/VNzQEc48n6Q21nHPiodBVNiPSsVXQRGO2CczmIJ8a/lMUK+Ym9ar4Aaz
         eX8ZDpu6PUg69lf2z1oL1L2SCuFRdc9O6A3h0U5pAF/0eLE8JbHO1gDduTRvSS3hmXWQ
         KMixCF0NFXUx+illsduFCdNEJCmkScQU1FODg4Bskt6YVBpXfbQsPQePMTeHzrXcXTbA
         mr4imV+2h8cDTPnMTZWc47r2LimNJ02yLt8PNnvYbSPLUrieaY2FDmJrQlIAaoU3+ziD
         XmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MO63HspkSoS+8puOzku9MZ9Vc3XS54AOWdYo+DDrqeA=;
        b=bwJ3VWvfyYF2Fy+u0+y4W3LDhrO0vHiyozlrGouLtSRj6agDU9uFvR0WF9A+cfRasZ
         iMb1m6HfRw1X/Huw7ctl81umYi+Vv5m90BxheVmiTCYjVj1VXJs6yHKW/8oIXTsH/OCp
         tHa0CAVwQg01gOJlWziKi4h+E9ud6HH8Vut+ywAckNuQ7u9KQ5q+rxvySqXSV3H+otwp
         vTHlbReQyT/LMaWcoU+9rOl7dkxDeReWtHV0S8WvEyENNBhe1hgEPWgRb51sbV3WgyXl
         cs6eME64WnDrtV9grpFYZPs6A9GiIEKBvMmYWNZfEn9MnkWmVBqX5zqMaQ/zQGJxS6vL
         XzQg==
X-Gm-Message-State: AKwxytc9dy0vCiKV9u051i6DHzfw6SjEALP1oestnpzM0ggAO7fzcxlc
        SAp0YjiYvYTNsbwmBG81DM6HQA==
X-Google-Smtp-Source: ACJfBotnhUloEQJdldzgZEwyDfDLjqJRpIIeli++YclA4Dvm0x2Es0qgT5Hy7P37jWq3I8thLN8Ong==
X-Received: by 10.98.214.7 with SMTP id r7mr4500048pfg.213.1515575253861;
        Wed, 10 Jan 2018 01:07:33 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id 15sm7616825pfi.97.2018.01.10.01.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 01:07:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 10 Jan 2018 16:07:24 +0700
Date:   Wed, 10 Jan 2018 16:07:24 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
Message-ID: <20180110090724.GA2893@ash>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <20180105221222.28867-1-avarab@gmail.com>
 <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 08, 2018 at 01:25:04PM +0100, Johannes Schindelin wrote:
> I agree that it would make a ton of sense to use a proper, portable test
> framework written in pure, portable C.
> 
> However, this ship has long sailed, hasn't it?

If you meant converting the whole test suite, oh yeah that's not gonna
happen. But it's still possible to have some tests written in C.

I played a bit with this. The assumption is if it's agreed that we can
get something bare bone (but functional) in then we could start having
more and more C-based unit tests in future and also improve the C
framework to be on par with shell one on the side.

There are still some minor problems with my patch, and a bunch of
optional features not supported. But the numbers looks unexpectedly
promising. 0.7 seconds on the shell version and 0.03 on the C one.

One disadvantage of this though, if this kind of framework does not
get popular, then any new test feature must be added at both places
but it's a waste of time to support both. So...

Anyway here it is. t3071 is the same as t3070 (this is on master)

 Makefile                             |   2 +
 t/helper/test-3071-wildmatch.c (new) | 273 ++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t3071-wildmatch.sh (new +x)        |   3 +
 test-lib.c (new)                     |  97 ++++++++++++++++++
 test-lib.h (new)                     |   5 +

-- 8< --
diff --git a/Makefile b/Makefile
index 2a81ae22e9..567387b558 100644
--- a/Makefile
+++ b/Makefile
@@ -644,6 +644,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_PROGRAMS_NEED_X += test-3071-wildmatch
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
@@ -895,6 +896,7 @@ LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
+LIB_OBJS += test-lib.o
 LIB_OBJS += tmp-objdir.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
diff --git a/t/helper/test-3071-wildmatch.c b/t/helper/test-3071-wildmatch.c
new file mode 100644
index 0000000000..24a657202d
--- /dev/null
+++ b/t/helper/test-3071-wildmatch.c
@@ -0,0 +1,273 @@
+#include "cache.h"
+#include "test-lib.h"
+
+struct match_input {
+	int expect_true;
+	const char *text;
+	const char *pattern;
+};
+
+static struct match_input match_tests[] = {
+	/* Basic wildmatch features */
+	{ 1, "foo", "foo" },
+	{ 0, "foo", "bar" },
+	{ 1, "", "" },
+	{ 1, "foo", "???" },
+	{ 0, "foo", "??" },
+	{ 1, "foo", "*" },
+	{ 1, "foo", "f*" },
+	{ 0, "foo", "*f" },
+	{ 1, "foo", "*foo*" },
+	{ 1, "foobar", "*ob*a*r*" },
+	{ 1, "aaaaaaabababab", "*ab" },
+	{ 1, "foo*", "foo\\*" },
+	{ 0, "foobar", "foo\\*bar" },
+	{ 1, "f\\oo", "f\\\\oo" },
+	{ 1, "ball", "*[al]?" },
+	{ 0, "ten", "[ten]" },
+	{ 0, "ten", "**[!te]" },
+	{ 0, "ten", "**[!ten]" },
+	{ 1, "ten", "t[a-g]n" },
+	{ 0, "ten", "t[!a-g]n" },
+	{ 1, "ton", "t[!a-g]n" },
+	{ 1, "ton", "t[^a-g]n" },
+	{ 1, "a]b", "a[]]b" },
+	{ 1, "a-b", "a[]-]b" },
+	{ 1, "a]b", "a[]-]b" },
+	{ 0, "aab", "a[]-]b" },
+	{ 1, "aab", "a[]a-]b" },
+	{ 1, "]", "]" },
+
+	/* Extended slash-matching features */
+	{ 0, "foo/baz/bar", "foo*bar" },
+	{ 0, "foo/baz/bar", "foo**bar" },
+	{ 0, "foobazbar", "foo**bar" },
+	{ 1, "foo/baz/bar", "foo/**/bar" },
+	{ 1, "foo/baz/bar", "foo/**/**/bar" },
+	{ 1, "foo/b/a/z/bar", "foo/**/bar" },
+	{ 1, "foo/b/a/z/bar", "foo/**/**/bar" },
+	{ 1, "foo/bar", "foo/**/bar" },
+	{ 1, "foo/bar", "foo/**/**/bar" },
+	{ 0, "foo/bar", "foo?bar" },
+	{ 0, "foo/bar", "foo[/]bar" },
+	{ 0, "foo/bar", "foo[^a-z]bar" },
+	{ 0, "foo/bar", "f[^eiu][^eiu][^eiu][^eiu][^eiu]r" },
+	{ 1, "foo-bar", "f[^eiu][^eiu][^eiu][^eiu][^eiu]r" },
+	{ 1, "foo", "**/foo" },
+	{ 1, "XXX/foo", "**/foo" },
+	{ 1, "bar/baz/foo", "**/foo" },
+	{ 0, "bar/baz/foo", "*/foo" },
+	{ 0, "foo/bar/baz", "**/bar*" },
+	{ 1, "deep/foo/bar/baz", "**/bar/*" },
+	{ 0, "deep/foo/bar/baz/", "**/bar/*" },
+	{ 1, "deep/foo/bar/baz/", "**/bar/**" },
+	{ 0, "deep/foo/bar", "**/bar/*" },
+	{ 1, "deep/foo/bar/", "**/bar/**" },
+	{ 0, "foo/bar/baz", "**/bar**" },
+	{ 1, "foo/bar/baz/x", "*/bar/**" },
+	{ 0, "deep/foo/bar/baz/x", "*/bar/**" },
+	{ 1, "deep/foo/bar/baz/x", "**/bar/*/*" },
+
+	/* Various additional tests */
+	{ 0, "acrt", "a[c-c]st" },
+	{ 1, "acrt", "a[c-c]rt" },
+	{ 0, "]", "[!]-]" },
+	{ 1, "a", "[!]-]" },
+	{ 0, "", "\\" },
+	{ 0, "\\", "\\" },
+	{ 0, "XXX/\\", "*/\\" },
+	{ 1, "XXX/\\", "*/\\\\" },
+	{ 1, "foo", "foo" },
+	{ 1, "@foo", "@foo" },
+	{ 0, "foo", "@foo" },
+	{ 1, "[ab]", "\\[ab]" },
+	{ 1, "[ab]", "[[]ab]" },
+	{ 1, "[ab]", "[[:]ab]" },
+	{ 0, "[ab]", "[[::]ab]" },
+	{ 1, "[ab]", "[[:digit]ab]" },
+	{ 1, "[ab]", "[\\[:]ab]" },
+	{ 1, "?a?b", "\\??\\?b" },
+	{ 1, "abc", "\\a\\b\\c" },
+	{ 0, "foo", "" },
+	{ 1, "foo/bar/baz/to", "**/t[o]" },
+
+	/* Character class tests */
+	{ 1, "a1B", "[[:alpha:]][[:digit:]][[:upper:]]" },
+	{ 0, "a", "[[:digit:][:upper:][:space:]]" },
+	{ 1, "A", "[[:digit:][:upper:][:space:]]" },
+	{ 1, "1", "[[:digit:][:upper:][:space:]]" },
+	{ 0, "1", "[[:digit:][:upper:][:spaci:]]" },
+	{ 1, " ", "[[:digit:][:upper:][:space:]]" },
+	{ 0, ".", "[[:digit:][:upper:][:space:]]" },
+	{ 1, ".", "[[:digit:][:punct:][:space:]]" },
+	{ 1, "5", "[[:xdigit:]]" },
+	{ 1, "f", "[[:xdigit:]]" },
+	{ 1, "D", "[[:xdigit:]]" },
+	{ 1, "_", "[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]" },
+	{ 1, ".", "[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]" },
+	{ 1, "5", "[a-c[:digit:]x-z]" },
+	{ 1, "b", "[a-c[:digit:]x-z]" },
+	{ 1, "y", "[a-c[:digit:]x-z]" },
+	{ 0, "q", "[a-c[:digit:]x-z]" },
+
+	/* Additional tests, including some malformed wildmats */
+	{ 1, "]", "[\\\\-^]" },
+	{ 0, "[", "[\\\\-^]" },
+	{ 1, "-", "[\\-_]" },
+	{ 1, "]", "[\\]]" },
+	{ 0, "\\]", "[\\]]" },
+	{ 0, "\\", "[\\]]" },
+	{ 0, "ab", "a[]b" },
+	{ 0, "a[]b", "a[]b" },
+	{ 0, "ab[", "ab[" },
+	{ 0, "ab", "[!" },
+	{ 0, "ab", "[-" },
+	{ 1, "-", "[-]" },
+	{ 0, "-", "[a-" },
+	{ 0, "-", "[!a-" },
+	{ 1, "-", "[--A]" },
+	{ 1, "5", "[--A]" },
+	{ 1, " ", "[ --]" },
+	{ 1, "$", "[ --]" },
+	{ 1, "-", "[ --]" },
+	{ 0, "0", "[ --]" },
+	{ 1, "-", "[---]" },
+	{ 1, "-", "[------]" },
+	{ 0, "j", "[a-e-n]" },
+	{ 1, "-", "[a-e-n]" },
+	{ 1, "a", "[!------]" },
+	{ 0, "[", "[]-a]" },
+	{ 1, "^", "[]-a]" },
+	{ 0, "^", "[!]-a]" },
+	{ 1, "[", "[!]-a]" },
+	{ 1, "^", "[a^bc]" },
+	{ 1, "-b]", "[a-]b]" },
+	{ 0, "\\", "[\\]" },
+	{ 1, "\\", "[\\\\]" },
+	{ 0, "\\", "[!\\\\]" },
+	{ 1, "G", "[A-\\\\]" },
+	{ 0, "aaabbb", "b*a" },
+	{ 0, "aabcaa", "*ba*" },
+	{ 1, ",", "[,]" },
+	{ 1, ",", "[\\\\,]" },
+	{ 1, "\\", "[\\\\,]" },
+	{ 1, "-", "[,-.]" },
+	{ 0, "+", "[,-.]" },
+	{ 0, "-.]", "[,-.]" },
+	{ 1, "2", "[\\1-\\3]" },
+	{ 1, "3", "[\\1-\\3]" },
+	{ 0, "4", "[\\1-\\3]" },
+	{ 1, "\\", "[[-\\]]" },
+	{ 1, "[", "[[-\\]]" },
+	{ 1, "]", "[[-\\]]" },
+	{ 0, "-", "[[-\\]]" },
+
+	/* Test recursion and the abort code (use "wildtest -i" to see iteration counts) */
+	{ 1, "-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1", "-*-*-*-*-*-*-12-*-*-*-m-*-*-*" },
+	{ 0, "-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1", "-*-*-*-*-*-*-12-*-*-*-m-*-*-*" },
+	{ 0, "-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1", "-*-*-*-*-*-*-12-*-*-*-m-*-*-*" },
+	{ 1, "XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1", "XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*" },
+	{ 0, "XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1", "XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*" },
+	{ 1, "abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt", "**/*a*b*g*n*t" },
+	{ 0, "abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz", "**/*a*b*g*n*t" },
+	{ 0, "foo", "*/*/*" },
+	{ 0, "foo/bar", "*/*/*" },
+	{ 1, "foo/bba/arr", "*/*/*" },
+	{ 0, "foo/bb/aa/rr", "*/*/*" },
+	{ 1, "foo/bb/aa/rr", "**/**/**" },
+	{ 1, "abcXdefXghi", "*X*i" },
+	{ 0, "ab/cXd/efXg/hi", "*X*i" },
+	{ 1, "ab/cXd/efXg/hi", "*/*X*/*/*i" },
+	{ 1, "ab/cXd/efXg/hi", "**/*X*/**/*i" },
+
+	/* Case-sensitivity features */
+	{ 0, "a", "[A-Z]" },
+	{ 1, "A", "[A-Z]" },
+	{ 0, "A", "[a-z]" },
+	{ 1, "a", "[a-z]" },
+	{ 0, "a", "[[:upper:]]" },
+	{ 1, "A", "[[:upper:]]" },
+	{ 0, "A", "[[:lower:]]" },
+	{ 1, "a", "[[:lower:]]" },
+	{ 0, "A", "[B-Za]" },
+	{ 1, "a", "[B-Za]" },
+	{ 0, "A", "[B-a]" },
+	{ 1, "a", "[B-a]" },
+	{ 0, "z", "[Z-y]" },
+	{ 1, "Z", "[Z-y]" },
+};
+
+static struct match_input pathmatch_tests[] = {
+	{ 1, "foo", "foo" },
+	{ 0, "foo", "fo" },
+	{ 1, "foo/bar", "foo/bar" },
+	{ 1, "foo/bar", "foo/*" },
+	{ 1, "foo/bba/arr", "foo/*" },
+	{ 1, "foo/bba/arr", "foo/**" },
+	{ 1, "foo/bba/arr", "foo*" },
+	{ 1, "foo/bba/arr", "foo**" },
+	{ 1, "foo/bba/arr", "foo/*arr" },
+	{ 1, "foo/bba/arr", "foo/**arr" },
+	{ 0, "foo/bba/arr", "foo/*z" },
+	{ 0, "foo/bba/arr", "foo/**z" },
+	{ 1, "foo/bar", "foo?bar" },
+	{ 1, "foo/bar", "foo[/]bar" },
+	{ 1, "foo/bar", "foo[^a-z]bar" },
+	{ 0, "foo", "*/*/*" },
+	{ 0, "foo/bar", "*/*/*" },
+	{ 1, "foo/bba/arr", "*/*/*" },
+	{ 1, "foo/bb/aa/rr", "*/*/*" },
+	{ 1, "abcXdefXghi", "*X*i" },
+	{ 1, "ab/cXd/efXg/hi", "*/*X*/*/*i" },
+	{ 1, "ab/cXd/efXg/hi", "*Xg*i" },
+};
+
+static struct match_input icase_match_tests[] = {
+	{ 1, "a", "[A-Z]" },
+	{ 1, "A", "[A-Z]" },
+	{ 1, "A", "[a-z]" },
+	{ 1, "a", "[a-z]" },
+	{ 1, "a", "[[:upper:]]" },
+	{ 1, "A", "[[:upper:]]" },
+	{ 1, "A", "[[:lower:]]" },
+	{ 1, "a", "[[:lower:]]" },
+	{ 1, "A", "[B-Za]" },
+	{ 1, "a", "[B-Za]" },
+	{ 1, "A", "[B-a]" },
+	{ 1, "a", "[B-a]" },
+	{ 1, "z", "[Z-y]" },
+	{ 1, "Z", "[Z-y]" },
+};
+
+static void test_match(const char *name,
+		       const struct match_input *input,
+		       unsigned flags)
+{
+	int ret;
+
+	start_test("%s:  %s match '%s' '%s'",
+		   name,
+		   input->expect_true ? "  " : "no",
+		   input->text, input->pattern);
+	ret = wildmatch(input->pattern, input->text, flags);
+	end_test(input->expect_true ? ret == 0 : ret != 0);
+}
+
+int cmd_main(int ac, const char **av)
+{
+	int i;
+
+	init_test_suite(ac, av);
+
+	for (i = 0; i < ARRAY_SIZE(match_tests); i++)
+		test_match("wildmatch", match_tests + i, WM_PATHNAME);
+
+	for (i = 0; i < ARRAY_SIZE(pathmatch_tests); i++)
+		test_match("pathmatch", pathmatch_tests + i, 0);
+
+	for (i = 0; i < ARRAY_SIZE(icase_match_tests); i++)
+		test_match("iwildmatch", icase_match_tests + i,
+			   WM_PATHNAME | WM_CASEFOLD);
+
+	all_tests_done();
+}
diff --git a/t/t3071-wildmatch.sh b/t/t3071-wildmatch.sh
new file mode 100755
index 0000000000..6e83b4d684
--- /dev/null
+++ b/t/t3071-wildmatch.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+exec helper/test-3071-wildmatch t3071-wildmatch "$@"
diff --git a/test-lib.c b/test-lib.c
new file mode 100644
index 0000000000..8e8b7cd6df
--- /dev/null
+++ b/test-lib.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "test-lib.h"
+
+static int test_failure;
+static int test_count;
+static int test_fixed;
+static int test_broken;
+static int test_success;
+
+static const char *suite_name;
+static int harness_active;
+static char *test_name;
+
+void init_test_suite(int ac, const char **av)
+{
+	char cwd[PATH_MAX];
+
+	harness_active = getenv("HARNESS_ACTIVE") != NULL;
+	suite_name = av[1];
+
+	getcwd(cwd, sizeof(cwd));
+	setenv("TEST_DIRECTORY", cwd, 0);
+	setenv("TEST_OUTPUT_DIRECTORY", getenv("TEST_DIRECTORY"), 0);
+
+	ac--;
+	av++;
+
+	dup2(1, 3);
+}
+
+static int skip_test(void)
+{
+	return 0; /* not supported yet */
+}
+
+int start_test(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	test_name = xstrvfmt(fmt, ap);
+	va_end(ap);
+	test_count++;
+
+	if (skip_test())
+		return 0;
+
+	return 1;
+}
+
+void end_test(int ok)
+{
+	if (ok) {
+		test_success++;
+		dprintf(3, "ok %d - %s\n", test_count, test_name);
+	} else {
+		test_failure++;
+		dprintf(3, "not ok %d - %s\n", test_count, test_name);
+	}
+
+	free(test_name);
+	test_name = NULL;
+
+	/* -i not supported yet */
+}
+
+void all_tests_done(void)
+{
+	if (!getenv("HARNESS_ACTIVE")) {
+		struct strbuf sb = STRBUF_INIT;
+		FILE *fp;
+
+		strbuf_addf(&sb, "mkdir -p %s/test-results",
+			    getenv("TEST_OUTPUT_DIRECTORY"));
+		system(sb.buf);
+		strbuf_release(&sb);
+
+		strbuf_addf(&sb, "%s/test-results/%s.counts",
+			    getenv("TEST_OUTPUT_DIRECTORY"),
+			    suite_name);
+		fp = fopen(sb.buf, "w");
+		strbuf_release(&sb);
+
+		fprintf(fp, "total %d\nsuccess %d\n"
+			"fixed %d\nbroken %d\nfailed %d\n\n",
+			test_count, test_success,
+			test_fixed, test_broken, test_failure);
+		fclose(fp);
+	}
+	if (test_failure) {
+		dprintf(3, "# failed %d among FIXME\n", test_failure);
+	} else {
+		dprintf(3, "# passed all FIXME\n");
+	}
+	dprintf(3, "1..%d\n", test_count);
+	exit(0);
+}
diff --git a/test-lib.h b/test-lib.h
new file mode 100644
index 0000000000..f8122c1719
--- /dev/null
+++ b/test-lib.h
@@ -0,0 +1,5 @@
+void init_test_suite(int ac, const char **av);
+void all_tests_done(void) NORETURN;
+
+int start_test(const char *fmt, ...);
+void end_test(int ok);
-- 8< --

--
Duy
