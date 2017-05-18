Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98BD201CF
	for <e@80x24.org>; Thu, 18 May 2017 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755405AbdERQU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 12:20:28 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33307 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbdERQU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 12:20:27 -0400
Received: by mail-pg0-f54.google.com with SMTP id u187so25102330pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dWcrLWbc/ijICU87i41ExrqccNiJ7cLfdA00a4hTmtQ=;
        b=o2NJAo88UHdl/VxeSwcH+NFiNfMaw4Z/3yiV3qOoQtP1ieYCsCFKbnrsKivnnAwtJK
         f5qpGh6klhjip0vHcxXPyPTmbpFqxJaCiRRZzxdszbFY4CHQmwZZfo9UWMpzlF0//JDO
         Q7paIZ5xfEyM3eZhiHRDpkruWgW7/JQYkeiYbEdBVmu+7z7jRMfiZfyNyQGXed55r5yB
         Oo4Geo0vDkwlHRlMqL+PJ4mQAhwAonUGR46Y+os0U7WSRKXiywEqVLLvjLS05uqyweFj
         WlgIglX7oOcw1N1gu0fG4VyBX7GuOvT0G7b8+aMIAeYgGN8jT/VGXbTUDJ98I3X9PiLU
         1S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dWcrLWbc/ijICU87i41ExrqccNiJ7cLfdA00a4hTmtQ=;
        b=lJwDyPCBo2aS0mm3I30Mf0LApiYP+tCaCBh0O4qvgZ9S5A27BWgLJoho1jL15my4rT
         JNMK+zi3ks43uqEPQrt76RCnUxnYJfj0TWnUwOhX+DnWbgC3PypTWAC8UkV1M1TbEJLW
         iKOqXMIkQr2WZ3c3MGRP0wkzfIVi9YAJ/A0BQ1RVff3oO0nVYASJFogy/3qNQHcS2k4X
         WaP0kdKgVxB6yPITzpCVhO+VIIH9txPvA7Lrx0wSFxB+sxkTDtr8c8xPmflAJhwDSqDz
         L4Oz/iL9uIcp5aGH+Volq9SOkxsEPt0UMDbAPaYJOWojlLKU27X7oKDUhzF7Ua8OIj4P
         yUMw==
X-Gm-Message-State: AODbwcBwMsuA+YtSsfZ1dvyO4IlRgH0Tl+dCaT0oDsqwGB1laQj/MMlD
        BeV0BPLSUkeUhB31EDVx56E4RQtmszZuAyc=
X-Received: by 10.99.56.66 with SMTP id h2mr5536013pgn.40.1495124426576; Thu,
 18 May 2017 09:20:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 18 May 2017 09:20:26 -0700 (PDT)
In-Reply-To: <20170518153901.GB112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com> <20170517213135.20988-4-sbeller@google.com>
 <20170518153901.GB112091@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 May 2017 09:20:26 -0700
Message-ID: <CAGZ79kZjMwoXOr_5xrU0Uy9K5bjJOd=YUBvK+Dpx+uS+5LH9Dw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Introduce submodule.recurse option
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 8:39 AM, Brandon Williams <bmwill@google.com> wrote:
> On 05/17, Stefan Beller wrote:
>> Any command that understands the boolean --recurse-submodule=[true/false]
>> can have its default changed to true, by setting the submodule.recurse
>> option.
>>
>> git-push takes a --recurse-submodule argument but it is not boolean,
>> hence it is not included (yet?).
>
> ls-files and grep could also be added.  They don't need to be added in
> this patch though.

I agree for git-grep.
git-ls-files is a pure plumbing command, which usually are not very accepting
of options. Then it is easier for script writers to rely on its expected output.

I just missed those two (at least grep) and will add them in this
patch if we think
this series is a good idea going forward.

Thanks,
Stefan
