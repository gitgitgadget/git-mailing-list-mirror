Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700081F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeHaAdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:33:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46164 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeHaAdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:33:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so9187493wrc.13
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=t1yDdWGH+PWK5ZTw8tbFSrYVjwTh2g8LvXYNMNg2qBk=;
        b=c6U6HuKb1ckC8QV75Prch3owwEwnrnLn3ngtd2Mb/cPCLGiWl2HQ9yM5Dbv/cl9N7h
         l1tyTVX52k876H9xcFa4keDkqVLH8GIIAbVlz4uQzoHZqI76W7Cp16AV0Uw/HtXD1zvr
         x2yo5Hh0XwQ8vNlaaFRFBbEuBSe0+VRcqoaw1usi6xRn/m9NV2ULfwKXImNPzw/QIZaO
         gPa1qfEB4RyuWIahONAaHVYLTpmvr+CLjo1LHiHoHexFailVi14wHASzzhpKpbHxwL4c
         uHIhhNjoSRBczYOhHK9a3jKT2HT3BjEHcOMEUyUapYNsIusDOWIpwELz0cKhddqx75Be
         TB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=t1yDdWGH+PWK5ZTw8tbFSrYVjwTh2g8LvXYNMNg2qBk=;
        b=Y+zhGSoQh+lj2IKTKWHZ0/NghjdmkGBODxDr/w4Zppwl0nqsZvZSTQ4xnaw8D2Tu9z
         OiQTJCJffOUqSeEpxknui09lzaD2c+Phfp66ejv/j1KUkKfPdYTuEF77nRv8Z7CxsZLU
         QEjt6nSn20WQdFJTxTmXfceVZsRbktnBDFWZOnb0Gxz8fiys5TFGxcqMEoH7MP638/JL
         pSxKQL3SwrFZMsoPFyh0arqceN0cT38Eba4r8esvBv3NugUvI/57EX6blqpsRukiDnNx
         3D6deCBylpTyFzG93ApwVCxF9TsprZuULdn9UvtoBesRYLztCmWRWRBrCcr635Bp6kj7
         vQhQ==
X-Gm-Message-State: APzg51Cxf+hbHH7H12AlMbjt5xDF93mrJEH/60nSCtUTDrhVqUD64OAD
        VQnav1nD5et7lUM904Yjt6huy3p6
X-Google-Smtp-Source: ANB0Vdaoxx47fhaiUfwYV103tEyBHSHwrhrLYfueIM1zZxRwlfDApqElbXEqRUYq0eJKJhV/e3lxMg==
X-Received: by 2002:adf:ad8e:: with SMTP id w14-v6mr9305684wrc.178.1535660995110;
        Thu, 30 Aug 2018 13:29:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v16-v6sm7343674wrw.12.2018.08.30.13.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 13:29:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
References: <20180622092327.GA8361@sigill.intra.peff.net>
        <20180622092459.GD13573@sigill.intra.peff.net>
        <87wos8cjt8.fsf@evledraar.gmail.com>
        <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com>
        <87in3rd422.fsf@evledraar.gmail.com>
        <20180830200452.GB22407@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 13:29:53 -0700
In-Reply-To: <20180830200452.GB22407@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 30 Aug 2018 16:04:53 -0400")
Message-ID: <xmqqo9dj4mym.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 30, 2018 at 09:53:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > In the SYNOPSIS section we still see "[-l]" listed; that also must
>> > be replaced with "--create-reflog", or just dropped, as that is the
>> > default.
>> 
>> Oh yes, it seems all of the doc indeed wasn't updated!
>
> Sorry, this is my fault. Patch is below (which would go on top of
> jk/branch-l-1-repurpose).

Heh, reviewers who did not notice share the same blame.  The patch
looks good.  Thanks for a quick update.

>> > I do not know if the documentation that is shipped in 2.20 should
>> > talk about how the old world looked like, though.  `-l` was a short
>> > for `--create-reflog` is worth saying, but I do not see much value
>> > in talking about the warning given in 2.19.
>> 
>> I'm anticipating that there will be users in the wild with similar -l
>> invocations, noting this helps them, because they'll be wondering what
>> some script that does "git branch -l <name>" is trying to do while
>> reading our docs.
>
> I don't have a strong opinion either way. If we do mention it, it should
> probably be short ("Until Git v2.20, the `-l` option was a synonym for
> `--create-reflog").

I agree that the short one would of course be good.  I am on the
fence about mentioning the warning only given in 2.19.

> -- >8 --
> Subject: [PATCH] doc/git-branch: remove obsolete "-l" references
>
> The previous commit switched "-l" to meaning "--list", but a
> few vestiges of its prior meaning as "--create-reflog"
> remained:
>
>   - the synopsis mentioned "-l" when creating a new branch;
>     we can drop this entirely, as it has been the default
>     for years
>
>   - the --list command mentions the unfortunate "-l"
>     confusion, but we've now fixed that
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-branch.txt | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 5552dfcec3..bf5316ffa9 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	[(--merged | --no-merged) [<commit>]]
>  	[--contains [<commit]] [--no-contains [<commit>]]
>  	[--points-at <object>] [--format=<format>] [<pattern>...]
> -'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
> +'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
>  'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>  'git branch' --unset-upstream [<branchname>]
>  'git branch' (-m | -M) [<oldbranch>] <newbranch>
> @@ -159,10 +159,6 @@ This option is only applicable in non-verbose mode.
>  	List branches.  With optional `<pattern>...`, e.g. `git
>  	branch --list 'maint-*'`, list only the branches that match
>  	the pattern(s).
> -+
> -This should not be confused with `git branch -l <branchname>`,
> -which creates a branch named `<branchname>` with a reflog.
> -See `--create-reflog` above for details.
>  
>  -v::
>  -vv::
