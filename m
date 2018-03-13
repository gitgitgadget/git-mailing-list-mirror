Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B653C1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 22:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeCMWMS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 18:12:18 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40284 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCMWMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 18:12:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id t6so762472wmt.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hNlc6R+S4gT9XOSiFWgV3KevDt9EWN7jnGFVW5sigB8=;
        b=PFWwQlrCKubpbdY+hKcgq6uWtya+mrBuP2HOG8jlU5OSqb69cYtL9sfC7fjUopiqVE
         frL9R30wMNr+j6DDfPUfQGcc4RpC0UZc/51aAVqiBylEC9YCFfd5Nqtwbo/xF6gpCGqC
         qQtDsrjccRrM57PtdbhTIMUWAvkxdfTOnU9weHu1PJ7rflLOT/m//45hxzdvma28kwGq
         vQXy4NOtU0Xxo1GWxoqpiU/0qgsyDh5G/O8cuvTZGbDYzZ87VlOdw80un8j8jqyQCKar
         JYw00dfPj03JGjtT9N3j0ho8taA/iRa9D7a+xRmnwWNSDWYnZlx53OwrGlziKgSjeg3S
         XdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hNlc6R+S4gT9XOSiFWgV3KevDt9EWN7jnGFVW5sigB8=;
        b=eyRPV2efjCN02lw9cOqRU5lvuawczbPy5VcR99mJiVCyMk0LniFsRi5ScfCd+0leW8
         6bQuqMxX602fSpHeDKqNSuxZsFWmNcfXF68oWOaDVk2G55ZPtoCnTpJ5qFFybTwSavas
         SdVG49mZb6/Y/AkYRhNQun9fEg5bGyakifk8W1l80legA5NTaQHyPOoP0b/S4Kuo+vxa
         w6CEmTkNQ/DL3ZeuEoBvn0XoClaw+sqya6U8BPlB90GG4LfatOnq6p8TZ0khJ7eQ/AWZ
         kOmRhmsmbME6TESzDM0lCoK3AdMhi/KRlpITGIZSqD4sk5XqTM00+8m4cIQpYq5Lla3E
         KFug==
X-Gm-Message-State: AElRT7GSe1SrF185OM/EEhqcb6u5mbsgP4HM/sSq/JIx9UtcWkeFYDjA
        6vrbeDzSsXfHkDyIBNywXTc=
X-Google-Smtp-Source: AG47ELtc4D38TrXIUGEKBwTt/DFoEIP2YBpzzlD2HvGJhkdxyd00rkoZs+9dtsghUnYNYL6hs0MdMQ==
X-Received: by 10.28.52.83 with SMTP id b80mr2110062wma.90.1520979136408;
        Tue, 13 Mar 2018 15:12:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r71sm1501153wmd.48.2018.03.13.15.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 15:12:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Opinions on changing add/add conflict resolution?
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
        <876061q6m6.fsf@evledraar.gmail.com>
        <CABPp-BHDOimDoLxWxS=BDOBkm6CUTrXTzD16=TSkWGN-HOiU2g@mail.gmail.com>
        <CABPp-BFsiWBiDYYvz=cOofECUHUMJs8x8RuMXqeCF1qP5HzGoQ@mail.gmail.com>
Date:   Tue, 13 Mar 2018 15:12:14 -0700
In-Reply-To: <CABPp-BFsiWBiDYYvz=cOofECUHUMJs8x8RuMXqeCF1qP5HzGoQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Mar 2018 19:53:10 -0700")
Message-ID: <xmqqk1uf1v7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> As currently implemented, yes.  However, I was more concerned the idea
> of handling files differently based on whether or not they were
> similar, rather than on what the precise definition of "similar" is
> for this context.
>
> As far as the definition of similarity goes, estimate_similarity() is
> currently used by rename detection to compare files recorded at
> different pathnames.  By contrast, in this context, we are comparing
> two files which were recorded with the same pathname.  That suggests
> the heuristic could be a bit different and use more than just
> estimate_similarity().  (e.g. "We consider these files similar IF more
> than 50% of the lines match OR both files are less than 2K.")

Yeah, I think there is similar difference between similarity score
that is used by diffcore-rename and dissimilarity score that is used
by diffcore-break exactly for that reason.  If you start from a
100-line original file and grow it to 100-line one by adding 900
lines, as long as you kept the original 100 lines, it is easier to
view the change within the same path as a continued development,
instead of saying they are so dissimilar.

In any case, I think the way the stage #2 and stage #3 (i.e. ours
and theirs) contents are externalized during a conflicted mergy
operation should be consistent across edit/edit and add/add
conflict, so if we are adding a new way to write out extra temporary
files out of these higher stage index entries, it should be made
applicable not only to add/add conflict (i.e. there shounld't be a
code that says "oh, let's see, this lacks stage #1, so do this
different thing").

Personally, I think it is best to leave it all outside of the core
and make "git mergetool" to be responsible for the job of
externalizing higher stage index entries to temporary working tree
files.  They already need to do so in order to work with external
tools that do not read directly from our index file anyway, no?

