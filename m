Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75CE51F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGNV0P (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:26:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:60455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbeGNV0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 17:26:14 -0400
Received: from MININT-3BS5S37.fareast.corp.microsoft.com ([37.201.195.126]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MSduu-1fWdiI1Waq-00Rcls; Sat, 14 Jul 2018 23:05:38 +0200
Date:   Sat, 14 Jul 2018 23:05:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>
Subject: Re: [PATCH] sequencer: pass absolute GIT_WORK_TREE to exec
 commands
In-Reply-To: <20180714003505.67650-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1807142304340.75@tvgsbejvaqbjf.bet>
References: <20180713230548.GC1042117@genre.crustytoothpaste.net> <20180714003505.67650-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n9cckntTd5VflW0yabavohVYxo4CFH5ZmMqp0cth24OkBg+Mg6z
 3ZXDc0gzfEzn5XZFUm54KGZokstp0yhCFw0O4y7qixxoKoTPWm4KfvfX1/qCmxQ2gUHCPpC
 KWoDxkTLZ2GCe2yERW01JBzB0Nr4OSuEJ4ekHYChViAGIDtIWeSrVHYSsXKuJJ8hJS0sCRv
 i6EyNzar/IR2A3CGnvOcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ld3PApFWFi4=:teOOX31VOCr6m3FQ2blRlH
 ciUSTnoNRLsksgyjDXo+fYmUYkHnlG5XU0uiBHiCNAlMzfBekRFK3vwqxKSR8Bvk0Re8gFO6t
 OEvJA19tZUxS0wm4sod9hU+eaQJqFjv61yc1ffHALyTQiUvFieejFAMQfEVPm10hpHSNwPDlp
 0rP9SIUvlmOrJwSuRa7HRSWpObW4WIkCzBRI8Dl/Bs/fo/6NLWjmqTZdjG8XJfL+S+MOknqLp
 YEEXspKviLskdxLaFBe1OFrpnRbBFtPBjq7CXGYCkGWCHzSPtN1onBAJRw2QpVDP9Oizdaaga
 LKBohC7lhktTMSwy236ZlqFKQ6T5dAyfahf/ZdhjJYN/ctxnK6BJlmf993piOjO84pM+eOoBX
 V3VDnFCqUS1YqnCgKQro7Y+6Yr7JxVvhQekh+cUMCUYOuS3Gwaf2qT4wLE5HkxK4CjWafqt/3
 efTTbBZdsUkGeBrAF6QY2cP/Ahups3KytE4tuTMHrZnmZcaukRVFO0/24K6pVTVA3LDABR4DO
 ebwQ1EtoXLr57q//mzVNUA7Oo9t2ZB0068eLMxP2sa2uzOHIetaOlXj6+PteV5WvrX+mLEaul
 Trz9ENIpy1E7mBuhxkDm4uja5ollv+iajBxZ/36wva2Tr7xanOlX/fCwjhg56vvqUWS1AjzzP
 JrSmaNKnTnb0fJN/oFsB6HC7zVyJTc7xYp1DiJoKHVOMsofLtzBrZmt0ijTaaZzqIn32E6MGQ
 wmLtTwRYFHvooReHLNFmh8JKxXKTB4f7EMALDGE0P67eClPekiGrBe83UEgbpQ/cr0RUry53+
 ZLuC11N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sat, 14 Jul 2018, brian m. carlson wrote:

> The sequencer currently passes GIT_DIR, but not GIT_WORK_TREE, to exec
> commands.  In that configuration, we assume that whatever directory
> we're in is the top level of the work tree, and git rev-parse
> --show-toplevel responds accordingly.  However, when we're in a
> subdirectory, that isn't correct: we respond with the subdirectory as
> the top level, resulting in unexpected behavior.
> 
> Ensure that we pass GIT_WORK_TREE as well as GIT_DIR so that git
> operations within subdirectories work correctly.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Dscho, is this test going to cause a problem on Windows with the forward
> slash in the grep statement?

It passes on Windows. The reason is that you are asking *Git* for a path,
and Git will always try to use forward slashes (which work on Windows
under most circumstances).

Ciao,
Dscho

>  sequencer.c                   | 2 ++
>  t/t3404-rebase-interactive.sh | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..c8e16f9168 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2636,6 +2636,8 @@ static int do_exec(const char *command_line)
>  	fprintf(stderr, "Executing: %s\n", command_line);
>  	child_argv[0] = command_line;
>  	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> +	argv_array_pushf(&child_env, "GIT_WORK_TREE=%s",
> +			 absolute_path(get_git_work_tree()));
>  	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
>  					  child_env.argv);
>  
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59d..d03055d149 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -119,6 +119,15 @@ test_expect_success 'rebase -i with exec allows git commands in subdirs' '
>  	)
>  '
>  
> +test_expect_success 'rebase -i sets work tree properly' '
> +	test_when_finished "rm -rf subdir" &&
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	mkdir subdir &&
> +	git rebase -x "(cd subdir && git rev-parse --show-toplevel)" HEAD^ \
> +		>actual &&
> +	! grep "/subdir$" actual
> +'
> +
>  test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>  	git checkout master &&
>  	set_fake_editor &&
> 
