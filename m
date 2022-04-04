Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3459C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiDDX3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiDDX3K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:29:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048102C102
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 16:27:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h63so13209065iof.12
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusionauth.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2ty08fIhqS0Y9l+6zWGPsI3HdVlcw4Pp65xoxrp4Hw=;
        b=nPxS9tgVdZmNA7tVSxdKrSdZcdaDUcNzUSjfY675PmOgHY+YeVcJuuOF1fpww0nAUX
         s3Mjvq4A2UpfU5TrDikmX6NoXB8nmZSDv+nTFJ/FLX9hH2yiv8VtN2tCTXbUxwkrJweT
         xHA8QW83hG9JvkQJTI5K8K4//yxJqYtRPmxK266aEwh7WIdZoIR64K+HSX9sd5Eqb2cm
         UUq0fpNFhCIUt6vQNm8K0Urpe7v1s+x3GpV7TkX2Wo7KFiILrxoxOLIBsyofPIhM4FxP
         5l/QPOWEmyqCoAbiJG5TS1BFSvqz1KJ4ZEBFklyeZxt8yHc5CiPCXfB6jtwA2ZVenw0F
         /t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2ty08fIhqS0Y9l+6zWGPsI3HdVlcw4Pp65xoxrp4Hw=;
        b=AbTrGDahYb2QhCPZ3BchsNnkGuQVQx2l2Z5GUMq48ZLKMP+6d2G+cviCrFPyNozAsX
         sB/APiPPA7NgpOYL14xBElmLRa5HWV0R9G+HY4SM5jRxfP6rXFMjw3Qxs/kcVdvPQIsy
         z/YtbR/+3kXVjmSiRcfjeu/9JX5XgNxNQa3881TJyjYELCm+xdIJgb3sAJhEMGgiJv/U
         SNI8OD4A4Lu6dzy8Qz7gK8ZW1QTQM2hQzlXpLv34tjgUpgWsLm0yDoMKxOYHW7v5aKoH
         KqWP7mQRlP6FidMVKS6BIy9rrJ6Ozr9NeY29ECcWCPM5jFVhaytLAlO+uQ9H5zgqv1jM
         /x3Q==
X-Gm-Message-State: AOAM5318+hVShjxNDGG3bz+Wjs3E48N48ZxvhQJxdKlHfY49SLRfntUg
        m5rIysK7Mv5jXmdtO76qrqj85QxTg9dofxfqiSUeS5wmcwWl8Q==
X-Google-Smtp-Source: ABdhPJxlc7t0Ad2ir9huUez1SOkl2c+CG7EHcK/hg2eIQY99y2+gelFEmmrx/w/QEfDcAi6kZ3ATTbB1C7w/B5cz/Zo=
X-Received: by 2002:a6b:ce07:0:b0:611:5754:c109 with SMTP id
 p7-20020a6bce07000000b006115754c109mr375502iob.58.1649114832365; Mon, 04 Apr
 2022 16:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <YkcmtqcFaO7v1jW5@nand.local> <Ykt6lPF0JC1Mg2Tx@nand.local> <CAKUhyqE2L9MiNvauA6kaPstvNp6ift5ehfmeFxKvb2DjPvOnsA@mail.gmail.com>
In-Reply-To: <CAKUhyqE2L9MiNvauA6kaPstvNp6ift5ehfmeFxKvb2DjPvOnsA@mail.gmail.com>
From:   Dan Moore <dan@fusionauth.io>
Date:   Mon, 4 Apr 2022 17:27:01 -0600
Message-ID: <CAKUhyqHSwUb3UL=sKxqNrZsRNbf=wuzsk06LFfE=UwdN4JN37g@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Yes, we would love to offer our monetary support if it makes sense for
the community.

Cheers,
Dan


On Mon, Apr 4, 2022 at 5:23 PM Dan Moore <dan@fusionauth.io> wrote:
>
> Hi Taylor,
>
> Yes, we would love to offer our monetary support if it makes sense for the community.
>
> Cheers,
> Dan
>
> On Mon, Apr 4, 2022 at 5:09 PM Taylor Blau <me@ttaylorr.com> wrote:
>>
>> On Fri, Apr 01, 2022 at 12:22:14PM -0400, Taylor Blau wrote:
>> > To that end, we have a few options about what to do with the website in
>> > the future:
>>
>> Dan Moore (cc'd) has graciously offered the support of his company
>> FusionAuth [1] to help assist with our hosting costs. From Dan:
>>
>>     [M]y company has benefited tremendously from git and would be happy
>>     to foot the monthly cost if you are looking for sponsors.
>>
>> External support would go a long way towards keeping our existing funds
>> available for things like sponsoring travel and lodging for Git Merge
>> attendees who could not otherwise make it in person.
>>
>> Dan: thank you very much for your gracious offer. Does anybody have
>> objections to having some external support? I think the only change to
>> the site would be adding an entry to the "Sponsors" section of the about
>> page [2].
>>
>> Thanks,
>> Taylor
>>
>> [1]: https://fusionauth.io/
>> [2]: https://git-scm.com/site
>
>
>
> --
> Dan Moore  Head of Developer Relations
> 1630 Welton St suite 600-a, Denver, CO
> p: 720.560.8545
> w: fusionauth.io
> e: dan@fusionauth.io
>


-- 
Dan Moore  Head of Developer Relations
1630 Welton St suite 600-a, Denver, CO
p: 720.560.8545
w: fusionauth.io
e: dan@fusionauth.io
