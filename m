Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89CC433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16B664DDD
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 17:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhBEPyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 10:54:05 -0500
Received: from mout.web.de ([212.227.17.12]:49289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233054AbhBEPvm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 10:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1612546317;
        bh=irlqaBWf8KiXGS1dJ7g3PwYCzUeA2TJnxim9zeTgI54=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OVJBVlZ4QcT5AOgZcsMWimdLs2ku8IPzFbWVaxhC/O4PZzgT5VSoaZTRexph2ERL7
         7rDTS2Dli0065ID0+ECH/01AiPci5D3RNC55Rk6kYAfJquv494m1XQzKQS9IUzMZhr
         yHRUj2Q8gyZp8Cuvzje4j+5z77M/M+D0+3Iq90Zc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1lXU8u3xZM-00RVWW; Fri, 05
 Feb 2021 18:31:57 +0100
Date:   Fri, 5 Feb 2021 18:31:56 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v4 1/1] MacOS: precompose_argv_prefix()
Message-ID: <20210205173156.6ypl2q56r6gzutac@tb-raspi4>
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
 <20210203162823.15756-1-tboegi@web.de>
 <xmqq35ydc5g3.fsf@gitster.c.googlers.com>
 <xmqqh7msbxzy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7msbxzy.fsf@gitster.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:7Ltg6QTurtYFW0R0QZpfTky+RrY4Fvfn7NjSSH7yEtC9rNXS5Of
 +3WyxGV5joNY7v6b6xI3M8pSIY00Gbolx74TS9eo3+mXoL/p3AdzzKbC2xAOjEobvuScIKB
 //gvcGAWRRr0ZMUSxl6ymPfakZw4GoZUDc0ZNZWsZn/NauWV5+gfSI4lJ49wK/guOdPjnk6
 AtJGu13tFRBRbmKwqXh/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FnUQxdMUHiE=:lHoeTCCkDzzEBKntZucMCh
 jL556s51W/cD37H90MJgFtubXxzZ3hCKd6H2LGyuwXBa8k6RIQEDZ2sVQhtGaXYnlZx6Y2CSG
 Y+rCW2UnZ2AFX6s0FVgnyrGCuKcfPDRVeilJ5wluSvgd0HnIObgGrux1Awl0DbXf0pkPKB/Wx
 KacrUIz2epOnWkgLSVodFDLf4bcdOXdZFoCyZASO6hMQeG6ZEFhaSgcOQHWOBAyLcWvkO0/F4
 t75UXhG7LxnIdRyw/CaAfxonexDEuDWwNJiHxBS3hZqW58d+D3NYadRCtqyBHXIUHOTHN7LPi
 w57CB7KsVbZW7QUeknZjgAtJlcsmosiFXYK/8oAVsjQvKJnxWOnlogk61dg6scHoncUuWOyvX
 Lv+pvbdqq+4uegi7yzLzdsYZOgU4ALaaHkUgnL2qrj4lEQuV0udepNflwuL2pgH6qwtnGqIAY
 WU5qu/fNu6mQydNyoSH0lAfQ2Z3cAa5vFgbKRukplXsG6n2hQorbarCsSG56KKc9fEtwpsvOK
 MW91VWxAdhPrPRRxihGieyOqVbzXBcXLqcgvKsoTD40/Uap1cYbb7WSr7weo1+n0728Ychof5
 F/n/V2hkqnKFkTShdInXyh2b+4vCjOJZ+9ws221YOdQPehnhjCZ71ug0fIWOgvTl101GXMOAC
 veuhQ9X6zcLex1k23iNpweazwBlc94Gm8BXEQTExsG4X5utw2Fi0aXQUBCMgWTu0PpuTEVStM
 VaBwsP/qaV/pIgwiRA7tTG8Id7Vtc7SyFEF9fyNdW5zDGWznZ6fy4T7gAC5UpBCMxXJb6O4Za
 PxUtEMFlmKuSogC3VnHJwh58HCLJbisxJTK3dpKg9+dVHUbwooyiOKpwL+hEanaaMKBySWqE7
 mP5bqcYH2MVS9nh+ACNg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 02:13:53PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Just as the prefix-less variant was idempotent and that was the
> > reason why cmd_diff_files() had its own precompose() even if the
> > incoming argv[] is supposed to be already precomposed because it
> > was processed in another call to precompose() in run_builtin(),
> > this patch keeps these seemingly redundant calls, because it is not
> > meant as a clean-up but as a bugfix for the prefix part.
> >
> > OK. ... Ah, no, the call in run_builtin() is a new thing.  We didn't
> > have it, and the redundant call is what this patch introduced, so
> > we need to be a bit more careful about the analysis here.  It is one
> > thing to say "we leave the existing iffy code and address only a
> > single bug" and do so.  It is entirely different to say so and then
> > do "we introduce an iffy code and address only a single bug".  We
> > need to admit that what we added _is_ iffy but supposed to be safe.
> > Just saying "it is supposed to be safe" without saying why it is
> > iffy is dishonest and does not help future developers who may want
> > to jump in and clean the code.
> >
> > Perhaps
> >
> > 	Now add it into git.c::run_builtin() as well.  Existing
> > 	precompose calls in diff-files.c and others would become
> > 	redundant but because we do not want to make sure that there
> > 	is no way for the control to reach them without passing
> > 	run_builtin(), we'll keep them in place just in case.  The
> > 	calls to precompose() are idempotent so it should not hurt.
> >
> > or something?
>
> FYI, I've tweaked the proposed log message like the following before
> queuing.  I think that would be explicit enough to remind us that we
> may be able to improve the situation fairly easily.
>

Thanks for helping me out.
That gives me some time to look deeper and prepare more test cases
ana a then cleanup on top of this patch (later).

