Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07A81FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 06:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbdC3Gjg (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:39:36 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52793 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751941AbdC3Gjf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 02:39:35 -0400
X-AuditID: 1207440f-129ff70000003517-9b-58dca8226ef6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FE.BD.13591.228ACD85; Thu, 30 Mar 2017 02:39:33 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2U6dSsd014897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 02:39:29 -0400
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     Junio C Hamano <gitster@pobox.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
 <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
 <xmqqk278av4x.fsf@gitster.mtv.corp.google.com>
 <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
 <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com>
Cc:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu>
Date:   Thu, 30 Mar 2017 08:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqKu64k6EwZSVghaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZbQt
        fMpWsEOo4nfPFdYGxh98XYycHBICJhJHDvxj6mLk4hAS2MEkcfbeOTYI5zyTxLNzq5hBqoQF
        fCUazqxlAbFFBNQkJrYdYoEoOsokMXHeIXaQBLNAtsThG6tZQWw2AV2JRT3NQGM5OHgF7CWW
        ba0FCbMIqEp8mLePCcQWFQiRmLPwASOIzSsgKHFy5hMWkHJOAWuJS8dEISbqSey4/osVwpaX
        2P52DvMERv5ZSDpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTS
        TYyQ4OXfwdi1XuYQowAHoxIPb8Xa2xFCrIllxZW5hxglOZiURHk3z70TIcSXlJ9SmZFYnBFf
        VJqTWnyIUYKDWUmE124xUI43JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8Gh
        JMFbuxyoUbAoNT21Ii0zpwQhzcTBCTKcB2j4DpAa3uKCxNzizHSI/ClGRSlx3oBlQAkBkERG
        aR5cLyy5vGIUB3pFmPcTSBUPMDHBdb8CGswENFjc5hbI4JJEhJRUA6NYmztvanEh06rTd7Ot
        Sud8XP5FdO6EXI5HTmFmr+0KLRLKBS+p2jgGzsqMfd3vsFd4l9DH4lndIs/rNt2d6D7ry/ze
        dwWfgsRm1VROygu48ilYTqbyVvvMpsPq65pr8pZdeJU9/0zj5YRJsa4Lev7cmMDSqFbLbPne
        ROGfw/u9m2wXTw9U5lViKc5INNRiLipOBADReRUyCQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 08:08 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I think IN_ORDER really only applies to *binary* trees, not arbitrary
>> trees like a filesystem.
> 
> How true.  Even if we were giving a sorted output (and dir-iterator
> doesn't and there is no need for it to), dir/ should come before any
> of its contents, so for that application we can use pre-order, and
> there is no sensible and useful definition of in-order.

Your email got me thinking, though, that there is one generalization of
the concept of PRE_ORDER vs. POST_ORDER that would be both easy to
implement and potentially useful. Namely, flags could include the
following orthogonal options (instead of `DIR_ITERATOR_POST_ORDER)`:

* DIR_ITERATOR_DIRS_BEFORE -- when this is set, directories
  are included in the iteration *before* their contents.

* DIR_ITERATOR_DIRS_AFTER -- when this is set, directories
  are included in the iteration *after* their contents.

Enabling one or the other of these options would select pre-order or
post-order iteration.

Enabling neither of them would mean that directory entries themselves
are not included in the iteration at all, even though recursion would
happen *into* subdirectories. This option would surely be useful to some
caller somewhere (though it's easy for the caller to get the same effect
itself via

	if (S_ISDIR(iter->base.st.st_mode))
		continue;

).

It's even conceivable that enabling *both* options at the same time
would be useful, if the caller want to know when the processing of a
directory is begun and also when it is finished (e.g., because it needs
to load or unload a `.gitignore` file for that directory). If we wanted
to make it easier for the caller figure out whether it is seeing an
"entering directory" event vs. a "leaving directory" event, we could
expose something like the `dir_state` member in the iterator.

While we're blue-skying, a

* DIR_ITERATOR_RECURSE -- recurse into subdirectories

would make the set of possible options complete. If this option is not
set, then the iteration would be over the entries in a single directory
without traversing its subdirectories.

I don't think any of this needs to be implemented now, but maybe keep it
in mind if/when `dir_iterator` gets more users.

Michael

