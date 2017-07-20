Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089681F600
	for <e@80x24.org>; Thu, 20 Jul 2017 23:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965889AbdGTXFQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 19:05:16 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35572 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965872AbdGTXFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 19:05:12 -0400
Received: by mail-pf0-f181.google.com with SMTP id r76so185461pfj.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8n6nbev6jvSob2jmBOrlmtRzASIBnrhuh1Bpqof4eiE=;
        b=W4leBMMfjaX4awuV5m+/sOkgn0oJU0aUvy9P0qIUXbFafDOtSNYXDTX4zGUVUdu2wL
         Zcs2KbGp/I8kBMw8DIjMEA9dhjIPO4t7tsQOjQ3yTiZYz+jvoDlkLs1+Tb4w9Cl4GWyL
         f+OUXwfdKAsTQc2DBpeq85UU9PUwCV49w3QDw5ZGiQl70HOJNM20mBE6oWGgmJ0sVnya
         0YDeRa15KePVww6P15DQRIdSA4dLQ6T0cIfkz5FXbUn2YXVKT8MaaNfzTleHmItvdMlg
         RjMBYzC4HXyQvvOtt5tOaRv4qGd2aMKPuEKuiwkX1eekWlwDPcgfrHjp1OnD2KYRQQ1Q
         EfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8n6nbev6jvSob2jmBOrlmtRzASIBnrhuh1Bpqof4eiE=;
        b=dRRfyMzuZ2fdOmhqk1Liv76oEh1hDhT4sjVb79wKJ5fWvFcsIJA8m2dSVgrktSlHDQ
         rhyJKRZNmn7U3u8XvGhXsit2Ztu2XtN3kq+vYtdqQcO2E82X5Y3v8EORviTORL3Mp9DS
         5M8RYMLbAq/+88W8WvNA6LrGLq1DFzYOqkr6AIXAYby54XM1FsuPl+M6BzjjAkZ7EwbW
         KkYV5OH6feWcAHzZ+ND0MNzY0d33RGaw3FxDk5sQCPWMWgxKJ5vN4DnQFwlE+gHq7C4Z
         F8LIGu0Q9o9mn2c7mCMWrzSRKnV8ZprlLM0hJl4bcXZDh8zH8dTtAy34agTIsC0IzkES
         5TUA==
X-Gm-Message-State: AIVw1132gn8MEI6Rw8WMoCctnnEzq5OClIOyqrWRn2inxvlTDhNbPm3O
        KnNrPOxm89DDQfu9tXOQA9w+rSjswVkP
X-Received: by 10.99.97.12 with SMTP id v12mr3303746pgb.97.1500591912344; Thu,
 20 Jul 2017 16:05:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 20 Jul 2017 16:05:11 -0700 (PDT)
In-Reply-To: <20170705091216.ij4uzp3wgsalb56f@sigill.intra.peff.net>
References: <cover.1498933362.git.mhagger@alum.mit.edu> <20170705091216.ij4uzp3wgsalb56f@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Jul 2017 16:05:11 -0700
Message-ID: <CAGZ79kY=N5H2q1SB9ZEtt1EvuAQg+bqVBZNoXE6nLgtoUd2txA@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Create a reference backend for packed refs
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 5, 2017 at 2:12 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jul 01, 2017 at 08:30:38PM +0200, Michael Haggerty wrote:
>
>> This is v3 of a patch series creating a `packed_ref_store` reference
>> backend. Thanks to Peff and Junio for their comments about v2 [1].
>>
>> Changes since v2:
>>
>> * Delete some debugging `cat` commands in t1408.
>>
>> * Add some tests of reading packed-refs files with bogus contents.
>>
>> * When reporting corruption in packed-refs files, distinguish between
>>   unterminated lines and other corruption.
>>
>> * Fixed a typo in a commit message.
>
> Thanks. I just quickly re-reviewed based on the diff from v2, and it
> looks good to me.
>
> -Peff

We have a user that reports:

  The issue is for users who have a mirrored repository, "git pack-refs"
  now overwrites the .git/packed-refs symlink instead of following it and
  replacing the file it points to.

I suspect this series to be at fault, as the bug report came in a day after
we deployed next containing these changes.

Do symlinks and packed-refs ring a bell for this series?

Thanks,
Stefan
