Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE471F406
	for <e@80x24.org>; Tue, 16 Jan 2018 02:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeAPCOx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 21:14:53 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38061 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeAPCOv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 21:14:51 -0500
Received: by mail-vk0-f68.google.com with SMTP id l63so8533094vke.5
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 18:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=32MjnmQNsgMdisFXxW4kS4Bgx6N2qSHQsF+UP5cQ3vo=;
        b=WQwwN3BJKBWVGa5NS/mqOq3kOGgj/+YlfWxb1cHWOsDG7YnkL0rmC1ca0+o+kQXQG8
         OMXQHatcI1X20fl9LQTivoEyv275NQs9PJN0oPH9Zoft7dspaiypI+7S3C3Njpt3I2S+
         z09IB+ECqsyTnZRVs5d6RzMPxQEG9Axy5hObpgvTr8iDmKsu48Du3OIQ79f2K159ylLC
         Ry7sSPFX7XylalMLeRrhhy7H95PHNpyh2IgjbKdnpyt9uqbkrok5XfyNZdDbrIBusxQS
         tOwhtrG5U2y3nXE6UfT0BxjlBtj4e58mm3DpXaZ+tOggjwD5pMp1+A6Hod+NV4PKVpr+
         DLYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=32MjnmQNsgMdisFXxW4kS4Bgx6N2qSHQsF+UP5cQ3vo=;
        b=TH/8XLQbqzdT9KFvlWWHsqBXvz555cXdeJEXjrdSmCpXdiIPxqbLaBtk6kbzfqZIKr
         jKRrzbQES+iAyggmo3NJdB6Ury9Tjp4lY8GwqpvfVOxVtJtXISOKv21EchrOyNrRWDBY
         +9wnD2ga6rEEFaMcyHCgNdaqMApB9mqQoy86M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=32MjnmQNsgMdisFXxW4kS4Bgx6N2qSHQsF+UP5cQ3vo=;
        b=JaxNPxCJgwln0QfisP049qotFe8/tr2sBAVZmdc7lhPCvKeyzQZ0ymnJk4J/4DRJFH
         Ar/ZoSCjWL/XNSdn4U2zMnZF1PRhS8OXSIZJXvYod++CMPQ/vStvNd5u7QYgtn/gJ0Te
         zmppweEh9Kc3tVuacVgyHRBUuXhu5hxLOtMkti9fRfZ8yH5WeQH8/qVMxMnrH2ePRBFE
         oLl0fK0XK2RGoFdU5CJaTXYeagPFqmyifyCdEzuORzMJE4j18khdlDRA0OO89bDq0Up4
         eDWQBoTFuJ8lxaGc2tdJYzq6eW3SeIxDakV3p60iVEE9rVjFlU/KLydBsVWVMFOnwTTf
         EpmA==
X-Gm-Message-State: AKwxytdpUBn/NpiqEfFXygijStbOyACk5bqFJpgDHQQ6yPlv9dzItk7D
        t9n28DLtIo/DSzy13p7MkBruNvbnaYwUOqSFo9210g==
X-Google-Smtp-Source: ACJfBoue21twQMLiHng6CWZbtpNJiagRiukDar9wxQBlHa7XaUAe+RKG2qDpTgEjy5ft5UvTu1r7/IWKKzKZ4ThYrR4=
X-Received: by 10.31.254.201 with SMTP id l192mr13424624vki.153.1516068890461;
 Mon, 15 Jan 2018 18:14:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.37.66 with HTTP; Mon, 15 Jan 2018 18:14:30 -0800 (PST)
In-Reply-To: <87tvvmiqn7.fsf@evledraar.gmail.com>
References: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com>
 <87tvvmiqn7.fsf@evledraar.gmail.com>
From:   Michael Giuffrida <michaelpg@chromium.org>
Date:   Mon, 15 Jan 2018 18:14:30 -0800
X-Google-Sender-Auth: 75pnYSXbSGZWUFzVvgOeG7oEc2g
Message-ID: <CACi5S_33F7VVRYiBOQsxgg_ZPOg9ZvhLZ26bStYWiq7n96aeug@mail.gmail.com>
Subject: Re: [BUG] git remote prune removes local tags, depending on fetch config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org,
        Michael Schubert <mschub@elegosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to confirm, you're talking about the behavior of removing *all*
tags that aren't found on the remote? (Not just tags that used to be
on some remote, but have since been removed from that remote.) So,
with your proposed workflow, you would never create your own tags
locally, without pushing them to the remote before running `git fetch`
-- otherwise they would simply be deleted.

It doesn't seem like a useful feature -- you wouldn't expect `git
fetch --prune` to remove your local branches that you were developing
on, right?

On Mon, Jan 15, 2018 at 4:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jan 15 2018, Michael Giuffrida jotted:
>
>> `git remote prune <name>` should "delete all stale remote-tracking
>> branches under <name>". I was surprised to discover, after some
>> troubleshooting, that it also deletes *all* local tags that don't
>> exist on the remote, if the following refspec is included in the
>> remote's fetch config:
>>
>>     +refs/tags/*:refs/tags/*
>>
>> So, if `remote.origin.fetch` is configured to fetch all tags from the
>> remote, any tags I create locally will be deleted when running `git
>> remote prune origin`. This is not intuitive [1], nor is is it
>> explained in the docs [2]. Is this behavior obvious to someone with a
>> better understanding of Git internals?
>>
>> I did find a better way to automatically fetch tags (using tagopt
>> instead of adding the fetch refspec). However, the refspec doesn't
>> seem "wrong" in itself; in particular, `git fetch --tags` used to be
>> considered equivalent to specifying the refspec
>> "refs/tags/*:refs/tags/*" -- implying that this is a sensible refspec
>> [3]. So I wouldn't expect it to "break" the behavior of another
>> command.
>>
>> [1] https://stackoverflow.com/q/34687657/1327867
>> [2] https://git-scm.com/docs/git-remote.html#git-remote-empruneem
>> [3] https://github.com/git/git/commit/c5a84e92a2fe9e8748e32341c344d7a6c0=
f52a50
>
> These docs are really confusing, but it is working as intended, and
> really should be re-documented.
>
> The `git remote prune` subcommand just ends up piggy-backing on
> git-fetch, whose behavior is explained here:
> https://git-scm.com/docs/git-fetch.html#git-fetch---prune
>
> It's worked this way since at least v1.8.5.6, maybe at some distant
> point in the past it only did this for branches when invoked via
> git-remote as the documentation says.
>
> RELATED:
>
> I've actually had the reverse problem with this. I want some way to turn
> this behavior on without explicitly hacking the refspec, so I can do it
> globally in /etc/gitconfig or in ~/.gitconfig without screwing with the
> config of each checkout on certain machines.
>
> You can set fetch.prune=3Dtrue, but that only prunes the branches, you
> need to inject remote.origin.fetch into each checkout, unless I've
> missed some way of doing this.
>
> I wanted to add fetch.pruneTags that would make it as if you had
> refs/tags/*:refs/tags/* in the fetch spec, but I haven't hacked that up
> yet, if anyone can see any inherent issue with that plan I'd like to
> know about it.
