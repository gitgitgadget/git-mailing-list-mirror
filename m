Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C100F203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 19:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbcGYTwP (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:52:15 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36678 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbcGYTwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:52:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id q128so147626222wma.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 12:52:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=70OwhI7hq77pLsgAp0e2dPE0Xr+sHYVxjYBUeyZkQx8=;
        b=YawGhK+cXDT0HwDYbvygZeNcgLIRqpxG6dzAutwh1eu6pzU49YOeNeHJIluwl2mXDe
         8HLcM3RvzemFuPr6XormE7G/ek59ztZOaZW7bbsh1k+jIxVs3E/PH3XCy6zzHVrYZYeF
         ivKAo6dUmL5GNm4BjcM/dl6sx9fhxsQ5eai6LSiv+ZIb/5QSISr66fRFHtgxPB9Y6zVh
         TFn81AtcdOXUNKqK0f462Zap9oBByhn+ctdrCQJIxrlUqq+ZA3LRKKIc4rnTs7yDwGCz
         mOvKiS0d+Bg+UqGxct/o38F7kvYRkXDI0ASPunAeqxQCAHI9oH5+DaZRGa2ORkNCI/7J
         Gl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=70OwhI7hq77pLsgAp0e2dPE0Xr+sHYVxjYBUeyZkQx8=;
        b=ZUL8A0pva5OPf1cbymXbM/AyiealU/eLZjSHCSlRpNtVNl8v7yXkLGIPGYECzI6xpH
         7QPJNfUQ6Xbx6gTOATptLB+k+nVO4r7uQFnlmYJPs0W1LahXkz0zblLxsUCuD5NaVAXK
         e373qdsJ61QdbZ5BlIFfo6XKoKqmqMJH65eUvU3L97IiEu9RYJd6xS/DP7SFtsORUFAK
         6aEW6v/enPFQ0k34p1ccmnSCiJ5rET/AAArkOB/ik8TWApF5JUx3gcWg5AIPms0nuYdz
         DkxH4tdmx+O7abHXNNvDGt5MTRUwcXxkevSndADqUNptSeiS+dV3RacMvcFOrVbHh37X
         Tv0Q==
X-Gm-Message-State: AEkoouvw7xVsQUTLm0UpMaGYkocSNDWyd6Fx1sHPGDec7WU/uMFPsMtlxSG6owRG+7Dghw==
X-Received: by 10.194.176.165 with SMTP id cj5mr19116357wjc.82.1469476331994;
        Mon, 25 Jul 2016 12:52:11 -0700 (PDT)
Received: from [192.168.1.26] (dax80.neoplus.adsl.tpnet.pl. [83.23.23.80])
        by smtp.googlemail.com with ESMTPSA id f10sm17334333wje.14.2016.07.25.12.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 12:52:11 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] status: support --porcelain[=<version>]
To:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
 <1469474750-49075-4-git-send-email-jeffhost@microsoft.com>
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	Johannes.Schindelin@gmx.de
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57966DDF.5020301@gmail.com>
Date:	Mon, 25 Jul 2016 21:51:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1469474750-49075-4-git-send-email-jeffhost@microsoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 21:25, Jeff Hostetler pisze:
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -144,6 +144,21 @@ static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> +static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
> +{
> +	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> +	if (unset)
> +		*value = STATUS_FORMAT_NONE;
> +	else if (!arg)
> +		*value = STATUS_FORMAT_PORCELAIN;
> +	else if (!strcmp(arg, "v1"))
> +		*value = STATUS_FORMAT_PORCELAIN;
> +	else
> +		die("unsupported porcelain version");
> +
> +	return 0;
> +}

Presumably it is not something hard to find, but perhaps it
would be better to print the version that were given (for
example "1" instead of "v1")?

-- 
Jakub Narêbski

