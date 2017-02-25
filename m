Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F3A201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 21:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdBYVWV (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 16:22:21 -0500
Received: from mout.web.de ([212.227.15.4]:54172 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbdBYVWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 16:22:19 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLP9u-1ciI183MW2-000ePA; Sat, 25
 Feb 2017 22:21:49 +0100
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <20170225101307.24067-2-vegard.nossum@oracle.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
Date:   Sat, 25 Feb 2017 22:21:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170225101307.24067-2-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Weq7/rlEVbI0kfVglGpj4VBMclvEN3VMB6z5HhB/GPR/uxEISSg
 Onsw5gqLoVj9ZFYittSBrnEdMj/tEq8J1jHIirNqOmcGPcNgObLU1XXo8t1m0LIJ3NOps9V
 LFXrSPt10+9aAJ+K8u++YVT8Fg9WBP7KG72ytk9fTldy53OkMeVk79GUQfiYTGDuVuOr8cx
 pbfWQ12UdIl+OVOUAOrUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IjW4/FrJRXU=:ci5Ouz9r1s3YWDaneInGPC
 TTG9gyBeO3EnSZ54pb0KKM2GdDIlHfcorIKrunD6m72lA9K159GR6ogkIhdRNhQ+n0/D58kFk
 gyLCBzpA+TXjM11lq4ZmlhwSgNT66/+d8lF0EwA78vvfn5gqxkbQi/gh+QuC8x5EppREoAbkQ
 YLoOhew9TZiWDOE6pLmoh5n60Le5fJ/zDKkLA/jyfToK9fFaQ5B2H5U05fmTXytXRG3iH6Jlw
 vcD5hdSmqvA8u1+HEuLff5Lw7KopBr5PsAGuOs4NE74t/jj39H6FFPuMlKJY0QE2kHIBq9RAP
 +rV9L7huU8CVBBhGEE5mU0JuXDLdrfUypB+u8XJOxFb4UwpNylfR+QWqas3dzKvvXv9njA5De
 7ZkExE+6q7H/LC+9TQC5eN3V+MaK07+D/zK/xlz67e/w9iif5OKuO+m6lrTlylZrwPEW0oW+9
 fwyJC9/8f0KHdReFkaKgTU8m3uZgPEEnANyle4E0kxhmm4rQs4xtHCt7EjzF33WYkvYHFWIIA
 jKhMPmQuHOdwyfNrwwVIwW5kdMAkcncsQmNv61NYMKUU+bquugtP+LPlecbHzdTuiSfex6MxM
 9AbUvCqYAuewIEYXDG/FVMNt3rtnATgUFff2/JbzSdY0KieejuSOYPORZLFtcqX2PRrrFFqDA
 sz+/pOeblrbvEu721e9lp7Z5YOLW3UNLnDJEXYHVBw92fh3S78+R2qIPxJ0aGGAHFA1EyB/Ia
 GJZZocsCOTLx9ovOiQN0rbJCrX0qFAy8rpIHmu5BCopi9sqkqWWLrDJVoi5m5Dgh/LMYaGsu4
 mdcGnIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 11:13 schrieb Vegard Nossum:
> For the patches in the added testcases, we were crashing with:
>
>     git-apply: apply.c:3665: check_preimage: Assertion `patch->is_new <= 0' failed.
>
> As it turns out, check_preimage() is prepared to handle these conditions,
> so we can remove the assertion.
>
> Found using AFL.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>
> ---
>
> (I'm fully aware of how it looks to just delete an assertion to "fix" a
> bug without any other changes to accomodate the condition that was
> being tested for. I am definitely not an expert on this code, but as far
> as I can tell -- both by reviewing and testing the code -- the function
> really is prepared to handle the case where patch->is_new == 1, as it
> will always hit another error condition if that is true. I've tried to
> add more test cases to show what errors you can expect to see instead of
> the assertion failure when trying to apply these nonsensical patches. If
> you don't want to remove the assertion for whatever reason, please feel
> free to take the testcases and add "# TODO: known breakage" or whatever.)
> ---
>  apply.c                     |  1 -
>  t/t4154-apply-git-header.sh | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index cbf7cc7f2..9219d2737 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
>  	if (!old_name)
>  		return 0;
>
> -	assert(patch->is_new <= 0);

5c47f4c6 (builtin-apply: accept patch to an empty file) added that line. 
  Its intent was to handle diffs that contain an old name even for a 
file that's created.  Citing from its commit message: "When we cannot be 
sure by parsing the patch that it is not a creation patch, we shouldn't 
complain when if there is no such a file."  Why not stop complaining 
also in case we happen to know for sure that it's a creation patch? 
I.e., why not replace the assert() with:

	if (patch->is_new == 1)
		goto is_new;

>  	previous = previous_patch(state, patch, &status);
>
>  	if (status)
> diff --git a/t/t4154-apply-git-header.sh b/t/t4154-apply-git-header.sh
> index d651af4a2..c440c48ad 100755
> --- a/t/t4154-apply-git-header.sh
> +++ b/t/t4154-apply-git-header.sh
> @@ -12,4 +12,40 @@ rename new 0
>  EOF
>  '
>
> +test_expect_success 'apply deleted file mode / new file mode / wrong mode' '
> +	test_must_fail git apply << EOF
> +diff --git a/. b/.
> +deleted file mode
> +new file mode
> +EOF
> +'
> +
> +test_expect_success 'apply deleted file mode / new file mode / wrong type' '
> +	mkdir x &&
> +	chmod 755 x &&
> +	test_must_fail git apply << EOF
> +diff --git a/x b/x
> +deleted file mode 160755
> +new file mode
> +EOF
> +'
> +
> +test_expect_success 'apply deleted file mode / new file mode / already exists' '
> +	touch 1 &&
> +	chmod 644 1 &&
> +	test_must_fail git apply << EOF
> +diff --git a/1 b/1
> +deleted file mode 100644
> +new file mode
> +EOF
> +'
> +
> +test_expect_success 'apply new file mode / copy from / nonexistant file' '
> +	test_must_fail git apply << EOF
> +diff --git a/. b/.
> +new file mode
> +copy from
> +EOF
> +'
> +
>  test_done
>
