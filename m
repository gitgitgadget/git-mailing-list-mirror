Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE52A1F6C1
	for <e@80x24.org>; Tue, 16 Aug 2016 05:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbcHPF1I (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 01:27:08 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35118 "EHLO
	mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcHPF1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 01:27:07 -0400
Received: by mail-yb0-f169.google.com with SMTP id z10so9033328ybh.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 22:26:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w3UEdBRh0VOXpalXz9ocTUVgeze7dctNhGRIrbLFLOg=;
        b=lftBlmDQfq9Rn6+OKog71kU20vuqwnrJcpZycFoXR4leljjXFv2Qqf+lYNTa5Epbg8
         wPhCH4WqMQH2O9KbNfuUx4fn+NNcazvIErpVIulxZajKq8OyQROqOrqfPmfOdgdgkybK
         mkuTfqGpl04K+wugKj3kvUqW3j5nLHwK3a7pwexiWSv/smFbdS9bMSB/hzqhftj2wc1U
         Bx3b9eQB7EarDoac85ug08ftXQ9x8uY0CZTIoqH4X6Ofx8dIdSa+/ctNTEUE8ZXYjJik
         h09RR+QugSMeAcoDqjuxt96gLsAFKWBYDSwBxLaf6u3Ui9zFs2zEd2XTZIbF5P9kVNmf
         ZjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w3UEdBRh0VOXpalXz9ocTUVgeze7dctNhGRIrbLFLOg=;
        b=A2jK9bX4kmBlRZP5NO94PWrTpK3/G9RjD9Xvx7IFaEnxnQib0xUSIqDwZNUJIwZrG8
         LsyZ+WtiJaS/YkezajSU9HjzSAqA2pqq4dUnk+iHQbQaJVajoin/1CbLnwzvrxRiEJgh
         GJmAhU0VMGXLlDFFHkQp+XfLj8mb7N1DJ6HpRcJZC5EgPPvZ5wXgACU4Vx6+yih+kOTU
         DkyYpWhdq1xmkUD+5wvlFAGowgJwO148FGWlR7yhpx1AO93egO6O6tvq+/SbTmeyLRwn
         KSmbuHKne5FBRh9r/fQWDrLaB0kR9s/0dND8AWmzsydUx9MMKiItvW/Ys8RKu0MfbMIe
         z5Mg==
X-Gm-Message-State: AEkoous4pmpAupIFQXdd5SNfqzdYft8s+ZZPGhDrq7UeD34H59+x3udas03JxvRCEqsdS6qRG9YJnihD+EHkJg==
X-Received: by 10.37.119.134 with SMTP id s128mr1586153ybc.58.1471325215873;
 Mon, 15 Aug 2016 22:26:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Mon, 15 Aug 2016 22:26:35 -0700 (PDT)
In-Reply-To: <CACsJy8CXKcjo6KO8HvBpx+N4Lj7MO5yMH2q4bVWi-x3mbvWsmQ@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
 <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
 <3E80981D72F74A11A41A228901644E1C@PhilipOakley> <CACsJy8CXKcjo6KO8HvBpx+N4Lj7MO5yMH2q4bVWi-x3mbvWsmQ@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Mon, 15 Aug 2016 22:26:35 -0700
Message-ID: <CA+P7+xr+HonJTj5AcRhAMf5Z059zHKiuOY8Zbd77uu_jAiiZBA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 8:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Aug 16, 2016 at 3:46 AM, Philip Oakley <philipoakley@iee.org> wrote:
>> From: "Jacob Keller" <jacob.keller@gmail.com>
>> [nip]
>>>>
>>>>
>>>> I've no problem with more extensive methods for those preparing very big
>>>> patch series, or with those needing to merge together a lot of series and
>>>> want to keep the cover letters, but ensuring that a simple flow is
>>>> possible
>>>> should still be there.
>>>> --
>>>> Philip
>>>>
>>>
>>> Some people have suggested this simple idea, and I like it, but they
>>> did mention that modifying the cover letter now requires a rebase over
>>> a potentially large series of patches, which can get annoying.
>>>
>>> Thanks,
>>> Jake
>>
>>
>> They can just add "squash! cover! <series>" commits for that ;-) Though more
>> likely the advanced workflow would be used... We'll need both (more than
>> one) options.
>
> Or even better, "git commit --reword $SHA1" brings up the editor with
> commit message of $SHA1. Modify any way you want and it creates a new
> empty, "reword!" commit that contains the diff between the old commit
> message and the new one. "reword!" can be consumed by "rebase -i
> --autosquash" without bringing up the editor again. I realize making
> "git commit --reword" run multiple times would be tricky though...
> --
> Duy

I was just thinking you write text and it gets appended to the text of
the reworded commit, and when you squash them using rebase you get to
finalize it like a normal squash?

Thanks,
Jake
