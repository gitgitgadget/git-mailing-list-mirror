Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024E270EC9
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773342; cv=none; b=RJJ+rFJQg4fENg7spmD8Z9GnfsYjS0U/982zjepAoZ9JVPXS5vgLkVbE8jXPY1NUxvh9u+hBdIwkARzJ0KzG0tPZE1GW/grj4eaH3KV++DAlruVGJ3BGh5xs6ZJrasisw3ZN3J2pWKcEeFrrnitOd8XdgwrXILMM+IYDaL7G+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773342; c=relaxed/simple;
	bh=G8p23v9FcG731XA5WbFunlZhqdvTk+sqa2WzP/Ny0Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+QVFmJiwLDhsIi1XjjmWHvOsJh6bm64ZPlF9ny9Hzjt1A8xmXB9TwT4omu1rqGCPzZAl76QQ4eSY8/9twahknecTZs6n2c76OJKIR0fCQ9ZpMQxwvkrb1XTXbqQVznT0TkTkl9UK5OQWYWWDJQZDwNyEIjTwx4EIYuR/m0nEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XvQJMB88; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XvQJMB88"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e461015fbd4so1843328276.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740773339; x=1741378139; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAQD/SgUPnbq4JnxSCNJ6aBMtydELh/EamcTLtouQNk=;
        b=XvQJMB88/JAi3/d+Fx6uoG5nE1t/fm5H7DgkzV6PizFsb4QZRMngAp9rsHfwN9iJEu
         +UdOjFq+gF728U9jOOjHwAcYC14yAt3gQBlxUtWN8r/YjPLqw4ubAQF2koiTofxkm8Xa
         5BTJo8mmjf25PzBgqffSv5RobNdBtJ7HfBHLGdKgMkvU0WWxMYaPjcafPGz2vvD5TTIm
         rITpSbgwEQ2OF/1dETn3/G42xfE/gaxLAYbdu2Yds/xmMba22Jv5Y5fnMqgvTH36Md3g
         dm09w5lLsmVaZUM8iLSFajqpj8QzEQuQiIK3GEX3PknBgCg1HBechMmxuMzsduGEGI3M
         CwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773339; x=1741378139;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAQD/SgUPnbq4JnxSCNJ6aBMtydELh/EamcTLtouQNk=;
        b=Ye0pRmixmxPbGzo+3EsEPJuvQ+eqbGqOev70cIV08SdYCKBw/OSVNmMHML4UXDUv7c
         XsvliKp2FZgc+u8Nb+lhl4mGkCVy+x4tRretAWGRhA3oh/2chgHGSqUR4dNzBcrx3K9M
         oaFJLokogxSY/PxKISy8RLwmM1RAiJdwz746cZMyPE+TFUeJfueCakwkDZEpsDIuBsWY
         BrZut7qAIxd3JDLV3QXuED6hEBlEqIzk8a/4yPeOlJzDRN8mmjj5CJrCzQptXNwTzINZ
         pxfkOrw/P1C/t8m/4EPe6HIRTFnGb/pqwk87NYzuWE8tp0ixRGrKGmVST5f4ILFuehjx
         l4mQ==
X-Gm-Message-State: AOJu0YxVSnx9pn32nt0PDyloyNnJqFXy+OADy+xqGk6HKD2Syf3ypC8y
	6dDEzmy4K4nmsAEf5IRIv79s3JgsGrSuEUGaiykOVQcJUoNjbxKPS/XfGL+79TmIHMxxobu7kjl
	n
X-Gm-Gg: ASbGncvu8W0DvomliVLt4esKNCxybKveOjyaBGF02EAoab3sM4ShUmydw/Iaop9aIqz
	4cOaNOMDqa/zjxcfaCC3XyXvR6GTc4WStOxbnzfspt+2zR2I4tKhs338yFMKR+62B121p/CJH2+
	uImoDpxGOX/yUX4yPLnt1GuLr8lhR0XeApvhYzxCS6DsS9+qd2DQ31Bn/895beFZs0f0cde9kDP
	TZeC7sDJ9/2Dj/W/q1LE6FvArBcQ985bkLPENKlxD8dcKRubfbV7jont5vfWQ4Mm2H9FsdVeHb8
	cNiTNbKCcHcTNUChqBegmpGAM3aD/pJmDxQphVtM5cnIEE9QGWAhXEWNlVhZ4+OJzf2V+fclyA=
	=
X-Google-Smtp-Source: AGHT+IED+xcW5ZK7DxQHKm8qsfVwpsTl4fcWfVp0iX+r6ZsyfImzu5UeUr2I+F7x1ti7IHBXY+BrXg==
X-Received: by 2002:a05:6902:2001:b0:e60:79c0:5089 with SMTP id 3f1490d57ef6-e60b2e860c6mr6179904276.10.1740773338959;
        Fri, 28 Feb 2025 12:08:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3a41ab9sm1289840276.27.2025.02.28.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:08:58 -0800 (PST)
Date: Fri, 28 Feb 2025 15:08:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, "\\ Junio C Hamano" <gitster@pobox.com>,
	"\\ Elijah Newren" <newren@gmail.com>
Subject: GIT-BUILD-OPTIONS can override manual invocations
Message-ID: <Z8IX2bMJe+V80idE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In 4638e8806e (Makefile: use common template for GIT-BUILD-OPTIONS,
2024-12-06), the project's Makefile changed how it writes the
GIT-BUILD-OPTIONS script. Prior to 4638e8806e, the Makefile would write
the file itself, but post-4638e8806e it fills out a template
("GIT-BUILD-OPTIONS.in") with the appropriate values.

This has an interesting side effect when running e.g. the t/perf or
t/interop suites. If I do:

    make && make -C t/perf GIT_PERF_MAKE_OPTS='NO_EXPAT=1'

, then we will still try and build with the libexpat headers!

For example, I removed the libexpat headers from my system, and ran the
above to get the following output:

    $ find /usr/include -name expat.h | wc -l
    0

    $ make && make -C t/perf GIT_PERF_MAKE_OPTS='NO_EXPAT=1'
    [...]
    http-push.c:28:10: fatal error: expat.h: No such file or directory
       28 | #include <expat.h>
          |          ^~~~~~~~~

This is AFAICT fallout from a change in 4638e8806e where instead of
*not* writing e.g. GIT_PERF_MAKE_OPTS into the GIT-BUILD-OPTIONS file,
we now write it with an empty value. So when we run 'make -C t/perf'
with a non-empty GIT_PERF_MAKE_OPTS, t/perf/run will source
GIT-BUILD-OPTIONS, and override the value of GIT_PERF_MAKE_OPTS we
specified.

Interestingly, 4638e8806e works around a similar issue in test-lib.sh
where it stores the value of $TEST_OUTPUT_DIRECTORY in a temporary
variable, and restores it after sourcing GIT-BUILD-OPTIONS if
$TEST_OUTPUT_DIRECTORY is still empty. I think even this is subtly
broken if your $TEST_OUTPUT_DIRECTORY is set to different non-empty
values between GIT-BUILD-OPTIONS and when test-lib.sh is executed.

I noticed this along with Elijah while merging v2.48.1 into GitHub's
private fork since our CI suite runs the t/interop tests with a custom
GIT_INTEROP_MAKE_OPTS.

We could partially fix this in the same way as we do for
TEST_OUTPUT_DIRECTORY, but I think that this isn't quite correct, and it
makes me uneasy knowing that there are other places we might face
similar issues. AFAICT, 4638e8806e has the potential to disrupt scripts
that use any of the following variables:

  - FSMONITOR_DAEMON_BACKEND
  - FSMONITOR_OS_SETTINGS
  - GIT_INTEROP_MAKE_OPTS
  - GIT_PERF_LARGE_REPO
  - GIT_PERF_MAKE_COMMAND
  - GIT_PERF_MAKE_OPTS
  - GIT_PERF_REPEAT_COUNT
  - GIT_PERF_REPO
  - GIT_TEST_CMP
  - GIT_TEST_CMP_USE_COPIED_CONTEXT
  - GIT_TEST_INDEX_VERSION
  - GIT_TEST_OPTS
  - GIT_TEST_PERL_FATAL_WARNINGS
  - GIT_TEST_UTF8_LOCALE
  - TEST_OUTPUT_DIRECTORY

So I think a more robust fix might look like only filling out those
lines in the GIT-BUILD-OPTIONS template when they are non-empty, similar
to the pre-4638e8806e behavior. Something like:

--- 8< ---
diff --git a/Makefile b/Makefile
index 97e8385b66..35e5571d8e 100644
--- a/Makefile
+++ b/Makefile
@@ -3145,6 +3145,7 @@ endif
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: FORCE
 	@sed \
+		$(if $(GIT_PERF_REPO),, -e "/^GIT_PERF_REPO=/d") \
 		-e "s!@BROKEN_PATH_FIX@!\'$(BROKEN_PATH_FIX)\'!" \
 		-e "s|@DIFF@|\'$(DIFF)\'|" \
 		-e "s|@FSMONITOR_DAEMON_BACKEND@|\'$(FSMONITOR_DAEMON_BACKEND)\'|" \
--- >8 ---

, and similar could work for the Makefile, but I'm not sure what
the Meson equivalent would be, or if this is even a good idea or not.

Thoughts?

Thanks,
Taylor
