Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558101FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 17:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934364AbdDFRcD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 13:32:03 -0400
Received: from mout.web.de ([212.227.17.12]:56218 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934260AbdDFRb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 13:31:57 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHp8z-1cxYAK2UZh-003cgl; Thu, 06
 Apr 2017 19:31:41 +0200
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
 <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
Date:   Thu, 6 Apr 2017 19:31:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:IvkcUXlAI1O7+mkXVy3Au4SJU0bBNRt97AAFqEO2lob4/5AQDj6
 UKPVJNgWEgk2c1Pyv4deigEaRlq4okEKVRlU3AhdnPeVD8F0JlvC8NJMHhddsgXcNO7S3mv
 o+31q0n+jkeqpQfPnlY0xlUqA4tD+moBRDFnIxxSno1AKQqdS7layNPLE2yNLuPOdky0UMl
 TOgvYi+oo6uyKrji6rbDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AHK5CMcfCf8=:j+Gb/00u5A9a8HXIN0D6FG
 Ov7lGQ9/swnzm2CESjvHfUuLkuuH/T7/vQCDTDBnB/67bXd4vUST9xKKP+TIxhomwpJ/y0Z3b
 CvCEt6XAnhUZMNCBwLbq9WXIxGAse9HuKaYwf4qH+KN02EBfPRYZ5EsYr35dzsRWwY1Ecy40r
 BHGLMQMGNWy9AY+5A+Z6NxT5ZvrdIh03NQDhYX6TkNCg2/zvvJJu9dc13sy5NMDDd8CwdhZeX
 q74/UOBseBa1JDtMuivYB51GmXWYO7j839S6D7vKF4LysoXU+1BLplS37vX7FYguCVKABGR3f
 28NpklhD4nYbTruXMveaO+JeDRVU/M5exIwmiyFD6uJtRNunyEfvsyC3SejNXm2m8RKH+uXB+
 o5Hx6Tdpxh2QOHJro72rJVGaCz9CgM/olRGkfaa/K2jNjm+3gMjXz39A7Mjo0bpxGZrazWx/7
 55Mgrq/Job/9p7BassqJYszLuZ0b96pNrgJ7wj6bV+3CNM68cki9WcowTspnrl6YRutWVxclf
 dYuKvQ4qj4mdNmn6hpUrfl3bGKApKfQxbl/c+KyC4MLc4Rr1mYLS8OYmQr1WBqzZC/LNpiXYu
 UxcWfYEAVN5H1Xs5wxEdddp478ecH+fWGuJOa/8n3TunlCWM17udqX0SueZahGRoIaCw97wwc
 HMUW64/pUt1CCjYb9RfWdb9ICZTu6HHRzPNHJFJIr1F8JrogqFnAXsvlbNdEqANIs7OSAPnav
 i1awh/FAvLu+Uz1Sdk7607thaa6WVYap/Vyvk21CD1wRypspZ4th1BBD/B9oZt8yecw5z9ar3
 oDruHLH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.04.2017 um 18:33 schrieb Johannes Sixt:
> Am 06.04.2017 um 17:42 schrieb Martin Liška:
>> +static inline void *sane_memmove(void *dest, const void *src, size_t n)
>> +{
>> +    if (n > 0)
>> +        return memmove(dest, src, n);
>> +    else
>> +        return dest;
>> +}
>
> Huh? memmove with n == 0 is well-defined. This wrapper is pointless.

memmove(3) with NULL pointers is undefined.  From string.h on Debian:

   extern void *memmove (void *__dest, const void *__src, size_t __n)
        __THROW __nonnull ((1, 2));

Sometimes we use a NULL pointer and a size of zero to represent arrays 
with no members.  That convention is incompatible with memmove(3), but 
the wrapper above would support it.  Checking the size instead of the 
pointer is preferable because a positive length with NULL pointers 
should still result in a segfault instead of a silent no-op.

(I'd still prefer a MOVE_ARRAY macro which also infers the element
size).

René
