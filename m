Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712AD2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 20:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbcKGUsZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 15:48:25 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:32769 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbcKGUsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 15:48:24 -0500
Received: by mail-qt0-f173.google.com with SMTP id p16so95181475qta.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0legZAmst9HsMOasx2MFzy1BuGJJO/6yg7KEVkXRdJU=;
        b=LDkunVhgFk82quzrlQNWvKg4absgvZah7nHTK1a42XVvKRfcfUSBTZIyVxelAuk8Y0
         WJjiqs2cAsycQus7bFN88AxYFSLj2SpmDolIvvHKpNRvY6pvJokxvLK8BOl+EtgQprhY
         ygrGnTFg7UcLIfCOKv6I9bC4mKPZwGCMICsxTSd2Ts4VGYXDvrtk5YXNYApDk/+LHfxT
         bIXl2/XrNw9Hw3C2W+lOQZh64d4Ii7P5SFmSuPImuL7YsTSH+ze3UDgN4O0u7xYj70k+
         Yp1Ad0PfBvWn8/3XS+lPNf/tD/CSl3hTTB5+glfF0lrifIvNCRjL2CRADfqL6pOmyDHw
         PfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0legZAmst9HsMOasx2MFzy1BuGJJO/6yg7KEVkXRdJU=;
        b=Ltj06X0o7Tew9urbijh5PlSrf5ZBwJ25DDN7GhLNMX3Mg1YDXW4wJMw8ISpUXksr+C
         +4yljiwckog2GXpaP+y8XEapB6fmyyCNrdF0AKvdqKCqYqmeDG25Ggq+d4FWynz0zTeX
         8r7klGchfS0nHkuILT8aBxQz3rG6MYVlzzvt6nTvga2NCEcBGOpm6Wui71TPJvxQsA0D
         fKXvluWYmBiAtDVIengn0ysYXWpjlJCqKmijj6Pb3lzwQtYG7iexzIYYMNqYj0NM2+65
         seb+C/iaGQO9cnAcI2mabBhTHbOIRvnPmckn0OXrQL+Ggk7cNYqohLgjKdWCZt/EJ6Kt
         CvXQ==
X-Gm-Message-State: ABUngvfbQTZhb4r/YCPhAqZiExzwA95HK7qf8XMjW90VnA0SeRaLvobe0RoXpoL99h96JQEvpbdh18eC+MWjXELV
X-Received: by 10.200.39.90 with SMTP id h26mr9177661qth.88.1478551703498;
 Mon, 07 Nov 2016 12:48:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 7 Nov 2016 12:48:22 -0800 (PST)
In-Reply-To: <378e63aa70e54fe9b839acf90680917a@exmbdft7.ad.twosigma.com>
References: <1478543491-6286-1-git-send-email-dturner@twosigma.com>
 <CAGZ79kbp82VssqutEg5=TnciQrGkDRQ3iNm_vUo9eBBGMXQRNg@mail.gmail.com> <378e63aa70e54fe9b839acf90680917a@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 Nov 2016 12:48:22 -0800
Message-ID: <CAGZ79kb8XM_j37H-j3fUz9a0DFXn_v+S4P4r-QyuQOKM3xqhRw@mail.gmail.com>
Subject: Re: [PATCH] submodules: allow empty working-tree dirs in merge/cherry-pick
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 12:38 PM, David Turner <David.Turner@twosigma.com> wrote:
>> -----Original Message-----
>> From: Stefan Beller [mailto:sbeller@google.com]
>> Sent: Monday, November 07, 2016 2:14 PM
>> To: David Turner
>> Cc: git@vger.kernel.org
>> Subject: Re: [PATCH] submodules: allow empty working-tree dirs in
>> merge/cherry-pick
>>
>> On Mon, Nov 7, 2016 at 10:31 AM, David Turner <dturner@twosigma.com>
>> wrote:
>> > When a submodule is being merged or cherry-picked into a working tree
>> > that already contains a corresponding empty directory, do not record a
>> > conflict.
>> >
>> > One situation where this bug appears is:
>> >
>> > - Commit 1 adds a submodule
>>
>> "... at sub1" as inferred by text below.
>>
>> > - Commit 2 removes that submodule and re-adds it into a subdirectory
>> >        (sub1 to sub1/sub1).
>> > - Commit 3 adds an unrelated file.
>> >
>> > Now the user checks out commit 1 (first deinitializing the submodule),
>> > and attempts to cherry-pick commit 3.  Previously, this would fail,
>> > because the incoming submodule sub1/sub1 would falsely conflict with
>> > the empty sub1 directory.
>>
>> So you'd want to achieve:
>>   $ # on commit 3:
>>   git checkout <commit 1>
>>   git cherry-pick <commit 3>
>>
>> which essentially moves the gitlink back to its original place (from
>> sub1/sub1 -> sub1).  This sounds reasonable.
>> But what if the submodule contains a (file/directory) named sub1? We'd
>> first remove the sub1/sub1 submodule (and even delete the inner
>> directory?), such that "sub1/"
>> becomes an empty dir, which is perfect for having a submodule right there
>> at "sub1/"
>
> I'm confused about the "what if" here.
>
> In our particular situation, the submodule in question was not initialized.

oops. That explains it. I somehow assumed we were talking about
initialized submodules.

>
> If your approach also fixes the same tests that mine fixes, then I am happy to use your series over mine.  Please CC me so I can take a peek.

No, my series seems to be orthogonal to this one. I plan
on cc'ing you nevertheless as it is still nearby.

> basically nobody needs two copies of one submodule in the same repo.

IIRC this is how gitlinks were used in very early days :/
(kernel people were using gitlinks to track different kernel versions
and see if they were interoperable or working at all.
e.g. see d92a39590d1126e195f1bbccf182a2cdb79218e7, which
only makes sense (for the update command) if the referenced repository
contains references of all submodules, which either means a huge reference
pile that contains different projects at the same time, or the same project
at different versions.

>  I think that case fails for other reasons anyway.
>

Yes. I agree that the patch as-is is applicable. I did not try to oppose
your approach, but rather give some thoughts I had.

Stefan
