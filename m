Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4605020281
	for <e@80x24.org>; Tue,  3 Oct 2017 04:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdJCEfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 00:35:18 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:43735 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdJCEfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 00:35:17 -0400
Received: by mail-qt0-f176.google.com with SMTP id a43so4962574qta.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 21:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vNB/BIBm/HA3is90/+blx2dzf9oR/Dfpm7/2EGns3Eg=;
        b=KVKoKNmCFps6GLjBxI3Vu1m4TvJ53pJweuaClRKyuuHplXRG8j9ttsSE2BRLXLnk6X
         +13QmKzC8z6GLqZ1bTpsKClMyW0bPeUOaWxiz9ZtbIJbv8TfTOFjwl1kpsp/UYEu5g6J
         48J0qKMmJtWt1pkEqZtu9zq9LwejiaIoEe9aGnsta38wFFrRTf5JXsZgUU1wheS4OY1t
         UnxmzCzOhSOnK7AU/Ft4CYyxPkfvuUiL8G3YwQI8mNBMojcufdrIJv2fn4PdPA/+QMPW
         7YmgAKFZwyhebFwH/ZkdOMrRmwQeZ8NcDg6rGVeHQUEUdnEqv5XYjHpZBEoEFxk2dgwA
         wWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vNB/BIBm/HA3is90/+blx2dzf9oR/Dfpm7/2EGns3Eg=;
        b=o5fjYiONs4oyuCDiUeZWGPDrT/1QHJi5uovHDCZIv9Eck6eCSGruyraslMCWlCgC2X
         2MsS6W9Z9Dn2fXZ8sfjETjPE+/qKkWKRikPKrxJKpHDohU9W9iRshbn4JNgAeDpmcPOV
         adYMcIs3FUk284RpvlljWveKJfBd4MnJpbriEHD9nS+EZSQSeAtD9cPDj4laJstFPfx1
         TAndqho/6lSBXW5Vmy5PCxqdOdz9FDt25noAlgcJ+CimSut9ENaVyIICfqFCxWw7ZVe0
         YkVp9UOnVYDmoYUUWXDo5sm+D5ypuNghdKypksvfOVwZqLVvB1TPdTlvbXLtUVJVM/KQ
         68qw==
X-Gm-Message-State: AMCzsaUuTqtmTVqaGteniKKz0qAVjoxOUwrekyTOTFwio96JqcRv41lq
        LlgCgygsQcZIJ4FXGqQf4dz18Wxfw5h+aqbXMt8=
X-Google-Smtp-Source: AOwi7QAqdYO7zc2l4uQStQehuwMZNiGW8D65+YhwiQ5RssVhQt4WZjCmsA2hrx6tYuthR2rSTOmOpJ3iFBw8Fu9cOto=
X-Received: by 10.200.37.230 with SMTP id f35mr8300159qtf.335.1507005316742;
 Mon, 02 Oct 2017 21:35:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.98.242 with HTTP; Mon, 2 Oct 2017 21:35:16 -0700 (PDT)
In-Reply-To: <xmqqa818lwi7.fsf@gitster.mtv.corp.google.com>
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
 <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
 <72995d24-d337-39c0-0abd-64bce1c22028@ramsayjones.plus.com> <xmqqa818lwi7.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 3 Oct 2017 10:05:16 +0530
Message-ID: <CAFZEwPNW96abYd-xTZdCx+K2jUJCf4SrM-Jr0R=i7fJXL+HzKw@mail.gmail.com>
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Tue, Oct 3, 2017 at 9:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> On 02/10/17 14:44, Pranit Bauva wrote:
>> [snip]
>>>...
>> Yes, I also meant to tidy that up by removing some, now
>> redundant, initialisation later in that function.
>>
>> Note, that wasn't the only bug! (I have probably forgotten
>> some of them, but look at 964f4e2b0, for example).
>
> It seems that Pranit needs a bit more work to take known fixes from
> your efforts and we should wait for the series to be rerolled?

This series is the initial part of the whole series. Things started to
get a little problematic after bisect_start(). The reason I am doing
the series in parts so that I can get the part which is solid to be
merged and then start work on later parts since I don't have a time
constraint now.

Regards,
Pranit Bauva
