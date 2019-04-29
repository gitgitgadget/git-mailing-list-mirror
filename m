Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3804F1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfD2GVE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38608 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2GVE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:04 -0400
Received: by mail-it1-f196.google.com with SMTP id q19so14633413itk.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wdDpwdWG5IRAnaK1ZLVNMRX2vAFTpQbjaugMNUnKizI=;
        b=saP1+cX6aEYnCmF52zyhM9pZM+l0BjWCzXoU0B1pv5eqbY6hI15zQWoJyGsxyptsw/
         b4Fn6s00iXFAlSFLRAQ2e9DcIV0G1wDjQOI3sk/ImrXYJQvpgtIB2jILjvfQrbIOmtCX
         olJf/5BY19u683LgRPANekA/G3J23dAIGVSrcjAd9ee1ZdIBzS8FdILxeHl+90Auvj5P
         s4warstdHz1lkiXtaBG9ZH/wDFLzqj2CUg+enJJcyxf3LB4QPdNUxQHCe8o/D2ldr6DW
         HCpbechws2uQypiFzbRUCiwIXX4XZdfDaYZN2kq4n1ug2CpaiH/8FhckdYaoQnQYZuND
         AxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdDpwdWG5IRAnaK1ZLVNMRX2vAFTpQbjaugMNUnKizI=;
        b=kyBzO1Z4cRbx/CzVNuLkT5G3pF95OqrfuBLmm0DQkdIyA4hD20L4UYHXD6rmBnhzQA
         qhsWCSZWERh9wSbLbWyVLGPZwSUN7JFAJdapeY18nxXGbILeSBo0gv9inurUAMI3h65v
         GBdWpa5gUZzGFrq21vJbpJvT1Fwz2JxbqAxUQ/tg5+r5Z80pbcbPPBoh02pan0hVdKwW
         x0fkDV+UWUuLe37zvWNeTJvpwgpuwHVC75RFC/0iYLtyToIG6Xz6AfGg0fjA8hr9+jYo
         kcckf9fWV1mjdyS6nNO7E+I3/0/Fes4yIOyWe6MWaV9AHhWwQSSH3ype/rxh7/ufThRK
         ugqg==
X-Gm-Message-State: APjAAAX2pKfk6XLfhgHrQXGTvNDswQEGzL+AL/ZjXO32MQdFX4cJyitw
        ymiRnNfb50jjxsJCXjuLNOHa46Cq
X-Google-Smtp-Source: APXvYqz56b7hlnoksw+p9XrYTJDQbXeh6pjLZaNWK8ei44ePXAflzfuDGMgpw7TOpoYX/hKDW4m89w==
X-Received: by 2002:a24:1fcd:: with SMTP id d196mr17073742itd.19.1556518862467;
        Sun, 28 Apr 2019 23:21:02 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id r142sm16393363itb.20.2019.04.28.23.21.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:01 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:20:58 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/7] difftool and mergetool improvements
Message-ID: <cover.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556185345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi David, thanks for the comments.

I'm not really sure why I did the double-negative thing... It seems
obvious that it should be the other way around. I also unrolled the
loops and wrote a gui_mode function.

Good suggestions!

---

Changes since v4:

* Remove double-negative
* Change double-nested search loop into one for-loop
* Create gui_mode function
* Change an instance of "exclusive" to "mutually exclusive"

Changes since v3:

* Move nested for into a subshell so that IFS does not leak out of
  function

Changes since v2:

* Unsuppress output in t7610
* Make `get_merge_tool` return 1 on guessed so we don't have to deal
  with parsing '$guessed:$merge_tool'

Changes since v1:

* Introduce get_merge_tool_guessed function instead of changing
  get_merge_tool
* Remove unnecessary if-tower in mutual exclusivity logic

Denton Liu (7):
  t7610: unsuppress output
  t7610: add mergetool --gui tests
  mergetool: use get_merge_tool function
  mergetool--lib: create gui_mode function
  mergetool: fallback to tool when guitool unavailable
  difftool: make --gui, --tool and --extcmd mutually exclusive
  difftool: fallback on merge.guitool

 Documentation/git-difftool.txt       |   4 +-
 Documentation/git-mergetool--lib.txt |   4 +-
 Documentation/git-mergetool.txt      |   4 +-
 builtin/difftool.c                   |  13 +--
 git-difftool--helper.sh              |   2 +-
 git-mergetool--lib.sh                |  47 ++++++--
 git-mergetool.sh                     |  12 +-
 t/t7610-mergetool.sh                 | 163 +++++++++++++++++----------
 t/t7800-difftool.sh                  |  24 ++++
 9 files changed, 180 insertions(+), 93 deletions(-)

Range-diff against v4:
1:  919aa32e20 = 1:  9f9922cab3 t7610: unsuppress output
2:  9a1bb60b20 = 2:  0f632ca6bf t7610: add mergetool --gui tests
3:  a900ce2a6a ! 3:  81dd25d8e2 mergetool: use get_merge_tool function
    @@ -18,8 +18,9 @@
     
         This change is not completely backwards compatible as there may be
         external users of git-mergetool--lib. However, only one user,
    -    git-diffall[1], was found from searching GitHub and Google. It seems
    -    very unlikely that there exists an external caller that would take into
    +    git-diffall[1], was found from searching GitHub and Google, and this
    +    tool is superseded by `git difftool --dir-diff` anyway. It seems very
    +    unlikely that there exists an external caller that would take into
         account the return code of `get_merge_tool` as it would always return 0
         before this change so this change probably does not affect any external
         users.
    @@ -63,7 +64,7 @@
      }
      
      get_merge_tool () {
    -+	not_guessed=true
    ++	is_guessed=false
      	# Check if a merge tool has been configured
     -	merge_tool=$(get_configured_merge_tool)
     +	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
    @@ -71,10 +72,10 @@
      	if test -z "$merge_tool"
      	then
      		merge_tool=$(guess_merge_tool) || exit
    -+		not_guessed=false
    ++		is_guessed=true
      	fi
      	echo "$merge_tool"
    -+	test "$not_guessed" = true
    ++	test "$is_guessed" = false
      }
      
      mergetool_find_win32_cmd () {
-:  ---------- > 4:  27a59e1e27 mergetool--lib: create gui_mode function
4:  abcf91688a ! 5:  40413dbda1 mergetool: fallback to tool when guitool unavailable
    @@ -15,8 +15,41 @@
         3. diff.tool
         4. merge.tool
     
    -    Note that the behavior for when difftool or mergetool are called without
    -    `--gui` should be identical with or without this patch.
    +    The behavior for when difftool or mergetool are called without `--gui`
    +    should be identical with or without this patch.
    +
    +    Note that the search loop could be written as
    +
    +            sections="merge"
    +            keys="tool"
    +            if diff_mode
    +            then
    +                    sections="diff $sections"
    +            fi
    +            if gui_mode
    +            then
    +                    keys="guitool $keys"
    +            fi
    +
    +            merge_tool=$(
    +                    IFS=' '
    +                    for key in $keys
    +                    do
    +                            for section in $sections
    +                            do
    +                                    selected=$(git config $section.$key)
    +                                    if test -n "$selected"
    +                                    then
    +                                            echo "$selected"
    +                                            return
    +                                    fi
    +                            done
    +                    done)
    +
    +    which would make adding a mode in the future much easier. However,
    +    adding a new mode will likely never happen as it is highly discouraged
    +    so, as a result, it is written in its current form so that it's
    +    immediately obvious for future readers.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ -42,41 +75,43 @@
      }
      
      get_configured_merge_tool () {
    --	# If first argument is true, find the guitool instead
    --	if test "$1" = true
    -+	is_gui="$1"
    -+	sections="merge"
    -+	keys="tool"
    -+
    -+	if diff_mode
    - 	then
    +-	if gui_mode
    +-	then
     -		gui_prefix=gui
    -+		sections="diff $sections"
    - 	fi
    - 
    +-	fi
    +-
     -	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
     -	# Merge mode only checks merge.(gui)tool
    --	if diff_mode
    -+	if "$is_gui" = true
    ++	keys=
    + 	if diff_mode
      	then
     -		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
    --	else
    ++		if gui_mode
    ++		then
    ++			keys="diff.guitool merge.guitool diff.tool merge.tool"
    ++		else
    ++			keys="diff.tool merge.tool"
    ++		fi
    + 	else
     -		merge_tool=$(git config merge.${gui_prefix}tool)
    -+		keys="guitool $keys"
    ++		if gui_mode
    ++		then
    ++			keys="merge.guitool merge.tool"
    ++		else
    ++			keys="merge.tool"
    ++		fi
      	fi
     +
     +	merge_tool=$(
     +		IFS=' '
     +		for key in $keys
     +		do
    -+			for section in $sections
    -+			do
    -+				if selected=$(git config $section.$key)
    -+				then
    -+					echo "$selected"
    -+					return
    -+				fi
    -+			done
    ++			selected=$(git config $key)
    ++			if test -n "$selected"
    ++			then
    ++				echo "$selected"
    ++				return
    ++			fi
     +		done)
     +
      	if test -n "$merge_tool" && ! valid_tool "$merge_tool"
5:  9ec39c5af0 ! 6:  c70789b689 difftool: make --gui, --tool and --extcmd mutually exclusive
    @@ -29,7 +29,7 @@
      	test_cmp expect actual
      '
      
    -+test_expect_success 'difftool --gui, --tool and --extcmd are exclusive' '
    ++test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive' '
     +	difftool_test_setup &&
     +	test_must_fail git difftool --gui --tool=test-tool &&
     +	test_must_fail git difftool --gui --extcmd=cat &&
6:  a72009fc3d = 7:  3fd4f46a7c difftool: fallback on merge.guitool
-- 
2.21.0.1033.g0e8cc1100c

