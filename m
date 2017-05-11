Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC49420188
	for <e@80x24.org>; Thu, 11 May 2017 02:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbdEKCUE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 22:20:04 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35592 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdEKCUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 22:20:03 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so1435908pfb.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UgISYmhbUpAc0hIGJgcFY7iv1VBMlKdz0tz4cJ4Y/Og=;
        b=LhNPeb9G0RT5sLi7rHk5H116ckiTMuqD0L3LyK9XdWiTqBDpsY1IzWMPnD/96tfpA0
         qwkkanVFw7q3gFGz/lCMC65EHcpZ0qdzXfiB2uGnD7mOh3jh3VL6sAhtCClpJTAUkGR+
         N7q8FdIZxtG4DkZV+QFxqUzHjqMiDbJKTd/2K2Ku1698E4x0WmBKpOAOPSCqAwL+eIVU
         KbOB3WwzDR4Ky7nVGAjmx5UskBF5XnE5rB5DEsTGu2KWWoZY+ZDZRJmz8n4W/vdVPyb0
         n7tjTyFZL1eyF5AED/PFgx4k1iB8Fb6O0KjU+4QnxR4J553qnjW6zuibp6KKFX6NR7AP
         LGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UgISYmhbUpAc0hIGJgcFY7iv1VBMlKdz0tz4cJ4Y/Og=;
        b=YAQ14xyx0RqOhn85GunkgI5tEAzKD7sPazrVpnPgAU28hraruKeYst+hya7OdpGl66
         tqigl9PpvUHgtz8EsNCT3J4VO6VIAnjWmXLJztqul3Gb0K+2apH9AmFZhlzuYTCHEymV
         uE4MHE5HyKyl3GVPnQkyowT6BJ6aUtOxiKjRK50UlrvnhXv+tT89xMjb4Bkc+F3fC3RC
         TCqJOZKdN1zokwfK//Xt8BohmiIKJs22TYXNVVpQ0u4MIi9zWEvYYT1i/7BGcMXCgTEI
         3U+/ekj8DXOto53QuL8VGZ3Vk/Kmu9FIzlLdQAx7GF30GICPR9+Vpr7/3VSTagyFz+r6
         yAKQ==
X-Gm-Message-State: AODbwcDcxeD/nxIe5tmGILPvaAZaaa2fpRlMQ13RwQfuycytXi4iBb2H
        7z08G8mJqbHZSA==
X-Received: by 10.99.103.7 with SMTP id b7mr9957194pgc.2.1494469203018;
        Wed, 10 May 2017 19:20:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id z5sm334967pfd.76.2017.05.10.19.19.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 19:20:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4VjwXNhFCwhd=-5ArWOvR5E2GDjWZf5dwz3Y4iCS0yYg@mail.gmail.com>
Date:   Wed, 10 May 2017 19:19:54 -0700
In-Reply-To: <CACBZZX4VjwXNhFCwhd=-5ArWOvR5E2GDjWZf5dwz3Y4iCS0yYg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 May
 2017 10:12:23
        +0200")
Message-ID: <xmqqvap8ceyd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, May 10, 2017 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> [New Topics]
>>
>> * ab/compat-regex-update (2017-05-09) 2 commits
>>  - compat/regex: update the gawk regex engine from upstream
>>  - compat/regex: add a README with a maintenance guide
>>
>>  Will merge to 'next'.
>
> [Sent last E-Mail too soon]
>
> There's a tiny typo in "compat/regex: update the gawk regex engine
> from upstream", one of the two bullet points says "Git project.f",
> should say "Git project.", i.e. without the stray ".f".

Yeah, I recall seeing it and feeling puzzled when I queued it.  Will
remove and requeue.

Thanks.

> If you don't mind amending that before merging it down that would be
> great, due to the whole multi-patch !fixup -> you needing to squash
> that sounds easier....
