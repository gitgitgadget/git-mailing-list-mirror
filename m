Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95ED21F406
	for <e@80x24.org>; Tue, 15 May 2018 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeEOQwH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 12:52:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34221 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbeEOQwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 12:52:06 -0400
Received: by mail-yw0-f194.google.com with SMTP id x27-v6so275734ywj.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y48Bsq8RfSbU1a5lB5d7lrmQZAyblbXEG2PBdA/h5fE=;
        b=fEW7A0g+R67w8noBKa3/ai6RHr6ye3umKBYHTcmi+oi14abum/T9lhG+uLOD2+LoMb
         OImf7888hPWoE2rD2JdvhZy0hZvLkU4HH9rRqJG3Sn4iIF773z90f3QtV51cyo0MSPX0
         jOMYdtYKX1DqHNuMmtBcQUP1sSkYsSZd/P4WK1vNQfTLB14a6mt5NKePUrFhrQMlWzGg
         8CL8xQzkP7Rs0UXzk91Uh+BAdRTxV5m01ZbpwE/zP9gj2hAOTYEwtaXf50HELnL6iimk
         9BPYGmFPKEL4DXsOGdu38WVSqLj5tI8XYaameznVjQ4T6VuuKLgOHn2Wm8XL4uYuEE/m
         dZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y48Bsq8RfSbU1a5lB5d7lrmQZAyblbXEG2PBdA/h5fE=;
        b=naRsVUqUAbP1F3XgbZP8jkz0dGCQzkHbHfRhBw/rZ5yf9AnSONYbvcuOf7hvn5QJOi
         N6jyd9MrHgMmAtBBL6vfZVkaW7xgtU6q4PvzLcOll5tAguxYHY18ksqWoErZBlklGjqS
         6JkasOdqULf8FbS/TdKwm/uca7Htc2swR6xODOZBeeFacRkLkGuzed3SCE2lZRMOn50F
         R8EBhLl9EjtYAFrdMlmaX8S73Fca75O3GyvcWUvgLQ9oD9H1dM08XHty3LXPMXVVWvPk
         Y5z0LgiehQ0xHFKJ89mQ6plkEZWOpGeZdrN4QZrlYntk3QUYZrVoCnkVbteTRE4fZlSU
         kFUA==
X-Gm-Message-State: ALKqPwfxGBg2zVMgmpM3b6/15fDZjOJReYukE5extoHzh1W9ShxbRAxO
        q/capHW+I2Bky+CPyRXn7OIDrL7E+1OiA7XZgSY4J1zWk2I=
X-Google-Smtp-Source: AB8JxZpSYA8Pqw3hW5bgGcTDcEZ2lqU344BUL3dLCoYymE0/WCEcjOeDIxtHRzcMxUWQielLkzTbVpeqCAIj6kogtM8=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr6720103ywg.345.1526403125966;
 Tue, 15 May 2018 09:52:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Tue, 15 May 2018 09:52:05
 -0700 (PDT)
In-Reply-To: <87k1s52va3.fsf@evledraar.gmail.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180514215626.164960-36-bmwill@google.com>
 <87k1s52va3.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 May 2018 09:52:05 -0700
Message-ID: <CAGZ79kaOt4oonsEMn47Rp_xL4_tGy6k78kFZFfxUOg_4sD_xtg@mail.gmail.com>
Subject: Re: [PATCH 35/35] submodule: convert push_unpushed_submodules to take
 a struct refspec
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 1:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, May 14 2018, Brandon Williams wrote:
>
>> Convert 'push_unpushed_submodules()' to take a 'struct refspec' as a
>> parameter instead of an array of 'const char *'.
>> [...]
>> diff --git a/submodule.h b/submodule.h
>> index e5526f6aa..aae0c9c8f 100644
>> --- a/submodule.h
>> +++ b/submodule.h
>> @@ -100,9 +100,10 @@ extern int submodule_touches_in_range(struct object=
_id *a,
>>  extern int find_unpushed_submodules(struct oid_array *commits,
>>                                   const char *remotes_name,
>>                                   struct string_list *needs_pushing);
>> +struct refspec;
>>  extern int push_unpushed_submodules(struct oid_array *commits,
>>                                   const struct remote *remote,
>> -                                 const char **refspec, int refspec_nr,
>> +                                 const struct refspec *rs,
>>                                   const struct string_list *push_options=
,
>>                                   int dry_run);
>>  /*
>
> Why do you prefer doing this to having this on top?:

The fewer includes in header files the better, as then the headers
themselves don't have dependencies. (Otherwise we'd end up
multiplying cache.h ;)

In the source files we have to include all needed headers, but for
the headers, it is better if we can just get away with declaring the
existence of a struct.

This way we reduce compile time, so I'd am not keen on your patch
on top.

This is discussed a lot on stackoverflow, e.g.:
https://softwareengineering.stackexchange.com/questions/195806/forward-decl=
aration-vs-include
https://stackoverflow.com/a/15828094

Stefan
