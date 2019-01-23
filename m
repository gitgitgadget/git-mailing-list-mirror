Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F22A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 19:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfAWT0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 14:26:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36034 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWT0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 14:26:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so572546wmc.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7k0m5s8BrOzgf4brMvfPdScGLdCDWWywCxK6XstN/k=;
        b=FWjSa46XNCcO3WSPLUTHnEoN1DZWyC0WoEHR6Mo21gOH9CNo4cHBiNabbkLbQQfqkF
         2EK4/6zMMfPfCaOIscseVyZPWwX5zWlKjsvYw1E8QkqUiuCHVMcSQlvEasMWmWjgs4qs
         Fopf3qT8OjGI7Xd2uEUnXh2Xo7DhQy9vLKl2ankKmQ35jI2i4y5iFnY21183h4RGx9/+
         IhKiZUib58QgyPMk0MXy+rhmMFafpmifoA6674i9kU35rQGEHGxF8WLkXNnZUs7+Ffz7
         FrL/0s5LjYX4e7BTMpbFbT6Sd3bF4d3675QwgAxfZ+YJ4BBR1IvIENiDF20NuahIPAki
         0q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7k0m5s8BrOzgf4brMvfPdScGLdCDWWywCxK6XstN/k=;
        b=QMSJTF3c+CDxrEnDfcYcS4VHqAvomtOiakXUh8GEb6/1cUhI+W8rRGd7B5fttm7nMe
         Il0r0lvG++hMcyhOMhLnbsKCwbTwrOZVUx8BmxZJKiL1KZwDEVCklnLkeAkyWo4++Zd0
         XWHIUpHNe6iOoWJH9DaYGu+/biAglW8QkpZNzQ9z5eXgV0HFU7bdlPEttmQMXwaItI85
         io+x3TGsRyvzZff585p3lVkfnpy3syHwuMaHg3jUCyVkn6uxnmmRgyTo7rx7CFvs8W45
         kf8mJyA1IYM+3Azcef2itUBCswAEw9VX4m4ZBEQOX7LXuiBjEUvWoSqWSPT9mCdlkVHf
         Uz6A==
X-Gm-Message-State: AJcUukd/3YE1ifSUSrfgzohO3Pvj74mhTZzyP2RBLqaIl9IzGIoUgjBh
        bpwyN3x4mNlWiE61lHgGS4s=
X-Google-Smtp-Source: ALg8bN6Z3gWLu6zETT8xEL6ifnIx9vwABgjpmjeIb8i2wXjoQZJ5I4+0JSEF+qTr/X5Okm+tU1G/eA==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr4118946wmg.42.1548271579575;
        Wed, 23 Jan 2019 11:26:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w6sm57022888wme.46.2019.01.23.11.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:26:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and their changes
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-3-brho@google.com>
        <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
        <xmqqlg3ch85x.fsf@gitster-ct.c.googlers.com>
        <20190122143500.397abc8e@gnomeregan.cam.corp.google.com>
Date:   Wed, 23 Jan 2019 11:26:18 -0800
In-Reply-To: <20190122143500.397abc8e@gnomeregan.cam.corp.google.com> (Barret
        Rhoden's message of "Tue, 22 Jan 2019 14:35:00 -0500")
Message-ID: <xmqqo987b2g5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

>> So... I dunno.
>
> I guess if you swap the lines as well as change them,...
> ... Then it won't have the semantic knowledge that "one" == "1".  If a user
> is ignoring a commit, we don't have an oracle that knows exactly what
> that commit did to determine what commit the user wants blamed.

Yeah, and if the original had two adjacent lines, and replacement
has three adjacent lines, the algorithm would not even know if 

 - the first line in the original was split into first two in the
   update and the second line was modified in place; or

 - the first line in the original was modified in place and the
   second line was split into the latter two lines in the update

In short, there is no answer to "what is the corresponding line of
this line before this commit changed it?" in general, and any
algorithm, as long as it tries to see what was the "corresponding
line" of the line that is blamed to a commit, would not produce
results human readers would expect all the time.

As you said, heuristics may get us far enough to be useful, though
;-).




