Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7F4207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 11:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbcJKLSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 07:18:30 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34513 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbcJKLS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 07:18:28 -0400
Received: by mail-it0-f52.google.com with SMTP id 189so17853037ity.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LjaJI51hia0rGL9dF8h0hw1Oz040cTVhUhD9pWVSVT0=;
        b=cAQV6xCFhNTHZfQIjGrnvB4Cbwq84syWReoMRvuf6F5Zoj7yafi3+G8ho8sXAiHO3P
         f01CgMNvmGEb5Dq3TsHxQn4cOoHhKpDCEoSE8T7C5BXc26JDP0Rag8WAqQTtkzH84f5r
         YzK2Apfx6AHPY6Wbk9H4is5evw0cR0HL1ODETeCX9N6LxdJxhu9gaEOH/8R3G3+srOBq
         VnRZjgq/Ctdlm5ZJag74cLYpARxGBaLR8vKJRsXPnEKBpJ0dJEf39tK5xEnQIz4pLSgK
         LSmo4fEE9D/mQ4kU9rlvZjEBXWaQ0Y2Fw78nf1cIlEpENp6/laZRT3cR5VkgwRR14sA8
         8K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LjaJI51hia0rGL9dF8h0hw1Oz040cTVhUhD9pWVSVT0=;
        b=WL3PTulKc+461iwgL0HXvLrkZ/2Jq08NWdDqmuABwgc8G4edDH3MvFWpv4+G2kVO5U
         49xmXcKApEEGgTGbCJ7Q4NJ4hS68nMspqUp49EquWpJQ3/PhyxxL9lojl9bhKQJGGeza
         X6Vd+xvhZ6HKH7edarMGYkf4EhBs7XRUovIoIpb5IYr4k+YqLK4ratLYnhfI8lMxzGYp
         ZD/S0sp+igqnA2EJz5ew8ecLecUY9hGrZ6MFOU8P5ieHPjMuqG+rjVZP6tNgxpQYsSEe
         HXxXPuNk7Ps0y37oFb7y/NLA8IgFJqthKHL85sBEgI1lfD6qQaU7nDWHRfHzVvCQFZz+
         yVgw==
X-Gm-Message-State: AA6/9RnNtWEEMtPNt5vSL3s02sQxqeZkAhHDAD5q5gsHBphe32Mo0axDd7mdtVrsrcvsMWC+Oqy+VtjxcDTfHQ==
X-Received: by 10.36.76.15 with SMTP id a15mr5138449itb.74.1476184601952; Tue,
 11 Oct 2016 04:16:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Tue, 11 Oct 2016 04:16:11 -0700 (PDT)
In-Reply-To: <xmqq60p0f3un.fsf@gitster.mtv.corp.google.com>
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
 <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com>
 <CADKxhpd-gDczp05Ny6wP57RXafWWCimArfA9ki2phh+-gHez4A@mail.gmail.com>
 <CACsJy8DGvyWz2_VBsEfmDWOPGUGAUhKYhCa1qLEMcOdn83ocSQ@mail.gmail.com> <xmqq60p0f3un.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Oct 2016 18:16:11 +0700
Message-ID: <CACsJy8AZVWNQNgsw21EF2UOk42oFeyHSRntw_rpeZz_OT1xdMw@mail.gmail.com>
Subject: Re: Feature request: use relative path in worktree config files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 1:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> I think there are some pros and some cons for relative path and absolute path.
>>> Maybe append a "--relative" option with `git worktree add` ?
>>>
>>> I've converted all path to relative and all work with success.
>>>
>>> What do you think to append this --relative option.
>>
>> Patches are welcome.
>
> Hmm, are they really welcome?
>
> Is an invocation of "git worktree add" really the right point in the
> workflow to decide if these references to other repositories should
> be relative or absolute?  When you are moving referrer, it is more
> convenient if the reference uses absolute path to name the
> referrent.  When you are moving both referrer and referrent, it is
> more convenient to use relative.

You're right (thanks for thinking this through). There's another case
that benefits from relative paths besides Stephane's use case: if you
put the entire repo and all associated worktrees on a portable disk,
the disk could be mounted on different paths each time, so absolute
paths do not fly.

> I somehow doubt that users know which future move they would be
> making when doing "git worktree add".
>
> To me, this almost looks like a need for a new subcommand to "git
> worktree" that lets you move existing worktree to elsewhere, or turn
> absolute reference to relative and vice versa.

An alternative is always use relative paths. You have to move
worktrees with "git worktree move". Which simplifies things a bit
(absolute -> relative conversion on existing worktrees could be done
at move time). But I'm not sure if it's a good idea to kill manual
move support. If you accidentally move a worktree, it'll be
disconnected and you have to fix that by yourself.
-- 
Duy
