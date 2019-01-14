Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B5A211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfANSeL (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:34:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40787 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfANSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:34:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so5115wrt.7;
        Mon, 14 Jan 2019 10:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wOOFjz25e0rbeAGojzNe9yPMeLW6RZ7UGffDuYe2Ogw=;
        b=aT/Qfl3Gyrop8HHf8yqyvYbQNLy0zJ6J43+I1XDL3gXzzaxgSnyjtU5fWNWf0jgbTz
         /8utEiplMbSeOi0UxHQsT8rMg3GQQUYkiUZNHvTqm7cpYyYe8A16oNsofHIxGwpxJmUD
         NDuAUAWUfWPl2St4zPs1L9KOP3FlVHn9ovTKK+6QxPq64mjf3oDYiXi59YI2zjJ5V5Zp
         W/v7eQI4NpXfxL9++0RVWHUrFnLVJAHRp4cGLgxHAqpA52WMc8JPnuiz+OS6ULfsjRbD
         J88e889vrqIQqSJv8WNTWRXy5jMGJ2o/T1OpSr0rDPEeVZNNmfFFhwb3xCmNW+fOdIM2
         Jm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wOOFjz25e0rbeAGojzNe9yPMeLW6RZ7UGffDuYe2Ogw=;
        b=cqDsXQck+OJOL0O5mlqcegly3P5TlF/PV7fyKh4lau5clgK7X9n/tHFdrNdZrGLuHc
         Ts94pnbSLIVCm3U6cq5bWfP6NP9Kq19/ttSFrtoy6CjClpFwOcXk93KR4GZZUSmjQYdj
         eijSf2OWDmbpenvO9+FOj20aWgXKexNYi4jCQWwgHTfrHfifl9Ifxz5s741j+8kh7JVn
         /UuPNeWMXqxZlg0wDr2YWiS8hEs3Hi0pg5oSsTkpaUg+18674RtR/6SGYRQG3mQ+XyVc
         w/FuaDoq4y1k6k6HHrw1jiz6ilK5B762SWEm09NmHcSlOQlny/Nwjsz2TO+jXaSFJ79d
         KxHg==
X-Gm-Message-State: AJcUukfcN7SkOpIO369ay7NHAqn3qBaYjWQqVXnBAiP9wA+O3MbsJTg4
        04ZOl7zZRiFaK56np1sHz56xAhDB
X-Google-Smtp-Source: ALg8bN6dBbHDF324e9ARK5vYIQvDelww06QomsYSH/h3uBdYsAZxG2RA7tUjE5UmuE1arNqYlgYFBA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr27572927wru.154.1547490848428;
        Mon, 14 Jan 2019 10:34:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c21sm18072164wre.71.2019.01.14.10.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:34:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, git@vger.kernel.org,
        Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] userdiff: Add a builtin pattern for dts files
References: <20190111215127.57356-1-sboyd@kernel.org>
        <16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com>
Date:   Mon, 14 Jan 2019 10:34:07 -0800
In-Reply-To: <16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com> (Alban Gruin's
        message of "Sun, 13 Jan 2019 22:26:21 +0100")
Message-ID: <xmqq7ef7w0kg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> thank you for your patch.  I left a few comments below.
>
> Le 11/01/2019 à 22:51, Stephen Boyd a écrit:
>> The Linux kernel receives many patches to the devicetree files each
>> release. The hunk header for those patches typically show nothing,
>> making it difficult to figure out what node is being modified without
>> applying the patch or opening the file and seeking to the context. Let's
>> add a builtin 'dts' pattern to git so that users can get better diff
>> output on dts files when they use the diff=dts driver.

A sort of meta-question.

What is missing in the current git that prevents the folks involved
in device-tree project from achieving what this patch tries to
accomplish without having to wait the Git project to act on it?  To
put it another way, is it a symptom of a bad design that from time
to time the Git project has to add built-in patterns?

Ability to ship arbitrary piece of text that you would normally
place in .git/config is not exactly an answer to the above question,
and will not happen as that has grave security implications.

But perhaps we can start accepting an in-tree config-like file whose
contents are limited to verified-safe settings
(e.g. "diff.*.xfuncname" and nothing else), so that projects can
ship two files in-tree:

 - ".gitattributes" that says "*.dts diff=dts"

 - ".gitpreferences" that says "[diff "dts"] xfuncname=..." to
   define the pattern the patch under review adds.

without waiting for the next release of Git to add one more built-in
pattern?

Anything that defines executable (e.g. "diff.*.command") should
never be accepted as part of the in-tree config-like file (for two
reasons: security and portability), but there should be some
"obviously safe" subset of config settings that we can allow project
to impose on its users, I hope.
