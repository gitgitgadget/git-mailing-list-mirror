Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AF81F406
	for <e@80x24.org>; Thu, 14 Dec 2017 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdLNI7a (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 03:59:30 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:40205 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbdLNI73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 03:59:29 -0500
Received: by mail-it0-f67.google.com with SMTP id f190so9381129ita.5
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Imv1535hqjqb9Jw4LwcPIwU0hSp/XaoVG/tM14zUcNA=;
        b=mxuzg1nKyfERPm+/J6wjz/tt7VMN7VjmcQv3y8yaROwvx7Z289QJZKjG5BGVuA0vNx
         dR0W4ZG+3P/tcJxv5iMW2jzOf4MUSOY0Vhkbxd5exJps/NIXE9tMDaLc0Tv/qv8orgC7
         ai4BPvHdAxklfgDLLXysFsVmY33nhZV6rt3spLnEBbCCI/0F4g9WY2gTiliilLYT/zWn
         DDAjJzkPqx8wrt9wqFZzSeNcKOUQvoDI99a3xX0qZypYDNynjl+K+oKqsVOhZ+uVrkZZ
         kfJ0T1xRGwqCJGLduwf9WFvUcqGcAmoX+z7t09ngQeSxLvkNKyrsCpno3otx/3ABJkNY
         EpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Imv1535hqjqb9Jw4LwcPIwU0hSp/XaoVG/tM14zUcNA=;
        b=tZd48afGFXOUR/qMWbZoOgSaanhSzEsaSJ4nLtwJRyGbn/eBxEop+TpUhTbDWzdYPg
         x48gjLX4sIAlclx9SLwJ/5iT0UFEO0aor+X5+QIjQqkLVZMHCFo+kzD1yHSYHqtEXHXU
         qtu7/Ggbys5ZzwMuGPy1Itwr9R7W7IeszIT+IxczBXFYUIjgRJ/z5JU8Kwthf0rPGSsI
         6g/H+9kqYXdjSHbp6p/IBlM4/jM5CYY754nIaERlVZ1aFMfsG9MU07/XOXI4eO61TFhr
         XdzzVhniD9o+EFLz57W9TA2YuqlI4ckbqXKthRsxyT7Auwic0ueeos0gW9I1GXKBEv51
         vcEg==
X-Gm-Message-State: AKGB3mJ+0+E9FTIYmLzAhfK9XsWLQ1MarWf0aogOIO4ROQjxNkprN94P
        QfaW/ZgWGQpIlyMo/Nge3MovuwakczsSXs+IyFQ=
X-Google-Smtp-Source: ACJfBovw4+gBX2ucSV7OKk+hOUzRMTf427EkDL3tvzGtQRhDi1nUQ7PsjFV2c2k7PLCYy47BRLgCKXnSVRR/qm7k44E=
X-Received: by 10.107.47.234 with SMTP id v103mr6034266iov.96.1513241968337;
 Thu, 14 Dec 2017 00:59:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 14 Dec 2017 00:59:27 -0800 (PST)
In-Reply-To: <xmqqbmj2wedd.fsf@gitster.mtv.corp.google.com>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
 <20171213151344.2138-5-chriscool@tuxfamily.org> <xmqqbmj2wedd.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Dec 2017 09:59:27 +0100
Message-ID: <CAP8UFD3=YCfrZZ0Xq6YSKTwr8e5HV5iwPN4G=Xb0s1yz8RTr6Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf/run: use $default_value instead of $4
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  t/perf/run | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/perf/run b/t/perf/run
>> index 43e4de49ef..bbd703dc4f 100755
>> --- a/t/perf/run
>> +++ b/t/perf/run
>> @@ -105,7 +105,7 @@ get_var_from_env_or_config () {
>>       env_var="$1"
>>       conf_sec="$2"
>>       conf_var="$3"
>> -     # $4 can be set to a default value
>> +     default_value="$4" # optional
>>
>>       # Do nothing if the env variable is already set
>>       eval "test -z \"\${$env_var+x}\"" || return
>> @@ -123,7 +123,7 @@ get_var_from_env_or_config () {
>>       conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
>>       eval "$env_var=\"$conf_value\"" && return
>>
>> -     test -n "${4+x}" && eval "$env_var=\"$4\""
>> +     test -n "${default_value+x}" && eval "$env_var=\"$default_value\""
>
> This conversion changes the behaviour.  Because default_value is
> always set by your change in the previous hunk, we end up always
> doing this eval.
>
> The original says "If $4 is set, then ${4+x} becomes x and if $4 is
> not set, ${4+x} is empty, so let's check if ${4+x} is a non-empty
> string to see if $4 is set.  If ${4+x} is a non-empty string, that
> means $4 was set so we do the eval.
>
> If you want to be able to use this helper to specify a default value
> of an empty string (which the orignal that used $4 did), then the
> previous hunk must be corrected so that it does not unconditionally
> set default_value to $4.  Perhaps like
>
>         if test -n "${4+x}"
>         then
>                 default_value=$4
>         else
>                 unset default_value || :
>         fi
>
> or something.

Yeah, you are right I will fix this.
