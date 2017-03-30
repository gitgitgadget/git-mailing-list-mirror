Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4CB1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbdC3L1i (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 07:27:38 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50099 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932471AbdC3L1g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 07:27:36 -0400
X-AuditID: 12074413-f67ff700000077e1-c8-58dceba699b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.EB.30689.6ABECD85; Thu, 30 Mar 2017 07:27:35 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2UBRWMU027139
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 07:27:33 -0400
Subject: Re: [PATCH v5 0/6] [GSoC] remove_subtree(): reimplement using
 iterators
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <708a97ce-9384-f863-37db-32383dd5a984@alum.mit.edu>
Date:   Thu, 30 Mar 2017 13:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqLv89Z0Ig10v2Cwef3rLZtF1pZvJ
        oqH3CrNF95S3jBabN7ezOLB67Jx1l91jwaZSj4uXlD0+b5ILYInisklJzcksSy3St0vgyji1
        bzZbwSWhimc3FRsYb/J3MXJySAiYSDx6eZixi5GLQ0hgB5PEp7uzWUASQgLnmSRu3RUAsYUF
        giQW3VgCVMTBISJgLXF9jRdEiYPEm/+rGEFsZgEbieNNvWA2m4CuxKKeZiaQcl4Be4kPR5NA
        wiwCqhITF7awg9iiAiEScxY+ACvnFRCUODnzCdhWTgFHiW0r5rFBjNST2HH9FyuELS+x/e0c
        5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCFh
        K7yDcddJuUOMAhyMSjy8FWtvRwixJpYVV+YeYpTkYFIS5d08906EEF9SfkplRmJxRnxRaU5q
        8SFGCQ5mJRFenxdAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG/+
        K6BGwaLU9NSKtMycEoQ0EwcnyHAekOEvQYYXFyTmFmemQ+RPMSpKifNeBUkIgCQySvPgemFp
        5RWjONArwrxXQFbwAFMSXPcroMFMQIPFbW6BDC5JREhJNTB2F/jtnvxuWQUrJ5dSy0z1hOWP
        m7tdeNhVl7jdLzyUVWTK88Hhnkxu7v4j3OtK1316/qbypMGCHZ/2HgifPiXwYuCk2+qdQrNv
        y5b+jVgVVrJFsPN51PrTprcW29w4YCY7R3jSPcVdgme1D7x7ZRnpNEu4w0DApOFb7RXRJy16
        m45Jzq5t+HlRiaU4I9FQi7moOBEAuMGWEwYDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> This is the fifth version of a patch series that implements the GSoC
> microproject of converting a recursive call to readdir() to use dir_iterator.
> 
> v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
> v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
> v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
> v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
> 
> I would like to really thank Michael for the incredibly thorough review of
> the last version of this series. I never expected anyone to give that
> level of attention to this change, and it's really, really appreciated.
> 
> All of the points he addressed are fixed in this version. As always, more
> feedback is greatly appreciated.

Thanks for the reroll. I have reviewed v5 and it's much improved
relative to v4. I'm very encouraged by your quick and constructive
responses and especially that you are sticking with it even though the
project is getting much, much more involved than a typical GSoC
microproject. Perseverance is a very important prerequisite to success
in the Git project.

Please pay attention to formatting trivia like the formatting of
multiline constants. It's boring to give the same feedback multiple
times [1].

It's common that nontrivial patch series have to go though many
iterations before being accepted, so don't get discouraged. Even
experienced developers sometimes get past v10! The important thing is
that every round gets better than the last, that we learn from the
experience together, and that you don't give up, and then it is almost
certain that it will converge eventually!

I can't speak for the GSoC mentors who will make the decision, but I
would expect that your taking on an ambitious project and sticking with
it will leave a good impression, even if you don't quite get your change
accepted by whatever deadline. So don't panic that you are ruining your
chances by picking an ambitious project; quite the opposite is more
likely to be the case.

Michael

[1] softwareswirl.blogspot.com/2014/03/my-secret-tip-for-gsoc-success.html

