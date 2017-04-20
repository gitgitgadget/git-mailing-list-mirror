Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B86207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032623AbdDTWUV (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:20:21 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34083 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031997AbdDTWUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:20:20 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so90534656ioj.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Z4QO00ONwbbQS189MWSP1XjCBj8yN5lNrgdX2kzqiM=;
        b=cya/T/AamIRuWIvNPwJFvArUh7HPxK5tB0NVAwn/XRUvOeoue650uVKjWcCXdLVpra
         Mbwa/geVOJMZteoJM6OG92dfLcj7f0HuswcJh1tBW9P7eRPmjz3L9gVjb8uBjexVpKL6
         ihCwq1HaWsL9PhTxLm5QU9WGV+vS3r2wEJtmlAK353s+L3zcVJquNwVohR3XO7ROmc59
         wwtyDM85sJgPi6Gt8EK8CJCNW0p7D1x7g23GyVXX+mqSItzFCGT4ra+c16+HWb21rZO1
         FagRdeF0CvXU1FXl3BNKh31Q5ipGYkO5lrnpvp33ah5GO0KA37ym0aLGMd9qX7ldUtGq
         9lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Z4QO00ONwbbQS189MWSP1XjCBj8yN5lNrgdX2kzqiM=;
        b=COAQWVjE1ecZLaTZqwsJ+h4kG0VUe0B3P514Ak7PmzDJ1KBrA4SziKL1qTn60SJ7SB
         I3+8Q2nntCfy3tEAqdQSlFMDs2pW9foiDJOIXVYj1C5PvwSFpqTdVdisxBP1w0sp055R
         LFDr1AuLKNxuMSPhBx29cN84vbovxhdBhusxs0qXW0x70yeM55U0oFah5WumNxy7zryA
         Jg6Yu9wNNNc/SSOPrlpoelFnXmU+38lee0udNOxa+/JElOEcIFr0EtvTAUpOKlReTiDu
         C5v3iTbsWMVoseWAe1uZ/G96/qzzOuJU05KMKiQtlLUo/CAcRRpVvoR3M4hY8NJpotcJ
         wmWw==
X-Gm-Message-State: AN3rC/6u+79aMnnCfrLlvNgVH/s+5HwSmbRV/9ojyaWYBgSOwBGxTZYu
        hrIjYT/QzfN3QmzQ
X-Received: by 10.98.12.134 with SMTP id 6mr9858386pfm.66.1492726819136;
        Thu, 20 Apr 2017 15:20:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id t141sm10242610pgb.3.2017.04.20.15.20.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 15:20:17 -0700 (PDT)
Date:   Thu, 20 Apr 2017 15:20:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?iso-8859-1?Q?Zolt=E1n?= Herczeg <hzmester@freemail.hu>
Subject: Re: [PATCH v3 03/18] grep: submodule-related case statements should
 die if new fields are added
Message-ID: <20170420222016.GJ142567@google.com>
References: <20170420212345.7408-1-avarab@gmail.com>
 <20170420212345.7408-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420212345.7408-4-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Ævar Arnfjörð Bjarmason wrote:
> Change two case statements added in commit 0281e487fd ("grep:
> optionally recurse into submodules", 2016-12-16) so that they die if
> new GREP_PATTERN_* enum fields are added without updating them.
> 
> These case statements currently check for an exhaustive list of
> fields, but if a new field is added it's easy to introduce a bug here
> where the code will start subtly doing the wrong thing, e.g. if a new
> pattern type is added we'll fall through to
> GREP_PATTERN_TYPE_UNSPECIFIED, i.e. the "basic" POSIX regular
> expressions.
> 
> This should arguably be done for the switch(opt->binary)
> case-statement as well, but isn't trivial to add since that code isn't
> currently working with an exhaustive list.

I was under the impression that the code wouldn't compile if there is a
missing enum field in the switch statement.  Does it instead silently
fall through?  I would choose not compiling over a die statement that may
not be caught during the development of a new series.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 3ffb5b4e81..be3dbd6957 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -495,6 +495,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
>  		break;
>  	case GREP_PATTERN_TYPE_UNSPECIFIED:
>  		break;
> +	default:
> +		die("BUG: Added a new grep pattern type without updating switch statement");
>  	}
>  
>  	for (pattern = opt->pattern_list; pattern != NULL;
> @@ -515,6 +517,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
>  		case GREP_PATTERN_BODY:
>  		case GREP_PATTERN_HEAD:
>  			break;
> +		default:
> +			die("BUG: Added a new grep token type without updating case statement");
>  		}
>  	}
>  
> -- 
> 2.11.0
> 

-- 
Brandon Williams
