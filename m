Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4CC1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbcHSCMQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:12:16 -0400
Received: from mout.web.de ([217.72.192.78]:61590 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754400AbcHSCMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:12:14 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MddFQ-1bocv53bvI-00PIrn; Thu, 18 Aug 2016 17:42:15
 +0200
Date:   Thu, 18 Aug 2016 15:42:13 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
Message-ID: <20160818154213.GA17141@tb-raspi>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:huP5F9zWCKDp0Avn5BRqHnZa6Lzoqv9hpM2uH/39sZyz7E6zhZs
 ZNiqwW5DOLRyltNG3NuXhDw+770QD02X47+ZX+qevyHRQRSl2TbHn6v6Y+qVZFrNZZ8bYPO
 Y1EZL0XZLzJY/qDXq03qZaRiLDOSM/R2Xa2Yu4IVu06stlANS9vFwuBnlTuWQ0/faya1tNO
 NWuRkdfBZzOuV+xvEoiJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MJMKEbTbfkI=:4PDUmUeq7y5i7dkk8nBdlV
 m6cSnxQyxo3RHMtmOLvW7xvKj8JGsmKRix7ccFv+1Qrn58NBJm/zQbhrlZBgHsHZQETZBKo0a
 pZsQG0+B/YETov+kCrZLJuCkBZi63Aaoysj+kuuIVhiyTgBKKW+z7csg1GdyqmaURGEEt/E0P
 ZLAr6grLSpU4IMpGdbh7zFxpgsSmwBIpsLeBg+tlqi/0R/GG9p5cR48aXrJlBgy9jlOaQlNMs
 QJcSXYvDH/egPrZ2ASMLwf0GpVUupuvHoMDxJu1eG1+m9MoAEinfD5ranemHkNlSokknTDIYC
 INM+KxFonbyt8q/JmWntWqTvTxzTGQg0HQ5419EZ56GtxlqQlpVPwkgPEfmx0LVrxlkOw8KZQ
 TfwPsT+4AghIuIsCrjrmJpcGbn6W4o7aVKaUPkp4oEME96zIl2JTz1sGyg4n0Hw8YsyUa9XZ6
 c26OW5zRtw/PHDP14NzlS7T5PNMxi2zm3XNQfayp/khyDztPaYzWRSu1HXu+8hagG89iyb5Y1
 j15Bth+TR06apdwnxPIS/N+rbpawTw+lkTGD472p5xWjLY4pU5NcSpYEhv2ZX5/XiXvF8T/S0
 1OV+03CDwkT2Fo/oEgujNGn6YCg2FGWoAp+KDmKDupeVC+kU5CBlJtx9k6zF2VCbJFdHbjJMF
 +o8XOuMeKo7/Tzm2Ilig2jWzU/Z92p9gQy0rOvux4m5FBMHup80Qf3U2FqPf9YcquRlUTC8zO
 CKuWEihdXT6msjt1gFJ+1Ft6bmW/ArrFKy1ZbpjGSJ4xzJxjP5yWBQJSzKQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:
> With this patch, --batch can be combined with --textconv or --filters.
> For this to work, the input needs to have the form
> 
> 	<object name><single white space><path>
> 
> so that the filters can be chosen appropriately.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-cat-file.txt | 18 +++++++++++-----
>  builtin/cat-file.c             | 49 +++++++++++++++++++++++++++++++++++++-----
>  t/t8010-cat-file-filters.sh    | 10 +++++++++
>  3 files changed, 67 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 59a3c37..1f4d954 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--use-path=<path>] <object>
> -'git cat-file' (--batch | --batch-check) [--follow-symlinks]
> +'git cat-file' (--batch | --batch-check) [ --textconv | --filters ] [--follow-symlinks]
>  
>  DESCRIPTION
>  -----------
> @@ -20,7 +20,11 @@ object type, or `-s` is used to find the object size, or `--textconv` or
>  `--filters` is used (which imply type "blob").
>  
>  In the second form, a list of objects (separated by linefeeds) is provided on
> -stdin, and the SHA-1, type, and size of each object is printed on stdout.
> +stdin, and the SHA-1, type, and size of each object is printed on stdout. The
> +output format can be overridden using the optional `<format>` argument. If
> +either `--textconv` or `--filters` was specified, the input is expected to
> +list the object names followed by the path name, separated by a single white
> +space, so that the appropriate drivers can be determined.
>  
>  OPTIONS
>  -------
> @@ -72,13 +76,17 @@ OPTIONS
>  --batch::
>  --batch=<format>::
>  	Print object information and contents for each object provided
> -	on stdin.  May not be combined with any other options or arguments.
> -	See the section `BATCH OUTPUT` below for details.
> +	on stdin.  May not be combined with any other options or arguments
> +	except `--textconv` or `--filters`, in which case the input lines
> +	also need to specify the path, separated by white space.  See the
> +	section `BATCH OUTPUT` below for details.
>  
>  --batch-check::
>  --batch-check=<format>::
>  	Print object information for each object provided on stdin.  May
> -	not be combined with any other options or arguments.  See the
> +	not be combined with any other options or arguments except
> +	`--textconv` or `--filters`, in which case the input lines also
> +	need to specify the path, separated by white space.  See the
>  	section `BATCH OUTPUT` below for details.
>  
>  --batch-all-objects::
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5ff58b3..5f91cf4 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -17,6 +17,7 @@ struct batch_options {
>  	int print_contents;
>  	int buffer_output;
>  	int all_objects;
> +	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
How do I read 'w' and 'c' ?
wilter and cextconv ? Does it make sense to use an enum here ?
Or a #define ?

