Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D11F956
	for <git@vger.kernel.org>; Fri, 16 May 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426837; cv=none; b=BjjCioYbuP7L6FFBPuV8OjqX9A1Qr14byx2dU1WksenvxDE0Ti2QUWErroer/MME9QrHhDt6ushltTE7VaKI0NH6d7eDOk17ms4Rn1ny+ktxeV49SmFt/oBCDdyeuwhOl+NgGVJSF0L+oS6sIEAwuAexy7vQHBPdKhM5mtaJCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426837; c=relaxed/simple;
	bh=xSYotJ4wzJJQEHEC2apwmic8UQOYuTvjjxT4yTy/o58=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ObaUUFzQRw0dYoJe4qiv1XglX0SzmP16RIqm453gsStsB8rv1O8qQLPlTMd4SwXIOV8VNPfLuuTeISeHg+4xtPD9b8pD8aYXvt86bJgecto/fgTnTp4OLWZ59rk9vgbOu1LHx0KOtCblK9vspF3hE2TM0Fxzn1eVi/KNagPQCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgzOnarK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgzOnarK"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3db8356ee37so6331355ab.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747426834; x=1748031634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YMoJTEPx47OFzZlgN8E8CmqD9hXBVtbXN1OyenaxHc=;
        b=NgzOnarKXYImwFpkuBRUxwRRrp0ay4gUfMVuncaLQKJCnWYIFTZVGQObq8qEgvTmrq
         2W3MR2QY9rznKSpz2fjz4lTIaJFbg+8rq9nxj++IBGlJTCHWkIksiwglRcAN9HwhUImC
         uBWgH9bQpQkKA4n9mCGBOjZFI0bxcilT7WWIBaSbaD/FVPUwgMbMkc0T642q2xl4EtA9
         VtKCzc8pzYMLmm97NlfdWBrVyHFeRGL7em5sF1nBQOzxF1iOK6IimzVX40LKjk4v4Ldd
         6neH2+4Jq6MtUcWeyvusAY+O3tIQMnA+VnE4ydes5iHLvym0G0y91XMI70t4ZbLQKw0V
         VSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747426834; x=1748031634;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YMoJTEPx47OFzZlgN8E8CmqD9hXBVtbXN1OyenaxHc=;
        b=tDkiLjFg4Eoe3gPAb7A/dHKF/051bPJ5i6z6hZcm4kPNIlSNlnu7S5SrbbmbreXDbs
         gwzPkFF0UJ5PPH8jRIJdytgIghJ6Svw/9acn0EIBfzqb44lLOfpIMOYblLkSa8gJSgAk
         vG5mIZxnrUsERfuK7zs7llOVsqd79etPs1vg4MmcPobeRBFEMoXI5lhYd44457KW0lS0
         /U0UQy8bXLqzV/YgYpANBFn7nD06mVJvb5NULlnZMNrVHwBcSJNFuhI7Jr6x0fzXDkza
         JvMh/iyrhqyTJbk1jssiDHJaVhjHZQ5FHdMef+0VvmP+qFnuKVMkNv5rU7Nkeu1OZDeI
         KeFQ==
X-Gm-Message-State: AOJu0YxS17dwqArJgU8wYtuOFNzCdH7PvgIwhVGW5pTiWEWgQjlN1q12
	3dcymFGoOIiD3g2kAni7yW06rtRkYGqEopYtBFGNIZDLBWf13ArzX6jtZ//Wkg==
X-Gm-Gg: ASbGnctfsmYeKAwNAgBItRp+8g4HE1dweMB3xJj/XphhoRi2UAdZ45cx64PCwDDIiGr
	WmVL9fzuz9GN5Ie1EP2Zf43/Lak59ViIuVCuIscY/FI5ce6URUDwe/lsh2NuuH81wuFbze15XyV
	rDCEcy+BLNXWfFpGJwF4LH8D9kYXme3I6ExvNXL3eRYYcKfsGmE6NODWq8RDc2NVCQQOnNRQw51
	/1qjFOZ+TbolnE9DZswnHL3VC/sTrtk9r6XLqYumpiQgyJaKjrEp+wzA0c3pRnlkEnxECUTAzvU
	CEbNaQ2ajjj69jtkoyo7sKFAiK9GsY21l+W1iRxiUtnGM15poCj7yUNopv1XKRJUPs1x+QlZmUD
	+GXVITI31rZ2xs8N7ZyzYUaxzUN/3GxMK
X-Google-Smtp-Source: AGHT+IGD5gBkdBKSN4pNxEzM+IGPjYJ/eXOJXUYFplkRNX4NAh0ROUb60SCTRmKNcL8jQKH0lFLi8A==
X-Received: by 2002:a05:6e02:351d:b0:3d0:47cf:869c with SMTP id e9e14a558f8ab-3db857b6555mr43408825ab.19.1747426834027;
        Fri, 16 May 2025 13:20:34 -0700 (PDT)
Received: from [192.168.1.253] (76-206-246-123.lightspeed.cicril.sbcglobal.net. [76.206.246.123])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1bf6sm560490173.45.2025.05.16.13.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2025 13:20:33 -0700 (PDT)
Subject: Re: [PATCH] Handle rebase fork-point options in pull --rebase
To: Junio C Hamano <gitster@pobox.com>
References: <06beff46-cdaf-91c8-e6a3-6557694af618@gmail.com>
 <xmqq5xi23riw.fsf@gitster.g>
Cc: git@vger.kernel.org
From: Mr Bill <billc56196@gmail.com>
Message-ID: <106d9ce5-2c2f-9724-792a-b7ea46641c8b@gmail.com>
Date: Fri, 16 May 2025 15:20:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqq5xi23riw.fsf@gitster.g>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 05/15/2025 08:57 AM, Junio C Hamano wrote:
> Mr Bill <billc56196@gmail.com> writes:
>
> Welcome to the community and thanks for a patch.

Hi Junio,

Thank you for the review and suggestions. I'll look into making
a more complete patch; however, I'm working on a major system
cleanup and upgrade which may delay this until complete.

Thanks,
Bill

>
>>> Content-Type: text/plain; charset=utf-8; format=flowed
> That is a sign that the patch itself cannot be used mechanically, as
> format=flawed is known to corrupt patches.  But still, let's read on.
>
>> This is a patch to handle --fork-point and --no-fork-point in pull --rebase.
>>
>> I had a recent bug report about pull --rebase not working correctly...
>>
>> but it was working correctly, but not doing what I expected due to always
>>
>> using "merge-base --fork-point"
>>
>> This patch implements handling the --fork-point and --no-fork-point options,
>>
>> and also checks the config rebase.forkpoint value...
>>
>> and it works to resolve my prior bug report issue.
>>
>> If there are any questions or comments, let me know!
>>
>> Thanks to all for the help and comments on my prior bug report!
>>
>> -Bill
> The above is not quite usable as log message.
>
> The usual way to compose a log message of this project is to
>
>   - Give an observation on how the current system works in the present
>     tense (so no need to say "Currently X is Y", just "X is Y"), and
>     discuss what you perceive as a problem in it.
>
>   - Propose a solution (optional---often, problem description
>     trivially leads to an obvious solution in reader's minds).
>
>   - Give commands to the codebase to "become like so".
>
> in this order.  You may want to check a few examples in "git log
> --no-merges master..seen" to get yourself familialized to the style.
>
> Also check Documentation/SubmittingPatches; you'd need to sign off
> your patch with your real name, which should match the authorship
> identity (i.e. "From: " line of your message and "Signed-off-by: "
> trailer should both have your real name plus e-mail address).
>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index a1ebc6a..f2d405f 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -117,6 +117,10 @@ static int opt_show_forced_updates = -1;
>>   static const char *set_upstream;
>>   static struct strvec opt_fetch = STRVEC_INIT;
>>
>> +/* options to include rebase fork-point preference */
>> +static int config_fork_point = -1;
>> +static int opt_fork_point = -1;
>> +
>>   static struct option pull_options[] = {
>>      /* Shared options */
>>      OPT__VERBOSITY(&opt_verbosity),
> As I already said, the patch part is all whitespace damaged and this
> patch will not be usable as-is, but let's see if the logic is sound.
>
>> @@ -253,6 +257,10 @@ static struct option pull_options[] = {
>>          N_("set upstream for git pull/fetch"),
>>          PARSE_OPT_NOARG),
>>
>> +   /* rebase option to use/not use merge-base --fork-point */
>> +   OPT_BOOL(0, "fork-point", &opt_fork_point,
>> +       N_("rebase with 'merge-base --fork-point' to refine upstream")),
>> +
>>      OPT_END()
>>   };
>>
>> @@ -366,6 +374,9 @@ static int git_pull_config(const char *var, const
>> char *value,
>>      if (!strcmp(var, "rebase.autostash")) {
>>          config_autostash = git_config_bool(var, value);
>>          return 0;
>> +   } else if (!strcmp(var, "rebase.forkpoint")) {
>> +       config_fork_point = git_config_bool(var, value) ? -1 : 0;
>> +       return 0;
> This is curious.  I would have expected it to return the value
> returned by git_config_bool() as-is, because "-1" is used as
> "unspecified" to initialize the config_fork_point variable.  With
> this code, configuring "[rebase] forkpoint = true" is a no-op, no?
>
> Assuming that it is fixed ...
>
>> @@ -1059,7 +1070,17 @@ int cmd_pull(int argc,
>>                  N_("pull with rebase"),
>>                  _("Please commit or stash them."), 1, 0);
>>
>> +       if (opt_fork_point == -1)
>> +           opt_fork_point = config_fork_point;
>> +       if (opt_fork_point < 0)
>> +           opt_fork_point = 1;
> ... this code looks reasonable.  opt_ and config_ are both
> initialized to "-1" (unspecified), so if there is no command line
> option given to affect the setting, we read from config_, and if
> neither specifies the settings, we enable the fork-point option.
>
>> +       fprintf_ln(stderr, _("rebasing %s fork-point"),
>> (opt_fork_point ? "with" : "without"));
> This looks like a debugging aid, not to be left for production.
>
> Besides, interpolating literal "with" in _("localizable string")
> does not make much sense.
>
>> +       /*
>> +        * If we're *not* using fork-point, or we don't find one in
>> get_rebase_fork_point(),
>> +        * clear the rebase_fork_point info.
>> +        */
>
>> -       if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
>> +       if (!opt_fork_point ||
>> get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
>>              oidclr(&rebase_fork_point, the_repository->hash_algo);
> Doubly besides, until we pass this point, we do not know if we are
> rebasing with fork-point.  The configuraiton, option, or the
> hardcoded default might have made opt_fork_point to true, but if
> get_rebase_fork_point() failed, we won't be rebasing with fork-point
> so the above debugging aid message we saw earlier, even if it were
> useful in production, is given way too early before we know enough
> to choose between "with" or "without".
>
> This new feature needs to have tests.
>
> The new command line option needs documentation.
>
> The new configuration variable needs documentation.
>
> Thanks.
>

