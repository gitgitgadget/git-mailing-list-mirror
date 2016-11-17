Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9D41FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbcKQU7v (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 15:59:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:63157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbcKQU7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 15:59:51 -0500
Received: from [192.168.178.43] ([88.71.246.160]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVayZ-1cHBUJ1kid-00Z1og; Thu, 17
 Nov 2016 21:59:48 +0100
Subject: Re: [PATCH v15 11/27] bisect--helper: `bisect_next_check` &
 bisect_voc shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1adb-ab4c90ed-d084-40b5-a037-f62c76e52ec4-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <b78a4cbf-86ed-938e-1d41-6c48e0df981e@gmx.net>
Date:   Thu, 17 Nov 2016 21:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1adb-ab4c90ed-d084-40b5-a037-f62c76e52ec4-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GzykwUTO6y8rHl/Aa99CDTSSnqpCM5aWVcWs6hl7hovbrcqTx2U
 bRylCYvZut8h0CVNTjvrMJOstNucP9V6PGbuKz448HRJkRkR/uxLYqGXOz9XiqEzAkuQfar
 V/HGsXb41Z1u0IyxDtem110dklI1r3ErgAmtfdms+vAJFGDSk1uqDyXjLSU2qCDc5C58QYj
 SxHCZ3GnM5KxMqB4OPa5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xfNIIvzA268=:pbniZ2j0kZDodBDkHNR7Z2
 tPM67Oax1ABUQ5cN8jF1dXCnuvHRcDrnmGUUwRK/RddJncKUwEXEnqvPQZ6F+579G6ZwNWET/
 /WF0hYH2eyyRjcgE7LOgs0JHNvUMW8Smk6fqTJugG4OtWGY/lItZx90OmAfwxJhxJV4fuvJTc
 KYX6SnO096ycTAoqtDj0FKQaWXY3hkpl8517G+/rawy7OS4eUvMKJs6XIm10m1mowL9/ceW3f
 rc/Mc9zjiXggFhLkCgxpDjPEjJSDQfZM6UeennROSfsLmloTEnrlP0nwZaWGqwdAT/2V4pktN
 GHdFlU9poo2ylzJWnF6cnxiXGJkP9ZFC+OuqTqlX0HXYNERaOqUo5n5HpbDeT/K+MTCwSb5gp
 ZyrhBxCK+g+DToHHuQPFjZMejJvV/bIh6ky54Z9TXvmnv7d0Tl356qc9w6wyrWjVe+pe34GRK
 wQKaFk0aF3h6/bYTX3pxWuI16aPkrN8n31+7iXYzYKNmDznK8EVcT27ZXCmsGHgHVPml3cnLJ
 /34IUm636UZczCl+vGVrGfcoYOFGdZrUVRu3YMqLKqXLgKDRqAMBcnLV6Rd/f/t1W3+e0j2so
 ARRQfR+PucmGqQD2ztm2KU65+e9xoWcxpJCn6UWthTrdGmPnqlUTTpqHryKjBTn8ouXP5nGNM
 LyeT1Cd2HdsvuZaMbolkf5Ca3vHFlR3zG3wWwF+8CGuOTlVm6b67riDs2BykLakWyYbQW2ezU
 KJAgdtGqFHpDBTmrTY2h2b5OiYVz/NGEctYAZvBOMuAtdAMQpvVMYUKUeo3g0sixsklGTilGW
 N95zKLF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> Also reimplement `bisect_voc` shell function in C and call it from
> `bisect_next_check` implementation in C.

Please don't! ;D

> +static char *bisect_voc(char *revision_type)
> +{
> +	if (!strcmp(revision_type, "bad"))
> +		return "bad|new";
> +	if (!strcmp(revision_type, "good"))
> +		return "good|old";
> +
> +	return NULL;
> +}

Why not simply use something like this:

static const char *voc[] = {
	"bad|new",
	"good|old",
};

Then...

> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good = 1, missing_bad = 1, retval = 0;
> +	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
> +	char *good_glob = xstrfmt("%s-*", terms->term_good);
> +	char *bad_syn, *good_syn;

...you don't need bad_syn and good_syn...

> +	bad_syn = xstrdup(bisect_voc("bad"));
> +	good_syn = xstrdup(bisect_voc("good"));

...and hence not these two lines...

> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
> +		error(_("You need to give me at least one %s and "
> +			"%s revision. You can use \"git bisect %s\" "
> +			"and \"git bisect %s\" for that. \n"),
> +			bad_syn, good_syn, bad_syn, good_syn);

...and write
			voc[0], voc[1], voc[0], voc[1]);
instead...

> +		retval = -1;
> +		goto finish;
> +	}
> +	else {
> +		error(_("You need to start by \"git bisect start\". You "
> +			"then need to give me at least one %s and %s "
> +			"revision. You can use \"git bisect %s\" and "
> +			"\"git bisect %s\" for that.\n"),
> +			good_syn, bad_syn, bad_syn, good_syn);

...and here
			voc[1], voc[0], voc[0], voc[1]);
...

> +		retval = -1;
> +		goto finish;
> +	}
> +	goto finish;
> +finish:
> +	if (!bad_ref)
> +		free(bad_ref);
> +	if (!good_glob)
> +		free(good_glob);
> +	if (!bad_syn)
> +		free(bad_syn);
> +	if (!good_syn)
> +		free(good_syn);

...and you can remove the 4 lines above.

> +	return retval;
> +}

Besides that, there are again some things that I've already mentioned
and that can be applied here, too, for example, not capitalizing
TERM_GOOD and TERM_BAD, the goto fail simplification, the terms memory leak.

Cheers
Stephan
