Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6623C1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeFHVls (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 17:41:48 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:46584 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeFHVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 17:41:47 -0400
Received: by mail-vk0-f43.google.com with SMTP id b134-v6so9055080vke.13
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZzEosYzypNV7K+V2Xof2vriVcKJ9J8tZ2C6fX2Kd1pw=;
        b=MxX9vuOonVBGt4TYOx45Dgy/aBA2V9OT+9yA5CmWoBqyoqDn6+x6IE735iesW5Bhyj
         g6Se/oyoSCzyMLuVkE/A9HGIgwUL/FH6Bg0dBC0+Ui2eedNITmHXiOUugdXDIn2t17uR
         6Cc4YPUgcPiEcDX2Vq6SbD8RWSvCOAadU1zloBvR2Mh/voZ7awiuCwAtezq0xslA9Cbz
         eK43kbzcfEFVDAyrcrDxglcQmd57NhrGi5lCJur+6iFfqZjBsjcedGsmkyG5LMaIWIqt
         y8Mfs/rN7KfFotqeUo88aJseHYbBWMiCNge2G/0scfqPEXl1umM//1xlI+/OUVs05K0x
         i+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzEosYzypNV7K+V2Xof2vriVcKJ9J8tZ2C6fX2Kd1pw=;
        b=W4ordYM69kg7fx+XwasOIU9N4Aqw5dxwfswbej82Gp2l26Q5Izh7+YKkMjuYNa2vfL
         /kNBMzOZZPYieaE+TITMG8CA6RHkDALH5d3Pte0WfOUpTSnwHya9yonQR9xSyYsVtbvR
         FpMPlH8KCcPDwF9lQnfSvtj7ZSANg2rld2KkkB1zszTbGSXzLNrk7Cmnk7l4GUjEfqvd
         kNG5Qbdv0kolZRotPbYykxqF+RAk6x8m6Atu9oP4ulw9Tu/8ySLCfAgJrmhwBoto19Pn
         ykwsJv5+pxsH/bCCScPpvXMJqh9sKsfV7v4cS3+VvjE1hki/sKJlywE0a/0pjetpi+RP
         KDqQ==
X-Gm-Message-State: APt69E0TxEv0tEDtyUFLC7ZxDN54CRM0PYjX1YQTZeRarWpZbsXCvwBU
        nPcdGvLpxqVGBqz7BMrjkJkC+Sd6zNVawis6dsM=
X-Google-Smtp-Source: ADUXVKLAwPROxW8jWDbggUxVDN7my7G9smrObQ7U+/PW5Vz63o1BGDdRKtV+RlcIOGnEw4GY9dTjxi6EW2a68ZtpF2Y=
X-Received: by 2002:a1f:142:: with SMTP id 63-v6mr4879992vkb.2.1528494107012;
 Fri, 08 Jun 2018 14:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3105:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 14:41:46 -0700 (PDT)
In-Reply-To: <20180608212348.GA42503@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com> <20180608211639.7611-1-szeder.dev@gmail.com>
 <20180608212348.GA42503@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 8 Jun 2018 23:41:46 +0200
Message-ID: <CAM0VKjkWkUmU9LGyKKFyvkOCFh1s+JJK4aZLPfoOJj26OkNQVg@mail.gmail.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 8, 2018 at 11:23 PM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> Hi,
>
> SZEDER G=C3=A1bor wrote:
>
>> Being in RC phase, I'm all for aiming for a minimal solution.
>> However, I don't think that the better fix would be erm.. any "less
>> minimal":
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> index f2aa484758..7aeb575cd1 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -3244,7 +3244,10 @@ __gitk_main ()
>>       __git_complete_revlist
>>  }
>>
>> -if [[ -n ${ZSH_VERSION-} ]]; then
>> +if [[ -n ${ZSH_VERSION-} ]] &&
>> +   # Don't define these functions when sourced from 'git-completion.zsh=
',
>> +   # it has its own implementations.
>> +   [[ -z "${GIT_SOURCING_ZSH_COMPLETION}" ]] ; then
>
> Needs a - before the } to avoid errors in a shell where the user has
> chosen to use "set -u".  See v1.7.4-rc0~159 (completion: fix zsh check
> under bash with 'set -u', 2010-10-27) for more details.

Right...  I did remember that, but by the time I finished typing out
that long variable name I forgot about it... :)

However, I'm not sure it's worth caring about, because the
bash-competion scripts don't work with 'set -u' anyway...

>>       echo "WARNING: this script is deprecated, please see git-completio=
n.zsh" 1>&2
>>
>>       autoload -U +X compinit && compinit
>> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/=
git-completion.zsh
>> index 53cb0f934f..049d6b80f6 100644
>> --- a/contrib/completion/git-completion.zsh
>> +++ b/contrib/completion/git-completion.zsh
>> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>>               test -f $e && script=3D"$e" && break
>>       done
>>  fi
>> -ZSH_VERSION=3D'' . "$script"
>> +GIT_SOURCING_ZSH_COMPLETION=3Dy . "$script"
>>
>>  __gitcomp ()
>>  {
>
> Except for that tweak,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Thanks.
>
> Now it just needs a commit message. :)
