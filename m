Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA85202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdKSSGe (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:06:34 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37497 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdKSSGd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:06:33 -0500
Received: by mail-qt0-f195.google.com with SMTP id d15so12367808qte.4
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=S7HKmnrjQuWKH/topGI5CoWZP0zF6SUnLJOs2zE9X70=;
        b=dPCWBlzh/vQuiJpsBpL7zkU4TOfQx9AZtqE96CQg/hCtL8Bm19qY8NWZ7En/PJJGK7
         ELROJBYmJWMrzebOuQb1lQOEHbhlO6hZEOji5mkWNafC0hrgIWPTjAKnTASyvVa//uxm
         PYPrPLnfhYPtgnxCb9vJlb4bAdHDS+Q1yHttFzaajS/TJie1UEKhFstTyTngKYGmCJCs
         q0gpPWJVy2p7gDJ972U/bs4X+DygnoeppLOUoeXF4bWIaWy8bpcY1WHA0yJvPrZSH4v4
         V9gKhKbEeHjrBI+p1EmJJBigf3i41c+3I7u+BTB+lMhbT69FV0lHHs3kjhkS5zT3ptfJ
         RDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=S7HKmnrjQuWKH/topGI5CoWZP0zF6SUnLJOs2zE9X70=;
        b=ZSRLeZAqJFDT4Tw/N8BHxTdcSdvKclkiuTeXb1J5qfE/Kqd3/ZsDjZub0ySwWz02Gv
         +sTdFynunSQOHq625dG8uxhSWVOFnN8blELjwzpupEDt0c2o+hEk1vD07WckeWfF06Mm
         wfjKey605hUJgG2o7MoCB4thHjHePeg1Au4qtRutapNhs2GjD3/mGU3oAPXV0DzmY/8u
         co7VnYdIxelMgYF+7T2ADXBEECrywrgCG/845JXnm4VA8AQdLc9eYM4PJwiZ3ZFCnq7/
         JLGc1TIODMBo9d2/2PndFMO/9pNDx7ihHJ2LVTUdk4FhUgPipB6nOAFaB/fgbk5AUE9X
         aXIQ==
X-Gm-Message-State: AJaThX7fFYXa+8O8FOiul9h7VJRMWJ5DOl8ndA6QBWMD+kKkyZ3fhVmU
        +pAfZhv7OlznhDHqtEgddjs+lO64QTLQab2Xcx4=
X-Google-Smtp-Source: AGs4zMZBXDJm1ptupVcrzLfaU9aNTm/EwslhQd/7fxOSzFWimxiwsoqeDn1P7i3dz+8wntptYsxZVFzzSoUspRuVWu4=
X-Received: by 10.200.5.2 with SMTP id u2mr17590137qtg.217.1511114792950; Sun,
 19 Nov 2017 10:06:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 10:06:32 -0800 (PST)
In-Reply-To: <a3bba8dc-0f4c-808c-9b6e-2252160a2cc1@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com> <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
 <CAPig+cRrJVhYMYfoFhSi+FOLv0X4or1-YV=M8_X10_d_Bbt3pA@mail.gmail.com> <a3bba8dc-0f4c-808c-9b6e-2252160a2cc1@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 13:06:32 -0500
X-Google-Sender-Auth: AY7tfnEjD14Vq9B96JpnDaNHgNU
Message-ID: <CAPig+cRXk8LdTFKagNFJ3L3AUsA=ZAs=eiaBwBs4JDYG303vmA@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtin/branch: strip refs/heads/ using skip_prefix
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2017 at 12:21 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Sunday 19 November 2017 06:34 AM, Eric Sunshine wrote:
>> On Sat, Nov 18, 2017 at 12:26 PM, Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
>>>
>>> diff --git a/builtin/branch.c b/builtin/branch.c
>>> @@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char
>>> *oldname, const char *newname, int
>>>   {
>>>          struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg
>>> = STRBUF_INIT;
>>>          struct strbuf oldsection = STRBUF_INIT, newsection =
>>> STRBUF_INIT;
>>> +       const char *prefix_free_oldref = NULL;
>>> +       const char *prefix_free_newref = NULL;
>>
>> A bit of a mouthful.
>> Perhaps name these 'oldname' and 'newname' or something?
>
> How about the following ?
>
> 1) "interpreted_oldname" and "interpreted_newname" or
>
> 2) "stripped_oldref" and "stripped_newref"
>
> I couldn't come up with better names for now.

Sorry, I didn't look closely enough at the context to see that
'oldname' and 'newname' were already used as function arguments.

Perhaps call them 'oldref_bare' and 'newref_bare' or something. It not
that important (though, shorter may be preferable). Aside from the
names being rather long, what I didn't mention originally (because I
had edited it out of my earlier response) was that having "free" in
the names made me think that the values needed to be passed to free()
by the end of the function. It's probably not worth a re-roll,
though...
