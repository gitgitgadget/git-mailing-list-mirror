Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315C1BD019
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444570; cv=none; b=jK6f94oDaFF0M7xcu1Yn/iatG3evtItZiy5ssPX5s6m/vhO2e/ODzN/rsQVtjvmtXcq8M37epf03e+aNbapW+SEpyvE6gV+F72twY1thxq/Z6RPpHZ5VneLIltVFv9+5iFcCIcpvFMxuzebe7ySKs/lX4NMDjjAUoV7I2WKCeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444570; c=relaxed/simple;
	bh=J7ud7mCGoLm3TdO1Tb9ACtYAPJz7qhK9bqqdS/ftD2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elp92YDJ/aNtq+dsvWxzuTOWE5Ma5qo/9gebVcKgyuVE4tHw8o0NlVVHym53Gsn0RAKhGd2YTkoSXkqQ/rtLZVmJvcDOh/jo1dQgUyq9a/o65v1ooUFkEpc5r00I4J2WbUZRv6VvM8GmR4xQcXRBqC7oP33VEkw4FdkbHnwHvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BJl88KFj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BJl88KFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722444516; x=1723049316; i=l.s.r@web.de;
	bh=SF5w88JZHeEWjHCoJkadMyLQw8QjmE0iF3bsE5D/fUU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BJl88KFjCilr/39KhvA7Bqpjs5XS1gGxj3oH7bsl0GidjQPpHmHH0l/FPRFRx9jb
	 5JKvIgvUHXVk9wKkBAEgKBx3jrywGBl3KtogVbBG+a9uwR4H3RU715+AbwufmyNf7
	 AYuxEnJPektalanhP1LeTrCUsa6E8BEQ1/Gffg61dhvru3tUSSQ/mBDuZS3tZQ2Yl
	 HTzFGLdiqdAoAcvs+G8CN6WwIyvu+j8DkMKKuxJm2TTyxf6PPfjRiqvXtG7oqWZ4U
	 C2PiiG+sLJSaVb17RcrQHxgmyZrC1FnJzF0w1w+BOvOpcWTp2XgbFv4+06WmpRv8H
	 kaBQIr6Eb85OuG/QeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1sAUZy2DaU-00yiiu; Wed, 31
 Jul 2024 18:48:36 +0200
Message-ID: <cf23d831-9412-408a-8e68-170a8a476808@web.de>
Date: Wed, 31 Jul 2024 18:48:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] Makefile: wire up the clar unit testing framework
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott
 <spectral@google.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <cover.1722415748.git.ps@pks.im>
 <5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9H0cjmvatQ09YW2L2EjwLFw13BmJIPC+Igw7txsg0lMlhjfeAgE
 /qziZ480qQsliASGbe17XgwjphZtfHRiGcnuqR0YOTByfYRGS2sfPFS8kWCml/zAoFFyDAB
 kNZQuXOYsIhY327KjyjypCNlBqXJCGb1knwJdljC5FrrhKDD3+SDOVQxL4uACdo2W+IqQGH
 HNC0IVFgaXnM+etr9qGhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zd6ogyVcGiQ=;4xKOyxW5Hlx+VM31hgLQ8XPnFQz
 WzODWkK1leaHJXN3sfScVNnDQc5S4Xh4AkRWDqtbCPQBqu02JwyYjBDogI0mVUZ79z2eppQL+
 SQIOF+jD1ZtFhx3+Ra5c/AccrBo0Aj1VfMu17LV5YJY7hbK4lGguxA12oTOPWKk74qj5wrjSw
 JFsI5BUUdiMOrzEVSjfq1eWi+LQ1ISARoTsGpOorAiro2WOTv6ENH9TNC74j78mSqtJv8QBQu
 SW3HiUyF/2JvwexK6X1c2KmMLCdY5RYMLVMmBuPHLA33i5mkVH9Wi38bsbZes+eYf2rAI8Kw9
 zjtjYa9B7fyh2vBhAYxLSW4835IrOcOHt48r6DBDC9ahj3zMQkb8oXEFJqU+WLufawnOlMKKs
 Eho/sOczy0MBUgLvpmM59JNKj26as2tSmaskKBAvNblhBxbAxk+/cOXPpYMzZB44aqQumlPQd
 hvwZJ9F65F92lPkv6GfMwGT19dHb8d1UplqLcZPEZlY2rtpP1R5OOfjPTe9W7ie3vgNeUD2Ew
 gnMc80r4QvXk8RsDYhSmT/5Vo5nco+9/kugM4VE+JnV4/PUCLmMyYSxPn6X9/87ah/7DL0VNB
 InTwUlbRA2zZlVIs4TWt/ll/SZBFYUAm3W3P0tH5oC3ZGO04UU7b9V3jyUiY8ktYMsvOe0Tjy
 DMap9LosX80T2mJL7EYElhwaRa8V8R3JceUXcvn5weKUga6oTV41PqY8KFnvxosp15ka1qMSG
 rQJxvL3n8DqdeYjmFI9VGECn9WTjrrRxrhUmwIAy3pN+cPgaBhpw1lK5k2xFLF3QjA2XFHnTB
 0+B8lEM1W2yMY4ZAtnzm1CsA==

Am 31.07.24 um 11:04 schrieb Patrick Steinhardt:
> Wire up the clar unit testing framework by introducing a new
> "unit-tests" executable. In contrast to the existing framework, this
> will result in a single executable for all test suites. The ability to
> pick specific tests to execute is retained via functionality built into
> the clar itself.
>
> Note that we need to be a bit careful about how we need to invalidate
> our Makefile rules. While we obviously have to regenerate the clar suite
> when our test suites change, we also have to invalidate it in case any
> of the test suites gets removed. We do so by using our typical pattern
> of creating a `GIT-TEST-SUITES` file that gets updated whenever the set
> of test suites changes, so that we can easily depend on that file.
>
> Another specialty is that we generate a "clar-decls.h" file. The test
> functions are neither static, nor do they have external declarations.
> This is because they are getting parsed via "generate.py", which then
> creates the external generations that get populated into an array. These
> declarations are only seen by the main function though.
>
> The consequence is that we will get a bunch of "missing prototypes"
> errors from our compiler for each of these test functions. To fix those
> errors, we extract the `extern` declarations from "clar.suite" and put
> them into a standalone header that then gets included by each of our
> unit tests. This gets rid of compiler warnings for every function which
> has been extracted by "generate.py". More importantly though, it does
> _not_ get rid of warnings in case a function really isn't being used by
> anything. Thus, it would cause a compiler error if a function name was
> mistyped and thus not picked up by "generate.py".
>

> +$(UNIT_TEST_DIR)/clar.suite: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_T=
ESTS_SUITES)) GIT-TEST-SUITES
> +	$(QUIET_GEN)$(UNIT_TEST_DIR)/clar/generate.py $(UNIT_TEST_DIR) >/dev/n=
ull

This uses the Python interpreter from the shebang line in generate.py,
which is python.  On my system I only have python3 and python3.12, but
not python.  Easily fixed, of course, but a way to configure the
interpreter name would be nice.

This gave me extra motivation to come up with the clunky patch below
to replace Python with sed and awk.  That and your statement that clar
doesn't have to be perfect in the other thread. ;)

It reverses the order of dependencies (builds clar-decls.h first), not
sure if that has downsides.  And the sed pattern is simpler than the
one in generate.py, just out of laziness.

Ren=C3=A9

=2D--
 .gitignore                |  1 -
 Makefile                  | 20 ++++++-----------
 t/unit-tests/.gitignore   |  1 -
 t/unit-tests/generate.awk | 47 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 15 deletions(-)
 create mode 100644 t/unit-tests/generate.awk

diff --git a/.gitignore b/.gitignore
index 6687bd6db4..8caf3700c2 100644
=2D-- a/.gitignore
+++ b/.gitignore
@@ -9,7 +9,6 @@
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-SPATCH-DEFINES
-/GIT-TEST-SUITES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index 8ebcbdc95a..1ffde38de5 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -3706,7 +3706,7 @@ cocciclean:

 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
-	$(RM) $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/.clarcache
+	$(RM) $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/clar-decls.h
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3866,19 +3866,13 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_T=
EST_DIR)/%.o \
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)

-GIT-TEST-SUITES: FORCE
-	@FLAGS=3D'$(UNIT_TESTS_SUITES)'; \
-	    if test x"$$FLAGS" !=3D x"`cat GIT-TEST-SUITES 2>/dev/null`" ; then =
\
-		echo >&2 "    * new test suites"; \
-		echo "$$FLAGS" >GIT-TEST-SUITES; \
-		rm -f $(UNIT_TESTS_DIR)/.clarcache; \
-            fi
+$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h $(UNIT_TEST_DI=
R)/generate.awk
+	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/generate.awk $(UNIT_TEST_DIR)/clar-d=
ecls.h >$@
+$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_T=
ESTS_SUITES))
+	$(QUIET_GEN)for suite in $(UNIT_TESTS_SUITES); do \
+		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/=
extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
+	done >$@

-$(UNIT_TEST_DIR)/clar.suite: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_TES=
TS_SUITES)) GIT-TEST-SUITES
-	$(QUIET_GEN)$(UNIT_TEST_DIR)/clar/generate.py $(UNIT_TEST_DIR) >/dev/nul=
l
-	@touch $@
-$(UNIT_TEST_DIR)/clar-decls.h: $(UNIT_TEST_DIR)/clar.suite
-	$(QUIET_GEN)grep '^extern void' $^ >$@
 $(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR) -I$(UNIT_TEST_D=
IR)/clar
 $(UNIT_TESTS_PROG): $(UNIT_TEST_DIR)/clar.suite $(UNIT_TESTS_OBJS) $(GITL=
IBS) GIT-LDFLAGS
diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
index b8d46f7bb1..d0632ec7f9 100644
=2D-- a/t/unit-tests/.gitignore
+++ b/t/unit-tests/.gitignore
@@ -1,4 +1,3 @@
 /bin
-/.clarcache
 /clar.suite
 /clar-decls.h
diff --git a/t/unit-tests/generate.awk b/t/unit-tests/generate.awk
new file mode 100644
index 0000000000..3c78253866
=2D-- /dev/null
+++ b/t/unit-tests/generate.awk
@@ -0,0 +1,47 @@
+function add_suite(suite, initialize, cleanup, count) {
+	if (!suite) return
+	suite_count++
+	callback_count +=3D count
+	suites =3D suites "    {\n"
+	suites =3D suites "        \"" suite "\",\n"
+	suites =3D suites "        " initialize ",\n"
+	suites =3D suites "        " cleanup ",\n"
+	suites =3D suites "        _clar_cb_" suite ", " count ", 1\n"
+	suites =3D suites "    },\n"
+}
+BEGIN {
+	suites =3D "static struct clar_suite _clar_suites[] =3D {\n"
+}
+{
+	print
+	name =3D $3; sub(/\(.*$/, "", name)
+	suite =3D name; sub(/^test_/, "", suite); sub(/__.*$/, "", suite)
+	short_name =3D name; sub(/^.*__/, "", short_name)
+	cb =3D "{ \"" short_name "\", &" name " }"
+	if (suite !=3D prev_suite) {
+		add_suite(prev_suite, initialize, cleanup, count)
+		if (callbacks) callbacks =3D callbacks "};\n"
+		callbacks =3D callbacks "static const struct clar_func _clar_cb_" suite=
 "[] =3D {\n"
+		initialize =3D "{ NULL, NULL }"
+		cleanup =3D "{ NULL, NULL }"
+		count =3D 0
+		prev_suite =3D suite
+	}
+	if (short_name =3D=3D "initialize") {
+		initialize =3D cb
+	} else if (short_name =3D=3D "cleanup") {
+		cleanup =3D cb
+	} else {
+		callbacks =3D callbacks "    " cb ",\n"
+		count++
+	}
+}
+END {
+	add_suite(suite, initialize, cleanup, count)
+	suites =3D suites "};"
+	if (callbacks) callbacks =3D callbacks "};"
+	print callbacks
+	print suites
+	print "static const size_t _clar_suite_count =3D " suite_count ";"
+	print "static const size_t _clar_callback_count =3D " callback_count ";"
+}
=2D-
2.46.0
