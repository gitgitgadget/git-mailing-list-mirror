Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030C1207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754126AbdFWWgK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 18:36:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33197 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbdFWWgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 18:36:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so9247335pfk.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ejezQ4DsWQKAoAUd+LK4exWRtnP2T7ONJcU6UXzVpto=;
        b=oAoDIpXh+FD8E3P1sl26sDeZPmjkWGZu8HDnvIHZzOsp9Ms07Zskmmo2n1LP2IFgB7
         6qnYjsnndFqSMjydoyknEW8QXH9CQB39K8xnWLKWBjo1N/zFId07ZivdYr5KTbvaURCG
         fS3wW44YEIxl5wvYKyQxW9sh1gkOlIAFY2hV6IGew1kHb2NVmHa4PqPGF/Wn73NScJNj
         jyp+qQcNfnZe4cYk91riFfX1lP7KSy+vHOm8JWnyznH3PujepYgKM7ghgZo/YeBce/tE
         Due8PSiWTkTE5vuAK3DIUCRfFdKrFKWp7hgLcZf5EBnklghZ93MErASb+WPyrKbBDGBt
         g3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ejezQ4DsWQKAoAUd+LK4exWRtnP2T7ONJcU6UXzVpto=;
        b=SxaK372Qig7ibD7TqFpbgJL4HktNHUv3hFxf/ELpPMz8TKpqd0VJ+nHkCoOETwSnGO
         uR63O4mNZT6Lcs/NOtaIya2Ffe39uLFgIiAw5dEOgIVYY+yb9wsao+U47wOUdT5wlMbP
         oI0BT2o0hFfFn6v70nw5XlACoR2CXoYPGkTgmzwTNQXQBoP4MhbxS/cTBq95TPM8kB5o
         iUOBUqbjr5R+kyvBU6yUHhZhI8hvS0CGFWPjG0mxDFZxCBVgGZsv4P1nY6BEQ8xgbmt7
         GSSeFn44ljqT/3vGVwmsXUjxlQiXMwSgbOtU9UYWws5Xd9iYCTDGHMHZjPc+J74Wtgp9
         TnKw==
X-Gm-Message-State: AKS2vOzmU6Z+bNaN8Lvg/CBFHHWGzlBiTCd2ljkUR/d2kGNPYAhbBcRY
        1k4jrEQg1s51NA==
X-Received: by 10.99.149.83 with SMTP id t19mr10021874pgn.247.1498257369273;
        Fri, 23 Jun 2017 15:36:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id z4sm11157595pgs.21.2017.06.23.15.36.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 15:36:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        philipoakley@iee.org
Subject: Re: [PATCH 2/3] builtin/fetch: parse recurse-submodules-default at default options parsing
References: <20170623191302.16053-1-sbeller@google.com>
        <20170623191302.16053-3-sbeller@google.com>
Date:   Fri, 23 Jun 2017 15:36:07 -0700
In-Reply-To: <20170623191302.16053-3-sbeller@google.com> (Stefan Beller's
        message of "Fri, 23 Jun 2017 12:13:01 -0700")
Message-ID: <xmqqo9tebaco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -1333,10 +1336,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		deepen = 1;
>  
>  	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
> -		if (recurse_submodules_default) {
> -			int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
> -			set_config_fetch_recurse_submodules(arg);
> -		}
> +		if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)
> +			set_config_fetch_recurse_submodules(recurse_submodules_default);

This is not a new thing, and it may not even be a problem, but I
have to wonder why this needs to be done conditionally.  "The
command line did not explicitly say --no-recurse-submodules, so we
would set what came from --recurse-submodule-default if and only if
that is given---otherwise we leave it as a compiled-in default" is
what the code before or after this patch tells me.  But if we drop
the "if (default is not DEFAULT)", the resulting code becomes "The
command line did not explicitly say --no-recurse-submodules, so we
would set whatever is the default (which may not have been given
from the command line, but came built-in to the binary)".  Aren't
they saying the same thing?

It's not like there is a configuration knob that further interferes
the interaction between these two.  I am puzzled.


>  		gitmodules_config();
>  		git_config(submodule_config, NULL);
>  	}
