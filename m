Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1701F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBWW0I (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:26:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38971 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeBWW0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:26:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id 191so7140813wmm.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uJZlT7H1zYqMb+hMbdaZtkhCsTeCLUiHUiVE8RrisWg=;
        b=M/tk4lLWxmtdy5qp7VECnBTUbFDpPXrK936DlUlRT0FqmS/XdMmHAdtwkhHUMDgfqp
         fOuHkYfBo964FC8A74uaFapOgA/oZNgDqYOc1RwIVY6LweRtJ/Hx1MPVRb5AmP663gmY
         eYOc/T4AjBWRNoXrErvsTajIskBC4NHiWrnoMs1+T/+pQ+fsjFr6jDSQTKj150B3D3bB
         Er+WGbZwFQ/I61EbC66N3rHixTYZglwT3AL8KAvgqEHwchCnghBwoQYxT3XxykdqJTJv
         aXKfZqXGl30iFZNr3SbQ1Ak4CPW32TsjB6iIyaUUUm/i5J/1YRi158Gpxbz4cx+xC8mh
         uZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uJZlT7H1zYqMb+hMbdaZtkhCsTeCLUiHUiVE8RrisWg=;
        b=pYHBEb/kvaAlAQmXL0uod4bhQV69ZiYVx38NRIS8AAGXm9FvyzU9H10pdmlKmrYcUF
         IQD0hWaGn2XjBuQb2cKltnFzA70ffZdFzdMPEq6XFUcITsVUgqc7pSmf0YBOQmrCMjBP
         e/ICfdwRLX2GotzCA8zanEif+xmPi+/HpkQBtvnlHUq8ITP2sgfcaGYH0SwDVLqg3LCK
         p4VLjfbpBs93lj6dOt4wfNRAFyPtkgGvlm4N3Blvnw8b3rc8LEz4XVoQFEMudx0/PcEq
         k1ZpyOsJiL/sBN2h1yCqk5GWRyaxl+urHTXQDERYS1oaLjurTJV251vtHPcdUGfGjBQN
         l/eQ==
X-Gm-Message-State: APf1xPBvWsxjWL04BL98fTtu2s1S+wF4G78NId2wG3oaH78oRgL4c7Xv
        8F+NwWkbV8ZPwBWkhEWF0sw=
X-Google-Smtp-Source: AH8x2274ya4Ev9XFWOLqKVcj2xxB/vnRc40eFYjapU1dJYheMNKdZc/MXBgiXPca0R8Cegkr0EbvTQ==
X-Received: by 10.28.11.147 with SMTP id 141mr2713487wml.138.1519424765738;
        Fri, 23 Feb 2018 14:26:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h50sm6021031wrf.65.2018.02.23.14.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 14:26:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
References: <20180214180814.GA139458@google.com>
        <20180223095640.25876-1-pclouds@gmail.com>
        <20180223095640.25876-3-pclouds@gmail.com>
        <CAGZ79karK7MT_qpFyYfVkioeBsBHidGdC_QfisPmG1a4dQuk5A@mail.gmail.com>
        <xmqqfu5rtrhg.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZUyo-C8FvphXh8dO8s0V5-Sa=fP=faXEiyD3xSezQsRw@mail.gmail.com>
Date:   Fri, 23 Feb 2018 14:26:04 -0800
In-Reply-To: <CAGZ79kZUyo-C8FvphXh8dO8s0V5-Sa=fP=faXEiyD3xSezQsRw@mail.gmail.com>
        (Stefan Beller's message of "Fri, 23 Feb 2018 12:04:22 -0800")
Message-ID: <xmqqfu5rs5qb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 23, 2018 at 11:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> I wonder if there is yet another missing case in the enumeration of
>>> the previous patch:
>>> Some commands are able to operate on GIT_OBJECT_DIR instead
>>> of GIT_DIR (git repack?), which may not even explore the full git directory,
>>> and so doesn't know about the hash value.
>>
>> ... because GIT_DIR/config is not known?  "repack" is not one of
>> them, though---it needs to at least use refs as the starting point
>> so a standalone OBJECT_DIR is insufficient.
>
> Yes, I could have worded this as a question:
> Is there any command that operates on GIT_OBJECT_DIR
> without trying to discover GIT_DIR ?

If somebody finds one that would be a good argument not to pursue
the approach.  Lack of response to the question would not amount to
that much---it is possible all people who bothered to think of
overlooked something obvious, though.  "When I asked around nobody
thought of a possibly way for this to cause breakages, so let's
declare it is safe to do so and do it" is not how we want to do
things X-<.

