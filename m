Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E8C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKUA1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKUA1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:27:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6F2CE17
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:27:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o30so7431278wms.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avy42AxhQ1h/s1mEiPLVRZE43fPSg0kpqHGveOIs4+M=;
        b=QwoPTLY/TlqbQSG7sc1Agy2GW/Pm4OBNtoR9okN9iPROwNv0O/jtmKQvQjt15bFra8
         od0GLw7rT9anfPIE/Ugp+1IZG0WAwwx+JGvKk7/GsWwctjukIMNvDXm8ns9/3N0WXtcT
         mlkls3czjSJDj3sU9tvJUioxVqi02kCljSCgUMYzDjczd5PR51rtELU489PP5baGosJ0
         E+927mNPA2asdmxOL/SDqLl+LGdXEGcS6Z0T9HVxXkXNs3wk55h2RvL5/oZcRUHe2kHH
         ocm58GK3WzXVx/MUKfJljWrGDPLj2qx/kcILBLIvHDrF9QoeO1eAySObm4gvgMPvzV6A
         moxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avy42AxhQ1h/s1mEiPLVRZE43fPSg0kpqHGveOIs4+M=;
        b=af1gOnuYf3kkXZKZM8Gl50Ne/xnsoFL/Jj5NT33nWLLSBzu+CNXlmwXG2/z5b5SOU6
         t4UyYImbQKCfV6L//hSnib/9WcBnhtNzbtOsjyYpcH0LG6uqHNvtcGIqArdzfZM07kRN
         jpxj3T4I2sldZlsczWMI3z1iBQBMJ6mCoCvNKuRVEHomLHWSc/rPcAp2s9CH+V3wxHk4
         L3TuzbGyTe7+Dvp9sLTrtxcog3aSiBdsvTiEz+PWGLs6kn+xmW4lJVmmLi9S2lNrG7BU
         1SJaNmUgKvmYSzROBw1LkMjj0TDMqo9fbdYyuokmI51CQ4S8UJjCK/cnbZOVX7vtKjNf
         5vRw==
X-Gm-Message-State: ANoB5pl2lqVa/eNLPPomXhyYkAnzsyL7iKhyWQZAgSSvRU4UijTAMrrS
        bdUQbryMeN4J0tEZuRkpEz8i2WKdxFQ=
X-Google-Smtp-Source: AA0mqf4pT6ksmHMWUwpIFGnsFYSIfZnJ7vEkeZcuS5ZQz7YObsm/IYvKt4H4FLwnDmWarrmgsuwl+Q==
X-Received: by 2002:a1c:7303:0:b0:3cf:e7bd:3035 with SMTP id d3-20020a1c7303000000b003cfe7bd3035mr10577739wmb.60.1668990420824;
        Sun, 20 Nov 2022 16:27:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo22-20020a056000069600b0023659925b2asm10033350wrb.51.2022.11.20.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:27:00 -0800 (PST)
Message-Id: <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
From:   "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 00:26:57 +0000
Subject: [PATCH v2 0/2] add case insensitivity option to bash completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alison Winters <alisonatwork@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 3bb16a8bf2 (tag, branch, for-each-ref: add --ignore-case for sorting and
filtering, 2016-12-04), support was added for filtering and sorting refs in
a case insensitive way. This is a behavior that seems appropriate to enable
with shell completion. Many shells provide case insensitive completion as an
option, even on filesystems that remain case sensitive.

This patch adds a new variable that, when set, will allow Bash completion to
use the --ignore-case option to match refs. Additionally, some basic support
is implemented to match pseudorefs like HEAD.

Changes since v1:

 * Improved comments and commit messages to clarify behavior on case
   sensitive filesystems
 * Replaced some lengthy if blocks with inline substitution
 * As a result of the above change, GIT_COMPLETION_IGNORE_CASE no longer
   needs to be set to "1" and now just needs to be present in the
   environment to work
 * Removed unnecessary exports in tests

Alison Winters (2):
  completion: add optional ignore-case when matching refs
  completion: add case-insensitive match of pseudorefs

 contrib/completion/git-completion.bash | 26 +++++++++++++++++++---
 t/t9902-completion.sh                  | 30 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 3 deletions(-)


base-commit: a0789512c5a4ae7da935cd2e419f253cb3cb4ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1374%2Falisonatwork%2Fbash-insensitive-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1374/alisonatwork/bash-insensitive-v2
Pull-Request: https://github.com/git/git/pull/1374

Range-diff vs v1:

 1:  cef9a12b575 ! 1:  a261a94877a completion: add optional ignore-case when matching refs
     @@ Metadata
       ## Commit message ##
          completion: add optional ignore-case when matching refs
      
     -    If GIT_COMPLETION_IGNORE_CASE=1 is set, --ignore-case will be added to
     -    git for-each-ref calls so that branches and tags can be matched case
     -    insensitively.
     +    If GIT_COMPLETION_IGNORE_CASE is set, --ignore-case will be added to
     +    git for-each-ref calls so that refs can be matched case insensitively,
     +    even when running on case sensitive filesystems.
      
          Signed-off-by: Alison Winters <alisonatwork@outlook.com>
      
     @@ contrib/completion/git-completion.bash
      +#
      +#   GIT_COMPLETION_IGNORE_CASE
      +#
     -+#     When set to "1", suggest refs that match case insensitively (e.g.,
     -+#     completing "FOO" on "git checkout f<TAB>").
     ++#     When set, uses for-each-ref '--ignore-case' to find refs that match
     ++#     case insensitively, even on systems with case sensitive file systems
     ++#     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
       
       case "$COMP_WORDBREAKS" in
       *:*) : great ;;
     -@@ contrib/completion/git-completion.bash: __git_complete_index_file ()
     - __git_heads ()
     - {
     +@@ contrib/completion/git-completion.bash: __git_heads ()
       	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
     -+	local ignore_case=""
     -+
     -+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
     -+	then
     -+		ignore_case="--ignore-case"
     -+	fi
       
       	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
     -+			$ignore_case \
     ++			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
       			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
       }
       
     -@@ contrib/completion/git-completion.bash: __git_heads ()
     - __git_remote_heads ()
     - {
     +@@ contrib/completion/git-completion.bash: __git_remote_heads ()
       	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
     -+	local ignore_case=""
     -+
     -+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
     -+	then
     -+		ignore_case="--ignore-case"
     -+	fi
       
       	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
     -+			$ignore_case \
     ++			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
       			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
       }
       
     -@@ contrib/completion/git-completion.bash: __git_remote_heads ()
     - __git_tags ()
     - {
     +@@ contrib/completion/git-completion.bash: __git_tags ()
       	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
     -+	local ignore_case=""
     -+
     -+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
     -+	then
     -+		ignore_case="--ignore-case"
     -+	fi
       
       	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
     -+			$ignore_case \
     ++			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
       			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
       }
       
      @@ contrib/completion/git-completion.bash: __git_dwim_remote_heads ()
     - {
     - 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
     - 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
     -+	local ignore_case=""
     -+
     -+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
     -+	then
     -+		ignore_case="--ignore-case"
     -+	fi
     - 
     - 	# employ the heuristic used by git checkout and git switch
     - 	# Try to find a remote branch that cur_es the completion word
       	# but only output if the branch name is unique
       	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
       		--sort="refname:strip=3" \
     -+		$ignore_case \
     ++		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
       		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
       	uniq -u
       }
     -@@ contrib/completion/git-completion.bash: __git_refs ()
     - 	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
     - 	local match="${4-}"
     - 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
     -+	local ignore_case=""
     - 
     - 	__git_find_repo_path
     - 	dir="$__git_repo_path"
     -@@ contrib/completion/git-completion.bash: __git_refs ()
     - 		fi
     - 	fi
     - 
     -+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
     -+	then
     -+		ignore_case="--ignore-case"
     -+	fi
     -+
     - 	if [ "$list_refs_from" = path ]; then
     - 		if [[ "$cur_" == ^* ]]; then
     - 			pfx="$pfx^"
      @@ contrib/completion/git-completion.bash: __git_refs ()
       			;;
       		esac
       		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
     -+			$ignore_case \
     ++			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
       			"${refs[@]}"
       		if [ -n "$track" ]; then
       			__git_dwim_remote_heads "$pfx" "$match" "$sfx"
     @@ contrib/completion/git-completion.bash: __git_refs ()
       			$match*)	echo "${pfx}HEAD$sfx" ;;
       			esac
       			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
     -+				$ignore_case \
     ++				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
       				"refs/remotes/$remote/$match*" \
       				"refs/remotes/$remote/$match*/**"
       		else
     @@ t/t9902-completion.sh: test_expect_success 'checkout completes ref names' '
      +
      +test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGNORE_CASE' '
      +	(
     -+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
     -+		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&
     ++		GIT_COMPLETION_IGNORE_CASE=1 &&
      +		test_completion "git checkout M" <<-\EOF
      +		main Z
      +		mybranch Z
 2:  c455e855395 ! 2:  480f6554c93 completion: add case-insensitive match of pseudorefs
     @@ Metadata
       ## Commit message ##
          completion: add case-insensitive match of pseudorefs
      
     -    When GIT_COMPLETION_IGNORE_CASE=1, also allow lowercase completion text
     -    like "head" to match HEAD and other pseudorefs.
     +    When GIT_COMPLETION_IGNORE_CASE is set, also allow lowercase completion
     +    text like "head" to match uppercase HEAD and other pseudorefs.
      
          Signed-off-by: Alison Winters <alisonatwork@outlook.com>
      
     @@ contrib/completion/git-completion.bash: __git_refs ()
       	local match="${4-}"
      +	local umatch="${4-}"
       	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
     - 	local ignore_case=""
       
     + 	__git_find_repo_path
      @@ contrib/completion/git-completion.bash: __git_refs ()
     - 	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
     - 	then
     - 		ignore_case="--ignore-case"
     -+		# use tr instead of ${match,^^} to preserve bash 3.2 compatibility
     -+		umatch=$(echo "$match" | tr a-z A-Z 2> /dev/null || echo "$match")
     + 		fi
       	fi
       
     ++	if test "${GIT_COMPLETION_IGNORE_CASE:+1}" = "1"
     ++	then
     ++		# uppercase with tr instead of ${match,^^} for bash 3.2 compatibility
     ++		umatch=$(echo "$match" | tr a-z A-Z 2>/dev/null || echo "$match")
     ++	fi
     ++
       	if [ "$list_refs_from" = path ]; then
     -@@ contrib/completion/git-completion.bash: __git_refs ()
     + 		if [[ "$cur_" == ^* ]]; then
     + 			pfx="$pfx^"
       			fer_pfx="$fer_pfx^"
       			cur_=${cur_#^}
       			match=${match#^}
     @@ contrib/completion/git-completion.bash: __git_refs ()
      +			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
       			esac
       			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
     - 				$ignore_case \
     + 				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
      @@ contrib/completion/git-completion.bash: __git_refs ()
       		else
       			local query_symref
     @@ t/t9902-completion.sh: test_expect_success 'checkout matches case insensitively
      +
      +test_expect_success 'checkout completes pseudo refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
      +	(
     -+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
     -+		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&
     ++		GIT_COMPLETION_IGNORE_CASE=1 &&
      +		test_completion "git checkout h" <<-\EOF
      +		HEAD Z
      +		EOF

-- 
gitgitgadget
