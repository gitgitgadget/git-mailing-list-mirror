Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFDE1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeI1BJc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:09:32 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55059 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeI1BJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:09:32 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so9160530ita.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7+wF+ZztRxjNg4hrV25CgIDx86Iy/KYA+r2gm7JDVO4=;
        b=DJkEK0Z6EotoR9s18y0T43UdeSKsUJOXqA4+b/u4o2eiR1WfOK2VWDEyuW4e9deo6P
         1y4YspArTn9j6bgJPGNmK2Xjdku8QsNrbWmfK0mzQgKJfOSaIWGSMNDvNHBF2tsaldna
         YCmmtTEFhGK/t1yTi502tEjyr5Kpa+LqUzIgsVxqmL9LiZMrjHNMTvDnnDeVHqNfpMYq
         ePgE+r+y8SG8T1Rtx/oKPegWL7ECxFqf3acbWvo4YbvRqQg8vzxEsjHPw1bask27hH7x
         ccE7QfWRLdlaEmAw9qDZDadL+TIi+K9BXr/C8Ol75K0NCog3XNwX+Bxr/AkwDySRmfLq
         pHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7+wF+ZztRxjNg4hrV25CgIDx86Iy/KYA+r2gm7JDVO4=;
        b=PySdvxWfWKiqBbZCMl8oHVDYJ3WMKzM31m7Hx3NGamLzI7teIiIQsBSjKl0dJWAKro
         4e2rgRWYtobNULbcIpUFUWuXIPJmIaJKE4DeSz5UqnKpEIGZitUwBG/z+x9eQ0c8Jwah
         MdjUDaeJQQshAoktGv50/e32HYVRtTRF0Tqlflxgxq6WhbjRcWeMskcRyZYQyA/FnSWR
         dkdqQIXe6ClAyIVQZXLBs6OdceDT5zryHpYGCppw4oYJ1zSJSkIaFCIWxYn3J2bAAOls
         5pG/+EdlzZQXA6WhPImIJdRTGwDAsNp0RO/KR/efBkbjW7+q/NSy/AFk+ECVgBAzODwx
         RRIg==
X-Gm-Message-State: ABuFfohj54z/KlONKT3iapQAkUdXBn50zCjU6n3dW75p86vIGdc8RQn+
        khknePwO5fubppS4wCAnqxvMBTkMuROaTd3Eadq7Mg==
X-Google-Smtp-Source: ACcGV60KySBargwIc4RCWrvyy7pXSvGL/8Huhe8RZeEhFxiAMkp/QnthCZRKPF9rzqFRSf2wIDseck1YKlu1UHW6Fh0=
X-Received: by 2002:a02:270f:: with SMTP id g15-v6mr10471310jaa.94.1538074193032;
 Thu, 27 Sep 2018 11:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <87bm8kjeu5.fsf@evledraar.gmail.com>
 <CACsJy8Dwo_cBEQeqttj3G=RGaJT7bmVb=ABnV2916swgYQnyrw@mail.gmail.com> <87r2heiybu.fsf@evledraar.gmail.com>
In-Reply-To: <87r2heiybu.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 20:49:26 +0200
Message-ID: <CACsJy8AxUC7MjTnwG8LL+-WEQzTCj7pya8s-6eE=NG3HaWWunw@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 8:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> ...
>
> So there is some special casing of .git/config somewhere. I looked into
> this ages ago, and don't remember where that's done.

Thanks! At least know I have some clues to look into (and will do).
--=20
Duy
