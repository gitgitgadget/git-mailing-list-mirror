Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582F01F4B5
	for <e@80x24.org>; Thu, 29 Jun 2017 18:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdF2S4S (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:56:18 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36466 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdF2S4R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:56:17 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so52058778pgb.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xAXyFz7GqTOoMgeLRPK4rgipr789JKRvEM4B7C8L9i8=;
        b=Cg8QJTqmMKK1BdFp8zLmpMzR8AO6q1M7SasGEHlWvzsAISbRb9txuT7wLXNFPzOWiJ
         QGvHyRMKs7AxUeMm+RB60dCODohx82o7n3hJBguvIVoS1+oR70g+i1Tz/XNKkGnoiAqY
         e1pyq/ovF5A6nb6ul8+oiUyTCC3Cvks9IJ3p0yFYQ0ZmrnXOKlVsDcjfUcm+eJrLNvwn
         k87eWMsDaBR3+5K72OIKCTPIcBEyklZR8TdPF2q1z4ejo7A9UgMeVv7D9VdTZh+Df42b
         RRi636deI/u0wBNoYAvXpfTLkerHID/jArV/FYPSi0kt2RV1T5PpqZ9KOuXF9OR28toQ
         lNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xAXyFz7GqTOoMgeLRPK4rgipr789JKRvEM4B7C8L9i8=;
        b=RRCVPGtTYqc0vG35ccKvI2H0ttXaiPIyzUlzbrQJDi7euRR0xCdcNCgxn2zDsCM99C
         cT4GZpODGuND4w52qM8CPn/UTCW6eYYJg2wTckfxmGr4MgZz41wwugiLWsl9nKD7BQX6
         xb8I9g2vu8dGtrYACEXm6gFWEIJTVRRvNDcN6RHbEgCX+mXfz6/htszCraf7Bltj5fwD
         rJKubc0QSxA9UIlEcLHsjV1fyPPeLvySw7/mA4Z9nGXgM8Ly05PlG5p3h6fI2fhzWZIF
         aPynJ6pidp0EJwRiTQklhHuvF6ZXPy5jviJ6dLaj2X1x3N1rXicxLAOEus+f02uY52Uv
         r5Ug==
X-Gm-Message-State: AKS2vOw/EItF4b2l8F5dfw0K35M3SsYPoBYeW/sUdapGUXLWzBlbaBJW
        QfB7e3esdIWoIi9DGZxeygGVw6qgqIij
X-Received: by 10.84.217.138 with SMTP id p10mr19510276pli.66.1498762576362;
 Thu, 29 Jun 2017 11:56:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 11:56:15 -0700 (PDT)
In-Reply-To: <xmqqefu2tyzc.fsf@gitster.mtv.corp.google.com>
References: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
 <xmqqefu2tyzc.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 11:56:15 -0700
Message-ID: <CAGZ79kYd+3OoUBcsTS9=S9qEUwKj9ypyHyjXLBW=KjWOVoae4A@mail.gmail.com>
Subject: Re: Warning suggestion for git stash drop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Laurent Humblet <laurent.humblet@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Laurent Humblet <laurent.humblet@gmail.com> writes:
>
>> Would it be possible to add an optional Yes/No when doing a 'git stash
>> drop'?  Something similar as what happens when pushing on a remotely
>> checked out branch (with a config setting to turn the warning on/off).
>>
>> I know that you can always get your dropped stash back using git
>> reflog but a small warning might be a useful feature to avoid unwanted
>> stash drops on a regular basis.
>
> I sympathize with this, but the same principle also would apply many
> destructive commands like "git reset --hard", "git rm <path>", etc.
> and also "/bin/rm -f" ;-)
>
> I however do not think a good general way to do this without
> breaking people's scripts.  When they do 'stash drop' in their
> scripts, they know they want to get rid of the dropped stash
> entries, and they expect that the user may not necessarily be
> sitting in front of the shell to give the command a Yes (they
> probably wouldn't even give the user a message "the next step
> may ask you to say Yes; please do so").
>
> On the other hand, just like "git reset --hard" and "git clean -f"
> does not have such safety (i.e. the user is aware that the command
> is destructive by giving "--hard" and "-f"), "drop" may be a sign
> that the user knowingly doing something destructive.
>
> So I dunno.
>

I was about to propose to have an easy undo operation, such as the
reflog. But then I checked the man page for git-stash and it already says:

       older stashes are found in the reflog of this reference and can be named
       using the usual reflog syntax (e.g. stash@{0} is the most recently
       created stash, stash@{1} is the one before it, stash@{2.hours.ago} is
       also possible). Stashes may also be referenced by specifying
just the stash
       index (e.g. the integer n is equivalent to stash@{n})

Maybe that needs to be polished a bit more?

I myself used the stash back then (I don't use it any more), and I assumed
the stash was a stack of changes, but the data structure seems to imply it
is only one thing that can be stashed and the reflog enables the stacking
part, such that a dropped stash is gone and is not recorded in the reflog.
Dropping a stash seems to just erase the topmost line from the stash reflog,
so it really is as destructive an "/bin/rm -f"

So getting back a dropped stash via the reflog is not via asking for a stash
reflog but rather for HEADs or a branchs reflog, which may be complicated.
