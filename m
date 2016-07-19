Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0881F744
	for <e@80x24.org>; Tue, 19 Jul 2016 07:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbcGSHrH (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 03:47:07 -0400
Received: from lang.hm ([66.167.227.134]:35925 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbcGSHrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 03:47:06 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id u6J7koHq000955;
	Tue, 19 Jul 2016 00:46:50 -0700
Date:	Tue, 19 Jul 2016 00:46:50 -0700 (PDT)
From:	David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:	Duy Nguyen <pclouds@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <alpine.DEB.2.20.1607190926420.3472@virtualbox>
Message-ID: <alpine.DEB.2.02.1607190045240.2015@nftneq.ynat.uz>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com> <alpine.DEB.2.20.1607190926420.3472@virtualbox>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 19 Jul 2016, Johannes Schindelin wrote:

> Hi Duy,
>
> On Mon, 18 Jul 2016, Duy Nguyen wrote:
>
>> On Sun, Jul 17, 2016 at 4:21 PM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>> I'm going to end up having to do something similar because of the issue
>>> of submodules.  Submodules may still be SHA-1, while the main repo may
>>> be a newer hash.
>>
>> Or even the other way around, main repo is one with sha1 while
>> submodule is on sha256. I wonder if we should address this separately
>> (and even in parallel with sha256 support), making submodules work
>> with an any external VCS system (that supports some basic operations
>> we define).
>
> It is safe to assume that any project using a submodule with a more secure
> hash would require Git tooling capable of said hash. It would hence make
> no sense to use SHA-1 for the super project.
>
> So I do not believe that we have to support the use case of a SHA-1-based
> project using SHA-256-based submodules.

they have different upstreams, what if the upstream of the submodule has 
upgraded and is using signed commits of the sha-256 but the upstream of the 
parent hasn't and is using signed commits of sha1?

David Lang
