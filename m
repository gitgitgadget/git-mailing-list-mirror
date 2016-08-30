Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC671FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 00:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcH3ANP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 20:13:15 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36640 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbcH3ANO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 20:13:14 -0400
Received: by mail-oi0-f41.google.com with SMTP id f189so4957408oig.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7bfr+DMumM+oLnkVjZSkSznaNHIQLIuWncKOLYLF+l0=;
        b=QnMQPCMLQVKxAkuQynxavgNiiwmynXjUc3/fTWKpdTfj8zqG6ZyFR8AWUaNonnR4AW
         Lz+cS9uN1G+/1oqHPCP83Bu1TdfV7Gl13LtXiobLFPukrhbOnO7q2f0L5qvruqDIDYUW
         e4FwLxBmUXC7y7z0u2wQTFVGab9Whsu+JCRpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7bfr+DMumM+oLnkVjZSkSznaNHIQLIuWncKOLYLF+l0=;
        b=VtE8ScJImeKnWdHM3TdZ7GWMSXW7uhipZ+nZt0EcT/BfDPIT9cfdn1zLPXMJ7HOTAC
         Xbg6Ja7QpIMUtuX44CNQbEGds7lCrqAclYYXQkdVgpwx8SdyNhcuPXJkwGDDAu8iVcoy
         qrfJ3hd3dKW3heyIEVWY54QBqNgxhTLG1CCQ7nO4IT/g5wgZL9x/YXelXZXH9KMoyXL/
         AkS8Q3Mqll9H4q3t+jEbgk/H1g3taq3FRp6SD17bNpii6rdNn0x0BMCfjakWghU+zwuv
         o9gh+d59pbVOIHnnqnql3jf9YDNpvGWHZyWybK/C034E7TIZ3eqkaubvikrs7Bwdr0eF
         xFZA==
X-Gm-Message-State: AE9vXwOsScQqSwRMwHZq5YVeYqmY0IFpO/2Vsdm+ywUIE6qMhyl3OG/DiI7JxF42ZRpNWrztSKlhHugCZ7VeOL8J
X-Received: by 10.202.218.2 with SMTP id r2mr642578oig.177.1472515949722; Mon,
 29 Aug 2016 17:12:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Mon, 29 Aug 2016 17:12:28 -0700 (PDT)
In-Reply-To: <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Mon, 29 Aug 2016 17:12:28 -0700
Message-ID: <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is great! Thanks Jake. If you happen to have the patch ID it
would be helpful.

Uma

On Mon, Aug 29, 2016 at 5:02 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Aug 29, 2016 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Uma Srinivasan <usrinivasan@twitter.com> writes:
>>> This fixes my issue but what do you think? Is this the right way to
>>> fix it? Is there a better way?
>>
>> I think we already have a helper function that does a lot better
>> than "does it have a file called HEAD" to ask "is this a git
>> directory?" and its name I think is "is_git_directory" (I know, we
>> are not imaginative when naming our functions).
>>
>> As to the check makes sense in the context of this function, I am
>> not an expert to judge.  I'd expect Jens, Heiko and/or Stefan to
>> know better than I do.
>
> One of my patches adds a "is_git_directory()" call to this, and if we
> fail falls back to checking the .gitmodules and git-config for
> information regarding the submodule should it no longer be checked
> out. I suspect this patch will address your concern.
>
> Thanks,
> Jake
