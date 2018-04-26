Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75971F424
	for <e@80x24.org>; Thu, 26 Apr 2018 05:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeDZF6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 01:58:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34442 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeDZF63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 01:58:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id p10so15082634pgn.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bK0bf+gx+2pI5//ty64sniUt3E4YYmS8NPUlMSn2pnQ=;
        b=L4zF3dwLPzggBjDRBVWUwXcratNTS2gyD5N9LZOwV/iAWWelqQSofyLmyENS/urVwu
         pBja3pmS1mralS0FZbUVDc/QUaAt/WaYhQuACy28985iYf/RnpeT3MjtHokUABGp0YEp
         hnUUuI1HnNu8HOe0utMyjC/ApfxD/pkH4z7WUN4/9tbkgzU4OQBUPToTOMcrj/fCvkgE
         Y4IEguBRHS+/Jmp2mEb7iFBSYoZq2c6lyex5lLlaaMkDFVUsfn0241MkeR4LvQiVTzoh
         nqNIaGXN1zS/IJMVIdusDZkRFuXkkbpw1zvagKh4e/5BtdE2mOj5f3FxAQVUOI+JlBKG
         rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bK0bf+gx+2pI5//ty64sniUt3E4YYmS8NPUlMSn2pnQ=;
        b=tR7T8hPeXHqxZXwiWGQR29VRndhbC2K5+i7lyeJTCAANnR2ozgYJwpaziEHQkCW3+I
         /Wc2Oe/VLOtXa6zD3qhZAO+e+6deHoxVHwppazHJrQIy1kj7Gw+SsCSIQ5TpZbVgnHdx
         TpBhgF89EDRp+JMf246SpuKsVuuXEXTawTKqX44rp1fEmRKDkv2OP4dQ1fmW2e7wtWjC
         f4yZZEQh1fdqEVO2x82NGGqEzMO2GjSEHNSeEXPpo001+GgxR7G54KOSi5LzlB0cOKT0
         ejEWUR4ZEloRFZ548JmyulfIMv7sV/aDSzCXU7ZIwrJswuswHM0TVpekFn+gmood/EMK
         YJsg==
X-Gm-Message-State: ALQs6tB7eHdmrnCx/WqU6SNCkHVg9f1GtpJ5cnJg2CTQWnqnowWhKt/N
        hOEDJhG17ix7MSpmmZLNzIMdVU482NQ=
X-Google-Smtp-Source: AIpwx4/AZ88/XNeuhZ+ubhswNWFAciTzYo8qEosCaAoXOZPiB2wMCA4pTr6dcaJntHENmDQY5MUTrA==
X-Received: by 2002:a17:902:694a:: with SMTP id k10-v6mr31313614plt.161.1524722307948;
        Wed, 25 Apr 2018 22:58:27 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id b3sm34691517pff.11.2018.04.25.22.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 22:58:26 -0700 (PDT)
Date:   Wed, 25 Apr 2018 22:58:25 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 0/5] builtin/config.c: combined series '--type',
 '--default'
Message-ID: <cover.1524722247.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524716420.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is an amended version of my combined series to add '--type' and
'--default'. My apologies for the re-roll, I thought that I had looked
everything over closely enough :-).

Since last time:

  * Correct an obviously-wrong assignment into '*to_type' [1]. I have
    moved both of these assignments into the top-line declaration of
    those variables.

  * Re-add a removed hunk to support '--type=color' correctly [2].

Thanks,
Taylor

[1]: https://public-inbox.org/git/xmqq7eou35ev.fsf@gitster-ct.c.googlers.com
[2]: https://public-inbox.org/git/xmqq36zi352x.fsf@gitster-ct.c.googlers.com

Taylor Blau (5):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: support `--type=<type>` as preferred alias for
    `--<type>`
  builtin/config: introduce `--default`
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `color` type specifier

 Documentation/git-config.txt |  81 ++++++++++++--------
 builtin/config.c             | 143 ++++++++++++++++++++++++++++-------
 config.c                     |  10 +++
 config.h                     |   1 +
 t/t1300-repo-config.sh       |  93 +++++++++++++++++++++++
 t/t1310-config-default.sh    |  36 +++++++++
 6 files changed, 305 insertions(+), 59 deletions(-)
 create mode 100755 t/t1310-config-default.sh

Inter-diff (since v1):

diff --git a/builtin/config.c b/builtin/config.c
index ec5c11293b..bb62816bba 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -72,19 +72,18 @@ static struct option builtin_config_options[];
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
-	int new_type;
-	int *to_type;
+	/*
+	 * To support '--<type>' style flags, begin with new_type equal to
+	 * opt->defval.
+	 */
+	int new_type = opt->defval;
+	int *to_type = opt->value;

 	if (unset) {
 		*((int *) opt->value) = 0;
 		return 0;
 	}

-	/*
-	 * To support '--<type>' style flags, begin with new_type equal to
-	 * opt->defval.
-	 */
-	new_type = opt->defval;
 	if (!new_type) {
 		if (!strcmp(arg, "bool"))
 			new_type = TYPE_BOOL;
@@ -96,11 +95,12 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			new_type = TYPE_PATH;
 		else if (!strcmp(arg, "expiry-date"))
 			new_type = TYPE_EXPIRY_DATE;
+		else if (!strcmp(arg, "color"))
+			new_type = TYPE_COLOR;
 		else
 			die(_("unrecognized --type argument, %s"), arg);
 	}

-	*to_type = opt->value;
 	if (*to_type && *to_type != new_type) {
 		/*
 		 * Complain when there is a new type not equal to the old type.

--
2.17.0
