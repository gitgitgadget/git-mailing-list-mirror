Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF581F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCYT7B (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:59:01 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:43649 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeCYT7B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 15:59:01 -0400
Received: by mail-io0-f172.google.com with SMTP id q84so15288562iod.10
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1mmKXXwTDSif0AOJDawhCNmWN9q18P8k1nFEzpYNWP4=;
        b=aZEkQWKm7+ykxk5cq5GNCnb5E/uJA+RsQEA30DVcjsYymRj8wvZgi2bB+Y7/3sMAsA
         yc9u12F9c2Wt8QYw3kwrhSm5lR6nGmkYGiNR746NkZJY83bWX6NTqKkrVBTein6VOMlk
         NlK7O/XX2CRX62GiPpP1Ohq8dZlC2rlnwTBpJ6tiPmsI9Z3X88JaQwtSjeXIHlCYdcWQ
         9q59doUdkTHoqf8wVXVcJ0pGCFIPYWvJmGmR1jenKrEVX5jb54rFJbRFr/crfNrQ1WRf
         fR0BfRaE7AdG0ARPzPzAkEJTeADwdbgQ1cHshZI1fEyUttd9xV35FMd2j96kTwz6U1K9
         U2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1mmKXXwTDSif0AOJDawhCNmWN9q18P8k1nFEzpYNWP4=;
        b=McJllTz6InhA4p/HV8BHJyWPi+nsRq9G1gcUWEVJ+7fM5GH4Jhsk6A4CkhE2q3MSEo
         Va4ogVZecLhUWpOo4h1wJSCdPKWVOt+JzdDUhNq+xoTdrLYTHagdyOaIlCVFlSRLg9kn
         0ttzjnj6sl06aYTEyd4UuJjxwxbzdWGBzwXlJImasopmkmxjQnpjm4fNtPxA/PS1fgtb
         snfJlLGWSjPl652ETT2eiqq59lJFRCvBk065uLy+Zyt47ofwaZrp5TuwI+TrIUa9hrTu
         M7Wod/jCNLa43UfxIG1eLmYAjKySggx4U8Da4E55pgk8a3xDLLrSxCFEXnTA8VwMrwkC
         2vQw==
X-Gm-Message-State: AElRT7H2s+KspE3Zi55lya/llUYVQO8U9aWe3JPO8ZzOnnW4q+aEHin9
        dyXnl9ap/XZte6g2Tku4DUBkET1vzsDROKNuCPKNBjy5
X-Google-Smtp-Source: AG47ELvSRbS/x4fjLuL0UmfLd9ALdgL2NgiORCPMTiaYBfVUNgmNOV/SF7Xo1W8ZI8bk/gImpxMV+DeXofokbdVpgEQ=
X-Received: by 10.107.144.197 with SMTP id s188mr39687376iod.147.1522007940127;
 Sun, 25 Mar 2018 12:59:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 25 Mar 2018 12:58:59 -0700 (PDT)
In-Reply-To: <CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
 <CAP8UFD3Qxt2YMqTtHwU8n7EDvD66QjGSywRQoxJDnncv7=2BUg@mail.gmail.com> <CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Mar 2018 21:58:59 +0200
Message-ID: <CAP8UFD04LF68LONP3hxpjc4oQokSab4HYvTkazeBq8STzN6E-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 6:51 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> On Sun, Mar 25, 2018 at 1:09 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> It seems to me that the apply_stash() shell function is also used in
>> pop_stash() and in apply_to_branch(). Can the new helper be used there
>> too instead of apply_stash()? And then could apply_stash() be remove?
>
> I wasn't really sure if I should remove code from the .sh file as it
> seems in the past the old .sh files have been kept around as examples.

Yeah, some original shell scripts that have been converted are kept in
contrib/examples/, but the shell code has still been removed from the
.sh files when they were being converted.

> Has that been done for previous conversions?

I don't think there were some cases when the shell code was not
removed. I haven't looked at all the conversions in details though.
