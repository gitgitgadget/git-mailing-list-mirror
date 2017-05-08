Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A221FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbdEHRPn (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:15:43 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33155 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754764AbdEHRPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:15:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id u187so30170583pgb.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H7OUiEJPoHwOj59xWgwzXYickrG8amogOmjPqSM77So=;
        b=Dn4rAeL04EOJRa5d9kMm98ri6q9RLxJXi877v14h0xL3J3mcpm2U3cMP27f4/s+O/w
         TqTD9ghWq+UF4jBY8E9PHvapkqudlDe4Je1OWb+0CCVqDqm6799vn+8HIlCqFlTrMRdK
         IAw96Tk2R20bjob0AS/HINn8TcBqMK++Tx0ArAq0gWNve49pSqFRNbCk8GlAKJoRD7mH
         TZ2pRrrI32iTx37dfkTvdoGExzP/W77eiOGS11kIFDJ6jzjajVhwSDrbUmJXWpL3u4ih
         OIpXPJKOHXHWRWXh5eQ3rDqqx7XoSwtk4KPWoK0CExcQDlTqeVR/ofhFJW1B/8pxulSe
         0AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H7OUiEJPoHwOj59xWgwzXYickrG8amogOmjPqSM77So=;
        b=JiEKuOPb0PoNBhNOWieWTT00u/jTAw7s+8cbex7oQ/uvnbeeRqXyMkRp9sAFjRhWI7
         b06lg1mU+PuzftPTxcYbarG8y3Ce9NhLODwJATE2V9BNYVPF7ipEcEMfsgoCg/8TmiTu
         hEh0mXyA3o7mPI+lkig+FHl289O9HtCdrjlpqD0vZd8iFz1bblf+L7gXfQNeKqHoSUyk
         kuBVySZx6qbwbM110BQNdzgc+MMks/x7heUh7hNdeBYclYFU0R+8IqrXlKxeNUElGJum
         H/dtFWnaffurdZraa3nW0LwA9yI34dg6jAUQcLOjCyUbvMh+b8yShWrja3zaiw3qifTi
         Futg==
X-Gm-Message-State: AN3rC/4enwfvavU8GaNptiYHI++LTHdek7eIf53PFQLvpIUcn8OPMAsH
        +WLuKtKvnxf6/cgmaDWwFT4d4TN7JT+x
X-Received: by 10.84.228.207 with SMTP id y15mr46340698pli.172.1494263736490;
 Mon, 08 May 2017 10:15:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 10:15:35 -0700 (PDT)
In-Reply-To: <20170508170846.GD179149@google.com>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
 <001b01d2c809$62ac8520$28058f60$@nexbridge.com> <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
 <002201d2c81a$9ff76060$dfe62120$@nexbridge.com> <CAGZ79kbxdXhhG3+4v9qH_oDi5o_zseGsQf8KCyTN3+axZB9sUA@mail.gmail.com>
 <002301d2c81d$4728aae0$d57a00a0$@nexbridge.com> <20170508170846.GD179149@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 10:15:35 -0700
Message-ID: <CAGZ79kbNEAL6dYFPzquDDAsMNqpFsE3_VEHXeKu1VuaLV+m8_w@mail.gmail.com>
Subject: Re: Add an option to automatically submodule update on checkout
To:     Brandon Williams <bmwill@google.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Ciro Santilli <ciro.santilli@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 10:08 AM, Brandon Williams <bmwill@google.com> wrote=
:
>>
>> >[submodule "gnulib"]
>> >    path=3D./gnulib
>> >    external =3D true # implies no branch for checkout -b --recurse-sub=
modules
>>
>> >I think there are a couple more situations where such "external" submod=
ules are treated differently, so maybe we'd want to think carefully about t=
he >actual name as different workflows would want to have different feature=
s for an internal/external submodule.
>>
>> I didn't want to open up that one, but yes. That makes sense. However, I=
 don't like overloading what "external" means or might mean in the future. =
Would you consider a distinct Boolean for that, like inherit-branch=3Dtrue?
>
> Something like that kind of already exists.  The 'branch' field.
> Internal repos would most likely use the '.' value to indicate that the
> submodules should track the superproject's branch.  While a value of say
> 'foo' would indicate that the submodule should always be on branch
> 'foo'; this could be used for external repositories.

so for external repos you'd keep the branch unset, such that
you strictly checkout the sha1 object into a detached HEAD.

Makes sense.

Thanks,
Stefan
