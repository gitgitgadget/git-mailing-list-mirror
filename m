Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABFD0201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbdKLUDs (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:03:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:49513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdKLUDr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:03:47 -0500
Received: from [192.168.178.43] ([92.76.226.11]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MarNa-1eTzCN3LXG-00KPWr; Sun, 12
 Nov 2017 21:03:45 +0100
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <214cfc63-79a8-a46f-4440-5e223186f2ff@gmx.net>
Date:   Sun, 12 Nov 2017 21:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JihplmLFnO8mUqm8ucAKUAF+ansQxVYntJQzuRTvOZZyagxgjwc
 GSziCMTXkDjmvHQiY3Cu/+qfTQRVRqaYkKtZ978YXBn4lIkyjkUnYpLSoHSG2m70RM+DbI0
 i/hYtnhT7BplxvK04rFKrmAbsww3nIv0Yrf6sHatHukiZHXoLDZbcG+sWCVvP4HuPgdp63s
 i5XfxlV/tXWcBLN2V7JAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F2jgMUWSSgc=:CGp74Y05IwaQBmi5wB120h
 SFbZnbdcTBtQnAzojgXFu+fPRUbYwBxeM2dVLOzRsMJVEgeOHghGUlN2pIMMFEcjbtfoZOkCa
 JjdLxGNthfHCzt/EEBFIrpev4L5JkaJ7fdTTqPtNlnQbyO6HjxYxCyqAQI4eQdcvCay485GbY
 fPDXuVZEi7QIDFZdidD8k/1x8CVyCoeoktYtgmp7UrjV1OISy+TI3AubUmvhpHubP/1THO/da
 lkBAr1i3vGP/pml0FycsNmvOw/sAMIe7462G4peVbglzFOAX8hJj2rfaS40fFI17NFj44Ma3U
 HacHIVT754qjNbjHX1h+4kjSE5XMJBCP8CVoWJfefPRl6OxHXuZlMyllgfWMxMNpbVFhED9LN
 wf+4aAnbeCBv0OoOG80ingXAoabtH5yHfyFpRppxy69dCLjnY4Wi+A1LVC7qx1x/1cm58IZV6
 +2e9UM1ErfZM4H41D/W04r/T6XIUhL1TGuSovkShHjIfUDvbuI0CxjHz2ZdAVc4Pdb3eThT7D
 e4l/aISc9fGXI2WammMujiv6nmMRJMnqpaycFvap473prsCIZbJsAdS+p0V4qzzIA2QDr25vJ
 ToQ41yCJ/qEytEKh9N1Rr9fPfQm+Pq1Rx7ZXYQXZTFqhTyC/n6ASTqFaZSac/45hlFVGmVBiG
 v39f/SPt+SVkgTiiNi5ufqc1mKaS/dGpxNd+ASLmmk9eiHR2USxmzDOxHY0uSopYI/lQ2outW
 9JkEW2m8Zi6LdODWCsdLFj73yugZ+p2HxykehT3O/aAcnAEggwd/ZWF9JhVY7R9wvdC1B8BhD
 rbw0Zil2CleTJ+/u/PKSXh9eltCZ+j7JJ0dK7M/KbskKfZaWko=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again ;)

On 10/27/2017 05:06 PM, Pranit Bauva wrote:
> @@ -44,6 +46,11 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
>  	terms->term_bad = xstrdup(bad);
>  }
>  
> +static const char *voc[] = {
> +	"bad|new",
> +	"good|old"
> +};
> +
>  /*
>   * Check whether the string `term` belongs to the set of strings
>   * included in the variable arguments.
> @@ -264,6 +271,79 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
>  	return 0;
>  }
>  
> +static int mark_good(const char *refname, const struct object_id *oid,
> +		     int flag, void *cb_data)
> +{
> +	int *m_good = (int *)cb_data;
> +	*m_good = 0;
> +	return 1;
> +}
> +
> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good = 1, missing_bad = 1, retval = 0;
> +	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
> +	const char *good_glob = xstrfmt("%s-*", terms->term_good);
> +
> +	if (ref_exists(bad_ref))
> +		missing_bad = 0;
> +
> +	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> +			     (void *) &missing_good);
> +
> +	if (!missing_good && !missing_bad)
> +		goto finish;
> +
> +	if (!current_term)
> +		goto fail;
> +
> +	if (missing_good && !missing_bad && current_term &&
> +	    !strcmp(current_term, terms->term_good)) {
> +		char *yesno;
> +		/*
> +		 * have bad (or new) but not good (or old). We could bisect
> +		 * although this is less optimum.
> +		 */
> +		fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
> +			terms->term_bad);
> +		if (!isatty(0))
> +			goto finish;
> +		/*
> +		 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +		 * translation. The program will only accept English input
> +		 * at this point.
> +		 */
> +		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
> +		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
> +			goto fail;
> +
> +		goto finish;
> +	}
> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
> +		error(_("You need to give me at least one %s and "
> +			"%s revision. You can use \"git bisect %s\" "
> +			"and \"git bisect %s\" for that.\n"),
> +			voc[0], voc[1], voc[0], voc[1]);
> +		goto fail;
> +	} else {
> +		error(_("You need to start by \"git bisect start\". You "
> +			"then need to give me at least one %s and %s "
> +			"revision. You can use \"git bisect %s\" and "
> +			"\"git bisect %s\" for that.\n"),
> +			voc[1], voc[0], voc[1], voc[0]);
> +		goto fail;

In both of the above "error" calls, you should drop the final "\n"
because "error" does that already.

On the other hand, you have dropped the "\n"s of the orginal error
messages. So it should probably be

 _("You need to give me at least one %s and %s revision.\n"
   "You can use \"git bisect %s\" and \"git bisect %s\" for that.")

and

 _("You need to start by \"git bisect start\".\n"
   "You then need to give me at least one %s and %s revision.\n"
   "You can use \"git bisect %s\" and "\"git bisect %s\" for that.")

Stephan
