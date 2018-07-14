Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7214F1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 08:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeGNIwV (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 04:52:21 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:47351 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeGNIwV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 04:52:21 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 14 Jul 2018 10:34:01 +0200
  id 0000000000000049.000000005B49B579.00005F71
Date:   Sat, 14 Jul 2018 10:34:01 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 01/25] structured-logging: design document
Message-ID: <20180714083401.GA2069@ruderich.org>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <20180713165621.52017-2-git@jeffhostetler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180713165621.52017-2-git@jeffhostetler.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 04:55:57PM +0000, git@jeffhostetler.com wrote:
> diff --git a/Documentation/technical/structured-logging.txt b/Documentation/technical/structured-logging.txt
> new file mode 100644
> index 0000000..794c614
> --- /dev/null
> +++ b/Documentation/technical/structured-logging.txt
> @@ -0,0 +1,816 @@
> [snip]
>
> +"event": "cmd_start"
> +-------------------
> +
> +The "cmd_start" event is emitted when git starts when cmd_main() is
> +called.  In addition to the F1 fields, it contains the following
> +fields (F2):
> +
> +    "argv"        : <array-of-command-line-arguments>
> +
> +<argv> is an array of the original command line arguments given to the
> +    command (before git.c has a chance to remove the global options
> +    before the verb.

Missing closing parentheses.

> [snip]
>
> +<slog_{detail,timers,aux}> are the values of the corresponding
> +    "slog.{detail,timers,aux}" config setting.  Since these values
> +    control optional SLOG features and filtering, these are present
> +    to help post-processors know if an expected event did not happen
> +    or was simply filtered out.  (Described later)

Please write out "slog_detail, "slog_timers", etc. Using the
abbreviated forms makes searching a pain.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
