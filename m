Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB111F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbeBWULK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:11:10 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42356 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbeBWULI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:11:08 -0500
Received: by mail-wr0-f193.google.com with SMTP id k9so15283557wre.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W+t15Ko5xDj1H58dHXMbdSaQv0N6/pssW2rdIPlHA+E=;
        b=N+CLR6gpAzDfPKOU2mvJmpeyAoCAilSNSz3kd1JhH1v4LM8F+FIApZZAtL+jWAobgY
         KMER4nBeHbkEqPhUlGehzOTFpHg2h9BapJYvzMeV9z7SXs2FGOeQxEl0kobl0lNob6m1
         RkTvihkcVAzgeMddGF8bad8DzohVejBbCBigdrWfmlNzE2yrqhpc8r7XiKWfKycYh55t
         +B1XIipqKObpIR/YMN4e8I23sbSpipBV5Q2wQXkWPbz1gNj8a03MLYWpFzSmzPVSEpB2
         W7G7gLEszrMMpW7wl8coCHE/ErDCbKLXBRBsFK8Yz+Xt0AVYQ9X37t2XA8wYk4ZgSYt4
         KL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W+t15Ko5xDj1H58dHXMbdSaQv0N6/pssW2rdIPlHA+E=;
        b=FqNrAWI6maJnCJbGTeHcLhQGrQsm+rquZ2JkjdqlDp5X7JpQNHWImxd3TpWSafMshR
         kYg+3NUXY9U/T5X/gQMKZFfF+EGZ5vs4T2+FwEq0ckq4CQf8APTSGo0k4/XyhN2ARJOj
         La0E+SbKL/7BMUbDjDWFMDkwM9wUjM8bhM64ksbzW0IzqVrzQkXpo9jbfHR6niVCldi0
         dRsz0JVgXKchYimWUlHSGMRXkYcqr0EqZ8aSFLcCoyyfndwmkuPa0ASYID6EDPxpf1Lp
         4tJ1bnuSYtlofRwlEvUnPgDvApd3efBjfat1I2aXSBiv1Fpoc4etif2XEveYC2IvV/qc
         Dk6g==
X-Gm-Message-State: APf1xPC7wlxO8IuMv/kar1PMnOB92fKwV0bHd1qWfAPGBlumeuG2vfjE
        hb4LclAqVtMaJi6Y7YjeAqQ=
X-Google-Smtp-Source: AH8x226Gudi2yMRDOW0mj1s1feCoXLoTNvlbMAzK7/nF67Nv6tHNXC0vVoZZVX9gwxeVv97X8YHYOQ==
X-Received: by 10.223.163.215 with SMTP id m23mr2884918wrb.90.1519416666586;
        Fri, 23 Feb 2018 12:11:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y111sm5311886wrc.0.2018.02.23.12.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 12:11:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <20180215152711.158-1-lars.schneider@autodesk.com>
        <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
        <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
        <20180216165815.GA4681@tor.lan>
        <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
        <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Feb 2018 12:11:05 -0800
In-Reply-To: <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 23 Feb 2018 08:35:49 -0800")
Message-ID: <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> I still think it would be nice to see diffs for arbitrary encodings.
>> Would it be an option to read the `encoding` attribute and use it in
>> `git diff`?
>
> Reusing that gitk-only thing and suddenly start doing so would break
> gitk users, no?  The tool expects the diff to come out encoded in
> the encoding that is specified by that attribute (which is learned
> from get_path_encoding helper) and does its thing.
>
> I guess that gitk uses diff-tree plumbing and you won't be applying
> this change to the plumbing, perhaps?  If so, it might not be too
> bad, but those who decided to postprocess "git diff" output (instead
> of "git diff-tree" output) mimicking how gitk does it by thinking
> that is the safe and sane thing to do will be broken by such a
> change.  You could do "use the encoding only when a command line
> option says so", but then people will add a configuration variable
> to turn it always on and these existing scripts will be broken.
>
> I do not personally have much sympathy for the last case (i.e. those
> who scripted around 'git diff' instead of 'git diff-tree' to get
> broken), so making the new feature only work with the Porcelain "git
> diff" might be an option.  I'll need a bit more time to formulate
> the rest of my thought ;-)

So we are introducing in this series a way to say in what encoding
the things should be placed in the working tree files (i.e. the
w-t-e attribute attached to the paths).  Currently there is no
mechanism to say what encoding the in-repo contents are and UTF-8 is
assumed when conversion from/to w-t-e is required, but there is no
fundamental reason why it shouldn't be customizable (if anything, as
a piece of fact on the in-repo data, in-repo-encoding is *more*
appropriate to be an attribute than w-t-e that can merely be project
preference at best, as I mentioned earlier in this thread).  

We always use the in-repo contents when generating 'diff'.  I think
by "attribute to be used in diff", what you are reallying after is
to convert the in-repo contents to that encoding _BEFORE_ running
'diff' on it.  E.g. in-repo UTF-16 that can have NUL bytes all over
the place will not diff well with the xdiff machinery, but if you
first convert it to UTF-8 and have xdiff work on it, you can get
reasonable result out of it.  It is unclear what encoding you want
your final diff output in (it is equally valid in such a set-up to
desire your patch output in UTF-16 or UTF-8), but assuming that you
want UTF-8 in your patch output, perhaps we do not have to break
gitk users by hijacking the 'encoding' attribute.  Instead what you
want is a single bit that says between in-repo or working tree which
representation should be given to the xdiff machinery.  When that
bit is set, then we

 - First ensure that both sides of the diff input is in the working
   tree encoding by running it through convert_to_working_tree();

 - Run xdiff on it;

 - Take the xdiff result, and run it through convert_to_git(),
   before emitting (this is optional, making this a one-and-half bit
   option).

That would allow you to say "I have in-repo data in UTF-16 which I
check out as UTF-8.  xdiff machinery is unhappy.  Please do
something." perhaps?

The other way around (i.e. in-repo is UTF-8, but working tree
encoding is UTF-16) won't need xdiff issues, I would imagine.
