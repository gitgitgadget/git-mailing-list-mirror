Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39657208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 16:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934456AbdHYQiO (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 12:38:14 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33869 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934433AbdHYQiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 12:38:13 -0400
Received: by mail-yw0-f181.google.com with SMTP id t188so1918027ywb.1
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NwNmGFAo3h7mIzRZ7K+RXS6TtWEWE1vEgE2B6pZ+4ic=;
        b=tmOHRiqqXqEXOV39IwMcQYXPVk1Bkfpg/exdDXZHIyBZiZcTojcINOTMiHk2b+qvzF
         nFA2RmtzWu8JjgMEKnfOx0gZAmdgP3IhBm71tM31+pYeZC7mMsoXa7Th7olSspYtxjDU
         JTUJxbmL8tgXxdtn7RmOHlrQlgwo+E8NN8RlIB3oIam81FqkCCtosvfuDydIevJDVfmg
         AJTccTjQLqy3oByvzDtaWhxu/Iw/8SLxBYKRzK9pLBttMuog76U0rs6hP5PchjDM6rmJ
         5tvUCi51EOAdmcLctMVyn70cjqA7u08eReMfVqp+NoOoNlOfSZ9LXsX/EC8OtlYLDmQ5
         RJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NwNmGFAo3h7mIzRZ7K+RXS6TtWEWE1vEgE2B6pZ+4ic=;
        b=DukuKtR4F2fCWgcM2QSwQr8VCmNP4opi8DB6FBhlFO3K22mPxKm6Fc9BPqd0SCKUHp
         8dX4p9i5TnPMwfMDq60JH7CHaU11qemY3pkCs/o0JppT8EPaz2+aCv3wIEOYz1IhDDpr
         kTXH47mXmlu1yFdvzpaXO5P3m1nrtM6hkiPiATWZ/pX9IdlgWMMDvmP83THhmG0ayNPv
         mMsP6E/W4NfH1SWPtRBHHmGxN0Bl0d7EJ3nRBXeSpIroJLmBlL6DyKPj83RRZfFn2XtE
         D2Fe7QgYSYCQTBhC6iYV5WSdfHdocCHwaGKThsJYpYLn4saBkl+4TTCh2LAsT8aI5SX5
         mETw==
X-Gm-Message-State: AHYfb5g85X2dap0yNDa4ch87ikVhfI4291loOXQ6Mxhb3EHctGqyZtH1
        BFo2a2cTGq9DrnYUA2oGjXpmzZA/B2IY
X-Google-Smtp-Source: ADKCNb5d8oHx/mj/EQorcjpHHAvQUzByNB6duk//L3TKVsF3LfHFkGuX5tEb5GltfVtB7SCT1+zlyqE6bE+lLKOYnko=
X-Received: by 10.37.208.17 with SMTP id h17mr1684651ybg.151.1503679093164;
 Fri, 25 Aug 2017 09:38:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Fri, 25 Aug 2017 09:38:12 -0700 (PDT)
In-Reply-To: <20170825091048.GB14872@book.hvoigt.net>
References: <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com> <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com> <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com> <20170821160514.GA1618@book.hvoigt.net>
 <CAGZ79kZvcY8hawq1qGfFLm1Ukb-wn8j0e_hN8gF5jrEY20o7YA@mail.gmail.com>
 <20170822153311.GA5697@book.hvoigt.net> <CAGZ79kbwJN_XVcAbkyVJTax9F2NR4EO8XjR3U9EH8MLqbAb90Q@mail.gmail.com>
 <20170825091048.GB14872@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Aug 2017 09:38:12 -0700
Message-ID: <CAGZ79kbYWyAkxbRv8vw9woR_KSSNRgjWhjkU3wwAGZfpFakhwA@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 2:10 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Tue, Aug 22, 2017 at 11:10:52AM -0700, Stefan Beller wrote:
>> On Tue, Aug 22, 2017 at 8:33 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > On Mon, Aug 21, 2017 at 09:42:54AM -0700, Stefan Beller wrote:
>> >> On Mon, Aug 21, 2017 at 9:05 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> >> > On Fri, Aug 18, 2017 at 11:51:13PM -0700, Junio C Hamano wrote:
>> >>     # You feel the superproject is in the way?
>> >>     git worktree add --for-submodule <path/to/sub> ...
>> >>     # The new submodule worktree puts the
>> >>     # submodule only UX first. so it feels like its own
>> >>     # repository, no need for specific flags.
>> >
>> > I am not sure I understand this one. What would that do? Put a worktree
>> > for submodule path/to/sub to ...?
>>
>> Yes, and at "..." you would have the UX of the submodule being
>> its own repository, no interaction with the superproject.
>
> Are you sure that is what Junio meant?

I am not sure at all, what Junio thought about this.

> IMO that would be 'git worktree
> clone' or 'git worktree checkout', no?  In todays git terminology an
> 'add' is something that puts data into the repository / the index. That
> is why I was/am confused.

I went with current gits:
$ git worktree
usage: git worktree add [<options>] <path> [<branch>]
   or: git worktree list [<options>]
   or: git worktree lock [<options>] <path>
   or: git worktree prune [<options>]
   or: git worktree unlock <path>

where the 'add' adds a new worktree (my mental emphasis was on the
option that says: "Make the new worktree for the submodule, such
that in that worktree the submodule feels like the toplevel
repository". If 'add' is a bad naming choice, we may want to
discuss&deprecate it in a new thread as that is related to the
worktree area?)

Thanks,
Stefan

>
> Cheers Heiko
