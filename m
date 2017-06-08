Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4176C1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 06:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdFHG2l (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 02:28:41 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38486 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdFHG2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 02:28:40 -0400
Received: by mail-it0-f49.google.com with SMTP id r63so15770050itc.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 23:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cf2PopdHZFMOF7EMTs+LKg4y374te+zx2UGVznMX+4E=;
        b=DTBAbv69L38nBvwSVXDXTpDJ7oukhUC7g2hvKW2M98bjQFaEvhCQXyyAjNZvn/6DHy
         Kp3ToqwLvgtz2ZRm0qVwWUk440J0ET0BS5LJJcaZ+59pifmkkA2mZvHfgZogUxXCkPEO
         okovtRq8WKwRbuWLszrqEcMOdbowheG/QbykMyfG1ST+mLJ/6+FdmqmHD0csFesl0CdI
         jek7xUD0eO5GFtEWSkznN9b9qX8kY/QOUc1A/wXg2NYEmUDDa3f6oQoPQlmjEC+WqVLt
         CFrzFdmXdHfYuoUpIJq13oMbKSfrRBpraJ0+2k+gasyhhT/MIGgteD6kg33gjmr1XTJ3
         vS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cf2PopdHZFMOF7EMTs+LKg4y374te+zx2UGVznMX+4E=;
        b=h8+oDBr6ZU9jB0WRnl3QtChL75hIDfmfJmij0gYJitLJxVTS9TDlws6iCiG3/EL9Et
         kw26NX2W6C7eGwrGBN/bHVR5lDcpN6dEgj+yH7mjQo/5tyzlAkCDVr731Af3PUNi3+8N
         9H52K8nOaOxls8fTSqm3/MNK/PLMRTVjlPxR/Uvw5K1WY9yxgDGIe3vV/rGbFxTX0wUS
         vylR5cI9/EbdBZ8nhlCk5YgpZznZQn6iboqvZn0gJBCV1QH9egAXD857bRVsc+lstcBk
         V6jSRr6u5lk47/3EOhyWF9G8WTKS3qOUweFmOatkfQHXV4wewh/21o4fYF4ekVOX6UED
         LRbg==
X-Gm-Message-State: AODbwcBJrzXD5EBEzxbjRqc/VOfaHCWVB+UeoUC8sFbU3c5kCKBWj187
        jMLzy7HVAOBTw/X5yOOgvwIyDz1TwQ==
X-Received: by 10.36.233.198 with SMTP id f189mr3921410ith.94.1496903320027;
 Wed, 07 Jun 2017 23:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 23:28:19 -0700 (PDT)
In-Reply-To: <CAJZjrdUSVeZ-zHpeyuN4p29Hg8eGk6ip2Tikkrh-wE-KaxWbEw@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
 <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
 <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
 <CACBZZX5dwUq58nghuMqnuGfe9sPm1VBxVwZGZcTCYgeO5OdyTg@mail.gmail.com>
 <CAKvHMgQB7fR+2O4AUYNn0JF13fxf3m-gJ70yPUEdqRkyfC-q+w@mail.gmail.com>
 <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com> <CAJZjrdUSVeZ-zHpeyuN4p29Hg8eGk6ip2Tikkrh-wE-KaxWbEw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 8 Jun 2017 08:28:19 +0200
Message-ID: <CACBZZX5SMsXHkVS-a9iarTw_VnH8hBEdN7a56e8ma89nfOLqrA@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 8, 2017 at 2:06 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 4:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
>> openssl, breaking the CPAN-built *.so object?
>>
>>> Agreed that send-email should be report errors properly. It's a rather
>>> essential tool.
>>
>> Indeed, do you get a meaningful error if you apply my patch?
>
> FWIW I'm on Arch as well and am getting what I assume is a related error:
>
> SSLeay.c: loadable library and perl binaries are mismatched (got
> handshake key 0xdb80080, needed 0xde00080)
>
> The last patch I sent out was on 5/23, and I just ran a system upgrade
> today (only one I've done since then), which presumably is what
> "broke" send-email. I used CPAN to install Net::SMTP::SSL,
> Mime::Base64, and Authen::SASL; I assume that Net::SSLeay is installed
> as a dependency of one of the three (presumably the first)?
>
> I know Net::SSLeay isn't controlled by Arch's package manager:
>
> $ perldoc -l Net::SSLeay
> /usr/lib/perl5/site_perl/Net/SSLeay.pod
> $ pacman -Qo /usr/lib/perl5/site_perl/Net/SSLeay.pod
> error: No package owns /usr/lib/perl5/site_perl/Net/SSLeay.pod
>
> =C3=86var's patch unfortunately does not fix or change anything for me.

It doesn't fix anything, it should make you get a better error message
when the thing does break, i.e. not an "Attempt to reload" error,
doesn't that happen? What error do you get with/without my patch?

> Liam: when you say "uninstall" /usr/{lib,share}/perl5/site_perl/*, do
> you just mean rm -rf?
