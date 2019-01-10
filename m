Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B511F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfAJTqo (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:46:44 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35551 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJTqo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:46:44 -0500
Received: by mail-wr1-f54.google.com with SMTP id 96so12782920wrb.2
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=ggJoc1j1EiHYLw1G+xpvNIiexrgmVHjBbdcaxdN+xjU=;
        b=Ei8qAnMSZvU2B6e95JIVxOLXjplVQdsN82LPB0vsSlT5CBeboAwfZZsVDJ2lUM3ZVc
         W6kDtsGSnXmPFEbOUaNzMZjD1cyK6X6vhVxQ6JD3a61PfAt6E6J2xyng5Pi/X5PFeMIG
         YElc8Eli3XY1+SRCHs/FfsCOtadUTDbIF5RjWj5plbzfA53mXe+xlEs/guilf7Ps4fnj
         1di1ikhV8bK6grEzyB1cKD7y+qxVq7V8LibSdKLPaNUAXswRsSfJGpLyOrHJwjwMS7PQ
         19mDoenEAjXiUT9e7OmUvybMB1/aOffAx8vKUOiW4e1PnX7wKz+ZxaRV9jSHjf06kHb0
         oxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=ggJoc1j1EiHYLw1G+xpvNIiexrgmVHjBbdcaxdN+xjU=;
        b=r/0VNMvqOlQ5EC0nuSa3fl+dQRZVEiV2js0lzCUxjhEX7I2aUGv8qUGK1ipPip4gyG
         EIx46OCQXy2GrpfQgUFlX6IOH+0qvi4FToUs8fGgAzt8CgN7R6oidHwaJ94z5O8pOPHa
         XafslsxiqTaFRazY71qJ99PcBz/BNUwlYEpeI7+IcjjBIhSYVDcKYZ+glpmukvzDHh8j
         V9F+ZhPhZhWiDFsdx//LKyIqEpaEn34UjdSuyWanBeq1+EQK1bUvYRYKq1TImswNwJlY
         m4SW97S6B1f+HoWtMKROAQVF3O1waoPXhoP3RM+rya6UlU1BfiYUftBkSOLmGuZwbQoE
         8E4Q==
X-Gm-Message-State: AJcUukcVW13L3oyuJeWPtMXLCa2hHf8lMaGHesfIj/xjz+vAZNdVKA1r
        a5ifb/mJbu1yxAgJpmdjrgw=
X-Google-Smtp-Source: ALg8bN7ioxEKVEIZsdBkL8Bcg/OAaqdzP49/wb/HTircM1Hei4QiQvFW924VkvSogt+BDqxJtnV9nA==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr10290785wrt.63.1547149601505;
        Thu, 10 Jan 2019 11:46:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r77sm20725157wmd.22.2019.01.10.11.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 11:46:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
In-Reply-To: <20190109102836.GA6743@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 9 Jan 2019 05:28:37 -0500")
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
        <20190109102836.GA6743@sigill.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 10 Jan 2019 11:46:40 -0800
Message-ID: <xmqqva2w1ejj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 07, 2019 at 03:34:10PM -0800, Junio C Hamano wrote:
>
>> * jk/proto-v2-hidden-refs-fix (2018-12-14) 3 commits
>>  - upload-pack: support hidden refs with protocol v2
>>  - parse_hide_refs_config: handle NULL section
>>  - serve: pass "config context" through to individual commands
>> 
>>  The v2 upload-pack protocol implementation failed to honor
>>  hidden-ref configuration, which has been corrected.
>> 
>>  Will merge to 'next'.
>
> Sorry I didn't catch this before it hit 'next', but I think we were
> planning to scrap this in favor of:
>
>   https://public-inbox.org/git/20181218124750.GC30471@sigill.intra.peff.net/

Ouch, indeed.

I did recall that <20181218124852.GD30471@sigill.intra.peff.net> was
the final verdict, which did mention that message, but somehow I
final onefailed to act on it.

Let me revert the merge and redo the topic.

Thanks.
