Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F383B1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 09:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeDIJz2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 05:55:28 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:42966 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeDIJz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 05:55:28 -0400
Received: by mail-qt0-f175.google.com with SMTP id j3so8460118qtn.9
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5/dKWqXHKrkI1Ce2tZRaqajUG471iU7hJg3psxmVDMY=;
        b=mcxlxmO63krQir0c1YPMyyPjr1urDhN92NBftemre1JOtW72+XjCdSvE5FGxuKD1fv
         oiEbD/un6mSH2h86yv8K802wyJ7R1MKmYbsDm4FeU/cKHQ3yrbgYBRs69BnWE6hyHQLC
         JGvWUtdBxp32C2lW2wrrnL6kKbhqtgJeIEBA4wjbX9HSAJcfjQXQfTKUPsxcDKCOAXcT
         3ETTC7RXsi2b/7uzgoIZPviCuFrCAGZZ6VoJtvh+7lSKQlo5TssTjjn7cDpjABGJvyT0
         trLcf9ueYAh7VYWmJ5Q670Pxm1hXQgrPO0geMiTu9cgsQQsOdzm1zw5XewnA7aWKzDCA
         Fnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5/dKWqXHKrkI1Ce2tZRaqajUG471iU7hJg3psxmVDMY=;
        b=bnuRPQeL72fSNoRWD4e5gvhuUgYDG+RL5gOgY9gWBi9TLdgNudzix9awpVkCcwd80v
         Fhh83WpYY6jxsQrJCgXwPnWWIRZcwuimRRxgd/BpxU3+NIDmk0n7y1pDKvw6ynyYIXxu
         6kzHwFARnyBryjCXT7izH1ebZPE0tg2CwonfLL19Jr6N5EF113D+hvphmu2tbYCIgMLO
         j3p5T063rmkEZPjj9ehqVS1cJWXmopISXM78BLlqqr/asJCMmjaYQJ09xMR2y6MqiBE1
         GvPtQ7DefJLdqEH+3qgFsxCkNUg6nJpnuBDR0WJpajdOXORH0JueW2igcti2LuT4hvC+
         w/KQ==
X-Gm-Message-State: ALQs6tB2co5J6tW1alaf/ygy2DCikkU+uzmxVb70RJy85OEK/AGYb/2P
        jz1uSW6JbuKboEXREV6cmiwlbkDIpqiFK8SkkRs=
X-Google-Smtp-Source: AIpwx48UzcC1oWPGZbIRoWNxcJpkvc2B1GxcmvZel0kmwQDoVPEiSbu47HTNN4FJ05VZ8TcXRWVZJb2MhVJ6wFDzJps=
X-Received: by 10.200.69.131 with SMTP id l3mr9097111qtn.50.1523267727277;
 Mon, 09 Apr 2018 02:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 02:55:26 -0700 (PDT)
In-Reply-To: <xmqqh8ok679l.fsf@gitster-ct.c.googlers.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-6-pclouds@gmail.com>
 <CAPig+cR-WP5z1u-9KG-mNOF0mEUcguMET93O21nfzYixEFWaYw@mail.gmail.com> <xmqqh8ok679l.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 05:55:26 -0400
X-Google-Sender-Auth: qFyoS7mTAiAh_nTmkpMETXgMKBM
Message-ID: <CAPig+cSwDpWOz2_PAZOCmdhoYXYhYR0fHsw8POgNDfd9nD2Q1A@mail.gmail.com>
Subject: Re: [PATCH/RFC 5/5] help: add "-a --verbose" to list all commands
 with synopsis
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 5:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy
>> <pclouds@gmail.com> wrote:
>>> +       switch (category) {
>>> +       case CAT_ancillaryinterrogators: return _("Ancillary interrogat=
ors");
>>> +       case CAT_ancillarymanipulators: return _("Ancillary manipulator=
s");
>>> +       case CAT_foreignscminterface: return _("Foreign SCM interface")=
;
>>> +       case CAT_mainporcelain: return _("Main porcelain");
>>> +       case CAT_plumbinginterrogators: return _("Plumbing interrogator=
s");
>>> +       case CAT_plumbingmanipulators: return _("Plumbing interrogators=
");
>>
>> s/interrogators"/manipulators"/
>>
>>> +       case CAT_purehelpers: return _("Pure helpers");
>>> +       case CAT_synchelpers: return _("Sync helpers");
>>> +       case CAT_synchingrepositories: return _("Synching repositories"=
);
>
> Somehow this screams "an array of strings" at me.  Aren't this
> CAT_things small and dense enum?

Duy's modified generate-cmdlist.sh does actually output an array of
strings for these, but the (generated) array is commented out in this
RFC. I suppose the reason it's not presently used is because the array
looks like this:

static const char *cmd_categories[] =3D {
    "ancillaryinterrogators",
    "ancillarymanipulators",
    "foreignscminterface",
    "mainporcelain",
    "plumbinginterrogators",
    "plumbingmanipulators",
    "purehelpers",
    "synchelpers",
    "synchingrepositories",
     NULL
};

which doesn't give quite the human-friendly output he'd like. The
series is RFC, after all.

A possible approach to fix it would be to add a new "### categories"
section to command-list.txt which associates those category tags
("ancillaryinterrogators") with human-readable counterparts
("Ancillary interrogators").
