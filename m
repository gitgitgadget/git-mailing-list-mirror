Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266AF1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 08:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeBIIXb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 03:23:31 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54024 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeBIIXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 03:23:30 -0500
Received: by mail-wm0-f45.google.com with SMTP id t74so13933748wme.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 00:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cdiTZJiu9pTEFw09Ee+dXtbrlXP5XVUkBJYS1RoP5EY=;
        b=sn8suo8VJ5hGWtPFlr9FDM0JE06/Ot/LKdIRdzhINh2IbsRe+iI1UIm8PaqMUuHe5j
         PWFmr0rTYNF0suRNbBLp2nOFvzpOL2ey0CAsoZN6FbjdpntQkdl6fWbrOAcfvbfOObrb
         hVZFwwjJ3Otf95oDIRuo1jV2BBw9E16QquTGag7Sp9lnPz0VbGSpbC2GRbZsLGUCHEfM
         0UpDWwrBrmdNeaxvpovo1Psrntp+OtkhsCnikLKrEeW9jXEJgac5Uri+n6GeaubyLc1f
         I248tDHXvQnN2kBwDfG+iczSH1AjdVsfNLtiuZIEHgjPYLVLwY9oNYsnBgb4krKMkFgW
         a8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cdiTZJiu9pTEFw09Ee+dXtbrlXP5XVUkBJYS1RoP5EY=;
        b=sR8+e6pttEVoK3W0Ffm2w1kPkeTicdnfA2wJB4GNtECodox3x5qIGyrAliDKPgBajd
         E2LOy+28BLsu+L9cZziva9tOUtbBF3Jr92eqhbQ992Kpt0/FsLe4L6SXMjv2RyL5pt0j
         7zv5Y3Hr4o769PDX4dlx9ufe+Vm35b/yu4sqj0r+i46RQv4a5Rj7vTW9pPls23gcbCp3
         ohmV1Gi1EtgukecGgrtUUaie5s54XP/AimMNiNb/p9wdSQOiHSp4vmyU86ERnsamZKrY
         XtnzsYJEfhaHBeMtFncPi0EHhM2KqjQf5Qz/6xndtNT5OQxKwle4to8Ww1Eulr5n2v5h
         6SBg==
X-Gm-Message-State: APf1xPBUV7zksPgWRbI8352pFyjQLzwI2i1GhPxCB/4Vf619GcbS5riX
        M764sOIrTH+6AQGnk65TtpcP9RYl
X-Google-Smtp-Source: AH8x225F3o28POjBeq+D5aJk2khuuOvzvOohuCt3R0noELwQpA2ewAh//dBfbjqVf5UuwlOetEaFyQ==
X-Received: by 10.28.66.198 with SMTP id k67mr1188389wmi.74.1518164609406;
        Fri, 09 Feb 2018 00:23:29 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u98sm2245643wrc.69.2018.02.09.00.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 00:23:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 16/17] fetch: add a --fetch-prune option and fetch.pruneTags config
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com> <20180208161936.8196-17-avarab@gmail.com> <CAPig+cS3OCi9CDykF-5EAx=J3ouXPo+7HE_CB8DfmWccBxyxgA@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAPig+cS3OCi9CDykF-5EAx=J3ouXPo+7HE_CB8DfmWccBxyxgA@mail.gmail.com>
Date:   Fri, 09 Feb 2018 09:23:27 +0100
Message-ID: <878tc2mv0g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Eric Sunshine jotted:

> On Thu, Feb 8, 2018 at 11:19 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Add a --fetch-prune option to git-fetch, along with fetch.pruneTags
>> config option. [...]
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> @@ -592,6 +592,15 @@ test_configured_prune_type () {
>> +               if test "$fetch_prune_tags" = 'true' ||
>> +                  test "$remote_origin_prune_tags" = 'true'
>> +               then
>> +                       if ! printf '%s' "$cmdline" | grep -q refs/remotes/origin/
>
> Is $cmdline guaranteed to end with a newline? Historically, not all
> 'grep's would be able to match the last line if it was not properly
> terminated. Perhaps you want '%s\n' instead?

Good point. No it's not, will fix that.

>> +                       then
>> +                               new_cmdline="$new_cmdline refs/tags/*:refs/tags/*"
>> +                       fi
>> +               fi
>> +
>> @@ -705,6 +714,66 @@ test_configured_prune true  true  unset unset kept   pruned \
>> +# When --prune-tags is supplied it's ignored if an explict refspec is
>
> s/explict/explicit/
>
>> +# given, same for the configuration options.
>> +
>> +# Pruning that also takes place if s!origin!<file:// url of remote>!,
>> +# or otherwise uses the file://-specific codepath. However, because
>> +# there's no implicit +refs/heads/*:refs/remotes/origin/* refspec and
>> +# supplying it on the command-line negate --prune-tags the branches
>
> s/negate/&s/
> s/--prune-tags/&,/
>
>> +# will not be pruned.

*nod*
