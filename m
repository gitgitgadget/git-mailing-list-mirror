Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1181C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 19:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiHBTqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiHBTqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 15:46:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B393E21810
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 12:46:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g12so14500863pfb.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mkzPRR1SJiulFSyKbnBAJCSrgMQECSyAEmjx5I+Hcr4=;
        b=RlhjC/wQDnHGBA9W24aQXwaGlRF9LgKj2Xxhu6qep34wm8ntUwO+L43jpbrZQTXlO0
         cYxHZWa/0PT0JAPJwXSvmMRzBT38P/DcQ+dEBqbm4jEODZY3BnSKPZ33UkHmZEyaPo+8
         PjUJVTmnzbpjuoTEgkhKVdsTSKx5MFwo8JJANzC3er5VojeaZgNgB+GTT6BGnWVyzVfe
         h50DJL1CP0CbIbdB7VUbBPWi/wUsEw6RSqjlLtEdPWdotq3C8ZRe51MW0+q+Zok/6A7M
         FL0UAWoCuhgWhgDV1/iEMv2Y81tNZQaf7OoDSfhM1WLdJz218gnYxlYg9dpqPSBRWpX7
         6vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mkzPRR1SJiulFSyKbnBAJCSrgMQECSyAEmjx5I+Hcr4=;
        b=5rwtHGLPWvGsowNsOGvbT6S8sV5dmLh7V0IUkrtjNjqSj2EPlg5S1kVoBSdjG+8YmH
         9tl3qACovh8Ode8q7cQsl+qjeY7b0uoNdemHH8lLBZ/7PgJePtEbgle2lzDOdB5oEoSX
         sRara9VEEIccgGEO2cNQi2+R+84FQ1KqZOklyquQqcv9T1BuZk07UEvUmfo1tKXrNvkq
         a6xofmD2SBnmSw9G8GrRSxkH7Sn3Ac60Nz0szmRLgYkwsDlILMCQPmJi8iKOIaH7kedi
         IAN6fNIwJ3pQjyQwIPBT+cYIxBuKK662o26mm5P4QcAQPIZq5oyxd0ccxJqz4QTMqVWx
         jbxw==
X-Gm-Message-State: AJIora+HAxCzV0yi42jORQ8+l0HrZ9RH5up98amfXlxTGMBnbLZC3+wy
        mnR4zgJGbpS4CtLummHigjPy
X-Google-Smtp-Source: AGRyM1vdlOuIhStOukaZaKNtQymOW5qmi9OAX8KygWQHn2MbA8+rSTHJAyUlU7dnHsptfWpog3SK0A==
X-Received: by 2002:a65:6bca:0:b0:411:f92b:5e39 with SMTP id e10-20020a656bca000000b00411f92b5e39mr18955965pgw.259.1659469589376;
        Tue, 02 Aug 2022 12:46:29 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902684a00b0016c29dcf1f7sm80843pln.122.2022.08.02.12.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 12:46:28 -0700 (PDT)
Message-ID: <f3235afe-25cc-21a4-fc35-56e35d6be0ce@github.com>
Date:   Tue, 2 Aug 2022 12:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 5/7] builtin/bugreport.c: add '--no-report' option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, emilyshaffer@google.com
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <d6527049a4f62f3b1f008706443a11a0e0816074.1659388498.git.gitgitgadget@gmail.com>
 <xmqqbkt3mw8w.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqbkt3mw8w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a '--no-report' option to 'git bugreport' to avoid writing the
>> 'git-bugreport-<suffix>.txt' file. This gives users the option of creating
>> only the diagnostic archive with '--diagnose' and mirroring the behavior of
>> the original 'scalar diagnose' as closely as possible.
>>
>> If a user specifies '--no-report' *without* also specifying '--diagnose',
>> the 'git bugreport' operation is a no-op; a warning message is printed and
>> the command returns with a non-error exit code.
> 
> I think this makes sense from scalar side, and I have no objection
> against this "--no-report" feature existing, but I wonder if those
> who want to send report may want to have a handy way to tell the
> command to "include" the diag archive in their report (instead of
> creating separate report and diagnose files, having to attach two
> files to their message).  Perhaps that is unneeded, or perhaps that
> comes in later patches in the series, I dunno.
> 

I tried finding where in the documentation there are instructions on sending
a bug report to the mailing list, but didn't see anything (otherwise, I'd
add some info on '--diagnose' there). Maybe Emily would know?

If instructions like that don't exist, I'll update the command documentation
here to clarify that '--diagnose' generates an attachment that includes more
complete repository information to aid in debugging.

>> +--no-report::
>> +	Do not write out a 'git-bugreport-<suffix>.txt' file. This option is
>> +	intended for use with `--diagnose` when only the diagnostic archive is
>> +	needed. If `--no-report` is used without `--diagnose`, `git bugreport`
>> +	is a no-op.
> 
> I wonder if thinking it this way may make the UI simpler to explain.
> 
> The "git bugreport" is capable of showing report and diagnose with
> these two orthogonal options, i.e.
> 
> 	--report::	writes bugreport file
> 	--diagnose::	writes diagnostic archive
> 
> And for backward compatibility reasons, the command pretends as if
> you gave it "--report" when you run it without either.
> 
> That way, "bugreport --diagnose" will just show diagnostic archive
> without having to pass "--no-report".  There is no need for "nothing
> to do", either.
> 

I like the simplicity of this, but I'd imagine that a user would want to
generate diagnostics *with* a report more often than without one. The cases
I can think of for "standalone diagnostics" are: internally in 'scalar
diagnose', someone requesting more info after an initial bug report, or a
user looking into something on their own.

Maybe I could replace '--no-report' with '--diagnostics-only'? Then the
three modes of use would be:

- 'git bugreport': report only (most common usage)
- 'git bugreport --diagnose': report + diagnostics
- 'git bugreport --diagnostics-only': diagnostics only (least common usage)

It would eliminate the need for "nothing to do" while making it (I think?)
clearer to a user why you would want to use any of these options.
