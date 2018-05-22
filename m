Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71101F51C
	for <e@80x24.org>; Tue, 22 May 2018 17:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeEVR4A (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 13:56:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46866 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbeEVR4A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 13:56:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id y15-v6so17002808oia.13
        for <git@vger.kernel.org>; Tue, 22 May 2018 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WKAopaIFPC/M4+lJZvryXh47dlKdF48nILI9Eq++eog=;
        b=Qk7lQ4NKdMfdW64Ze0Ligy1VDjjsWXdiH7XPZ96tb2YnDuLSdGJ1/k5eNXJdHb1v1t
         UyZWBuaQCpQ5xbb4VXmvrumauoIBqEFVtZGtDMwVbufkhF93OBXAEupKmu0BMqNIcCVQ
         4eEqbisfW6BNpoq5Z3BGXNZbR2bEuhOtTb2gz/Luz3UvZsrth+DPDr11eeLrFQWJ8veD
         js8UMIYrwBG/Y9wpvIeQlSER5XjADT8n5FmUxPQXvvqgLAkZHwDfZlfqCQgHwWCvxWzF
         x8fCjJ+QNKF/S0c6cvjGk0hFep37ZSzycbag/ibsQ3DOHo6bOibLvdiGn6QEVoX1W9oY
         wtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WKAopaIFPC/M4+lJZvryXh47dlKdF48nILI9Eq++eog=;
        b=kCEC0OW5Leh1buUscL2bwYguMAjCx6IstECzj/bSFyVazQrlWwhGX9DssNTQqpawRj
         gwgOwb6kBQQcr1yETRsPzIRQH3dn+RIITLoFkab0hMbFA9+hp54H3XCvC9hGbvAFD3W/
         +Oavbxe5vqSc2gMSZIC28byR1Vk1bX4NqgA1VoY43aOT+RKugNv8w0rncC5TC3Zp+WRa
         uRY1OKyk1dxK54XDkCvQae2qOwVbIa+SXIGa8ByVrDA9yUajX/wPnIRUUzWmWL5+oLAJ
         dkknc4Dgd4M4RgaT1PY94W2RsurnFm5aZ1S3dJT0eFQS6Uhq+AjcCIqIzQw8RiPbY3KU
         jMlw==
X-Gm-Message-State: ALKqPwcHY2SJ/+ys9qTkpvDXvPM7SfSpHP2RwxprGULtscklpfAXEObn
        jNqMTX82eLno9Y8IYxcoVLLTyxd3oOQFfavpv6Y=
X-Google-Smtp-Source: AB8JxZr3BWiDNshHBekOAQsTj370uMaskStxTEjIFAbio5IICkuV3BEooWS+oTgkQtjP/jR+WBftl0lqIQ6ZWMDJVP4=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr15211993oir.56.1527011759460;
 Tue, 22 May 2018 10:55:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Tue, 22 May 2018 10:55:29
 -0700 (PDT)
In-Reply-To: <874liz8tsi.fsf@evledraar.gmail.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com> <20180516222118.233868-3-sbeller@google.com>
 <874liz8tsi.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 May 2018 19:55:29 +0200
Message-ID: <CACsJy8BnsbOvz+iSz=9ug99Cs5Dm17Fgk65K2nXusBg0dML4xg@mail.gmail.com>
Subject: Re: Why do we have both x*() and *_or_die() for "do or die"?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 7:49 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, May 16 2018, Stefan Beller wrote:
>
>> A common pattern with the repo_read_index function is to die if the retu=
rn
>> of repo_read_index is negative.  Move this pattern into a function.
>
> Just a side-question unrelated to this patch per-se, why do we have both
> x*() and *_or_die() functions in the codebase?

I wondered about that myself shortly after suggesting
repo_read_index_or_die(). My only guess is xfoo is better version of
foo, which sometimes involves dying inside but that's not the only
possible improvement. Later I guess people go with _or_die() more
because it describes what the function does much better.

> I can't find any pattern
> for one or the other, e.g. we have both xopen() and then write_or_die(),
> so it's not a matter of x*() just being for syscalls and *_or_die()
> being for our own functions (also as e.g. strbuf uses x*(), not
> *_or_die()).
>
> I'm not trying to litigate the difference and understand it could have
> just emerged organically. I'm just wondering if that's the full story or
> if one is preferred, or we prefer one or the other in some
> circumstances.



--=20
Duy
