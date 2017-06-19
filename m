Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C577420401
	for <e@80x24.org>; Mon, 19 Jun 2017 01:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbdFSBC1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 21:02:27 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34829 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbdFSBC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 21:02:26 -0400
Received: by mail-io0-f179.google.com with SMTP id k93so54931671ioi.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x5NiixLc5mhf7DdCOQhg1kd9yC+CJBE6Rx8uq7N7R64=;
        b=U8q3lnaJdQmXMne3nku4EgSYuJ9mDWUKClsgpwTHTpJP09Ptb0MjiPu6vLL3Q1ZfTG
         hH4XEx0m2e469xytWJE4GvGSZdeJFsTx1AOU+SbTFgNKVe0MNYZcMfFw2yYDsb+UMmEV
         wmVawjJRG5dRRajmELmCHT5GzN3jcNaz/IWbAxwJGus8JYVJQMHT2ldlMe8LkcOy0W3J
         WG2B824aSTJbUHlFi4Nxss+SIS4v6j8JuF6gqyMeGWA2HxVv69L+UCLRjrBscoHflLI7
         jd145Z+2qafvuK3AY5aaD95K9vS5vNU4zlMroxU3dB6XgV6JP9p1iEwuFPGRBeaWhUCo
         wItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x5NiixLc5mhf7DdCOQhg1kd9yC+CJBE6Rx8uq7N7R64=;
        b=AtuTPaELHOj9lGxeRiQ8wtrVyaGueRDM3UWi+p3bzNaT3AaLa6W7jCKvCLH+n/tykC
         oQIFjHDFDtK4LhbOZPOjWWYjeEXacI3Wq+JUnVobE/m/7M1OUl0zuuK1el/odYI7X5Uu
         3f3SoFZZnN8qoZIDnx+pDo4mx0EC/55Kq6yVtwnJ7pAjMWDWuRzysF2DTi198+RAx08w
         yNvK7tGZz/8KBj5QAQ51id9koD7IJ9o2l8UhTFkQOduebGFJ/vCP3t7+URm9Zgp37P9d
         yeE9srVEo/sbSSWuhrjOGMlMqrJt0sa6B/+TFU+5K8laoOkyzzURIJWgkZbtiM1fCFU3
         6m2w==
X-Gm-Message-State: AKS2vOzrKgDBqfbjiVGCGpxkfaMdF2xU1P+8bdPzU1ti/UyUL/J3aYDj
        spxfjt9XyaIqJvlvw3DE3gYP+XQiyw==
X-Received: by 10.107.150.203 with SMTP id y194mr21932311iod.17.1497834146007;
 Sun, 18 Jun 2017 18:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Sun, 18 Jun 2017 18:01:45 -0700 (PDT)
In-Reply-To: <20170619001701.gvyjdrohsv7scshc@gmail.com>
References: <20170617102454.2040-1-davvid@gmail.com> <CAJZjrdX=8DbRTsdJ+bH5BABJG0m=y2QpT8C4kFviUsxVqVLVLg@mail.gmail.com>
 <20170618074603.epf3vhsi4pevg6jn@gmail.com> <CAJZjrdVU7h6RCd7K2hwFbZfo-6ifiKeh3dYdz7bdNzaPzCRXCg@mail.gmail.com>
 <20170619001701.gvyjdrohsv7scshc@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sun, 18 Jun 2017 21:01:45 -0400
Message-ID: <CAJZjrdWYUV88Ob1pB+yNLKKG22Xr+qCH3Ft06p8ne7x0hkwR5g@mail.gmail.com>
Subject: Re: [PATCH] mergetools/meld: improve backwards-compatibiilty when
 using "--output"
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 8:17 PM, David Aguilar <davvid@gmail.com> wrote:
> On Sun, Jun 18, 2017 at 05:11:48AM -0400, Samuel Lijin wrote:
>> On Sun, Jun 18, 2017 at 3:46 AM, David Aguilar <davvid@gmail.com> wrote:
>> > On Sat, Jun 17, 2017 at 10:11:36AM -0400, Samuel Lijin wrote:
>> >> On Sat, Jun 17, 2017 at 6:24 AM, David Aguilar <davvid@gmail.com> wrote:
>> >> > Meld 3.16.0 requires a "=" in the --output argument, as it uses
>> >> > a simple hand-rolled command-line parser.
>> >> >
>> >> > Newer versions of Meld (3.16.4, and possibly earlier) use
>> >> > optpaarse, which accepts either "--output <file>" or
>> >> > "--output=<file>".
>> >
>> > Junio, there's an optpaarse -> optparse typo in the commit message
>> > here in case you want to fix that up.
>> >
>> >>
>> >> Do older versions also support both?
>> >
>> > No.  When the "--output" option was first added (3.16.0, or possibly
>> > earlier) it used the simpler parser that does not undertand the
>> > "--output <filename>" form.
>> >
>> > Much older versions didn't support "--output" at all, so we don't have
>> > to worry about them since we already use the "--output" flag
>> > selectively based on whether or not it's supported.
>>
>> It sounds like this patch would break versions of Meld that use the
>> hand-rolled parser, then.
>
> I don't think so.
>
> The whole point of this patch is to make it compatible with the
> hand-rolled parser.
>
> Before the patch:
>
>         --output <filename>
>
> After the patch:
>
>         --output=<filename>
>
>
> The form with "=" (the latter one) is the one that's maximally
> compatible.
>
> Please re-read the commit message and patch to verify that this is
> indeed true.

Whoops, sorry, yes, you're right. It does still sound like there are
some versions of Meld in the middle that rely on "--output <filename>"
though, that this does break.
