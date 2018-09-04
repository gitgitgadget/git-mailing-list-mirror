Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016F41F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeIEANy (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:13:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39599 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEANy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:13:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so5454230wmq.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GdUfVQ6UbStZwmZMtwLwTJiDyCfXZQtqcaEi752xfw0=;
        b=b6NwcrroKLiGrybuivRgfohznNQKpNdpxKVEiqudL+pzJyJ7awteWhLxxIZmJ20lEJ
         IVxAUx0DsftDrtCGX3IA9wKBEDiW9+FQLcnjIMcrrZyiFoHJzBlTLc/QwmJsz7/ApAHr
         AysBY8AdjJsWhPgrZw9jJit45znLyCTbiwbfjXuOcoaH/h9ThdzmTlcI7hOdTsBkLQ7C
         Ji/BR9Ghli2IWJM+DnND2Q+PY+4hd34PXs2R7rZ1U5Kyvwd28/9GZM4aon14a7RX1uHc
         lBb+kP5+S0I6rJ0CFoQ/syrGnbWsq2Lj14JH7Zrk75DBsShE8J5mxmafnyKWARpAx90v
         5ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GdUfVQ6UbStZwmZMtwLwTJiDyCfXZQtqcaEi752xfw0=;
        b=Ap0aZG+teWDx39GCtKyYuU8fpE3hapCajKbfkPI9rTnxIS3InfcDfcqnsKI0eo674O
         Ynq1OW+4lOM0UrCrO1+ox2sFM4lKVzK+p6QgZyKIjKuR3v1zeQC+nU6SeiV4nkx7J1Fq
         Vl8MBspyjdgZNOlYuSqPj2688oWacBU+UWoe+2Ov54OqsyERfnBRIAo8x0m89qwfun8+
         GsZIovxxpfa8qtEnKuMhgRkU3V6mevLwgCLMf06l8jWMRDvDlF0zrt1s0O/sTdhJf+zr
         02BXLnC7pT9DefUGHJ3mKD8bVoget5r0fRo9qNh86+Qo+hdqAv7uwCc4y/1Lk06MI5cW
         zURw==
X-Gm-Message-State: APzg51DvgAICnc2vNFKEpCsb3WgIfknTfqQwR/Y+WLu1cX+J4lTWQksh
        rNH5FAL8T4yZbJvbHS5r03w=
X-Google-Smtp-Source: ANB0VdYhpib7SmjrCVC1HOIrmj8WFpaxcKYUHWYP45SsetnGSoAt0NJAvJRPYQ8A+bBgA6SeL517mg==
X-Received: by 2002:a1c:9011:: with SMTP id s17-v6mr9130697wmd.146.1536090436251;
        Tue, 04 Sep 2018 12:47:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g126-v6sm57654wmg.5.2018.09.04.12.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:47:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH] i18n: fix dangling dot in die() messages
References: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
        <20180904141816.26398-1-jn.avila@free.fr>
        <CACBZZX6Bm-xOO-mvDzmRAA9Xu6HrBr5z+39dp4t6fTTCmNHKbQ@mail.gmail.com>
        <2f6f52c8-4b8a-a954-5ffb-5d66dfb97fe1@free.fr>
Date:   Tue, 04 Sep 2018 12:47:14 -0700
In-Reply-To: <2f6f52c8-4b8a-a954-5ffb-5d66dfb97fe1@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Tue, 4 Sep 2018 17:13:53 +0200")
Message-ID: <xmqqefe982pp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> On 04/09/2018, Ævar Arnfjörð Bjarmason wrote:On Tue, Sep 4, 2018 at 4:59
> PM Jean-Noel Avila <jn.avila@free.fr> wrote:
>> Your commit message says "dangling dot"...
>
> The dot is dangling on its own line. I don't really catch why this would
> be needed.
>
>>
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index b56028ba9d..a011abfd7c 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -521,7 +521,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>>>                 printf(_("Entering '%s'\n"), displaypath);
>>>
>>>         if (info->argv[0] && run_command(&cp))
>>> -               die(_("run_command returned non-zero status for %s\n."),
>>> +               die(_("run_command returned non-zero status for %s"),
>> ...but here and below you're also removing the newline. Is this
>> intended, and does it work as desired afterwards? I.e. were we just
>> ignoring the \n?
>>
>
> I checked that usually, the die command does not have the final dot nor
> a new line. But I'm not sure of what's intended here.

Your changes look correct.  Die() and friends terminate the message
on their own, so a trailing newline in the message is usually a
mistake.
