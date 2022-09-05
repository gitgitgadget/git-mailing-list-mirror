Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAB6C6FA83
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 20:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiIEUaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiIEU2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 16:28:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D445F51
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 13:28:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa2so9257405pjb.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=PM9wK5TAHePQMMHdhEI+7bSpNKsA5sN6CEF2bGgroeQ=;
        b=Yo4J66tDiwDb4OJIHESUTn8OiF7laEvrpXXnNs6/m7mEMVuMLOb8wWbWc8gfbttWIl
         1u0HRHhVmy8Q9RH+aMvQkV99fAUgcCjUfyArNo6SvZyTtXhnfmtA7IjMeJn4RiSE1Yum
         g2ga2gmXH/1MCnhw6+C/oe96fxKy/HtvO20kSpcy1UI0cWMSOn+GpM4OyGKgT4DsQw8t
         HXXLw9m/QEmAqwWhEAFuSTGzBzmxv8VCHmm8xrT4pynRdHuBS2EefLHHzv44+IWv3/P/
         Lt8DE67oHgyNA0MifoqLtVr6oLtx3bn99dd2ampnkNyN9RWGMCz1A11rRjQK4TzQTcpL
         C0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=PM9wK5TAHePQMMHdhEI+7bSpNKsA5sN6CEF2bGgroeQ=;
        b=5NoxKU1t9VoMP8SGvXKug2Xjuey2Bm8nNr5xaFppWUXUSW+y02IzyVRehityA/Bc9/
         4+o9CF8m+qvMPZtldkvKUzyd8AdXs/UBK9DnMo5LsHrc/oq4bHAO3GOd78AlSDhnba02
         0R/tvTTQNZQHG3yE9H4mTAjqCv6w0l/wR3RPaf+SRPzRcf+WgR7Tc6FP4NtBIk4yHlko
         2utopH72CjPIm4EkOcfCiQR4HP2cFGWenr5uSU7xYpLAavWAE4UQ00EAa8m2hyPPyI4G
         tqHvZOgJe1f1m2AwIx8Xn8PANYh0E85uvMnR9TZ1mxn9WMf+X1prJxm3nnj3Y2ZiRMxL
         GlLw==
X-Gm-Message-State: ACgBeo1JCNh+pGeAXl7FCt2X3wSrNtFSyma+kYeKWUSV+be6U5v6pQz5
        YJ6lZrwgycbGo0XaSmEtXx/ubjp18pM=
X-Google-Smtp-Source: AA6agR7NIuRZHwcoAfXPMjb+NVDE4zgHol/r6zFlL/xTnW6ATQybvpre3wPuTVMlE78I0tAyzEl6Fw==
X-Received: by 2002:a17:902:7c94:b0:170:aed6:7e6c with SMTP id y20-20020a1709027c9400b00170aed67e6cmr49335061pll.10.1662409680732;
        Mon, 05 Sep 2022 13:28:00 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0016f057b88c9sm8085078pln.26.2022.09.05.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:28:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
        <xmqqwnal7gc9.fsf@gitster.g>
        <161877q5-843n-q73q-6q3q-sq2664s6q340@tzk.qr>
Date:   Mon, 05 Sep 2022 13:28:00 -0700
In-Reply-To: <161877q5-843n-q73q-6q3q-sq2664s6q340@tzk.qr> (Johannes
        Schindelin's message of "Sat, 3 Sep 2022 11:29:35 +0200 (CEST)")
Message-ID: <xmqq4jxl1s8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 2 Sep 2022, Junio C Hamano wrote:
>
>> "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
>> > index 601aae88e9a..43400fd6025 100644
>> > --- a/Documentation/howto/coordinate-embargoed-releases.txt
>> > +++ b/Documentation/howto/coordinate-embargoed-releases.txt
>> > @@ -1,6 +1,121 @@
>> >  Content-type: text/asciidoc
>> > -Abstract: When a critical vulnerability is discovered and fixed, we follow this
>> > - script to coordinate a public release.
>> > +Abstract: When a vulnerability is reported, we follow these guidelines to
>> > + assess the vulnerability, create and review a fix, and coordinate embargoed
>> > + security releases.
>> > +
>> > +The `git-security` mailing list
>> > +===============================
>>
>> Dissapointingly, addition of these two new "=====" underlined
>> sections breaks the documentation build, which broke mi build
>> locally as well as GitHub CI [*1*]
>>
>>  * https://github.com/git/git/runs/8162258928?check_suite_focus=true#step:4:658
>>
>> Fix should hopefully be trivial, keep the original title line
>>
>>     How we coordinate embargoed releases
>>     ====================================
>>
>> intact, and make these two new sections underlined with "-----",
>> demoting their subsections one level down accordingly.
>
> Here is a fixup, could you please apply this to the
> `jr/embargoed-releases-doc` branch?

Thanks but no thanks.  The contents change is needed so I will wait
for an updated patch from the author.

