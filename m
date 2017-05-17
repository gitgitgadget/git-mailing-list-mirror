Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C9A201A7
	for <e@80x24.org>; Wed, 17 May 2017 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbdEQP2O (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 11:28:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60226 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753958AbdEQP2A (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 11:28:00 -0400
X-AuditID: 1207440f-701ff700000004e5-4a-591c6bf96fa0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 06.62.01253.9FB6C195; Wed, 17 May 2017 11:27:54 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HFRoBZ011398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 11:27:52 -0400
Subject: Re: [PATCH 19/23] read_packed_refs(): report unexpected fopen()
 failures
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <5d13d0f0e0a63430a9bf2889e9a9e911382170de.1495014840.git.mhagger@alum.mit.edu>
 <20170517132839.fx6oebgqt5t65tia@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <488f1c1d-2611-5665-34dd-23ed88769fbc@alum.mit.edu>
Date:   Wed, 17 May 2017 17:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517132839.fx6oebgqt5t65tia@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqPsrWybS4HwTr8XaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujC0NX5gLfnBVnF71grmBcQ1HFyMnh4SAicTeNxPYuxi5OIQE
        djBJHOtdzQLhnGOSuL52NlMXIweHsECwxJnFFiANIgKyEt8Pb2SEqDnEKLHr6h5WkASzwCYm
        ia1n7UFsNgFdiUU9zUwgNq+AvcTuWzvZQWwWAVWJS++PM4PYogIREg87d7FD1AhKnJz5hAXE
        5hRwkdi24SETxEx1iT/zLjFD2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlT
        nJqsW5ycmJeXWqRropebWaKXmlK6iRES5vw7GLvWyxxiFOBgVOLhjQiQiRRiTSwrrsw9xCjJ
        waQkyrv/gXSkEF9SfkplRmJxRnxRaU5qMdDrHMxKIry6WUDlvCmJlVWpRfkwKWkOFiVxXvUl
        6n5CAumJJanZqakFqUUwWRkODiUJ3jcgjYJFqempFWmZOSUIaSYOTpDhPEDD14MNLy5IzC3O
        TIfIn2LU5Tj0/Od7JiGWvPy8VClxXgeQIgGQoozSPLg5sPT0ilEc6C1h3rMgVTzA1AY36RXQ
        EiagJc0g3/EWlyQipKQaGCOTVptUnW7LvhKoe/V17L2lbCU197rqnd0Uj7dv7uTYfefL8+So
        VWFSW09O+7Oq2HN1bZS3rN/jeqPGPW0GldnBh4xOMbzMLSnfuvP8xt89nee576/8eq5V/xvv
        9Ksh5m4cyxkbCnI5bxy7Wy+49Ou/Xu6qWBknj8a1reerv3x/M2n2vHNXQ5VYijMSDbWYi4oT
        AeEJaHQqAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 03:28 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:42PM +0200, Michael Haggerty wrote:
> 
>> The old code ignored any errors encountered when trying to fopen the
>> "packed-refs" file, treating all such failures as if the file didn't
>> exist. But it could be that there is some other error opening the
>> file (e.g., permissions problems), and we don't want to silently
>> ignore such problems. So report any failures that are not due to
>> ENOENT.
> 
> I think there are may be other "OK" errno values here, like ENOTDIR.
> That's probably pretty unlikely in practice, though, as we're opening a
> file at the root of the $GIT_DIR here (so somebody would had to have
> racily changed our paths). It's probably fine to just err on the side of
> safety.

Yikes, I think if somebody swaps $GIT_DIR out from under a working git
command, the user would want to know about it. How would you possibly
recover, anyway?

>> +	if (!f) {
>> +		if (errno == ENOENT) {
>> +			/*
>> +			 * This is OK; it just means that no
>> +			 * "packed-refs" file has been written yet,
>> +			 * which is equivalent to it being empty.
>> +			 */
>> +			return packed_refs;
>> +		} else {
>> +			die("couldn't read %s: %s",
>> +			    packed_refs_file, strerror(errno));
>> +		}
> 
> I think this could be die_errno().

Ah yes. I'll change it.

Thanks,
Michael

