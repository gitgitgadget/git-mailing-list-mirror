Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE4D2082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdFXLOs (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:14:48 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59974 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751272AbdFXLOr (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Jun 2017 07:14:47 -0400
X-AuditID: 12074411-cebff700000033ea-50-594e49a5a4fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.32.13290.5A94E495; Sat, 24 Jun 2017 07:14:46 -0400 (EDT)
Received: from [192.168.69.190] (p54AAE63F.dip0.t-ipconnect.de [84.170.230.63])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5OBEhV0019860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 24 Jun 2017 07:14:44 -0400
Subject: Re: [PATCH v2 00/29] Create a reference backend for packed refs
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net>
 <20170623200024.amgced62hue2iffj@sigill.intra.peff.net>
 <xmqqefuacr6y.fsf@gitster.mtv.corp.google.com>
 <20170624011131.5kgmzgpb4vtwikk5@sigill.intra.peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <57a15496-ab0b-97fc-b6a2-8c2526f2c5d3@alum.mit.edu>
Date:   Sat, 24 Jun 2017 13:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170624011131.5kgmzgpb4vtwikk5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLvM0y/S4MwScYu1z+4wWTxff4Ld
        outKN5NFQ+8VZoslD18zW3RPecto8aOlh9li8+Z2FgcOj52z7rJ7LNhU6tHVfoTN41nvHkaP
        i5eUPT5vkgtgi+KySUnNySxLLdK3S+DKmDztC3vBBJ6KfR37GRsYL3J2MXJySAiYSMw7fo8d
        xBYS2MEk8WyhUxcjF5B9nkniz40FLCAJYQEPieM7HzOD2CICjhIXthxhgSiaxiQxaXIzI4jD
        LLCFSeLR1IOsIFVsAroSi3qamUBsXgF7iTk/NjOC2CwCqhL/994DmyoqECHxsHMXO0SNoMTJ
        mU/A4pwCLhJH+6+A2cwC6hJ/5l1ihrDlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3
        NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJOQFdzDOOCl3iFGAg1GJh1fA0zdSiDWxrLgy
        9xCjJAeTkihv7BmfSCG+pPyUyozE4oz4otKc1OJDjBIczEoivJxmfpFCvCmJlVWpRfkwKWkO
        FiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3lMeQI2CRanpqRVpmTklCGkmDk6Q4TxAw687
        gwwvLkjMLc5Mh8ifYlSUEud9BtIsAJLIKM2D64WlpFeM4kCvCPOqgFTxANMZXPcroMFMQINn
        rPEBGVySiJCSamBsOr9g1mwls1st35LEQq3YbphN15qq9/bqodbT95b/1XA68XTDxWe722X/
        LGprU+p9tH8a2412w3zTmc7buYv96rJ6LULbb53N0HWriXbxcz+v3Pgs7FqElGLbVoaXPyVW
        5u11jlfz/dG55O69L6eO8CmEaCTtrIy+6dja8sKeO1p5pbrexQ4lluKMREMt5qLiRAD3/7is
        JAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/24/2017 03:11 AM, Jeff King wrote:
> On Fri, Jun 23, 2017 at 02:47:01PM -0700, Junio C Hamano wrote:
> 
>>> Speculating on my own question. I guess it would prepare us for a day
>>> when a possible ref store is to use a packed-refs _without_ loose refs.
>>> IOW, the property is defined on packed-refs today, but a possible future
>>> direction would be to use it by itself. But maybe I'm just making things
>>> up.
>>
>> OK.  In other words, it's not a packed-refs's characteristics that
>> cruft are allowed.  It's that a ref storage that is implemented as
>> an overlay of one storage (which happens to be the loose one) on top
>> of another (which happens to be the packed refs file) allows the
>> latter one to have cruft if (and only if) that broken one is covered
>> by the former one.
> 
> Thanks, that's a much better way of saying what I was trying to get at.
> I don't know if that's Michael's argument or not, but it's certainly one
> I find reasonable. :)

That was exactly my thinking. A packed-without-loose storage scheme
might, for example, be interesting for people with case-insensitive or
strangely-Unicode-normalized filesystems but have colleagues who like to
use case or Unicode in their reference names. (Of course that would
still require a way to store symbolic refs and reflogs, so I'm not
saying that we're there yet.)

I also think it is a good idea to keep the backends' interfaces as
similar as possible to reduce the number of quirks that the reader has
to keep in mind.

Michael

