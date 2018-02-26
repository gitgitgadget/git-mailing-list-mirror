Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AA51F404
	for <e@80x24.org>; Mon, 26 Feb 2018 19:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeBZTUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 14:20:53 -0500
Received: from mail-yb0-f182.google.com ([209.85.213.182]:37507 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBZTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 14:20:52 -0500
Received: by mail-yb0-f182.google.com with SMTP id u5-v6so4420404ybf.4
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 11:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xdzv6ojr+/WvIW5e6es38RkwPnQsi1K/Y1XDJq7HVII=;
        b=rAYtCwrcX3Qgd+V/gPrmLIFj7RR19FXK5jQNsnW0ZfAzP1CS/2cJ6WO58qYID9/TKg
         OPQNIwb5H/ZK9HSj9+4wrszO+L8o96UYIrafa0PmeHOiJV83QjF1WMGCJtG+ldKrsPLG
         wGFhdqcHN7CyvLxmHKNA3OtJJYcKI9SU8vjDrojNg8ylPDnOp+zNf3/5/N4UY6NC6iqa
         4RmkdXbqyCc6Ejwed/9GMiXDPz/V98vvFxaxvr0/usBYbyy9r9q+i/qzUSRure1vCtqA
         xrzUWa+ayFQi387mL4oQwN6Nz7EtGjvtxR39ATYG3JwDuBDC2JQ/PGEA0pavOuWNUE6E
         2Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xdzv6ojr+/WvIW5e6es38RkwPnQsi1K/Y1XDJq7HVII=;
        b=O2WeZzh2t+NckwRKB9Ux1F7qanZJSqG0cPffQ3IoIOWakVhCs5H1Ib0/ddxiSZ4c8f
         FS9mYdm/v/UhK1KrcHKZVu06dLcIhWgnJ6pyizN9D9DkGEl9AwcGjyD87rHPzm4V7lS/
         EAohyRL3WCDU3Dv6/4ciev8ioGtX4UA+/ePXGE+Pt4B67K3PwGjlRpR2izVIAZIgr2x0
         rgzmgoxA39B8VrjM0+gjx1+MxHjATTBBVK8X8xdiHAhOwlT7KTqoZac3UeC7fq+WnGZE
         dCX8OoUelomkHw5eVCC6HgPKLfer7k8d2U6DtOIdUPUT5aaCL5ood2Y4QSSdH7s6piei
         q9ng==
X-Gm-Message-State: APf1xPCKzE2+RtRYRR/i31yfMBjr9YeYYJyPeadPYJPEtx/3mvg/QAQx
        WHuxN/QNOtOKVWHiIfEoRF6QrQyikIYRAnRYxW+d4Q==
X-Google-Smtp-Source: AG47ELvBwV/JbDGa3ES1O9r6j/Aaga55UkN5xwciICvJQ0QKfzk5VYNOp29AjY24+zMzgkMSshgwt4AX6aI8EDKSJa0=
X-Received: by 2002:a25:b087:: with SMTP id f7-v6mr8168324ybj.247.1519672851769;
 Mon, 26 Feb 2018 11:20:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Mon, 26 Feb 2018 11:20:51
 -0800 (PST)
In-Reply-To: <20180225203401.GF4620@genre.crustytoothpaste.net>
References: <20180224033429.9656-1-pclouds@gmail.com> <20180225111840.16421-1-pclouds@gmail.com>
 <20180225203401.GF4620@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Feb 2018 11:20:51 -0800
Message-ID: <CAGZ79kY-n-4xnN450+U6_dn2u27ZZE5fKCY4sKKA_yGE=gUOMA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix initializing the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 12:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Feb 25, 2018 at 06:18:34PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>> v3 refines v2 a bit more:
>>
>> - fix configure typo (and stray words in commit message)
>> - use repo_set_hash_algo() instead of reassigning the_hash_algo
>> - compare hash algos by format_id
>> - catch NULL hash algo, report nicely and suggest GIT_HASH_FIXUP
>>
>> The last point makes me much happier about keeping this workaround
>> around until we are confident we can live without it. Interdiff
>
> This looks sane to me.
>
> Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>

I agree with this version as well.

Thanks,
Stefan
