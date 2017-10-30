Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA9B1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 13:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdJ3NWi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 09:22:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:58684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdJ3NWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 09:22:37 -0400
Received: from [192.168.178.43] ([92.76.242.15]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lmp-1dESnM16Jr-00zZw2; Mon, 30
 Oct 2017 14:22:35 +0100
Subject: Re: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <7d978e14-2eec-23b9-c25f-e6b361101b03@gmx.net>
Date:   Mon, 30 Oct 2017 14:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:H6hUslrbfyXMPpWMtLarXHizAfkEAWwo5G8xSZFvdfuM6D6Z00/
 9s5n3LeY+AxOh0xDdG/ekj5x+dItzfJebLb9tZ3rE9HiTceYCZxHxisKw+Jr+QJQucQzVz1
 eff9uydH1xfC/kpwVLhNx9UptmQbvi4lhhGhQkp8DZ5CByA/i9NWhTbNhhnGku4SzaA4WIQ
 TzZhASdBPFbg+2Fw8x4pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dvD0V0h9d94=:7npLK8DRCJLS4jycaMTyi1
 KJqwUdAL7ZmOfJgtzFRCd7e5/W3pnUXjLgTNRCkaN7l2lAKRzgyecfjVhbi0AnU3vIAfcrTGV
 5CRvo9nVDkejCfvY2cVqhLlob5EJiCiu6eSG8biAWcx4aEMn0fOAi32OD496XjCgcT8dbrvlm
 xwE6gV+FGQiiWHJ4sYqdmv6p7XZ1Jl/c/owfPFzryMPbDdFNb7KQAZ4L+4UTUPB7TQVHF2l6S
 vEdBrKJWx2qfB81/eGOD5MSOKGy8kxKkrzls3hPPOmUcDsIa5ixXoDIJFJEVcjcNUHvSOOtD2
 AXGH/O/64X/fV3P4VZDCoogpA0F+MnZmvBpLWeLUDrSNEwk9pO+6lGmQ3zHiVK089svK53kw6
 Mo+fWq9EhUeP8fSXQLUPz8su1AFckbbNaZWdCsoe0HjVzqw2hDFlbfqf031IK3A03ed8rgDFO
 MAOBhytPrn+jBtBlud/I+Da/SuLxVEKBccZQzRIsJ3FQ6sDdVGulWFMBWD5uunIlcaDHF45f0
 myP4M2HwOycvw4IYYzPHSfUcXUAnT4BfR0P25ep0A1tpFiRBAa3lN072Bxj1qVYbRjD8S5fzs
 A+PhoBQU9WJjCshWon/4un+ERxfKT279YMsZbWbxK6JL6h+l2RylVIgn9m0MWeQZsB3DL21M8
 FLDAHMANTvFbhl0qcoBCQm3z85GTDRGpFNUpfKkh0TdgpXp8XRrSYPBFqxPJmrfc8nlLIrLJm
 lZgjwo3ZTCLKYWhGT1BUGSOVZI6dq/4fVGnRb49l5QvKxzNC5uVBjWO3b/NQC3kiXNLAeMRKk
 CBQ3jAZVN29oXAxiVfgcl5EicP4ecNyPuTfBPsPnWXDsN+6qko=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 10/27/2017 05:06 PM, Pranit Bauva wrote:
> A big thanks to Stephan and Ramsay for patiently reviewing my series and
> helping me get this merged.

You're welcome. ;)

In addition to the things mentioned by the other reviewers, only a minor
thing:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 35d2105f941c6..12754448f7b6a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
[...]> @@ -106,13 +112,48 @@ static void check_expected_revs(const char
**revs, int rev_nr)
>  	}
>  }
>  
> +static int bisect_reset(const char *commit)
> +{
> +	struct strbuf branch = STRBUF_INIT;
> +
> +	if (!commit) {
> +		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
> +			return !printf(_("We are not bisecting.\n"));

This is weird; I had to look up the return value of printf first before
I could understand what you are doing ;) I think that it is meant as a
shortcut for

	printf(_("We are not bisecting.\n"));
	return 0;

but please also express it with these two lines. (Or what is the point
of returning a non-zero value only in the case when nothing could be
printed?)

Best,
Stephan
