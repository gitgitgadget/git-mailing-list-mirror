Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714E82018E
	for <e@80x24.org>; Tue, 23 Aug 2016 10:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757251AbcHWKEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 06:04:38 -0400
Received: from mout.web.de ([212.227.17.12]:53144 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbcHWKD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 06:03:57 -0400
Received: from [192.168.178.36] ([79.237.50.37]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MT8bi-1bkU9e3WX0-00S71u; Tue, 23 Aug 2016 11:56:56
 +0200
Subject: Re: [PATCH v2 7/7] blame: actually use the diff opts parsed from the
 command line
To:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
References: <cover.1471864378.git.mhagger@alum.mit.edu>
 <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fe96d9e6-b306-0b57-8f24-6106b7e285cb@web.de>
Date:   Tue, 23 Aug 2016 11:56:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GOelKzBkMMvuuS658d8IMnmhwuy7Wq8Tjd5dW3WboIHpSMvZKlc
 V8uRdum3j1uPp5cl83Wx2Q2/ZTWEKum5U0kt22C6BHEk2QGebiyew0hVWaEAR8NJBZTAw3/
 9k+n2ebHr4g1nEnPy1vP9qDhIVz92a7yNvA50BYnQ6RGTMC62xaWhRmEUYaj/ruGVZAB0GA
 1/OCj1A7vmm+xkUqeyP2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kZHCMpZeFJE=:1xgoIguWi5llJacZFe2cxl
 ae4DDf5+ozTmAHft5Wq/5vL0rBZkl+Aqf1a0T7HQp+KpB5ybzdgLYYQ97UQcUUKl4mYhiUfvU
 ivSbMpmO5dZ5YDQKg5lkSbS8HpvXbqsW42fkHrV9uuxm+BUzrbKKoxMd/+flU9MsT46baZq5B
 PU79DoEAZYPX51/VegVSNqUZIF4jKeCsQFthynycWVPTM6+q5GHg7tqtMt8hWbOqgP/AGlJQL
 dTLkn+oG3q7LIDfRYqFb+tQupsmo96QP+eXedTHmJu5fwsz0LTTSRDv5LzDtW+UKbKhkF+XkQ
 BiYX0FKlG7S0Y5P86bd/fhUagWrxTeeYixUhlleQkiPja/hkSO8sLRisqTtoy13HgGpm3f+oA
 LmPAnksodhqApp+K7L0mFERfTKTOLOsujX3x26xnqXZNVwUedZb7M0l1NLbN7hv2SZBwuvsjk
 7qAYB3qJjeatMpgDCx9FmLlqg2XgGpMEYIVT/b7gLLwKPcriB+Zk90g0+CA028QEN3J6Iq6+c
 +xQ5VuMl5WwX2piwwUHYgTOsKpRvgNerNauZGZBTlg1KGmWW1issDZYWeKHFASsYpt/aJrrPE
 JIbWUmcsSzlfvg7wfgf17YLSZcIdJ/I2S2sKLvt9haD3CGMfGbe21mlu+YdlBGodzi+p8BrNV
 gu6YdUr9AXAAgBWmyptWdAoAIO8ozl+29B1WMC0t1xqrNf7V0j/CtKhwlpBrIB8XxdNY5b4db
 ruh0FaS0W+j+n+yY0Q/tG8EJNq/Hdf8dz3ww6D/3ph7M/+QHcFqxALbsM2k7gsY+kXbr4a5CK
 m6kUwf9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.2016 um 13:22 schrieb Michael Haggerty:
> "git blame" already parsed generic diff options from the command line
> via diff_opt_parse(), but instead of passing the resulting xdl_opts to
> xdi_diff(), it sent its own xdl_opts, which only reflected the values of
> the self-parsed options "-w" and "--minimal". Instead, rely on
> diff_opt_parse() to parse all of the diff options, including "-w" and
> "--minimal", and pass the resulting xdl_opts to xdi_diff().

Sounds useful: It allows more fine-grained control over which whitespace 
changes to ignore and which diff algorithm to use.  There is a bit of 
overlap (e.g. with -b meaning show blank boundaries vs. ignore 
whitespace changes), but with your patch blame's own options still take 
precedence, so there should be no unpleasant surprises.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Somebody who knows more about how diff operations are configured
> should please review this. I'm not certain that the change as
> implemented won't have other unwanted side-effects, though of course
> I checked that the test suite runs correctly.

I don't qualify, but I'll comment anyway..

>  builtin/blame.c        |  11 ++--
>  t/t4059-diff-indent.sh | 160 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 165 insertions(+), 6 deletions(-)
>  create mode 100755 t/t4059-diff-indent.sh

This new test doesn't call git blame.  Does it belong to a different 
commit?  And shouldn't the change to blame.c stand on its own, outside 
of this series?

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 7ec7823..cde2d15 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -48,11 +48,12 @@ static int show_root;
>  static int reverse;
>  static int blank_boundary;
>  static int incremental;
> -static int xdl_opts;
>  static int abbrev = -1;
>  static int no_whole_file_rename;
>  static int show_progress;
>
> +static struct rev_info revs;
> +
>  static struct date_mode blame_date_mode = { DATE_ISO8601 };
>  static size_t blame_date_width;
>
> @@ -137,11 +138,12 @@ struct progress_info {
>  static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
>  		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
>  {
> -	xpparam_t xpp = {0};
> +	xpparam_t xpp;
>  	xdemitconf_t xecfg = {0};
>  	xdemitcb_t ecb = {NULL};
>
> -	xpp.flags = xdl_opts;
> +	memset(&xpp, 0, sizeof(xpp));
> +	xpp.flags = revs.diffopt.xdl_opts;

Why call memset instead of using a static initializer?  The intent of 
this patch is just to change the .flags assignment, isn't it?

>  	xecfg.hunk_func = hunk_func;
>  	ecb.priv = cb_data;
>  	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
> @@ -2517,7 +2519,6 @@ static int blame_move_callback(const struct option *option, const char *arg, int
>
>  int cmd_blame(int argc, const char **argv, const char *prefix)
>  {
> -	struct rev_info revs;
>  	const char *path;
>  	struct scoreboard sb;
>  	struct origin *o;
> @@ -2548,8 +2549,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('l', NULL, &output_option, N_("Show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
>  		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>  		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
> -		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
> -		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),

This removes -w and --minimal from blame's short help; diff options 
should be mentioned somehow in exchange for that loss.  Or perhaps they 
should be mentioned in git-rev-list(1)?  (git blame -h points to 
git-rev-list(1) already.)

Documentation/git-blame.txt needs an update as well.

>  		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
>  		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
>  		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },

