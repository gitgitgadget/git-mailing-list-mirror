Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498001F404
	for <e@80x24.org>; Fri,  6 Apr 2018 15:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeDFPj5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 11:39:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:59233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbeDFPj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 11:39:56 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSx9-1f5rRe2EG3-00371B; Fri, 06
 Apr 2018 17:39:49 +0200
Date:   Fri, 6 Apr 2018 17:39:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 3/5] stash: convert drop and clear to builtin
In-Reply-To: <20180405022810.15796-4-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061712230.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-4-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bn7UyfHVA9QPghOKrLHGGZIPZIJ820txPhun3OO8aTCPZlmyDCe
 hTYOxqxTj1HUEoAuYi6vqWvPvTwndb3JAvOPWgRVNL2byfKARf70RqMcGIV6p0t/4Mb+E62
 btnmDQg6KSkSFwdxkAjTTyNgK4yyzTgBkCsdFLw1ErgUSrcb4vZ0uUMEUrvT/fIDefjteYl
 aWf9Rw+oOj23zcEUcGiGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xhow8/CPeoo=:czG6l0Msb1+QzXu5A6rVWW
 /85Y5M1ipOkyiLu6S79akDsX53wgApATopzfbeBd/lXVtjTnCKOXSShv1WvCKxOwBh5TEV3cS
 t1MfgZeh4GND0E1dW1hPiq0HrqK+cUIqQfArZ1ft8MSbM21iuO1gEsW4jWc1xJQS/L7qhJ3h6
 /ZO3eFfA7qjgxShNCUZNTr/NHBBl/5+8/R3ZOvGT0RSpWulARgkE+Bm6o5DtJuZ1ZJ7RdvYoy
 JZj4TVo4C0RBCxRKFp7bMK3KuGOlAowEDTP50SQpIU1R0K1X5XNkN4pa//ssM+HhvNPerHlvh
 eSxB1a6oKR2DVkF3ncB93dvl8WAUTy8e289GkrvWNqJbOTkzT13EZ/WeIaAaD/Zpgra0vdxWS
 /Z5ps+3QZ5MmvNH5nUygl9Rz7NIm4Zw9JfIzWzj4oh+gLMQzB45HoaWtcQvHZwm2lsWvlPelT
 6VsIM+LhNZZskGH2ezTB2n/JpuCBqlFMm9gOqO7emcRIKhf2udCoGfQXMOfMiRhYMvCr2DjQ7
 35G7xQSqwHFFv5NHLFDnEPSH2XBj/1d43LaMccSc5cBQKNkpl2px+h5JyrPvGf9W7EBqM/HOR
 ftkfiAHrXQKZr1YIIAL4kcila2paYMPvPDtuhuOXQIq4+wqnrc7i/ioOmdQvKeRlqmtFgVeCP
 xPG1lruSQMf+OxHpIiQKdRewSdGp4LePofaG+tKH3lfcOPIseKS7KF4xRoGc5+t4zeR2By7Ax
 cf7iUG3j5r29gXEzFOn2zIXuMLw0vgP50HJugTBquwvL1AJEOaudM/Cy/X4YDw+zcaHf7Xkj2
 1XpqXYrcE8QHw39sHwWaB4hk7/2+3idgcCGVvW4NBRFYpBlG7oSP/ISeVRIDsKHz6xEtJZ6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> Add the drop and clear commands to the builtin helper. These two
> are each simple, but are being added together as they are quite
> related.

Makes sense.

> We have to unfortunately keep the drop and clear functions in the
> shell script as functions are called with parameters internally
> that are not valid when the commands are called externally. Once
> pop is converted they can both be removed.

Excellent explanation.

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 9d00a9547d..520cd746c4 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -134,6 +146,29 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>  	return 0;
>  }
>  
> +static int do_clear_stash(void)
> +{
> +	struct object_id obj;
> +	if (get_oid(ref_stash, &obj))
> +		return 0;
> +
> +	return delete_ref(NULL, ref_stash, &obj, 0);
> +}
> +
> +static int clear_stash(int argc, const char **argv, const char *prefix)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, git_stash_helper_clear_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (argc != 0)
> +		return error(_("git stash--helper clear with parameters is unimplemented"));
> +
> +	return do_clear_stash();
> +}
> +
>  static int reset_tree(struct object_id *i_tree, int update, int reset)
>  {
>  	struct unpack_trees_options opts;
> @@ -399,6 +434,74 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int do_drop_stash(const char *prefix, struct stash_info *info)
> +{
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	int ret;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/* reflog does not provide a simple function for deleting refs. One will
> +	 * need to be added to avoid implementing too much reflog code here
> +	 */
> +	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite", NULL);
> +	argv_array_push(&args, info->revision.buf);
> +	ret = cmd_reflog(args.argc, args.argv, prefix);
> +	if (!ret) {
> +		if (!quiet)
> +			printf(_("Dropped %s (%s)\n"), info->revision.buf, oid_to_hex(&info->w_commit));

This is a correct conversion. In the future, we will want to print this to
stderr, though.

> +	} else {
> +		return error(_("%s: Could not drop stash entry"), info->revision.buf);
> +	}
> +
> +	/* This could easily be replaced by get_oid, but currently it will throw a
> +	 * fatal error when a reflog is empty, which we can not recover from
> +	 */
> +	cp.git_cmd = 1;
> +	/* Even though --quiet is specified, rev-parse still outputs the hash */
> +	cp.no_stdout = 1;
> +	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
> +	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
> +	ret = run_command(&cp);

Since we already have `grab_oid()` (or `get_oidf()` if you heed my
suggestion), we could use that here right away.

> +
> +	if (ret)
> +		do_clear_stash();

I was a bit puzzled why we clear the entire stash when we only wanted to
drop one? Going back to the shell script, there is this helpful comment:

	# clear_stash if we just dropped the last stash entry

Can you please add that comment here, too? It really helps readers, such
as myself...

> +
> +	return 0;
> +}
> +
> +static int assert_stash_ref(struct stash_info *info)
> +{
> +	if (!info->is_stash_ref)
> +		return error(_("'%s' is not a stash reference"), info->revision.buf);
> +
> +	return 0;
> +}

I am a bit curious why that did not appear in the previous patch, as
`apply_stash()` in the shell script already called `assert_stash_ref()`...

The rest of the patch looks pretty good to me! Thank you.

Ciao,
Dscho
