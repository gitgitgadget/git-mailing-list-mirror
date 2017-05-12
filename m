Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2152D20188
	for <e@80x24.org>; Fri, 12 May 2017 09:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757317AbdELJjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 05:39:33 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38123 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdELJja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 05:39:30 -0400
Received: by mail-it0-f47.google.com with SMTP id e65so34148394ita.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qbS0WblMM0vAO3EQdFsJIRms5rdABn2bb2IitmDRPTw=;
        b=kc6xK12I8Lofpym8E+4C+3RUfKAtg0hw4bQhTOvrXhCYj95os8VW18BlthddAHdNS8
         ozUyvcFdAw1wYNz36O/5Jd8pAj73ePhfQGY5tk19uCAXspHY5luUN5xFVTKyyULhdNx8
         vOxWi+caKYs8P/V4myLFo4ZoqeK8cmcb7mBRhxEHT+WLeuzll01bhK650ZyGL8r9i7rd
         cFUN7dSA8v+/my57CrysOmvjqbNS8ft7H50zK1ZxlsJgb1AC6Yth1lHyQQs81yMdL4MN
         RvJQCPDcqFxFcpvvXvZ0gj8yw1iQuwu9U3xOo/5dSIS67aV6UA8SLMKyO1pdCrG9Ad1P
         9/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qbS0WblMM0vAO3EQdFsJIRms5rdABn2bb2IitmDRPTw=;
        b=l0YYaUu/yIsaq97a51jzOvwF1kFipPWbFjaNGNr2DlIpy0ku29s7MnZ4v+QKy+/kJR
         O00McuX6nwUFsWYWh/DJNSP/1G/Vehk3r4QzcpO3TOwxTg31GfpOaADfnVFGB6mv78Fl
         Jqb9uC6fTUCv1uIg3uYiLkd+CtstT74h+9/gGSAoUzVTY0fsjTriRpVnaE1yf1C9+Jpj
         Mk+nSLF2mJamgtKUM4uLZtj67Ol7+RZM0Zbq+mxsYkHmOtfFvFJrLgzc1H3SgJtBA5mO
         GseDlekj3vVttncCHh7XfbXHDqgMtOcA/jbC9MNCez7uCRZQ9GY4cXtmkdd+kJX555Xk
         nCrQ==
X-Gm-Message-State: AODbwcBqslctu0IKtGtR21rSU0tuDr2ehoxieHyAAtlQ4aHDiae8eQWZ
        ob2/yQssLIx9ihvlI8fDmHrPRcsZWogZ
X-Received: by 10.36.28.139 with SMTP id c133mr2256823itc.117.1494581970022;
 Fri, 12 May 2017 02:39:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.104.194 with HTTP; Fri, 12 May 2017 02:39:29 -0700 (PDT)
In-Reply-To: <20170512092212.wpw232jfpp3bnqol@sigill.intra.peff.net>
References: <CAHGBnuOzWSCR9wr=TSGoJSnimZDx2Gr-eR3+LFXmpc9m0cv4qw@mail.gmail.com>
 <20170512092212.wpw232jfpp3bnqol@sigill.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Fri, 12 May 2017 11:39:29 +0200
Message-ID: <CAHGBnuOXRdpyozq2BbLFnao6NB0GAL09bsQ-3NtDv6gZTpqvOA@mail.gmail.com>
Subject: Re: [BUG] fast-export --anonymize does not maintain fixup! commits
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 11:22 AM, Jeff King <peff@peff.net> wrote:

>> these (or any other command prefixes in commit messages). Given that
>> the --anonymize option is explicitly designed to help reproducing
>> bugs, I consider this to be a bug in the --anonymize option itself.
>
> Yes, it probably should handle those prefixes.
>
> I don't know if I'd call it a bug. Maybe a missing feature. :)

I'd usually agree, but in this case, as I mentioned above, I consider
the missing feature to be so essential that the oversight to implement
it is actually a bug :-)

> So this seems like a good example of that. I think I'd prefer to see us
> add in known prefixes like "fixup!" and "squash!" then try to guess what
> other prefixes might be OK. I don't know of any other command prefixes
> besides those two, so maybe that's all you were suggesting.

Those were also the only two that came to my mind, but I wanted to
give some one who has a better overview the change to amend that list.

> It shouldn't be too hard to add. You'd probably need to make two
> adjustments to anonymize_commit_message():
>
>   1. Teach it to store the mapping of anonymized messages, using
>      anonymize_mem().
>
>   2. Parse "fixup! <msg>" and just anonymize_mem() the second half. I
>      think technically this wouldn't handle a fixup-of-fixup, but I
>      don't think rebase handles recursive ones anyway.

Thanks. I'll give it a try.

-- 
Sebastian Schuberth
