Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F6D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 12:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbdASMCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 07:02:52 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33579 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdASMCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 07:02:51 -0500
Received: by mail-io0-f195.google.com with SMTP id 101so4752983iom.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 04:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mSZIyS/kSQz+/x3dXhR2h8PDI70X5YD4NahmZbN/gmo=;
        b=KRXqwy/+ymQYRhHlJSpWsElQJsbZbSjxk7Yk3pmh4B48DVqCYRIhMKS6Zi25JN+HV1
         /qpdvPTwZ9jdnOZkF+RBrvOIK3y/bB63Im7IDtkcadkAvteqsmmMcbDKmkEQoNCit4dg
         Ur3tkPMIR6BWr8jeoOlfcWm4B0+qJIu8aX0L+wHXyZx4iVOQclwa5ZJrPMNfL9Ujf1Mj
         JC/cCVmLC3O3Z4gDNK7d4EJrXpS5ZRcX9y1zG07I7fRPabYFXmUUOuCezxSES1y/+ts9
         Totdq45tbK4Dh/itLCCT2eGIUsoWOghSYiGUsVC2Nh5C0hDaQkY8pe4j7SaLDOPMQaH4
         6bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mSZIyS/kSQz+/x3dXhR2h8PDI70X5YD4NahmZbN/gmo=;
        b=GDpGuOOKoVFiyIs/UTW56yXFXqlcuZziSX2nreG+5v1j//yCfFrIrXdYQjRIBEJf80
         WWYpueVgeC4AHNVjnLCuEJEgZrMGpowzaaiSZ6IZOk5CDZ/eBlsPHabBYx7VOsUER+Eo
         cGFZ3Nwdg0WLnnd5zjwRWb5QgBwFUTtozjxz7JKrBxUTarprM63JhFU6pnTP+yOMtFpS
         1myc5hVOrxoBSm6SdjrOEClB7Dp/G/bkcVXf15ehoM8/2AApg1204gVR5iBGz1ZOO9p3
         NUcnUrimMM7RhLuBufXMvKid8XBiXdrlc7nFiWFC9FhBEk1ksgFvoPgrqm/eu+V+kfHa
         LApw==
X-Gm-Message-State: AIkVDXI3n4HD8ws+BW6B41ZMW92hZv7ilnZ5hHGF7VOEHwD1PtNrG7CNJIQl4l7hmQJFJVcu4JmADbszEDCnlQ==
X-Received: by 10.107.198.195 with SMTP id w186mr8010770iof.19.1484827370616;
 Thu, 19 Jan 2017 04:02:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 19 Jan 2017 04:02:19 -0800 (PST)
In-Reply-To: <xmqqh953j2q0.fsf@gitster.mtv.corp.google.com>
References: <20170110112524.12870-1-pclouds@gmail.com> <20170110113320.13119-1-pclouds@gmail.com>
 <xmqqh953j2q0.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jan 2017 19:02:19 +0700
Message-ID: <CACsJy8B3TQ5va_wvbiKgkVggYJG=x+RVyabtAkzbqQqWFO2F-A@mail.gmail.com>
Subject: Re: [PATCH/RFC 5/4] Redefine core.bare in multiple working tree setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. I'll shelve this for now, maybe sleep on it for a while. The
series is complete without this patch by the way, if you want to pick
it up.

On Fri, Jan 13, 2017 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> With per-worktree configuration in place, core.bare is moved to main
>> worktree's private config file. But it does not really make sense
>> because this is about _repository_. Instead we could leave core.bare in
>> the per-repo config and change/extend its definition from:
>>
>>    If true this repository is assumed to be 'bare' and has no working
>>    directory associated with it.
>>
>> to
>>
>>    If true this repository is assumed to be 'bare' and has no _main_
>>    working directory associated with it.
>>
>> In other words, linked worktrees are not covered by core.bare. This
>> definition is the same as before when it comes to single worktree setup.
>
> Up to this point, I think it is not _wrong_ per-se, but it does not
> say anything about secondary worktrees.  Some may have their own
> working tree, others may be bare, and there is no way for programs
> to discover if a particular secondary worktree has or lacks its own
> working tree.
>
> Granted, "git worktree" porcelain may be incapable of creating a
> secondary worktree without a working tree, but I think the
> underlying repository layout still is capable of expressing such a
> secondary worktree.
>
> So there still is something else necessary, I suspect, to make the
> definition complete.  Perhaps core.bare should be set in
> per-worktree configuration for all worktrees including the primary
> one, and made the definition/explanation of core.bare to be
> "definition of this variable, if done, must be done in per-worktree
> config file.  If set to true, the worktree is 'bare' and has no
> working directory associated with it"?  That makes things even more
> equal, as there is truly no "special one" at that point.
>
> I dunno.



--=20
Duy
