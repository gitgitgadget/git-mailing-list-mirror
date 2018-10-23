Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0071F453
	for <e@80x24.org>; Tue, 23 Oct 2018 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeJWXIv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 19:08:51 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:36594 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWXIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 19:08:51 -0400
Received: by mail-it1-f171.google.com with SMTP id c85-v6so2428153itd.1
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zHqkjxGrpqXH4sU5T/RaTfxb+ApnQyoKw6340KnSnQg=;
        b=WYaq2lGLqB1hEKqkQe80GyZYQM0lVYvuxmeJ2oFcPbN5Jhdt0Gt/gM94nYQ+59Kdkn
         VyOa0b+gt7ancA5FN884trdl5O9ieZ2SdUrIHI7NQpVd5icrdcOjNHb2B0JzPOr/I/m7
         NsF3PofF9gstDzPkSgwGUbzERf6e2qXa7r7lq+kZxGI5qWfcmo7QILG5ItxQBXZe9JwP
         EVEyu9ijoNEmFNHruJmIBFq9esa5IPwxxTIvizXbJxG5IkS+vWik/LxuRxyHt47qvKtz
         3mCZiAq/X+4h5Mos8Yu831/lm60SybFhEKMi4JGGJEKrovuV6oNKXD1SAmqeh++7nkvt
         9b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHqkjxGrpqXH4sU5T/RaTfxb+ApnQyoKw6340KnSnQg=;
        b=ZjjLoscZEvFu2wTutZewRNddFUxSXAPzJj4Hfcr7mxc5qC469mirrhz8+mAdCfq6HV
         uRpWaiXLKDT1aia2ykCDcCopsrggqGj3+QY2QwAfCTVXW0b+gKXQrpsrMqAySW6UI2zB
         OzH2VUMOsayY/pONpIIetmuipVnSssRTt/BEH25+D8SHIWLzFYgmWgWR8h/RjZco7AMg
         ZUfLi4DiEHUdkemy+Xs83T3w0L80pmzQBsj/Og7voFyCzCYajI6BLJmvtrXoVGbra6QV
         cWQ+SBeyAvpek0jc/HDOX6GcGey/TYwi1pGzNtkAMJ42bTUpmiUjIBlrk7GChRir03GK
         4Q4w==
X-Gm-Message-State: ABuFfoiCDOxr6oiJH4+tvxAZb57mjYAx270mV9xrNAj4hdiV3iKAYIoO
        3EZecAzG0afqkd33HjIpDTkdCGt/h9X6dVZccENI4A==
X-Google-Smtp-Source: ACcGV62AfPuJJx9axC6QiU/znhXPxpS0OT0DjP0rHX0TSgsvcTFML5hbR+SYRmereR3qWc4vk0aGqoaxaa7nG35DcjQ=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr12704523itc.123.1540305906462;
 Tue, 23 Oct 2018 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181022153633.31757-1-pclouds@gmail.com> <20181022202241.18629-1-szeder.dev@gmail.com>
 <20181022202241.18629-8-szeder.dev@gmail.com>
In-Reply-To: <20181022202241.18629-8-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Oct 2018 16:44:38 +0200
Message-ID: <CACsJy8DEta1f8v5XPK53bMdarWX4TYiQAx0Qz1LCRA0nvZANwg@mail.gmail.com>
Subject: Re: [PATCH 7/8] gettext: introduce GIT_GETTEXT_POISON=scrambled
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 10:23 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> [TODO: Fallout?
>        A 'printf(_("foo: %s"), var);' call includes the contents of
>        'var' unscrambled in the output.  Could that hide the
>        translation of a string that should not have been translated?
>        I'm afraid yes: to check the output of that printf() a sloppy
>        test could do:
>
>          git plumbing-cmd >out && grep "var's content" out
>
>        which would fail in a regular GETTEXT_POISON test run, but
>        would succeed in a scrambled test run.  Does this matter in
>        practice, do we care at all?

If var is supposed to be translated, _() must have been called before
the final string is stored in var and the content is already
scrambled. Whatever left unscrambled is machine-generated and should
be ok to grep, or we have found new strings that should be _() but
not.

PS. Another thing I'd like to have is to mark the beginning and end of
a scrambled text. For example, _("foo") produces "[f.o.o]" or
something like that. If we have it, it's easier to see "text legos"
(instead of full sentences) that makes translator's life harder. But
it could interfere with stuff (e.g. some strings must start with '#')
so let's forget it for now.

>
>        Does gettext_scramble() need a FORMAT_PRESERVING annotation?
>        Seems to work fine without it so far...]

I don't think you can. _() can be called on plain strings that just
happen to have '%' in them.
--=20
Duy
