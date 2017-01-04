Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F26B205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 11:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758910AbdADLtR (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 06:49:17 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35700 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757176AbdADLtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 06:49:13 -0500
Received: by mail-io0-f194.google.com with SMTP id f73so59509532ioe.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cY+RTiNL/nc9KmLRheKxmPBUMb7Ah9C3rO9BKHZDbWo=;
        b=rBqhJLW4ZqXGKlJMU9CCh7sd5wsAnVldriaiIwwtZjargpZlqzeNaYRJDGR7KTppti
         GWZl2G4i+mK65qvtjmwF6buDNsRT1Y+t2jOsISzSugBoSVgzNwDPno6IGNae1B6x7Po4
         MR2WS3UV94qhr8x1dCVJTxg7rk6XP6M/dGUj9WIKkjJlgcSXaMNFC92U8CA6cIyvyjEB
         FAllgeRaJFy9i05iGusmZahi7TwJbTbV/5/TNNteI4ARWeDCfxrsZZtJb6tmyEiZ6ybT
         B6q2ZfE3c4IhNVwBxc325osrV1ayHlyBpJYdtwQa3qViAnp0r5yBaEiVLXLx4hrHXDxi
         O8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cY+RTiNL/nc9KmLRheKxmPBUMb7Ah9C3rO9BKHZDbWo=;
        b=kUjLGSeKAp96ebZjfA6pcZcyWEJHVcJSvb5flA2QBkp1xkFRCECxvDXaeTVSbeEogK
         faHkWPkODWZwFOazgDPvPjqSNnToGojO+lexq7jSuR4LQYC7dJKTj7042o27b16M6NoZ
         Ja3ELagPyNoO0XtqqEbHm94iTgLZXHHUMABWeHYB2SNEG+xQX7KpQlGFXulaSpoGJdA2
         wvO6nbohhbwm9vO5dI3IpWIHvcwMZoRJCcfclqrNY+JrekwZ3CEQAObfJ0xSMvjs3RQ8
         CSJsgNUN9slRQvsxDQajNIn1wYU7ieU8hIj+8CWLmj45Ka/bzp9Se/jqDGQBkobRKI9R
         i7Ug==
X-Gm-Message-State: AIkVDXIS9rRohHy5S5BucIaYx/xrpy2RBU+bvvJ8BnJwx0mbNxMIP1fxonaLAMoI7vhpPuVFUSkWSvhvxGf0Mg==
X-Received: by 10.107.182.70 with SMTP id g67mr61199333iof.120.1483530552488;
 Wed, 04 Jan 2017 03:49:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Wed, 4 Jan 2017 03:49:11 -0800 (PST)
In-Reply-To: <CAE5ih78vLwDubesnAxD=g3TzsbN0sQZae3McdFcwDAZfYYhXSg@mail.gmail.com>
References: <20170102184536.10488-1-pranit.bauva@gmail.com>
 <20170103195708.15157-1-pranit.bauva@gmail.com> <20170103195708.15157-2-pranit.bauva@gmail.com>
 <CAE5ih78vLwDubesnAxD=g3TzsbN0sQZae3McdFcwDAZfYYhXSg@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 4 Jan 2017 17:19:11 +0530
Message-ID: <CAFZEwPNuWf3WPY_WjTK8on1mzC58nZgmFhNdkmqQY5=-HE9XCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t9813: avoid using pipes
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Luke,

On Wed, Jan 4, 2017 at 2:41 PM, Luke Diamand <luke@diamand.org> wrote:
> On 3 January 2017 at 19:57, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> The exit code of the upstream in a pipe is ignored thus we should avoid
>> using it. By writing out the output of the git command to a file, we can
>> test the exit codes of both the commands.
>
> Do we also need to fix t9814-git-p4-rename.sh ?

I don't think so. As Johannes[1] and Stefan[2] pointed out, we should
avoid upstream pipes for git. p4 can be treated as an "external
command" just like grep/sed.

[1]: http://public-inbox.org/git/285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org/
[2]: http://public-inbox.org/git/CAGZ79kZRFLzD7wcAnFvke9vBxxTAgE7=Ud7F_O95EfkWqz=LJw@mail.gmail.com/
