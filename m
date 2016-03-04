From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v3 2/3] test: add test for --[no-]autostash flag
Date: Fri, 4 Mar 2016 11:13:08 +0530
Message-ID: <CA+DCAeSWhtDuQmYkppz2iR61b6dcaT6SsF-=wcqE1dM9XoTfEw@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-2-git-send-email-mehul.jain2029@gmail.com>
	<vpq1t7rii3u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 04 06:43:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abiWB-0003fE-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 06:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbcCDFnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 00:43:12 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34694 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcCDFnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 00:43:09 -0500
Received: by mail-qk0-f196.google.com with SMTP id u128so1445458qkh.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 21:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8UaIlA1lNuS2uwlVTa22Z+e8SE0C9l5xF56fmSzu3nk=;
        b=PmTCn9wX55SFxeOVhvTlCouH3urD1t2f5TAKv00Vufvm/nWNe0GIKEWQnSMFTEkj1+
         jq7l6j5GPUjqJpxYIBwTGJYGYc17JJPQp2UbisqRhvS4m5lorSMYr2A5XqcWtCuoLf9k
         0FbNcEPoflB7PRa9RS83bfwCC7/XJ5enlizip7esgx0SsKh1fGsuBDsjsCKvTwkFPucN
         6kt1dK3eltyLZh21bt424B0BXTGS+twtSU12JG1RnN3I8JHCiYt71BZ5GTuQ1nQGm3bZ
         wiCp86kA508fNO9A7+McHCyzBwZ81V51ELzAXVtI3wkUpW/43JD9Nl1kBwJH/AbazMhD
         FfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8UaIlA1lNuS2uwlVTa22Z+e8SE0C9l5xF56fmSzu3nk=;
        b=SF/LadGvgISeRv3sSn5UHKiGekSNlZ9LyjuXas4/JPNOpxjl+llAgCnGOUFo4zMYoG
         t05AD2ImtrRudPDyRMFiIMpBhpKtO/6x0+RAjvTM1aNsYOc5zW+KK+Zdlbz2/CDD4Ak9
         i4wzxcAG5itLOeMGcRAA30mSPTssSe6tsHFO+g4FaVEnFIyknhGjWP+/7B4ImiFS31kP
         RzM1XJpjUw+sd8I1WbyBIvtyObND+qJ21T4/A731Qbzc++GraGFqoarjaXjagK/lKTT8
         owaZMU17fdqMfRYEd9ZKVrbAwIbPRikPcqQWkK3BJM9n6hdyKEJAa3kQ4GNDUU24Iuko
         bC/Q==
X-Gm-Message-State: AD7BkJJdHJdsbxb+TB20DevWGP5vHvQTfoJiFq34+j5RK2477NxoxIpZllCqVAungj9fyF5f02rOgVJ9ZPQE9g==
X-Received: by 10.55.82.70 with SMTP id g67mr7916825qkb.57.1457070188339; Thu,
 03 Mar 2016 21:43:08 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Thu, 3 Mar 2016 21:43:08 -0800 (PST)
In-Reply-To: <vpq1t7rii3u.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288232>

On Thu, Mar 3, 2016 at 11:01 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> There's no need to split code/test/doc into separate patches, except if
> your patches are getting really huge. As a reviewer, I like having tests
> and doc in the same patch because they describe the intention of the
> programmer.
>
> We try to have a history where each commit is equally good, and with
> your version there are two commits where --autostash exists and is
> undocumented (which is not catastrophic, though).

Alright, I will make a single patch for the next version.

>> --- a/t/t5521-pull-options.sh
>> +++ b/t/t5521-pull-options.sh
>> @@ -62,6 +62,22 @@ test_expect_success 'git pull -v --rebase' '
>>       test_must_be_empty out)
>>  '
>>
>> +test_expect_success 'git pull --rebase --autostash' '
>> +     mkdir clonedrbas &&
>> +     (cd clonedrbas  && git init &&
>> +     git pull --rebase --autostash "../parent" >out 2>err &&
>> +     test -s err &&
>> +     test_must_be_empty out)
>> +'
>> +
>> +test_expect_success 'git pull --rebase --no-autostash' '
>> +     mkdir clonedrbnas &&
>> +     (cd clonedrbnas  && git init &&
>> +     git pull --rebase --no-autostash "../parent" >out 2>err &&
>> +     test -s err &&
>> +     test_must_be_empty out)
>> +'
>
> Not sure these tests are needed if you have the ones in t/t5520-pull.sh.
> More tests means more time to run so testing twice the same thing has a
> cost.

I agree with you. This test may not be needed as t/t5520-pull.sh already test
this option.

Thanks,
Mehul
