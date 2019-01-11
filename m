Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2812F211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 14:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfAKOEO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 09:04:14 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38929 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfAKOEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 09:04:13 -0500
Received: by mail-wm1-f41.google.com with SMTP id y8so2469936wmi.4
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o4iGJTLdXE5MToQz9M6LIHyPReQDxC18ixbeH6FODFk=;
        b=XnxHQ5WecBgcQ05r29NUrrzPM4w32ksubZn1GxbNGK3ZkByon+VglsXyI/iwXjEW5v
         oGBfI2T4BKsVWi1I6OOIjjWwJDgKz5+n6q/AWznTedOor59TJ2eruoGgqglo5WgIDAG3
         WW2J00CBECjn+93//P5u+e2mvPXzm2SD5fx6IfJXJPAWDXNaZY/V+Rw7cSe08uyqvdTr
         TNQyzlZc4hmuoJxQsupzyMRr6wHvqGsQopnDTyg/6xPviac1Kupyroz/IgizmwMAeuVZ
         9EPi6Em177UNU4bOUNtbjUlRyMRdN/dARnovHPoqy9mGS/AZlB6tT+K2XZxhp7I1a21T
         Amew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o4iGJTLdXE5MToQz9M6LIHyPReQDxC18ixbeH6FODFk=;
        b=ZQpM+MnwlJZwWqHskZHtFxErvUdrfgfWOmOfmdujcDKDthAXYiyun1+D0wG+BhWTjC
         wXLrYw/h2P4qKozpPnBOdbhVKhNzfPt/4C2e2BdxhBX71+HzQPwDF799NN+YFbsBxIKw
         0bmDMn6iKlGyblEl4FHwk7EmD/uu0i0shxsp4vg0fqxVwbOzd9q9VtfXp02Fkx9b3yQ/
         NcBlJyIoQHjCqB8DLSaxWvuhJvPpv39CUNvlvHha7wRfLP2SRU3MliD7b/B2+1FSkd8M
         VRPBOoctuEAheEURf0Pd8rdM5F4X4AgKVIDxGqg5ayuWHpHFFdLSwqQ2Hf+cEcsBIO3Z
         FN2w==
X-Gm-Message-State: AJcUukfwKwPacy0essPapMDo90k48NLIII1soY7+a00aZmZ8LoqQDKyS
        O77XP4V4EHLHcag96pE8skY=
X-Google-Smtp-Source: ALg8bN7cWmANaazzUskXUsA5gNi/GO0RJoCdsFs3iTPknE1wlHzmdBF5GWBYod/TZk5YeEM/PfpTQw==
X-Received: by 2002:a1c:63d5:: with SMTP id x204mr2401841wmb.137.1547215451119;
        Fri, 11 Jan 2019 06:04:11 -0800 (PST)
Received: from szeder.dev (x4db349c7.dyn.telefonica.de. [77.179.73.199])
        by smtp.gmail.com with ESMTPSA id x81sm20506600wmg.17.2019.01.11.06.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 06:04:10 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:04:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: t0021-conversion: flaky filter process test
Message-ID: <20190111140408.GC840@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

I see occasional failures in the test 'required process filter should
filter data' in 't0021-conversion.sh', added in edcc85814c (convert:
add filter.<driver>.process option, 2016-10-16); most often in the
macOS Travis CI build jobs, but it's an OS-independent timing issue.

That's an enormous test, and the part failing every once in a while is
this:

    filter_git checkout --quiet --no-progress empty-branch &&
    cat >expected.log <<-EOF &&
            START
            init handshake complete
            IN: clean test.r $S [OK] -- OUT: $S . [OK]
            STOP
    EOF
    test_cmp_exclude_clean expected.log debug.log &&

Here's the relevant trace output:

  ++filter_git checkout --quiet --no-progress empty-branch
  ++rm -f debug.log expected.log
  ++git checkout --quiet --no-progress empty-branch
  ++cat
  ++test_cmp_exclude_clean expected.log debug.log
  ++expect=expected.log
  ++actual=debug.log
  ++for FILE in '"$expect"' '"$actual"'
  ++grep -v 'IN: clean' expected.log
  ++for FILE in '"$expect"' '"$actual"'
  ++grep -v 'IN: clean' debug.log
  grep: debug.log: No such file or directory
  error: last command exited with $?=2

So when checking out the 'empty-branch' four tracked files from the
currently checked out 'master' branch must be removed, and this part
of the test assumes that the filter process is always invoked to clean
those files.  Alas, this is not necessarily the case: if 'git
checkout' knows for sure that all files are clean, then it won't waste
resources running the clean filter process at all, and just deletes
those files.

Now, in our tests commands are executed in rapid succession, so it's
highly probable that those files are racily clean, and, consequently,
'git checkout' has to look at the contents of the files, meaning that
it has to run the clean filter process, and then all is well: that's
why the test succeeds most of the time.  Occasionally, however, the
commands are executed slow enough or just at the right moment that the
files are really clean, and 'git checkout' won't bother starting the
clean filter process, which then won't write a 'debug.log' file,
resulting in the above failure.

You might find the 'sg/stress-test' topic (already in 'next', tip at
fb7d1e3ac8; just run './t0021-conversion.sh -r 1,15 --stress' and
wait) and the patch below helpful in reproducing and debugging the
issue.



diff --git a/convert.c b/convert.c
index e0848226d2..f87184cae2 100644
--- a/convert.c
+++ b/convert.c
@@ -812,6 +812,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
+	trace_printf("apply_multi_file_filter()\n");
+
 	if (!subprocess_map_initialized) {
 		subprocess_map_initialized = 1;
 		hashmap_init(&subprocess_map, cmd2process_cmp, NULL, 0);
diff --git a/read-cache.c b/read-cache.c
index bd45dc3e24..ce39ace43f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -412,11 +412,13 @@ int ie_match_stat(struct index_state *istate,
 	 * carefully than others.
 	 */
 	if (!changed && is_racy_timestamp(istate, ce)) {
+		trace_printf("'%s' is RACILY clean!\n", ce->name);
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else
 			changed |= ce_modified_check_fs(istate, ce, st);
-	}
+	} else
+		trace_printf("'%s' is clean\n", ce->name);
 
 	return changed;
 }
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index fd5f1ac649..6b3d3b12e5 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -390,7 +390,11 @@ test_expect_success PERL 'required process filter should filter data' '
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
-		filter_git checkout --quiet --no-progress empty-branch &&
+		GIT_TRACE=2 &&
+		export GIT_TRACE &&
+		filter_git checkout --quiet --no-progress empty-branch 2>trace &&
+		cat trace &&
+		unset GIT_TRACE &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -398,6 +402,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
+		grep RACILY trace &&
 
 		filter_git checkout --quiet --no-progress master &&
 		cat >expected.log <<-EOF &&
@@ -416,6 +421,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		test_cmp_committed_rot13 "$TEST_ROOT/test3 '\''sq'\'',\$x=.o" "testsubdir/test3 '\''sq'\'',\$x=.r"
 	)
 '
+test_done
 
 test_expect_success PERL 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&

