Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C587F1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 18:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfBPS55 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 13:57:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40400 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBPS55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 13:57:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so4790598wmi.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7dfV3rjBJWPvIssviARascA0VgxnORUWi3w3Rq6vpoY=;
        b=Hbmbp5VPYsrI0r1x3ez8m+NyM+1JCyc9m2S3JxkqLUwwZ09f40OdZacSdwATz0reet
         wPgzceK+iCRv13sFRICZ5+C+GGXFeFWtC9oikUBvoecqrtUCpROQ7sKGlnWLqIZDz6pK
         Y2W+8glLkI/+Uj+70+uobubE0WO2ljbqKAdp4brepyKwwBCKgpWcSKWxan9N4uRbVwQO
         HUS/WMOpWOzuryk+b9YtSEUhzA974D0DgwJFzEWgGoPeCLPvJiwy4PS7uxxaB/eGl7N6
         aiPmlJcUoSXKjiT6TVcTnQkLLkKZ2QPLB5EIvL4n/u4UO7CUiKP1UniTdz0TEF3V3hgd
         0GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7dfV3rjBJWPvIssviARascA0VgxnORUWi3w3Rq6vpoY=;
        b=i77nSnHVFZKFepiwAeu5Wt2xIIIlNBIA7m3o4udMgI//BzRXtMSj3IkufZRDtOWiQG
         dIJ68tAuJJ1Bo+T3mVuiSMmQi6oyHElxs3Y0ZGWJFILNjarj6PuLhCO8r1gmlbxSeL3f
         VYg2S7dT02odU4tFS+qyaqWHxhbnLuPnlVVxxS6u+9Jy9AiUxrYOznJvNLn4LSbvJsrc
         Px4pg3toE15TvNayUNW2iVebTBYCVDepIdA7JB33FvS3QA5icwTgNCwZ4rAJR7j8nfZo
         0lCdjBCx/uLz446kb8GtRIDTrnN0K6gWc25WUN+KSdI7v3v5LTn/gw3FVAZj40E3GvD1
         vkfw==
X-Gm-Message-State: AHQUAuaC5Fxz7CMJRLqnWV4xEO52LzjF9R5V6m+hgt7Y/Oy5JKFthl8A
        Xh/xUfFGt7ZY3GSS0M0j5x0=
X-Google-Smtp-Source: AHgI3IZf9pnZOT8y0obWkNKxft7HgQU3C4C5FEITBxf6ATVm0rVtk14s3ZR7E/TrytvBHLHdL0Ewcw==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr10518273wmg.111.1550343475108;
        Sat, 16 Feb 2019 10:57:55 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r15sm9351016wrt.37.2019.02.16.10.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 10:57:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Max Kirillov'" <max@max630.net>,
        =?utf-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
        <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
        <000001d4c624$da8e05d0$8faa1170$@nexbridge.com>
Date:   Sat, 16 Feb 2019 10:57:52 -0800
In-Reply-To: <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> (Randall
        S. Becker's message of "Sat, 16 Feb 2019 13:24:23 -0500")
Message-ID: <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> > The current condition of the code is (the generate_zero_bytes delete
>> > was previously removed so can be ignored for the patch):
>> 
>> Just to make sure I do not misunderstand, this result is with Max's patch but
>> without the generate_zero_bytes stuff?
>
> Correct.

Thanks for a quick response.  I've been staring at b46221ff ("Merge
branch 'rb/no-dev-zero-in-test'", 2019-02-13).  IIUC, t5562 wouldn't
have passed if it still fed http-backend from /dev/zero, no?  The
shell redirection would have failed, so we do need to keep that part
of the change---i.e. in order to pass, we do need cc95bc20 ("t5562:
replace /dev/zero with a pipe from generate_zero_bytes", 2019-02-09)
and Max's "t5562: do not reuse output files", right?

I have been wondering about the whole /dev/zero business.  Although
we have b46221ff ("Merge branch 'rb/no-dev-zero-in-test'",
2019-02-13) in 'master', "git grep /dev/zero t" has hits in
t/helper/test-sha1.sh and t/t4152-am-resume-override-opts.sh, so it
must have been somewhat incomplete to help platforms that lack
/dev/zero in the first place.

We haven't heard from Dscho in European timezone, but I'm
inclined to

 - keep b46221ff in 'master', not reverted.
 - apply Max's "t5562: do not reuse output files"

to 'master' and hope that we can declare victory in this part of the
code ;-).  There may be fix-ups for other topics before -rc2 on top
of that, though.

>> Thanks, all.  Hopefully we can get this test failures behind us before -rc2;
>> knock, knock...
>
> Once the fix is integrated and in the usual spots, I can verify
> with haste. The full test cycle is now at 50 hours (argh), which I
> will rerun in full at rc2, but this one is fast.
