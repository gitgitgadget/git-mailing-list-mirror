Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927741F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeDIQRR (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:17:17 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44091 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDIQRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:17:17 -0400
Received: by mail-ot0-f195.google.com with SMTP id p33-v6so9243555otp.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GzTVAHhqDN60FRrxhEd3n7Q0KDJl3zT+RyNW2NpYZto=;
        b=GmKOMSm2dj2u5kVF6otZIZPEoeclX6ZWJL6eRV5uukCESooTqXxMbZxxQU2ZhidyiQ
         ftrJlOwEpI4uu758ig4LgJ4jem4l5MN18nTjWK2BtW8Zvjm8qES2MjrQN1e5tDOmiTDW
         UJJ6+SSLPKs6158cJPEcQToJCOQMJoCYsu6YPt6ppjT6ZBsPlw8v8be2bUv8uKwRpIPG
         aDR+a3n43WugEzbNX7/R6fZ3LQWmE2zOtACdKNAG+vj6Tu9K1VvXxysdXPl3DNExM+X+
         1WTNsDioGo7smewUwaUoUddP8fN7sSti4riLq+U7vUX7puIZvxBRdE8qej1v8AkDh7pV
         mLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GzTVAHhqDN60FRrxhEd3n7Q0KDJl3zT+RyNW2NpYZto=;
        b=JegfYK5Yic8Y2MwS2ikTrtwx02bVu3aXjaLzJJDyzFTrXebIrgXW6cmVRoMiLakYJZ
         ar/zZcmz4OuA549nqVTVpuiu9tOtP7WfDMNvPLliiV2xdlM0odrymeTX0h0d3i2aSjnf
         B1eR89bMqEGs9+nD8rf7AHpc3E/ClzwhHeOVwyHZ2GZfzFEXOxirMusiM0rWByrZch48
         lwO+QnY1Hsr4UCl1njSFX26FiU0RmIrcem4+qWm/U5Hu3BIys+sSnC0BcOKf4dbQGMwy
         hCmIm+ZUisxQRHct82QwK7KturLPuoFhAAakyp521CwCFOIHS4nH6sB/pZCQteCeH7Wv
         2AqQ==
X-Gm-Message-State: ALQs6tBYedlFla+QDn0xu9w7N64WVUKIqm1Cej2P3Kr2gNdXda+pced9
        T7ROrkZosTSTLRMFgOuic+7anDBic41daksd1dw=
X-Google-Smtp-Source: AIpwx48Bv9EUlc5P1S+2EgpTJ0dojN1ENq3jOePRtnoFcgK5ushNGewePX3+MmSaRoTmIK3gEjeMcEkQ8oqXk+Vy37s=
X-Received: by 2002:a9d:16f3:: with SMTP id s48-v6mr9910949ots.304.1523290636578;
 Mon, 09 Apr 2018 09:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 9 Apr 2018 09:16:45 -0700 (PDT)
In-Reply-To: <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-4-pclouds@gmail.com>
 <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Apr 2018 18:16:45 +0200
Message-ID: <CACsJy8DQEZ_wYWWRQLeLNwJoWhkAwN++Uaxnp=tDvCd_u4gFaQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/5] generate-cmdlist.sh: keep all information in common-cmds.h
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 6:59 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> common-cmds.h is used to extract the list of common commands (by
>> group) and a one-line summary of each command. Some information is
>> dropped, for example command category or summary of other commands.
>> Update generate-cmdlist.sh to keep all the information. The extra info
>> will be used shortly.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
>> @@ -2,9 +2,10 @@
>>  struct cmdname_help {
>> -       char name[16];
>> +       char name[32];
>>         char help[80];
>> -       unsigned char group;
>> +       unsigned int category;
>> +       unsigned int group;
>>  };
>> @@ -23,27 +24,50 @@ sed -n '
>> +echo "#define GROUP_NONE 0xff /* no common group */"
>> +echo "#define GROUP_ 0xff /* no common group */"
>
> Meh, this "GROUP_" alias of "GROUP_NONE" isn't so nice.

Yeah. I don't want to mess too much with shell script. I wonder if we
should instead kill this script and extend Documentation/cmd-list.perl
to handle this task too. It would be much nicer to write and maintain
the script. The downside is NO_PERL builds will have no commands in
"git help".
--=20
Duy
