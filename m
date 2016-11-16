Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C972042F
	for <e@80x24.org>; Wed, 16 Nov 2016 23:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938703AbcKPXr2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 18:47:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:53619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbcKPXr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 18:47:26 -0500
Received: from [192.168.178.43] ([92.76.229.29]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKu9E-1c79vG3IWG-0001Ye; Thu, 17
 Nov 2016 00:47:22 +0100
Subject: Re: [PATCH v15 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
Date:   Thu, 17 Nov 2016 00:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0paru9MzjPkPSiYiop87acHV0+nOuDTl2ckCTCzPRceywZOaSyY
 1m3MUYaw6IBQ/a46x9uF1cxHmFj0y6DgCfQXLsG9W+7hVriW4Kmbae4LxpSjDu9ZolSG1qa
 Q1Ck+o3OjHa9fvVsbpa3xOFMud4oxW7oQr/zZrjyDy0VX1ZXQbnoBMQFno9XB+jV+bS5kpf
 iKG0Hify3+yPo5F2CDv5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cJCMoi8H9b4=:CHWlIAB2ZT4tkq7K2WSQsd
 eDjvVqo75zuKziNYdzTC8jVvDdNByW2PNVNLfIK69VGNdltN7Rgj4aKZYi3QZoi6Xi2ga09HR
 frhtGhuTuChW8rmDP78EvdF77HTgQQmQ30W0I8FBUVgbJNPQ0EWton+Gpmx8T61Osd5z8aY/z
 2ALlBVX8YXBppUzc5gBENnqM/w4QlEVmpB+d1cbXrkLjVcAYe/vC5HSon3us6OFwNQkGq/fDA
 E4i0B+UwbwCF8LG22XEKfNLnKcbMX+kmpFwleVWFkZcfV7kEZsHGBLm0uqxnjX6TKFilNgmBK
 OmqB6gXD/EGsF/mcYd0BDiq/tqsXbA/UnNracyeXjHdQUvfRk7XbK9g0xYk3qOhRczkNkK506
 VrJclcCOz23hnagX8srwKEJHMQMpcmksWg01LuAPuhmrt/pONnoCM5QjNfwzk+KG4b4SKKNtN
 42M2UB90niDCvuWNp65Rv22cUnmMdhfKPJM4KDTNyjWfKGrkStIbQG0uYQj1ABKyu+M1NUd1K
 XWJFzlykAv4eIa1saqp2WFUhi/oEKM6Npo0jo5atHNcz8tAyC5yE4vzD+gj25VKUwGdehUSRB
 dt+JqzvqChp0hxKz6xxq6VP4TxG0NzdiVbxwkxzISJ3ThctF2ySvnsU5hUHlVCpF7sXJvIfkM
 +cYHOKimh3Xad+fiTpuwKrQC/lEpFKT4eu/4sd9QUswlRXrCUXexkJLizIzJlrVby9JEifylB
 rDhByoFBCqIch+Ama4C+gg5x2kv8Xy3I3BK59L+asYDiXuEHUvJtdzICcSW/0dmubf/Fzihtw
 xi+Kej+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index d84ba86..c542e8b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -123,13 +123,40 @@ static int bisect_reset(const char *commit)
>  	return bisect_clean_state();
>  }
>  
> +static int is_expected_rev(const char *expected_hex)
> +{
> +	struct strbuf actual_hex = STRBUF_INIT;
> +	int res = 0;
> +	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
> +		strbuf_trim(&actual_hex);
> +		res = !strcmp(actual_hex.buf, expected_hex);
> +	}
> +	strbuf_release(&actual_hex);
> +	return res;
> +}

I am not sure it does what it should.

I would expect the following behavior from this function:
 - file does not exist (or is "broken") => return 0
 - actual_hex != expected_hex => return 0
 - otherwise return 1

If I am not wrong, the code does the following instead:
 - file does not exist (or is "broken") => return 0
 - actual_hex != expected_hex => return 1
 - otherwise => return 0

> +static int check_expected_revs(const char **revs, int rev_nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < rev_nr; i++) {
> +		if (!is_expected_rev(revs[i])) {
> +			unlink_or_warn(git_path_bisect_ancestors_ok());
> +			unlink_or_warn(git_path_bisect_expected_rev());
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}

Here I am not sure what the function *should* do. However, I see that it
basically mimics the behavior of the shell function (assuming
is_expected_rev() is implemented correctly).

I don't understand why the return value is int and not void. To avoid a
"return 0;" line when calling this function?

> @@ -167,6 +196,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		if (argc > 1)
>  			die(_("--bisect-reset requires either zero or one arguments"));
>  		return bisect_reset(argc ? argv[0] : NULL);
> +	case CHECK_EXPECTED_REVS:
> +		return check_expected_revs(argv, argc);

I note that you check the correct number of arguments for some
subcommands and you do not check it for some other subcommands like this
one. (I don't care, I just want to mention it.)

>  	default:
>  		die("BUG: unknown subcommand '%d'", cmdmode);
>  	}

~Stephan
