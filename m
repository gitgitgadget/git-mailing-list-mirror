Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9811F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbcHPPxN (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:53:13 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33576 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbcHPPxM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:53:12 -0400
Received: by mail-yw0-f180.google.com with SMTP id r9so45680302ywg.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 08:53:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fyH0kRMwLlDib3EtvDB3hYPY96jd35kP+NysI9i1Bdo=;
        b=tR8nOlmhWKENDutUD9FXc+s3CFqTVupvpNQpqNNfomf0U5bgQ0WP9j3eCpCCfi9ZSi
         bSUybzBzCH0cA0uQqguIrmZRwV9PiXMMXoF3qE/rH0tooQ+ogljrkhCeUaM8Mf+aOoMt
         AzLHKjkWvMo2FtKCnDCiFV5NkvaeThbZbjf6EiLrazLqP2w4s7u1OVPOxYVO8tzADjS3
         9Sxj+BNGbCvcMaVYriIQb4C/E24/RLVu/nVWr9adq69haqjoshnRBAMtLrqIdfnCe8/6
         WiB0mA5R3/n/b3STLNhEFcjroaoi5EsQjeKWE2JQ633z6EcNXIKgwlQtXNk7U8iY4BW0
         j6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fyH0kRMwLlDib3EtvDB3hYPY96jd35kP+NysI9i1Bdo=;
        b=TJkN+TOraMFY2kDAwN+08hpoqJVoB4pyV8cnKGz1EFTkrTttY/jgauRo3o58ovPOS8
         eAFrDhHlwbWvlMez6uVxI2w6yIVRRz9azEn56Rcb+6VSmbdDFhK+RjnjPy+5Mqyj+/a4
         vvFGab+5/EcHrsHiXy4wA42WJlV8Pjo+mNcS7yhvErzEdWSOst78Mu9MpHeijhBMhNKQ
         tkyhcBZS5sP/cMOf2sgh3OVfT6Aua0FffERVVw9N+57l0vnbIAXpDsjIEWOEOjzkhmkx
         tDE1tEIA2ZSu6UmY0VWIrwLTx6FMmhIGz14aO5zvapEXA8DHnXIZYfjPiVQ3SPE1uJEW
         44wg==
X-Gm-Message-State: AEkoouvMeei7B4HxNd5lwHxpVB/2tD/OVn5qOMYxA4nLdk3Kh3m+aZAR/2qDFm2DLFAjThWqM/llVNBKEFmy0Q==
X-Received: by 10.129.135.2 with SMTP id x2mr25447673ywf.310.1471362791147;
 Tue, 16 Aug 2016 08:53:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 16 Aug 2016 08:52:46 -0700 (PDT)
In-Reply-To: <CACsJy8DJmONcgQO37Xk+2cZb+Svx-bgwjrG1XrZQ4BYipownqw@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
 <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
 <3E80981D72F74A11A41A228901644E1C@PhilipOakley> <CACsJy8CXKcjo6KO8HvBpx+N4Lj7MO5yMH2q4bVWi-x3mbvWsmQ@mail.gmail.com>
 <CA+P7+xr+HonJTj5AcRhAMf5Z059zHKiuOY8Zbd77uu_jAiiZBA@mail.gmail.com> <CACsJy8DJmONcgQO37Xk+2cZb+Svx-bgwjrG1XrZQ4BYipownqw@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 08:52:46 -0700
Message-ID: <CA+P7+xqDMgi8pvAN-Pme7SE=C=m3xq6o2aQxnyxzPJEbyiqMhA@mail.gmail.com>
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

On Mon, Aug 15, 2016 at 11:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Aug 16, 2016 at 12:26 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>> They can just add "squash! cover! <series>" commits for that ;-) Though more
>>>> likely the advanced workflow would be used... We'll need both (more than
>>>> one) options.
>>>
>>> Or even better, "git commit --reword $SHA1" brings up the editor with
>>> commit message of $SHA1. Modify any way you want and it creates a new
>>> empty, "reword!" commit that contains the diff between the old commit
>>> message and the new one. "reword!" can be consumed by "rebase -i
>>> --autosquash" without bringing up the editor again. I realize making
>>> "git commit --reword" run multiple times would be tricky though...
>>
>> I was just thinking you write text and it gets appended to the text of
>> the reworded commit, and when you squash them using rebase you get to
>> finalize it like a normal squash?
>
> I think that's what Phillip meant by 'squash! cover!' though I wanted
> to go further, I don't want an editor popping up at rebase time,
> instead 'rebase' just update cover letter automatically for me.
> --
> Duy

Maybe teach it some sort of "reword! cover!" which pops up an editor
and you can edit to your hearts content, and it just saves the "new"
message. Since there is no such thing as a diff on message contents,
it would just be a complete replace for the new message (obviously we
would then strip reword and cover part out but otherwise leave the
rest in place so rebase machinery would be able to fix it up without
you having to edit it a second time in the rebase process? That
doesn't seem as complicated as somehow storing a new diff format for
the cover letter. Not sure how to handle several in a row though.

Thanks,
Jake
