Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8791F404
	for <e@80x24.org>; Wed, 28 Mar 2018 00:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeC1APs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:15:48 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:33236 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC1APr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:15:47 -0400
Received: by mail-pl0-f41.google.com with SMTP id c11-v6so484173plo.0
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9BVtnswIRPdRMlt0rk8EeoLOZNKwPPOI5ZhAuGZVSK4=;
        b=gKw0a7f7fUGq/pxZC2eIIds7u2zwgHn2No4Z6+NSXLl1yRQHnPyXb4OUF+HJrTtawy
         5bYq4YMez7UDpEQ/oTcgZw9wO6bb6ZpGsUywRXH1m/qLFGPOdOOEraj/nIGRTl6gL4Yp
         r+gCWcUgFZeF6GINW0jJfxAyh1oFRu9eb9+3098RWXCemkeZ0JsrXtVH7dzK9St5QRMu
         CyRPrn8gs7XNIYiXE6UckAOLIVLTEzjJRTfi34VZg+pseMI7M9WZfGPhj50femfSvoX5
         i1pbP3gckxilP4YK/AWYJAwTHJoeHJSy46wQl5ArtVKCgq1El0a42NBIy8DUS7dRYUin
         mU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9BVtnswIRPdRMlt0rk8EeoLOZNKwPPOI5ZhAuGZVSK4=;
        b=Qw1JyqbIFWygRUJooTLRjRDGYBGl78ZJR99Kl341Fc6xylW73uHVvvlsHu3I3xm4p3
         +jubTGrO61lMmuzlFPL8RwxghppOuHdndqC2GbN9BuZtR/WCBiJD3SVJmEx4ywSeRGDU
         s0rjAdQRNrYWBkUcyUbY2aCtII91Mx3ul7MwlKtvGdBaqGUCrtsx6ZSjQPX9IgK6WsY4
         M9COEPcasSoRbWaIGv7CX780OnMaYC8JHm/FS2HTFl0I3ZV971FA0WN2ML/EEBGE4lCP
         vO1k83AoO2JCEq4CRktrPGeT6BBSZ6UGES6Unx2VLsem1YhY7ZVYRFbIepYkSiSXAVih
         8IBQ==
X-Gm-Message-State: AElRT7H7GPhHa9+25oC88PMcKMGYJ+DCFI6j+pqMq/ggB2yY84mn9LOu
        QxURqCFaTRX6VlDurkBEgrqnk8aA8l8=
X-Google-Smtp-Source: AIpwx4+IxRyeudaTQpXZ+5gXrCla5+zMCoGMCFir05l7l66EAbjC5fZNh+qjG9upTkMh2FHkaA0oGQ==
X-Received: by 2002:a17:902:850b:: with SMTP id bj11-v6mr1411802plb.35.1522196145537;
        Tue, 27 Mar 2018 17:15:45 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id j65sm4315423pge.58.2018.03.27.17.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 17:15:42 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>
Subject: [RFC PATCH 1/1] bdl-lib.sh: add bash debug logger
Date:   Tue, 27 Mar 2018 17:15:35 -0700
Message-Id: <126d0c61bf79c137bb2e220d57c94282719035f4.1522190580.git.wink@saville.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1522190580.git.wink@saville.com>
References: <cover.1522190580.git.wink@saville.com>
In-Reply-To: <cover.1522190580.git.wink@saville.com>
References: <cover.1522190580.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add bdl-lib to assist the programmer in debugging scripts and tests.
---
 bdl-exmpl.sh       |  46 ++++++++++++
 bdl-lib.sh         | 215 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0014-bdl-lib.sh | 115 ++++++++++++++++++++++++++++
 t/test-lib.sh      |   4 +
 4 files changed, 380 insertions(+)
 create mode 100755 bdl-exmpl.sh
 create mode 100644 bdl-lib.sh
 create mode 100755 t/t0014-bdl-lib.sh

diff --git a/bdl-exmpl.sh b/bdl-exmpl.sh
new file mode 100755
index 000000000..a47d82bca
--- /dev/null
+++ b/bdl-exmpl.sh
@@ -0,0 +1,46 @@
+#!/usr/bin/env bash
+# Examples using bdl-lib.sh
+
+# Source bdl-lib.sh
+. bdl-lib.sh
+
+# These both output to the default bdl_stdout=1
+bdl
+bdl "hi"
+bdl 1 "hi"
+
+# Output to a file as parameter
+echo -n >bdl_out.txt
+bdl bdl_out.txt "hi to bdl_out.txt"
+cat bdl_out.txt
+
+# Output to a file via bdl_dst
+echo -n >bdl_out.txt
+bdl_dst=bdl_out.txt
+bdl "hi to bdl_out.txt"
+cat bdl_out.txt
+bdl_dst=
+
+# Output to FD 5 connected to 1 via bdl_stdout
+bdl_stdout=5
+exec 5>&1
+bdl
+bdl "hi"
+bdl 5 "hi"
+exec 1>&5
+bdl_stdout=1
+
+# No printing to stdout
+echo -n >bdl_out.txt
+bdl_stdout=1
+bdl_dst=
+bdl 0 "not printed"
+bdl_stdout=0
+bdl
+bdl bdl_out.txt "printed to bdl_out.txt"
+bdl "not printed"
+bdl_stdout=1
+cat bdl_out.txt
+
+# This prints a "0" since there is only one parameter
+bdl 0
diff --git a/bdl-lib.sh b/bdl-lib.sh
new file mode 100644
index 000000000..cecf726bb
--- /dev/null
+++ b/bdl-lib.sh
@@ -0,0 +1,215 @@
+# ##################################################################
+# Bash Debug logger scriplet, source into your script to use.
+#
+# Write debug info with file name and line number.
+#
+# If the number of parameters == 0 then just the file
+# name and line number are printed to the destination.
+#
+# If the number of parameters == 1 then the file
+# name and line number are printed followed by a space
+# and then the parameter.
+# 
+# If number of parameters > 1 then the first parameter
+# is the destination and the other parameters are written
+# to the destination.
+#
+# The destination can be the first parameter to bdl
+# or bdl_stdout or bdl_dst. If the destination is empty
+# then the data is written to bdl_stdout unless bdl_stdout
+# is empty or 0 then no data is written. Also, if the
+# destination is 0 no data is written.
+#
+# Examples:
+#$ cat -n bdl-exmpl.sh 
+#     1	#!/usr/bin/env bash
+#     2	# Examples using bdl-lib.sh
+#     3	
+#     4	# Source bdl-lib.sh
+#     5	. bdl-lib.sh
+#     6	
+#     7	# These both output to the default bdl_stdout=1
+#     8	bdl
+#     9	bdl "hi"
+#    10	bdl 1 "hi"
+#    11	
+#    12	# Output to a file as parameter
+#    13	echo -n >bdl_out.txt
+#    14	bdl bdl_out.txt "hi to bdl_out.txt"
+#    15	cat bdl_out.txt
+#    16	
+#    17	# Output to a file via bdl_dst
+#    18	echo -n >bdl_out.txt
+#    19	bdl_dst=bdl_out.txt
+#    20	bdl "hi to bdl_out.txt"
+#    21	cat bdl_out.txt
+#    22	bdl_dst=
+#    23	
+#    24	# Output to FD 5 connected to 1 via bdl_stdout
+#    25	bdl_stdout=5
+#    26	exec 5>&1
+#    27	bdl
+#    28	bdl "hi"
+#    29	bdl 5 "hi"
+#    30	exec 1>&5
+#    31	bdl_stdout=1
+#    32	
+#    33	# No printing to stdout
+#    34	echo -n >bdl_out.txt
+#    35	bdl_stdout=1
+#    36	bdl_dst=
+#    37	bdl 0 "not printed"
+#    38	bdl_stdout=0
+#    39	bdl
+#    40	bdl bdl_out.txt "printed to bdl_out.txt"
+#    41	bdl "not printed"
+#    42	bdl_stdout=1
+#    43	cat bdl_out.txt
+#    44	
+#    45	# This prints a "0" since there is only one parameter
+#    46	bdl 0
+#
+#
+# This is the output of bdl-exmpl.sh
+#
+#  $ /bin/bash ./bdl-exmpl.sh
+#  bdl-exmpl.sh:8:
+#  bdl-exmpl.sh:9: hi
+#  bdl-exmpl.sh:10: hi
+#  bdl-exmpl.sh:14: hi to bdl_out.txt
+#  bdl-exmpl.sh:20: hi to bdl_out.txt
+#  bdl-exmpl.sh:27:
+#  bdl-exmpl.sh:28: hi
+#  bdl-exmpl.sh:29: hi
+#  bdl-exmpl.sh:40: printed to bdl_out.txt
+#  bdl-exmpl.sh:46: 0
+# ##################################################################
+
+BDL_LOADED=t
+
+# Prompt waitng for a return, q will exit
+bdl_pause () {
+	read -p "Line ${BASH_LINENO}: $@" bdl_pause_v_
+	[[ "$bdl_pause_v_" == "q" ]] && exit 1
+}
+
+# Initialize bdl variables if user didn't
+[[ "$bdl_dst" == "" ]] && bdl_dst=
+[[ "$bdl_stdout" == "" ]] && bdl_stdout=1
+[[ "$bdl_call_depth" == "" ]] && bdl_call_depth=0
+[[ "$bdl_call_stack_view" == "" ]] && bdl_call_stack_view=f
+
+# Initialize priviate bdl variables
+_bdl_call_lineno_offset_array=()
+_bdl_call_lineno_offset_array_idx=0
+_bdl_call_save=()
+_bdl_call_save_idx=0
+
+# Push bdl state and initialize call meta data.
+#
+# $1 is value for bdl_call_depth
+# $2 Optional text of a script with where bdl calls
+#    will be found and used to compute lineno info.
+bdl_push () {
+	# Push the bdl data
+	_bdl_call_save[$_bdl_call_save_idx]="bdl_dst=$bdl_dst; \
+bdl_stdout=$bdl_stdout; \
+bdl_call_depth=$bdl_call_depth; \
+bdl_call_stack_view=$bdl_call_stack_view; \
+_bdl_call_lineno_offset_array=(${_bdl_call_lineno_offset_array[*]}); \
+_bdl_call_lineno_offset_array_idx=$_bdl_call_lineno_offset_array_idx"
+	_bdl_call_save_idx=$((_bdl_call_save_idx+1))
+
+	# Set meta data to fudge line numbers when bdl is used in tests.
+	bdl_call_depth=$1
+	shift
+	_bdl_call_lineno_offset_array_idx=0
+	_bdl_call_lineno_offset_array=()
+
+	if test "$1" != ""
+	then
+		# Read the script and find lines that begin with "bdl "
+		# and compute their offsets and saving them in an array
+		# that bdl will use to compute compute the lineno.
+		IFS=$'\n' read -d '' -r -a test_run_script_array <<< "$@"
+		for i in "${!test_run_script_array[@]}"; do
+			ln=${test_run_script_array[$i]}
+			tln="$(sed -e 's/^[[:space:]]*//' <<<$ln)"
+			if [[ "$tln" =~ ^bdl\  ]]
+			then
+				_bdl_call_lineno_offset_array+=$((i+1))
+			fi
+		done
+	fi
+}
+
+# Pop a previously save state.
+bdl_pop () {
+	_bdl_call_save_idx=$((_bdl_call_save_idx-1))
+	eval "${_bdl_call_save[$_bdl_call_save_idx]}"
+}
+
+# Write debug info with no source or line number
+bdl_nsl () {
+	if (( $# > 1 )); then
+		bdl_nsl_v_=$1
+		shift
+	else
+		bdl_nsl_v_=$bdl_dst
+	fi
+	[[ "$bdl_nsl_v_" == "" ]] && bdl_nsl_v_=$bdl_stdout
+	if [[ "$bdl_nsl_v_" != "" && "$@" != "" ]]; then
+		if [[ $bdl_nsl_v_ =~ ^[0-9] ]]; then
+			# There's probably a better way, but this "works":
+			case $bdl_nsl_v_ in
+				1) echo "$@" 1>&1 ;;
+				2) echo "$@" 1>&2 ;;
+				3) echo "$@" 1>&3 ;;
+				4) echo "$@" 1>&4 ;;
+				5) echo "$@" 1>&5 ;;
+				6) echo "$@" 1>&6 ;;
+				7) echo "$@" 1>&7 ;;
+				8) echo "$@" 1>&8 ;;
+				9) echo "$@" 1>&9 ;;
+				*) : ;; # 0 and all other characters are nop's
+			esac
+		else
+			echo "$@" >> $bdl_nsl_v_
+		fi
+	fi
+	return 0
+}
+
+# Write debug info with file name and line number.
+bdl () {
+	#View the call stack
+	if test "$bdl_call_stack_view" != "f"
+	then
+		for i in "${!BASH_SOURCE[@]}"; do
+			(( $i == 0 )) && ln=${LINENO} || ln=${BASH_LINENO[${i}-1]}
+			bdl_nsl "[$i] ${BASH_SOURCE[$i]##*/}:${FUNCNAME[$i]}:${ln}"
+		done
+	fi
+
+	# The ${@:+ } only adds a space if $@ isn't empty.
+	# This is done because We allow the call to bdl to
+	# have no parameters and bdl then just prints the
+       	# file name and line number which can be useful
+	# to know a line was processed but there is no need
+	# to print any other data.
+	bdl_ln=${BASH_LINENO[${bdl_call_depth}]}
+	if (( ${_bdl_call_lineno_offset_array_idx} < ${#_bdl_call_lineno_offset_array[@]} ))
+	then
+		bdl_offset=${_bdl_call_lineno_offset_array[$_bdl_call_lineno_offset_array_idx]}
+		bdl_ln=$((bdl_ln+bdl_offset))
+		_bdl_call_lineno_offset_array_idx=$((_bdl_call_lineno_offset_array_idx+1))
+	fi
+	if (( $# <= 1 )); then
+		bdl_nsl $bdl_dst "${BASH_SOURCE[${bdl_call_depth}+1]##*/}:${bdl_ln}:${@:+ }$@"
+	else
+		v_=$1
+		shift
+		bdl_nsl $v_ "${BASH_SOURCE[${bdl_call_depth}+1]##*/}:${bdl_ln}:${@:+ }$@"
+	fi
+	return 0
+}
diff --git a/t/t0014-bdl-lib.sh b/t/t0014-bdl-lib.sh
new file mode 100755
index 000000000..a0546189a
--- /dev/null
+++ b/t/t0014-bdl-lib.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+
+test_description='test bash debug logger'
+
+# Only execute if shell is bash
+if test "$BASH_VERSION" != ""
+then
+
+. ../bdl-lib.sh
+bdl_dst=output
+
+fi
+
+. ./test-lib.sh
+
+test_expect_success 'do nothing' '
+	printf "" >output &&
+	printf "" >expected &&
+	test_cmp expected output
+'
+
+# Only execute if shell is bash
+if test "$BASH_VERSION" != ""
+then
+
+test_expect_success 'bdl_nsl only prints nothing' '
+	printf "" >output &&
+	bdl_nsl &&
+	printf "" >expected &&
+	test_cmp expected output
+'
+
+test_expect_success 'bdl_nsl with string prints string only' '
+	printf "" >output &&
+	bdl_nsl "test 1" &&
+	printf "test 1\n" >expected &&
+	test_cmp expected output
+'
+
+test_lineno=$LINENO
+test_expect_success 'bdl only print source and linenumber' '
+	printf "" >output &&
+	bdl &&
+	printf "t0014-bdl-lib.sh:$((test_lineno+3)):\n" >expected &&
+	test_cmp expected output
+'
+
+test_lineno=$LINENO
+test_expect_success 'bdl with string prints source and linenumber and string' '
+	printf "" >output &&
+	bdl "test 1" &&
+	printf "t0014-bdl-lib.sh:$((test_lineno+3)): test 1\n" >expected &&
+	test_cmp expected output
+'
+
+test_expect_success 'bdl 0 "nothing printed"' '
+	printf "" >output &&
+	printf "" >expected &&
+	bdl 0 "nothing printed" &&
+	test_cmp expected output
+'
+
+# Save current bdl_dst and restore when test completes
+#bdl_dst_save=$bdl_dst
+#bdl_stdout_save=$bdl_stdout
+bdl_push
+test_expect_success 'bdl bdl_dst empty bdl_stdout=0 nothing printed' '
+	bdl_dst= &&
+	bdl_stdout=0 &&
+	printf "" >output &&
+	printf "" >expected &&
+	bdl "nothing printed" &&
+	test_cmp expected output
+'
+#bdl_dst=$bdl_dst_save
+#bdl_stdout=$bdl_stdout_save
+bdl_pop
+
+# Testing subroutine calls from a test verify bdl_push/pop works
+# for direct calls and nested calls
+subsub_lineno=$LINENO
+subsub () {
+	bdl_push 0
+	bdl "subsub line"
+	bdl_pop
+	return "0"
+}
+
+sub_lineno=$LINENO
+sub () {
+	bdl_push 0
+	bdl "sub line"
+	subsub
+	bdl_pop
+	return "0"
+}
+
+test_expect_success 'test calls subsub' '
+	printf "" >output &&
+	subsub &&
+	printf "t0014-bdl-lib.sh:$((subsub_lineno+3)): subsub line\n" >expected &&
+	test_cmp expected output
+'
+
+test_expect_success 'test sub calls subsub' '
+	printf "" >output &&
+	sub &&
+	printf "t0014-bdl-lib.sh:$((sub_lineno+3)): sub line
+t0014-bdl-lib.sh:$((subsub_lineno+3)): subsub line\n" >expected &&
+	test_cmp expected output
+'
+
+fi
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7740d511d..85142e462 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -680,11 +680,15 @@ test_run_ () {
 		trace=$trace_tmp
 	fi
 
+	test "$BDL_LOADED" = "t" && bdl_push 4 "$@"
+
 	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?
 	teardown_malloc_check
 
+	test "$BDL_LOADED" = "t" && bdl_pop
+
 	if test -z "$immediate" || test $eval_ret = 0 ||
 	   test -n "$expecting_failure" && test "$test_cleanup" != ":"
 	then
-- 
2.16.3

