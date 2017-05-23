Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE7A2023D
	for <e@80x24.org>; Tue, 23 May 2017 05:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761277AbdEWFWQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 01:22:16 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34878 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdEWFWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 01:22:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so24925574pfd.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ltLWVANnYirHDT80V5EJc+zF656X30RDbmQ1hve76Ik=;
        b=Er0cTsnEKuSFea6wOPwpequMuVoWWZVOAcAn4cOiTGlAs6AsAbMtWb8vqknRhV2hXE
         Sn23atXTJnXf1fee+In/RCJ/ivw8WIzPcCeU4SKgfcJbVD+xH2GNm3LJFkn0qF7K6+Nl
         VGKMt1l6QNmrgsZj+00ggeMseDAZqkx8F4eyAq9u1TVrh7BYfvc6deuIOplXArQ181Tk
         XHrhnNaxkHqGvA4nAu1PjttxO7o/JDLbDPfDt8rG+uJdoMgu6DqsbpWX4MqvZTt2TYdP
         SJ9boQu1XcCWS32gjb7BuBLOkZ8w+HlpAJnAoTagqKJq4fJufO19P4OnXk84IutzlxhJ
         V7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ltLWVANnYirHDT80V5EJc+zF656X30RDbmQ1hve76Ik=;
        b=XiQjRG9x8Lc0Pp1SEBKKgKE8z/OAVOWDCjEx22Os0lsd2f2wZyFKffkWHkAJFLVeqO
         TWCPtMNzAl4u8iYpMfPkknydH4ULQ33jL0ZKl/scp5QLDPlj8bCUMC7ZdNoHU+s8v0SV
         1+5ZhKwvkQXG4bMGjpayptfdxA7gxDzqbStq5GX97KXcI22SgEgKo0ff2c78aNqf9Pvr
         PFgXQMOdacWkwHW9AZT3EE7q8KSFpFMcVoToEFNNW97lmlNrqJpoZ5egR1tuk6pZoS5n
         TsmX373dipASgvdk2g8oVGyN6DhdOZPN6yafjosDrQD7pG8LyMNl7O24DOMQlK+q8ERj
         1O4g==
X-Gm-Message-State: AODbwcDEKGuz8vRXTNEc6Waj661Sx585hF45EZJFNaLIdQEQNX+JFIt4
        LYSj0ySStSsweQ==
X-Received: by 10.99.125.12 with SMTP id y12mr1431618pgc.5.1495516934623;
        Mon, 22 May 2017 22:22:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id m8sm34747941pga.34.2017.05.22.22.22.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 22:22:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
References: <20170522135001.54506-1-larsxschneider@gmail.com>
        <20170522135001.54506-5-larsxschneider@gmail.com>
        <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de>
        <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com>
Date:   Tue, 23 May 2017 14:22:13 +0900
In-Reply-To: <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com> (Lars
        Schneider's message of "Mon, 22 May 2017 22:37:29 +0200")
Message-ID: <xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>>> +	sigchain_pop(SIGPIPE);
>>> +
>>> +	if (err || errno == EPIPE) {
>> 
>> This looks strange, at first glance.
>> Do we set errno to 0 before ?
>> Or is there a trick that EPIPE can only be reached,
>> if it is "our" error ?
>
> You are right and I'll fix it! 
> Thanks for reminding me! 
> Peff also noticed that some time ago:
> http://public-inbox.org/git/20170411200520.oivytvlzkdu7bfh5@sigill.intra.peff.net/

Ben Peart's bp/sub-process-convert-filter topic also had the same
EPIPE issues in its earlier incarnation, IIRC.  I haven't looked at
this topic for some time, but I wonder if we can share code with it.

