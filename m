Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E0D2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 18:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbcGFSyx (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:54:53 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36081 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbcGFSyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:54:52 -0400
Received: by mail-io0-f178.google.com with SMTP id l202so1067887ioe.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 11:54:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QDfpPfHDPUsdgHEpRP7idDZqNfukGhGfYlnn5yjsz2A=;
        b=x8Zey1drKGkeoLRMJ2tUNUCgg1T8ZcFT0+gROm1laLaFQtKdORaLiK+aKzzmK1VqXQ
         0PpyphzHlN/et18inSsBWZ7uTImuzjJE54egwHBCM48lHPAm/w1Kvt87xEu27gsBX5E+
         U6Y4je9eON7PmNQ3rOsi4KyaaOlnEDcbBTibWWHPuOmJSA7a9K+gFtdjI27Uat6gAU0A
         aAeb8GNriIyrufOjojdDyzObSwva19MhAepoiw7auXzF4NC6YHLFbnCuUWeLb7rKx0cF
         iKXfiuzrEqwuoxuA/G6PwBWlhgKWWTIDSskScTfCViOs7UdjUiCdg8PCKfX8TLgZ54vH
         54hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QDfpPfHDPUsdgHEpRP7idDZqNfukGhGfYlnn5yjsz2A=;
        b=hhsfpeBM1PzXa4O2ZOK7lcsfrjVwWYEZkS5Nd15IS46U8Wo3dPTLoMZjZ0sZiY277+
         FBDDy6TmF8eH2pKflHiacQq5VOFiBZMfp9r/csBax2j6O2YPWlyX/n7tB5W7uQIc4D31
         a5GALB2Do26Sg3/a/jHZLNwXLr8BvHLZhtXpTd9Oe3z7Px2FfA84kbaRx15TsizLhMZj
         vjz/YPS2xVTThdnIlQe+npXJSZ79DaiTJLZrEVmMZoR1RlolRpsQk+m9K8YnNWBBP2IK
         ji8DZEILvLSKh3q0/8RSxdDjhIZGmQAfoIwtySI541ZekcthfRC9XEXRAVxJU72NISNa
         Re7Q==
X-Gm-Message-State: ALyK8tI8zqtZiScDKDHO6KT52WqmJ+No84RwZv3Ujw8Q7sEz1Pz3SdJ5JeN8iPApo3a4erNDVz57vFsBnp3c3Q==
X-Received: by 10.107.8.220 with SMTP id h89mr21382454ioi.95.1467831290872;
 Wed, 06 Jul 2016 11:54:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 6 Jul 2016 11:54:21 -0700 (PDT)
In-Reply-To: <1467828168.6286.5.camel@gmail.com>
References: <1466807902.28869.8.camel@gmail.com> <20160705170558.10906-1-pclouds@gmail.com>
 <1467756891.4798.1.camel@gmail.com> <CACsJy8BDQbanGsf=3z3K-OuH0++EuqQFEB22udXJT+WZnFKSBg@mail.gmail.com>
 <1467828168.6286.5.camel@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 6 Jul 2016 20:54:21 +0200
Message-ID: <CACsJy8DxT1=9if3UksTJcvpJS73uCDoAojsBC9Gg4R9DvZHdjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
To:	Christoph Michelbach <michelbach94@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 6, 2016 at 8:02 PM, Christoph Michelbach
<michelbach94@gmail.com> wrote:
> I now created a repo on a 64 bit system (same command as before), then
> duplicated it. One copy I applied git gc to on the 64 bit host system,
> the other copy I gave to my 32 bit virtual machine to apply git gc to
> it.
>
> The 64 bit host uses git from the Ubuntu repositories, the 32 bit
> virtual machine uses git 2.9 from github with the patches applied.
>
> git gc worked without problems on the host but I got
>
> frank@frank-virtual-16-04-32-bit:~/g$ git gc
> Counting objects: 6, done.
> Compressing objects: 100% (3/3), done.
> error: bad packed object CRC for
> f595ad71c1a1ecc312ddcb32a84a4bfc4a2ed1c8
> Writing objects: 100% (6/6), done.
> Total 6 (delta 0), reused 0 (delta 0)
> error: failed to validate delta base reference at offset 342896 from
> .git/objects/pack/pack-630b5a3f28cd9d02a546462bf0d0bc640ffde784.pack

Yup. So far I can only say that pack-objects generates incorrect pack
:-(  I hope it's the possible 6/5 patch I mentioned earlier but I'm
not sure. Will continue tomorrow.

> error: bad offset for revindex
> error: failed to read object 4246d27f8e0149d45687b0cc23bc29a67f1f0c79
> at offset 342887 from .git/objects/pack/pack-
> 630b5a3f28cd9d02a546462bf0d0bc640ffde784.pack
> fatal: packed object 4246d27f8e0149d45687b0cc23bc29a67f1f0c79 (stored
> in .git/objects/pack/pack-
> 630b5a3f28cd9d02a546462bf0d0bc640ffde784.pack) is corrupt
> error: failed to run prune
> frank@frank-virtual-16-04-32-bit:~/g$
>
> on the virtual machine.
>
> Not including the mailing list in CC wasn't intended.
>
> --
> With kind regards
> Christoph Michelbach
>
> On Wed, 2016-07-06 at 17:23 +0200, Duy Nguyen wrote:
>> On Wed, Jul 6, 2016 at 12:14 AM, Christoph Michelbach
>> <michelbach94@gmail.com> wrote:
>> >
>> > I now tried git gc again and it failed (in a different way, though;
>> > and
>> > the error message only appeared once git gc terminated).
>> >
>> > Full input and output:
>> >
>> > christoph@virt-16-04-32-bit:~$ mkdir test && cd test && git init &&
>> > touch someFile && git add someFile && git commit -m "Initial
>> > commit."
>> > && dd if=/dev/urandom of=bigBinaryFile bs=1MB count=4294 && git add
>> > bigBinaryFile && git commit -m "Introduced big biary file."
>> > Initialized empty Git repository in /home/christoph/test/.git/
>> > [master (root-commit) 20507ef] Initial commit.
>> >  1 file changed, 0 insertions(+), 0 deletions(-)
>> >  create mode 100644 someFile
>> > 4294+0 records in
>> > 4294+0 records out
>> > 4294000000 bytes (4.3 GB, 4.0 GiB) copied, 435.236 s, 9.9 MB/s
>> > [master 88e5dbb] Introduced big biary file.
>> >  1 file changed, 0 insertions(+), 0 deletions(-)
>> >  create mode 100644 bigBinaryFile
>> > christoph@virt-16-04-32-bit:~/test$ git gc
>> > Counting objects: 6, done.
>> > Compressing objects: 100% (3/3), done.
>> > Writing objects: 100% (6/6), done.
>> > Total 6 (delta 0), reused 1 (delta 0)
>> > error: inflate: data stream error (incorrect header check)
>> > error: failed to read object
>> > 705f438ccb845871ffba9d4b56f16ac763652937
>> Sigh.. I'll try again :) BTW if you have a 64-bit machine too, try
>> create the repo with it (so we are sure the repo is not corrupted in
>> the first place) then you can run tests like this on 32-bit systems.
>> The previous "bad crc" message was a fault in the code, not the data.
>>
>> PS. I have just let gc run till the end (last time I tried
>> pack-objects, which is only part of gc) and got a(nother) error.
>> Checking... BTW, you should send these mails to git@ as well, no need
>> for private message exchange.



-- 
Duy
