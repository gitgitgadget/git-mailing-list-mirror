Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F00202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 11:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCNLZF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:25:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40646 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCNLZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:25:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id r23so4266998edm.7
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EWJ3CPV2rzm+7T628LZHWRJnwCBXUiAhAtcOIOyAmx4=;
        b=uN2wBz85VUVcHio4Hl5/sb78s9WEn+iKBlB2IkVUUdLPxCmjfd+YDZsVDDo/8UzV0z
         +njtk3UhWNF2bl2zO2I2ubvdkkCItNiy2x2OaY2vBi4ZUfUCROohvEshYwpR3Iq1ujiG
         bouN5GY5OR/Q41rgj3XSbmiVMilZ6pUNZ4dbi5A+mbtIvK/m/Uk6SL5rBBL0FenMeQNI
         sssgpljIsO85v4MfzxDk8OPdISJt55z1zlLbL+qj4IZLBa/7jQKc61FJlEqxHyVe+0Dm
         qei4IhfPhirKv7LAyud7/itudcP1oGJysF1N3ixDc5G2jEDCo+KvcORcYF40auwfKMxM
         Wg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EWJ3CPV2rzm+7T628LZHWRJnwCBXUiAhAtcOIOyAmx4=;
        b=i2oYSUmBdpvG9R7VEonYk3j1968ZKz52dsfrwGk89WZ0dXTnTJ3dGA+MjZ8We0gNeZ
         MyRPNaHAH1Oz/4RzYSp8nIA8hamkKvoWt76zZEOOfIrQcwjcr7FwgMul3nUurWTIcAnW
         etW20Ue3RWBiDKp2Yrv+0VpDwNJd5/olLOQr6tnOx5dJOQJgb0iu2xsaOjhud803V8MR
         Fyk1jt1kfFozMyPDKd5k0PPs+yGWmDfQVI6BYBatL27OKX01TwSj2VAbXkDPh8H8x72t
         ywtuH0AUrFGhfjB4oZ+cF4VuSBACitJeV52A2N3TvjniMDaomQFV4/M6mtf0PEs3TGQK
         AB4A==
X-Gm-Message-State: APjAAAVpP+6N5xGeHSyEox0xIns2iqCBuL9ZVl6W0Vv8ltzxStvb6g6P
        5Z8pXwFDxTiVhH7QxyXhzcBqdrX/
X-Google-Smtp-Source: APXvYqzzNPbS3zAixaSS3CU/2aW8c6lyqNTXBB0+6A4p8GGYRHXGD7oFYEYBEJwt8wlcyQmQvRsfNw==
X-Received: by 2002:a50:a484:: with SMTP id w4mr11014533edb.193.1552562703044;
        Thu, 14 Mar 2019 04:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm1301331edq.71.2019.03.14.04.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:25:02 -0700 (PDT)
Date:   Thu, 14 Mar 2019 04:25:02 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 11:24:58 GMT
Message-Id: <pull.163.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.163.git.gitgitgadget@gmail.com>
References: <pull.163.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Allow difftool to be run outside of Git worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported in https://github.com/git-for-windows/git/issues/2123 that 
git difftool --no-index fails to work outside worktrees, even if it should
work.

I fear this is a regression I introduced over two years ago (!) when I
converted the Perl script to C.

At least now that I know about the bug, I can fix it.

Changes since v1:

 * Instead of ad-hoc parsing to look for --no-index, the OPT_ARGUMENT() was
   enhanced and not has its first real user! After all those lonely, long
   years (11 years, 1 month and 11 days), what a wonderful thing to
   celebrate on π day.
 * The test now uses the nongit helper.
 * The test uses test_cmp to make diagnosing regressions easier.

Johannes Schindelin (3):
  difftool: remove obsolete (and misleading) comment
  parse-options: make OPT_ARGUMENT()  more useful
  difftool: allow running outside Git worktrees with --no-index

 Documentation/technical/api-parse-options.txt |  4 +++-
 builtin/difftool.c                            | 14 ++++++++++----
 git.c                                         |  2 +-
 parse-options.c                               |  2 ++
 parse-options.h                               |  4 ++--
 t/helper/test-parse-options.c                 |  2 +-
 t/t7800-difftool.sh                           | 10 ++++++++++
 7 files changed, 29 insertions(+), 9 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-163%2Fdscho%2Fdifftool-no-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-163/dscho/difftool-no-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/163

Range-diff vs v1:

 1:  2ad91f19c5 = 1:  2ad91f19c5 difftool: remove obsolete (and misleading) comment
 -:  ---------- > 2:  10775638ad parse-options: make OPT_ARGUMENT()  more useful
 2:  9f6eb60eee ! 3:  8cca9f800c difftool: allow running outside Git worktrees with --no-index
     @@ -22,24 +22,24 @@
       {
       	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
      -	    tool_help = 0;
     -+	    tool_help = 0, i, no_index = 0;
     ++	    tool_help = 0, no_index = 0;
       	static char *difftool_cmd = NULL, *extcmd = NULL;
       	struct option builtin_difftool_options[] = {
       		OPT_BOOL('g', "gui", &use_gui_tool,
     +@@
     + 			    "tool returns a non - zero exit code")),
     + 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
     + 			   N_("specify a custom command for viewing diffs")),
     ++		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
     + 		OPT_END()
     + 	};
     + 
      @@
       	if (tool_help)
       		return print_tool_help();
       
      -	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
      -	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
     -+	for (i = 0; i < argc; i++)
     -+		if (!strcmp(argv[i], "--"))
     -+			break;
     -+		else if (!strcmp(argv[i], "--no-index")) {
     -+			no_index = 1;
     -+			break;
     -+		}
     -+
      +	if (!no_index && !startup_info->have_repository)
      +		die(_("difftool requires worktree or --no-index"));
      +
     @@ -73,13 +73,13 @@
       '
       
      +test_expect_success 'outside worktree' '
     -+	mkdir outside &&
     -+	echo 1 >outside/1 &&
     -+	echo 2 >outside/2 &&
     -+	test_expect_code 1 env GIT_CEILING_DIRECTORIES="$(pwd)" git \
     ++	echo 1 >1 &&
     ++	echo 2 >2 &&
     ++	test_expect_code 1 nongit git \
      +		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
     -+		-C outside difftool --no-prompt --no-index 1 2 >out &&
     -+	test "1 2" = "$(cat out)"
     ++		difftool --no-prompt --no-index ../1 ../2 >actual &&
     ++	echo "../1 ../2" >expect &&
     ++	test_cmp expect actual
      +'
      +
       test_done

-- 
gitgitgadget
