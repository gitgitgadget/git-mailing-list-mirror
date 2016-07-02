Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB962018A
	for <e@80x24.org>; Sat,  2 Jul 2016 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbcGBOff (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 10:35:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32949 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbcGBOff (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 10:35:35 -0400
Received: by mail-it0-f68.google.com with SMTP id y93so5003232ita.0
        for <git@vger.kernel.org>; Sat, 02 Jul 2016 07:35:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1u8MNJkV8aIO0b/BMHRiFgqbwX8fc7tOW1ytrt4sp6Y=;
        b=FVZrffg0OTbzdJ/EFHIWSwRdHrdTfKIQtRCU8l6jKLKm0fXv5eWjs8fxmTWcwXmFgI
         K87aielCncjqzd0RKoWLwZVbO1FSA64KV1GrcSsfhrspc5C/Jj2wt+bsHzNTjvziFW26
         3yoRn2vp0DvTGFqLbogdQjwcOqmm6FXtT8lAhqY+NG833CpJcPRBjRz0Uay5PuYid5tz
         +YVKjUJ1626My19pZPdwvXy0CLmdvDYDmHoDpPC89OGnMQh3ZsZuGEaaI2q79ulQ3mwr
         l7nwAPL2E3WMTpf+oDY9IXsnVnGAKg9eNufO/ehzI8DUmDj83pB40w8huBknHMSaiKbZ
         hKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1u8MNJkV8aIO0b/BMHRiFgqbwX8fc7tOW1ytrt4sp6Y=;
        b=O1TZhuwIsygk0O64A0B62XNbcAOuxuIlH2tbKG8SctrinIFQK7F45wWVTjiePK3iTU
         vuzk7aWK4OWX23IpWjre7ETOJ934Dg8FYHCC1B5DeDwy29V5YdTfeZzzhqV6ywtCHFZP
         I2foOac/9Nzn7K8xTNl85MCIQRnM+MhQamis0Y6REAXLz4VCCVBTZPBTDDwl2h9zQ94P
         ApdrpaN/e9HhBf6KGnqouWCnVcsiaY8KlNimMkSLTGiTdI98hVd85LCjk8uJqsm1qNGn
         EylpRUF+kF5J9GCaS3yVryx1ePFfvhMx93XssqXsi+bTPAwPjBRvbduXHG9byY/K5Uz/
         J5bQ==
X-Gm-Message-State: ALyK8tIUF0uCV2y8unqyOFq9MwujmHpxus8MhfBeDAPyZvELg5/hmz9luMvJv9txrorBE2ey1ZHimUqhWIVvsQ==
X-Received: by 10.36.33.22 with SMTP id e22mr2969570ita.42.1467470133865; Sat,
 02 Jul 2016 07:35:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 2 Jul 2016 07:35:04 -0700 (PDT)
In-Reply-To: <20160702091034.GA31852@duynguyen>
References: <1466807902.28869.8.camel@gmail.com> <20160702091034.GA31852@duynguyen>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 2 Jul 2016 16:35:04 +0200
Message-ID: <CACsJy8AJxbnEXciP91_r0jtH3mv+T_dqQZt9pKnJvSK-s9Yamg@mail.gmail.com>
Subject: Re: [bug] Reliably Reproducible Bad Packing of Objects
To:	Christoph Michelbach <michelbach94@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 2, 2016 at 11:10 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 25, 2016 at 12:38:22AM +0200, Christoph Michelbach wrote:
>> Hi,
>>
>> when run on a 32 bit system (Linux system, don't know about other
>> systems),
>>
>> mkdir test && cd test && git init && touch someFile && git add someFile
>> && git commit -m "Initial commit." && dd if=/dev/urandom
>> of=bigBinaryFile bs=1MB count=4294 && git add bigBinaryFile && git
>> commit -m "Introduced big biary file."
>>
>> reliably produces this error message: "error: bad packed object CRC
>> for"
>
>
> I tried with a 32-bit git build on 64-bit system and did not see this
> message. Maybe it's because the 64-bit system. Just too lazy to bring
> up a 32-bit VM to process 4GB of data.
>
> But I did look around a bit, and the problem is probably number
> truncation. Could you try this patch?

Just FYI. There may be more truncation problems on 32-bit systems.
"clang -Wshorten-64-to-32" reports a couple of spots that could be
real problems (pack-objects, index-pack...) for handling 4+ GB files
on these systems. Still working on it...
-- 
Duy
