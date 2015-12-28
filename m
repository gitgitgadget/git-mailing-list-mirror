From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/4] create_symref: modernize variable names
Date: Mon, 28 Dec 2015 09:20:42 +0100
Message-ID: <5680F0DA.1020301@alum.mit.edu>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151220072949.GC30662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 09:28:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDT9w-0001Fm-EM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 09:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbbL1I17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 03:27:59 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64486 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593AbbL1I16 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 03:27:58 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2015 03:27:58 EST
X-AuditID: 12074412-f79a76d000007c8b-0b-5680f0dd8f4c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CA.88.31883.DD0F0865; Mon, 28 Dec 2015 03:20:45 -0500 (EST)
Received: from [192.168.69.130] (p4FC97751.dip0.t-ipconnect.de [79.201.119.81])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBS8Kh9i012628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 28 Dec 2015 03:20:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <20151220072949.GC30662@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1L37oSHMYPItSYuuK91MFj9aepgd
	mDye9e5h9Pi8SS6AKYrbJimxpCw4Mz1P3y6BO2Px8d+sBf1sFV9bfRsYn7F0MXJySAiYSGzc
	uIMVwhaTuHBvPVsXIxeHkMBlRol3f8+xQjjnmSQWXOln7mLk4BAWcJDo2xsL0iAiYCRx48M3
	NhBbSCBbYuHfb0wgNpuArsSinmYwm1dAW2Lq7K9gNSwCqhJnl1wDWyYqECKxd2cHC0SNoMTJ
	mU/AbE4Ba4m2F/+YQWxmAXWJP/MuQdnyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqub
	m5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREo5COxjXn5Q7xCjAwajEw9vR1BAmxJpYVlyZ
	e4hRkoNJSZTX+zxQiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv6RugHG9KYmVValE+TEqag0VJ
	nPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBO+R90CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkp
	qUWJpSUZ8aB4jC8GRiRIigdob/g7kL3FBYm5QFGI1lOMuhwLftxeyyTEkpeflyolztsNskMA
	pCijNA9uBSz5vGIUB/pYmJcFmIqEeICJC27SK6AlTEBLZk6tB1lSkoiQkmpg1FKOtuC7MGli
	3kHbl3EbfQzixNzmHPA4adKXcuJiXfzxtOjtUlleWx/LZV1LWNFWLbA3+j/H1uOS8heN9M69
	2lA352Uqw/2ypk37uyyeHEmxeuV+6RKDaJ2D+gnF2fOXPTw4c+E6axc+5rk6H1tf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283031>

On 12/20/2015 08:29 AM, Jeff King wrote:
> Once upon a time, create_symref() was used only to point
> HEAD at a branch name, and the variable names reflect that
> (e.g., calling the path git_HEAD). However, it is much more
> generic these days (and has been for some time). Let's
> update the variable names to make it easier to follow:
> 
>   - `ref_target` is now just `ref`, matching the declaration
>     in `cache.h` (and hopefully making it clear that it is
>     the symref itself, and not the target).

I've been trying to name variables that hold reference names "refname"
to distinguish them clearly from other representations of references,
like "struct ref_entry *".

> [...]

Otherwise LGTM.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
