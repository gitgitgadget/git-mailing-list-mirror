Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1841F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbcJQUtC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 16:49:02 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33740 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbcJQUtA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 16:49:00 -0400
Received: by mail-qk0-f181.google.com with SMTP id n189so258045274qke.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eg9UH/ysWADcuCAVaCLWWUWXYFIYSYpZeNqFZ1dKLcA=;
        b=PshhEfHiYnBuoT5ZQMgzgOMmrYEXUNZhwQOPg4W+AovOoMd568ZnvB+jbUg9Nzto71
         n+KIkQldNapPF/uCSc5ZOz6+dopix8jXNVraJEdesqfQZtGldFGLhoAwzaKUZUkmhn+Y
         3prFqrDKWNPSuI/99cjOomE6L9FEMIHEaEMJuq69xvwj91v6DaijvestTZklslbkaTmD
         ebldjs2A3IFSEeliy/ptdoKPkVZsnuFeRRqnaF8rAf5FID2Y6kFGNww73z+59IWmWkWP
         xMY2tkm2RrdhsFcRmSiy7anjjm1n1AwPFN4qHQSp51mZzF3omlQDwCfp6mFK5XFOQHi8
         PHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eg9UH/ysWADcuCAVaCLWWUWXYFIYSYpZeNqFZ1dKLcA=;
        b=nOgM7QdkMGOTT74by/C8WnUf9QWhKufU5CcViboAEomCor32UWCsYJHFTfMMxhf6uM
         KxNqXeJrIL6sq2zbQ+6f47/QJfuTAYyB8wA5MNpWxh5jSfu7I5Bkt4gPZb7MSiWQNB8l
         blP1RFLWWp4a9AFxaKI3oQpxHzx3H5bdbFaA7WVOKsHGb0E4HgFSr2W6qHX0Q6EHHCsW
         rfDe6g28TVvX5iiqsZRGdtiNDc77yjz2jvhW7n7lL3yfRtqCsCBfJ/7yJbOnkSOHPDHL
         4G/OMu95kWPQGtYdRnLMyjxHnXKIoRfcrnvC0vDz6p74SkWYsc/h9k71ZsUB/Si+oLlb
         gIYQ==
X-Gm-Message-State: AA6/9Rn/+0XAx+TaWgXjtPIg+hUANOhXRWz1v/K5RQvklCWkxSL81wrvXzBA5RzvvHwv6CqFMKhrLZ5vvXY8V5fz
X-Received: by 10.55.56.11 with SMTP id f11mr24675631qka.255.1476737339776;
 Mon, 17 Oct 2016 13:48:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 13:48:59 -0700 (PDT)
In-Reply-To: <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com> <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com> <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
 <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net> <alpine.DEB.2.20.1610171058580.197091@virtualbox>
 <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net> <16298e68-c0f9-b7ff-d4b5-0d4b79306377@ramsayjones.plus.com>
 <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 13:48:59 -0700
Message-ID: <CAGZ79kZ7oo7NpMY_xFc5Of9BBgeA+7BBaqth37Eifh4nfVY9xQ@mail.gmail.com>
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 1:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Heh, I actually have the following in my config.mak already:
>>
>> extra-clean: clean
>>       find . -iname '*.o' -exec rm {} \;
>>
>> But for some reason I _always_ type 'make clean' and then, to top
>> it off, I _always_ type the 'find' command by hand (I have no idea
>> why) :-D
>
> "git clean -x" anybody?

I only want to cleanup compiled stuff and such, not the precious
unversioned text files I have laying around here. So I guess

  git clean -x -e:(attr:!binary)

would suffice, though. ;)
