Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA13D1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbeIUA2h (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 20:28:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeIUA2h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 20:28:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so10421787wrr.9
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zy/mffX9jRaHX/hqa/PzUgrYdrE1uigoUCs1VXs0DJg=;
        b=uisF8PTJFKflVrpKp71kNRNBMo4bwUjSpuUCsxSWnno089sgF/0qt1CZ8cPLY0gQpv
         VOZyFPgc/Ppypm5OUm2XS0rftSueWSAZA3q5z766HTZRdQ/M3hdps68pTtP15AMR31VX
         9jvHE/M5q/7aPRMgKyVFDqKWrV38c6Qv9uQw4Rgn5omc6WgIhIhozVCFzOMmbyTFAw80
         oL6TnrlaYl2+FK0aHWBOM2KHxUWbYookJLFwkHloPb1hJoDXikeNszJgUu8KinU0nVrf
         Pou/dN5ScXkYZQ4Mlo+idRov57lN2wy0NPXYexGYPWhtP7CCcdpCttPR+R03SEIi3NBL
         Cf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zy/mffX9jRaHX/hqa/PzUgrYdrE1uigoUCs1VXs0DJg=;
        b=r0s+YTX4l8U6cjyMG9ZhrwKM7BjvHvWpqfebqhPso5dUuDWrURCvVYYdKFK+nfFMfW
         qpFOn2cnYa+UIi5gdLYLl5B8IT+kVuEYDp4zQsbLXBVKHgA+8RHOUbcBSe6KmdGYdVEU
         QuFL8/LTIB8V4YDeMC1RrocHdeRR8ANCzU9xv2FWTei7MKzbxqKmA5RDRPNZjqDZce8/
         P0ieU/IzT8QRtqMBlEXDt4eBKNx5HKDpODswFV3+5EcG5IEB3lXSk8ZMsHyBqQYn5P5q
         s28DDKjpznPDS7w2i6QYAKldd5k2LBg62ioVsoAZdiLhmPNAKInnyyoAy6J4dubVifUf
         2zJw==
X-Gm-Message-State: APzg51BKQSP5/CkZ8KWQKb6Atgg5NY54QPZnPChHUjqLsnBReGlN3KIb
        lGTvy1lpJVe1kgxxX68LUN6WpbRu
X-Google-Smtp-Source: ANB0VdZTsEntcu7b4ZjPRdKokODjfGrj0HiPemSfWihEwHGBag7kQZCA80stue0cOnG5pTMAA+NVTQ==
X-Received: by 2002:adf:fd90:: with SMTP id d16-v6mr35862777wrr.276.1537469024674;
        Thu, 20 Sep 2018 11:43:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v17-v6sm6181383wrc.63.2018.09.20.11.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 11:43:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jrnieder\@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re*: [PATCH v3 0/5] Cleanup pass on special test setups
References: <20180914143708.63024-1-benpeart@microsoft.com>
        <20180918232916.57736-1-benpeart@microsoft.com>
Date:   Thu, 20 Sep 2018 11:43:43 -0700
In-Reply-To: <20180918232916.57736-1-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 18 Sep 2018 23:29:33 +0000")
Message-ID: <xmqqtvmkyppc.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> This round has one code change based on feedback. Other changes are just
> rewording commit messages.

Thanks.  I think the only remaining issue is what to do with the
interaction between extra/additional error message that comes from
the updates in 3/5 and the test framework selftest in t0000.

-- >8 --
Subject: t0000: do not get self-test disrupted by environment warnings

The test framework test-lib.sh itself would want to give warnings
and hints, e.g. when it sees a deprecated environment variable is in
use that we want to encourage users to migrate to another variable.

The self-test of test framework done in t0000 however do not expect
to see these warnings and hints, so depending on the settings of
environment variables, a running test may or may not produce these
messages to the standard error output, breaking the expectations of
self-test test framework does on itself.  Here is what we see:

    $ TEST_GIT_INDEX_VERSION=4 sh t0000-basic.sh -i -v
    ...
    'err' is not empty, it contains:
    warning: TEST_GIT_INDEX_VERSION is now GIT_TEST_INDEX_VERSION
    hint: set GIT_TEST_INDEX_VERSION too during the transition period
    not ok 5 - pretend we have a fully passing test suite

The following quick attempt to work it around does not work, because
some tests in t0000 do want to see expected errors from the test
framework itself.

         t/t0000-basic.sh | 2 +-
         1 file changed, 1 insertion(+), 1 deletion(-)

        diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
        index 850f651e4e..88c6ed4696 100755
        --- a/t/t0000-basic.sh
        +++ b/t/t0000-basic.sh
        @@ -88,7 +88,7 @@ _run_sub_test_lib_test_common () {
                        '

                        # Point to the t/test-lib.sh, which isn't in ../ as usual
        -		. "\$TEST_DIRECTORY"/test-lib.sh
        +		. "\$TEST_DIRECTORY"/test-lib.sh >/dev/null 2>&1
                        EOF
                        cat >>"$name.sh" &&
                        chmod +x "$name.sh" &&

There are a few possible ways to work this around:

 * We could strip the warning: and hint: unconditionally from the
   error output before the error messages are checked in the
   self-test (helper functions check_sub_test_lib_test_err and
   check_sub_test_lib_test); the problem with this approach is that
   it will make it impossible to write self-tests to ensure that
   right warnings and hints are given.

 * We could force a sane environment settings before the test helper
   _run_sub_test_lib_test_common dot-sources test-lib.sh; the
   problem with this approach is that _run_sub_test_lib_test_common
   now needs to be aware of what pairs of environment variables are
   checked in test-lib.sh using check_var_migration helper.

The final patch I came up with is probably the solution that is
least bad.  Set a variable to tell test-lib.sh that we are running
a self-test, so that various pieces in test-lib.sh can react to keep
the output stable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0000-basic.sh | 4 ++++
 t/test-lib.sh    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 850f651e4e..52c02b7c7e 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -87,6 +87,10 @@ _run_sub_test_lib_test_common () {
 		passing metrics
 		'
 
+		# Tell the framework that we are self-testing to make sure
+		# it yields a stable result.
+		GIT_TEST_FRAMEWORK_SELFTEST=t &&
+
 		# Point to the t/test-lib.sh, which isn't in ../ as usual
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8ef86e05a3..364a11ea25 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -135,9 +135,17 @@ GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
 check_var_migration () {
+	# the warnings and hints given from this helper depends
+	# on end-user settings, which will disrupt the self-test
+	# done on the test framework itself.
+	case "$GIT_TEST_FRAMEWORK_SELFTEST" in
+	t)	return ;;
+	esac
+
 	old_name=$1 new_name=$2
 	eval "old_isset=\${${old_name}:+isset}"
 	eval "new_isset=\${${new_name}:+isset}"
+
 	case "$old_isset,$new_isset" in
 	isset,)
 		echo >&2 "warning: $old_name is now $new_name"
