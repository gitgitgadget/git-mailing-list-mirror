Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015CA1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 08:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfDWIyA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 04:54:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 04:54:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7262475pgl.5
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxMRWAVx29917QCL7d03SOysm2dpwHyRMmq4quO0U0A=;
        b=oIiKiubwtAZSMC6YyXi5D3koAZmzfXwemM4yETNa8mwdJv3EOOwTqpn4vE8ljoRA+T
         saqBX7xFYNNtzjq78xfxnmaXTW1/FZlX3uGWxw6U89C39LZOWEbgEAKPXsGvEKXNB9SN
         YSF/8Oa5hcGVyi6HHtDMzhXey8clk7lQ2TpULxSIaeTbfOPxRKvL8NhmCGUCCJrAho9t
         4boWWsJSri07F1/KAf/HAa2ZEb6N2nq4jOy7+C15e5XiEgCtk5nP71Kgj7RzyUbVYd72
         PO4y4BGAlgaityPfeBxc5b9weyuJ3aRTYXq2iwWW854Ikrzd9zI3LqXJPrycY8m1eQ/L
         532w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxMRWAVx29917QCL7d03SOysm2dpwHyRMmq4quO0U0A=;
        b=FZ0XAMlgLtRmFeTm8/pYFmuCe5Q6YoKA1rqhLmpGgZYclTe94ccwbPOQJS7WtNAVTw
         Q8R/CDYjVXWv3ZlYFS0tdkIw1AQDxgcTXkZsZ8T9vP3Bp5dLz9YIEl6oEGhxCbjXJiuX
         593ZfJfi/NYwC8E5+ZJI0GEwDamxmjGgqBZ2iGe0Yc3OHAfPFqGUd2LI/KrTfwccXSAt
         uhuiL4g3b7EVVcy2xNlg/4tnlf+GC/fG/QujgXSuSFHNXlqzVcj7UT4Tby//Zq2H9irH
         fkksw3fBDy4gEG108eiCK7qcH4BsSxGIpv+pB8rGgsvPDT2xWa2rQGO1QmNuFB1ablfi
         Z8UQ==
X-Gm-Message-State: APjAAAX+m3/b0WsgH/eALx3xk5PMldSMQFGU56vJ+hlgJ5X8k++byWUP
        TqYIvp2yIhAUTOZb/L6a5PyOYZsZ
X-Google-Smtp-Source: APXvYqyzsqduXZo90qiFALxvW+iUKNbpFY9wrdcaYtX+G7H8ZOrOV0YO4ODStrA1cbf4czW+cjhfQw==
X-Received: by 2002:a62:1194:: with SMTP id 20mr25664084pfr.224.1556009638466;
        Tue, 23 Apr 2019 01:53:58 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k5sm4560184pgi.58.2019.04.23.01.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:53:57 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:53:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] difftool and mergetool improvements
Message-ID: <cover.1556009181.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555880168.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Eric.

Hopefully, these changes have addressed the concerns that you've raised.

---

Changes since v1:

* Introduce get_merge_tool_guessed function instead of changing
  get_merge_tool
* Remove unnecessary if-tower in mutual exclusivity logic

Denton Liu (5):
  t7610: add mergetool --gui tests
  mergetool: use get_merge_tool_guessed function
  mergetool: fallback to tool when guitool unavailable
  difftool: make --gui, --tool and --extcmd mutually exclusive
  difftool: fallback on merge.guitool

 Documentation/git-difftool.txt       |  4 ++-
 Documentation/git-mergetool--lib.txt |  9 +++++-
 Documentation/git-mergetool.txt      |  4 ++-
 builtin/difftool.c                   | 13 ++++-----
 git-mergetool--lib.sh                | 39 ++++++++++++++++++--------
 git-mergetool.sh                     | 11 ++------
 t/t7610-mergetool.sh                 | 41 ++++++++++++++++++++++++++++
 t/t7800-difftool.sh                  | 24 ++++++++++++++++
 8 files changed, 114 insertions(+), 31 deletions(-)

Range-diff against v1:
1:  678f9b11fc = 1:  678f9b11fc t7610: add mergetool --gui tests
2:  692875cf4b ! 2:  e928db892e mergetool: use get_merge_tool function
    @@ -1,15 +1,19 @@
     Author: Denton Liu <liu.denton@gmail.com>
     
    -    mergetool: use get_merge_tool function
    +    mergetool: use get_merge_tool_guessed function
     
         In git-mergetool, the logic for getting which merge tool to use is
         duplicated in git-mergetool--lib, except for the fact that it needs to
         know whether the tool was guessed or not.
     
    -    Rewrite `get_merge_tool` to return whether or not the tool was guessed
    -    and make git-mergetool call this function instead of duplicating the
    -    logic. Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not
    -    the guitool will be selected.
    +    Write `get_merge_tool_guessed` to return whether or not the tool was
    +    guessed in addition to the actual tool and make git-mergetool call this
    +    function instead of duplicating the logic. Also, let
    +    `$GIT_MERGETOOL_GUI` be set to determine whether or not the guitool will
    +    be selected.
    +
    +    Make `get_merge_tool` use this function internally so that code
    +    duplication is reduced.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ -17,38 +21,32 @@
      --- a/Documentation/git-mergetool--lib.txt
      +++ b/Documentation/git-mergetool--lib.txt
     @@
    + 
      FUNCTIONS
      ---------
    - get_merge_tool::
    --	returns a merge tool.
    ++get_merge_tool_guessed::
     +	returns '$is_guessed:$merge_tool'. '$is_guessed' is 'true' if
     +	the tool was guessed, else 'false'. '$merge_tool' is the merge
     +	tool to use. '$GIT_MERGETOOL_GUI' may be set to 'true' to search
     +	for the appropriate guitool.
    ++
    + get_merge_tool::
    +-	returns a merge tool.
    ++	returns a merge tool. '$GIT_MERGETOOL_GUI' may be set to 'true'
    ++	to search for the appropriate guitool.
      
      get_merge_tool_cmd::
      	returns the custom command for a merge tool.
     
    - diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
    - --- a/git-difftool--helper.sh
    - +++ b/git-difftool--helper.sh
    -@@
    - 	then
    - 		merge_tool="$GIT_DIFF_TOOL"
    - 	else
    --		merge_tool="$(get_merge_tool)" || exit
    -+		merge_tool="$(get_merge_tool | sed -e 's/^[a-z]*://')" || exit
    - 	fi
    - fi
    - 
    -
      diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
      --- a/git-mergetool--lib.sh
      +++ b/git-mergetool--lib.sh
     @@
    + 	echo "$merge_tool_path"
      }
      
    - get_merge_tool () {
    +-get_merge_tool () {
    ++get_merge_tool_guessed () {
     +	is_guessed=false
      	# Check if a merge tool has been configured
     -	merge_tool=$(get_configured_merge_tool)
    @@ -61,6 +59,10 @@
      	fi
     -	echo "$merge_tool"
     +	echo "$is_guessed:$merge_tool"
    ++}
    ++
    ++get_merge_tool () {
    ++	get_merge_tool_guessed | sed -e 's/^[a-z]*://'
      }
      
      mergetool_find_win32_cmd () {
    @@ -81,7 +83,7 @@
     -			guessed_merge_tool=true
     -		fi
     +		IFS=':' read guessed_merge_tool merge_tool <<-EOF
    -+		$(GIT_MERGETOOL_GUI=$gui_tool get_merge_tool)
    ++		$(GIT_MERGETOOL_GUI=$gui_tool get_merge_tool_guessed)
     +		EOF
      	fi
      	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
3:  de1b897a11 = 3:  24db1afeee mergetool: fallback to tool when guitool unavailable
4:  a272594bd2 = 4:  6f65b5c913 difftool: make --gui, --tool and --extcmd mutually exclusive
5:  4fc3f84bad = 5:  5a24772219 difftool: fallback on merge.guitool
-- 
2.21.0.1000.g11cd861522

