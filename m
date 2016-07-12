Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680051FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbcGLQN5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:13:57 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35432 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbcGLQN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 12:13:56 -0400
Received: by mail-io0-f179.google.com with SMTP id m101so20966009ioi.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 09:13:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L76hp3wpsUiNLxPnqrXjz2Pu4UEs8Bo/7L/5fK8vXtk=;
        b=wXFyuvwPGanir+hpnbLrq6Mx5nwBUkaVJeyZhlK5dZPHhchpkmSdlZv+NaqWuQDv5l
         ADUIKuGl3I8A8skhGCXKsUem4Nel7PCxB5pu5gF3q8qxwBESOjCeLEo70Awb5evXEhDu
         7GCbAOPsF6hv8j3gCi2UxTRvBM3eunBHGkFE4gQzbEl8alCBVVMHiULU6i5kBKcORmpb
         ZojO/oU7k4oGPTpOYASctQBYm2npcXIy1Nb2aI2V0Q/SdC5BdPc1NtrR8UkxZrnCBxKn
         XUsKfdpFfqWK2S/fAbz2VWmsdNXOU62liewQtkdfYF1stKvngNCxsymQiPgzhOTBX4DG
         AuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L76hp3wpsUiNLxPnqrXjz2Pu4UEs8Bo/7L/5fK8vXtk=;
        b=fKq5S+ej4HBa9DMlkc/PlE1rb3/z1FLfe4CWVgrW0FLiW/xa9vgni4BxKPWMuUaCZR
         mx4W8/f2eKeJrYoMG//IBoUP7vjg9/rAHIJ1bajasog3dR8kNcacEVlw5ffh8JID94zC
         MXwkmP3HI19EODvpGuUsyrv4XA8kpB8O13Nm2WQaT25RZbta8mTo4obqiWcNEqegHHYv
         NTF9wPRwZ8m1h16VfhGW0egWzO4fkb3XeI7COaHlmTezOBR1vD0PkjV5G3M7FjlKTjKl
         avvkJjjaelneiLsevcU6XZAbRjFeyc9elkOH2AC8Fy9UhQNTnbdT8sAOr68oriONY0Xu
         R5Kw==
X-Gm-Message-State: ALyK8tJeUVEXR0vv/O/mRyBMN65LFbSvBZfOmKrIxZbv7taFv6fBQtYfTN4o7ns9rUui6PlAPqPRuwAw5IlhBw==
X-Received: by 10.107.22.6 with SMTP id 6mr3767431iow.128.1468340030626; Tue,
 12 Jul 2016 09:13:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 09:13:21 -0700 (PDT)
In-Reply-To: <20160712155141.GA5967@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1607090928500.6426@virtualbox>
 <20160709140931.GA3185@x> <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox> <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607121243470.6426@virtualbox> <20160712152646.GF613@sigill.intra.peff.net>
 <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com> <20160712155141.GA5967@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 18:13:21 +0200
Message-ID: <CACsJy8BfXSvKM3=rRCDYzR=rpLRi+FBYs4r1WGXFisq0Esk00w@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 5:51 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 12, 2016 at 05:46:12PM +0200, Duy Nguyen wrote:
>
>> I'm not opposed to letting one worktree see everything, but this move
>> makes it harder to write new scripts (or new builtin commands, even)
>> that works with both single and multiple worktrees because you refer
>> to one ref (in current worktree perspective) differently. If we kill
>> of the main worktree (i.e. git init always creates a linked worktree)
>> then it's less of a problem, but still a nuisance to write
>> refs/worktree/$CURRENT/<something> everywhere.
>
> True. I gave a suggestion for the reading side, but the writing side
> would still remain tedious.
>
> I wonder if, in a worktree, we could simply convert requests to read or
> write names that do not begin with "refs/" as "refs/worktree/$CURRENT/"?
> That makes it a read/write-time alias conversion, but the actual storage
> is just vanilla (so the ref storage doesn't need to care, and
> reachability just works).

A conversion like that is already happening, but it works at
git_path() level instead and maps anything outside refs/ to
worktrees/$CURRENT. Reorganizing all refs in a single ref storage is
probably possible, but...

> The trickiest thing, I think, is FETCH_HEAD, which is not really a
> ref (because it may have a bunch of values, and contain extra
> information).

Yeah.. I think David and Junio touched this when lmdb backend was
discussed, which resulted in leaving per-worktree refs to filesystem
backend even when shared refs are in lmdb. We probably can still make
it work, I think refs subsystem has special case for FETCH_HEAD
already. But 'refs' stuff is really not my area, I should stop writing
now before making too many wrong statements.
-- 
Duy
