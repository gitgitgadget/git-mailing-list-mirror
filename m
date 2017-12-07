Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEB020C31
	for <e@80x24.org>; Thu,  7 Dec 2017 06:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdLGG0j (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 01:26:39 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:46832 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdLGG0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 01:26:38 -0500
Received: by mail-it0-f67.google.com with SMTP id t1so12221446ite.5
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 22:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bfa70BUMSlArXJlmnsnFgV3zWYqVVyy7+RbPETPAP9g=;
        b=u+Xd7PIbObhMlgwGabxnNl8AUAQXZVMmhitsgTO7UYEUYhDrfHg9U0vLD1J2lTDrup
         lHQb5GtFpidUXfyr2DejFU5gYku3pGO472gT3Q6+BoxnIpWTbKVjrLQdKs/k2y3LdjrS
         mGnEMIfwyLzDa+QqsSdJPU+lMzC7zz3fARHfCho1+hHrc+so2/ucjNnSl3l5PrPQRYXn
         lk/8Q1ZkE5ITBxrD4YQvQEdnkp0usPYExLZuS6CsTkpC5in+7ODS9i68kEOjdrU7HpMa
         XFFyzceYrfKxKBlmRFkcmNxFkl2Oi0mrubpBVJoP+GpjYKV7bRcX/4Ag+9nbYRKl55Qb
         8pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bfa70BUMSlArXJlmnsnFgV3zWYqVVyy7+RbPETPAP9g=;
        b=pYmhIVDn6PH1rvtfdcuUxhMojXRpAiKD1jkgisrSWgSGk89VUPwtvnCof6I/TuKgb3
         mtyY0eWvOq0ezN4TzXP79Xkbi4P72ccDDbujzV7PVqIOFP6GJllE1hiGjvXPMT9bPlqh
         d3uFstX09paYHGEop6b81Yf2QKJzlhEEymLe83msJEvkxn/gPsRrku1U8h15RZ9yWZnt
         VAtNbMnpiS6mEQW3eXiVweyY0bIs/CiT+vMlaucoZZONmK4B+vdoKg5urMKGIYTmqqtB
         lcfY1Q/JfdA2jwUof2CpiSU9C9g1hDDFBOUmvySVs8+f5dcLYwrs7gz0cuweh1qLbzia
         Tjug==
X-Gm-Message-State: AJaThX7yAH5YYu/dINZ5MFZYPKWSRlUYf0eiZ5ToA3xuwh5UrzQWiXhg
        3j4UX6qmzTjMWgUFueAeGTFIwDnB9jn6U91M6TQ=
X-Google-Smtp-Source: AGs4zMb1HKQFunIjRNX86HS/5Gqb36EnAWcKtIkX4PPuakphlFfxkY7irUqIoSkJ8pLbFdhuk+LWtDl1p3pZLfzmk8E=
X-Received: by 10.107.47.234 with SMTP id v103mr34373988iov.96.1512627997717;
 Wed, 06 Dec 2017 22:26:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 6 Dec 2017 22:26:37 -0800 (PST)
In-Reply-To: <CA+P7+xpeBsH4QGmv-m2i4RQ7DdZ9pMnpHmFi_=akDkg0CTj+pg@mail.gmail.com>
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
 <20171203170415.15939-3-chriscool@tuxfamily.org> <CA+P7+xqD80v=CsbT003b7czro4CZ77CJMppAhbQOPo1ssqTsKA@mail.gmail.com>
 <CA+P7+xpeBsH4QGmv-m2i4RQ7DdZ9pMnpHmFi_=akDkg0CTj+pg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Dec 2017 07:26:37 +0100
Message-ID: <CAP8UFD3H3PGqFyQoNwwi9ZA2_WM7Q_3pikbmEOnLLHfD4k4ahA@mail.gmail.com>
Subject: Re: [PATCH 3/3] diff: use skip_to_opt_val()
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 1:18 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Dec 6, 2017 at 4:16 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> This causes a regression in the --relative option which prevents it
>> from working properly.
>>
>> If I have a repository with a modified file in a subdirectory, such as:
>>
>> a/file
>>
>> then git diff-index --relative --name-only HEAD from within "a" will
>> return "a/file" instead of "file"
>>
>> This breaks git completion, (among other things).

Ok, thanks for the report. I will fix that.

> I believe this occurs because skip_to_optional_val overwrites the arg
> even if it's not there, and the --relative argument expects prefix to
> remain unchanged if the optional value is not provided.

Yeah, that makes sense.
