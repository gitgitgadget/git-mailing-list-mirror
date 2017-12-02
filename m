Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172DB20A40
	for <e@80x24.org>; Sat,  2 Dec 2017 17:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbdLBRza (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 12:55:30 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33138 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbdLBRz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 12:55:29 -0500
Received: by mail-ot0-f179.google.com with SMTP id h9so11615702oti.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EezpFOIsntS0xaJunVpC/5zjuwO3hirueC4E22AAJN8=;
        b=bnzFwCXd8PxRrv1RQcZhGyM0ZJITpn8KgdeHh3aZF2Yla4nhrn+2tDysmvpyfVh+HQ
         cRWK6JNAp6nV3mmZzXMu0G6ceHdykYpntWF2WxT/CY9OxUARmM2H/j2lGAwX79TslwxK
         vtuzAar0ZCTha5zh2JAyaFRQj3OTgwiMdTuB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EezpFOIsntS0xaJunVpC/5zjuwO3hirueC4E22AAJN8=;
        b=pLzNtvyJ+eZd1g0EN/6YDRAlJxdIdNr2VmBkPTjLdB4b+4p/4KQ9o7E4x8ofqmXkyM
         rj8qZ5O7oRd/tqZmePWesRasYN6/iW8jgHrb3BCZ0+VLwUaujePQ8bkBmSOskKPmCtSI
         HDGuVZZytp47PYodr9LS3LiRIOXk0dl5+ipG/73NsCurdl4GUxiiYXnooHlphMIvCRi3
         5g65VjuRz6Uu44f0roHbfMMhKZDwtTb3zzbJv0uphUYbVJgbci38dQVg54wX6bOEP22V
         XpjzvGhNJggd7LWlfCLRH8EvRetJ8/3VOyky5XHyRKiRsOGy5BUA2RBEKLH31Vh2NY9i
         WZGQ==
X-Gm-Message-State: AJaThX6qktZR0AS27ZmQXHeTpxlXibHz0iep7Iq4u2JOf1y5IFXL5ihp
        CeOTrvZhP1Xy78lsk9bK255/0lKxaQuV1IvjS2CQLQ==
X-Google-Smtp-Source: AGs4zMZCvZEQYLr2mA7jOKX7IQ4J2TiXmYT2N9yiSpKAxP1tNkx87EmsKDJANM2doO6Og8X0xEeLu8cJeLe8afynL2E=
X-Received: by 10.157.40.142 with SMTP id s14mr10713676ota.159.1512237328631;
 Sat, 02 Dec 2017 09:55:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.12.236 with HTTP; Sat, 2 Dec 2017 09:55:28 -0800 (PST)
In-Reply-To: <CAL1_K8A=7xmLCYzWa0ejtwjy9P+rD+D0cqz+kOXCaQWOgQfuEw@mail.gmail.com>
References: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
 <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com> <CAL1_K8C3bNMae6PFk73c7n6AvnbO=5Sujz3oqL_jBj=DpiEO1g@mail.gmail.com>
 <A6F43B7B-F0AF-46E7-B34B-7D54493E2C8B@gmail.com> <CAL1_K8A=7xmLCYzWa0ejtwjy9P+rD+D0cqz+kOXCaQWOgQfuEw@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 2 Dec 2017 17:55:28 +0000
Message-ID: <CAE5ih78GOFqe_Vb3k_-jPiS7zbX1EdvYmsUyWvKKy=xOH9WrcQ@mail.gmail.com>
Subject: Re: git-p4: cloning with a change number does not import all files
To:     Patrick Rouleau <prouleau72@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 December 2017 at 15:35, Patrick Rouleau <prouleau72@gmail.com> wrote:
> On Fri, Dec 1, 2017 at 7:45 AM, Lars Schneider <larsxschneider@gmail.com> wrote:
>> Oh, I am with you. However, I only used git-p4 for a very short time in the
>> way you want to use it. Therefore, I don't have much experience in that kind
>> of usage pattern. I was able to convice my management to move all source to
>> Git and I used git-p4 to migrate the repositories ;-)
>>
>> Here is a talk on the topic if you want to learn more:
>> https://www.youtube.com/watch?v=QNixDNtwYJ0
>>
>> Cheers,
>> Lars
>
> Sadly, there is no way I convince the company to switch to git. They
> have acquired
> many companies in the past years and they have standardized around Perforce.
> It is in part because they want access control and they need to store
> a lot of binary
> files (including big VM images).
>
> I keep this video close to explain why I like git:
> https://www.youtube.com/watch?v=o4PFDKIc2fs

I feel your pain.

I think I've sort of stumbled across something like the problem you've
described in the past. Perhaps the files you need have been deleted
and then re-integrated or some such.

Would you be able to take a look at some files with this problem and
see if you can spot what's happened to it ("p4 changes" and perhaps
"p4 changes -i").

One thing that can certainly happen is that Perforce gets *very*
confused if you start getting too clever with symlinked directories,
and git-p4 can only do so much in the face of this. But it may be
something else.

Thanks
Luke
