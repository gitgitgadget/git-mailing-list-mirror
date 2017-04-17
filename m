Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042FC1FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 06:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbdDQG3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 02:29:25 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:42912 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932734AbdDQG3Y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Apr 2017 02:29:24 -0400
X-AuditID: 12074412-4bbff70000000b04-81-58f460bedb90
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.B7.02820.EB064F85; Mon, 17 Apr 2017 02:29:20 -0400 (EDT)
Received: from [192.168.69.190] (p5790773A.dip0.t-ipconnect.de [87.144.119.58])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3H6TFkX018532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 17 Apr 2017 02:29:16 -0400
Subject: Re: [PATCH v8 0/5] [GSoC] remove_subtree(): reimplement using
 iterators
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a60b2ed6-2b99-b134-05af-7c8492a6949c@alum.mit.edu>
Date:   Mon, 17 Apr 2017 08:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqHsw4UuEwfwPrBaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZazs
        bWYu6FSp+HxjB1sD4yK5LkZODgkBE4nZd66xdzFycQgJ7GCS6Po8mwnCOc8kcejzemaQKmGB
        IIme+e+AEhwcIgLWEtfXeIGEhQQcJCZNaWIFsZkFbCSON/UygthsAroSi3qamUBsXgF7iT1/
        2tlBbBYBVYmFB26wgdiiAiEScxY+YISoEZQ4OfMJC4jNKeAocePaNCaImXoSO67/gpovL7H9
        7RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsY
        IcErtINx/Um5Q4wCHIxKPLwWxz5HCLEmlhVX5h5ilORgUhLlFVP9EiHEl5SfUpmRWJwRX1Sa
        k1p8iFGCg1lJhDcwHCjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTB
        qxgP1ChYlJqeWpGWmVOCkGbi4AQZzgM0/EEcyPDigsTc4sx0iPwpRkUpcV4HkGYBkERGaR5c
        Lyy5vGIUB3pFmLcDpIoHmJjgul8BDWYCGhwRADa4JBEhJdXA6Ppw3fuPnz88OqJZt1Q/ZEXk
        +U1R27S0887I2VYfZWFi38C7e6uW0IampcInHRZG5wSxMZ+NmXNgokN4JOfTIr7JHdlm0/Te
        HpHexrcwZsuHBMFe5V/KUhtstq1nfeb+9ZzYhD3rvinNjbMOUOrdL2TPe9aWwdNL+Qj7I45U
        n6XnHDvNHxVvVmIpzkg01GIuKk4EANqY3ocJAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06/2017 03:39 AM, Daniel Ferreira wrote:
> This is the seventh version of a patch series that implements the GSoC
> microproject of converting a recursive call to readdir() to use dir_iterator.
> 
> v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
> v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
> v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
> v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
> v5: https://public-inbox.org/git/1490844730-47634-1-git-send-email-bnmvco@gmail.com/T/#m2323f15e45de699f2e09364f40a62e17047cf453
> v6: https://public-inbox.org/git/1491107726-21504-1-git-send-email-bnmvco@gmail.com/T/#t
> v7: https://public-inbox.org/git/1491163388-41255-1-git-send-email-bnmvco@gmail.com/T/#t
> 
> Travis CI build: https://travis-ci.org/theiostream/git/jobs/219111182
> 
> In this version, I applied pretty much all suggestions Michael and Stefan had
> for the patch.
> 
> Michael, regarding the patch you sent for parsing the arguments on the
> test-dir-iterator helper, I did not squash because it'd generate too many
> merge conflicts. I just preferred add your code manually. Let me know how I
> can properly credit you for it.

It's a small enough bit of code that you don't have to credit me.
However, technically you should add a

    Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

line to your patch that includes my code, which you are allowed to do
because I included that line in the email where I suggested the change [1].

> The only "controversial" part of this code is how I ended up caching the result
> of lstat() on the dir_iterator_level struct. Having to handle the case of the
> root directory ended up making set_iterator_data() way more complicated (having
> to handle the case of level->stat not being set by push_dir_level()), as well
> as required the introduction of st_is_set member in the level struct. This issue
> would be solved if we could lstat() the root dir on dir_iterator_begin() and
> possibly return an error there. Regardless, I appreciate other suggestions to
> make this less complex.

I agree that this adds a lot of code complexity. But I think your
suggestion to move the initial `lstat()` call to `dir_iterator_begin()`
is a good one. It could return NULL on error (being careful not to leak
memory of course). It should be careful to leave `errno` set
appropriately, which would allow the caller to see why it failed (i.e.,
because the directory didn't exist, or the path was not a directory, or
whatever). In that case, probably `dir_iterator_begin()` could call
`push_dir_level()`, eliminating a bit of repeated code at the same time.

This would also fix an anomaly in the current code: currently, if the
top-level "directory" is not a directory, it is nevertheless reported
back to the caller during `DIR_ITERATOR_PRE_ORDER_TRAVERSAL` and *again*
during `DIR_ITERATOR_POST_ORDER_TRAVERSAL`. Instead,
`dir_iterator_begin()` would report an error and the caller would not be
misled.

> Hey there! I'm sorry for bothering you, but any chance you might have
> overlooked this patch for a review? (I'm just not familiar with how
> long patches usually take to be reviewed, and since I always got an
> answer within two days of sending it I wondered if you may have just
> not noticed it.)

It's pretty common for response times to vary wildly in open source
(Junio being a notable exception). People often work on open source in
their spare time, and disappear and reappear without notice based on
what else is going on in their lives. For this reason, it is really
important to submit changes in small batches as early as possible
(especially in GSoC) and continue working on the next batch while
waiting for review on earlier batches. If you find yourself with nothing
else to work on, maybe spend some time reviewing *other* people's
patches, which is also a valuable contribution.

That being said, if you are waiting for a response from particular
person, after a wait it is OK to write them an email asking if they will
have time to get to it (realizing that the answer might be "no").
Probably such an email should be to the person directly, and not CCed to
the mailing list.

Michael

[1]
http://public-inbox.org/git/bfd5d9a07139dbc6eb1fd1dc82ffb38dbbefee1e.1491286711.git.mhagger@alum.mit.edu/

