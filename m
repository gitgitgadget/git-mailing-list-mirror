From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bad object pointed under refs/head/
Date: Sat, 14 Feb 2015 07:19:10 +0100
Message-ID: <54DEE8DE.9060501@alum.mit.edu>
References: <CAN6kTyfiw6QPk469xV6gyL-+YB5Ca3vNHhEX7daiyn7j536SXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GitCafe-dev-team <dev@gitcafe.com>
To: Zheng Zhang <simsicon@gitcafe.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 07:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMWBg-0003or-2x
	for gcvg-git-2@plane.gmane.org; Sat, 14 Feb 2015 07:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbBNG0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2015 01:26:30 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43021 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125AbbBNG03 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Feb 2015 01:26:29 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Feb 2015 01:26:29 EST
X-AuditID: 12074413-f79f26d0000030e7-0c-54dee8e3ece8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 21.A3.12519.3E8EED45; Sat, 14 Feb 2015 01:19:15 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3718.dip0.t-ipconnect.de [93.219.55.24])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1E6JAPP023464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 14 Feb 2015 01:19:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAN6kTyfiw6QPk469xV6gyL-+YB5Ca3vNHhEX7daiyn7j536SXQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1H384l6Iwfmd4hZ3e8+yW3Rd6Way
	aNrbzOjA7PHj42I2j8+b5AKYorhtkhJLyoIz0/P07RK4M2Z+fM1S8JO9Yt/n2AbG+WxdjJwc
	EgImEhuOrmaHsMUkLtxbDxTn4hASuMwocWzqU1YI5xyTxNE7b8CqeAW0Jdq/HGIGsVkEVCXm
	NT9jAbHZBHQlFvU0M4HYogJBEodOP2aBqBeUODnzCZgtImAtcej7crDNzAJqEss39oDNERYw
	kPi3Yy8jiC0kECDR9PccK4jNKRAo0XBgAytEvbrEn3mXmCFseYntb+cwT2AUmIVkxSwkZbOQ
	lC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERKywjsYd52UO8QowMGo
	xMMrsfReiBBrYllxZe4hRkkOJiVR3s9rgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeH1uA+V4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK85sDYFBIsSk1PrUjLzClB
	SDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHv/PAfZW1yQmAsUhWg9xagoJc5rCjJX
	ACSRUZoHNxaWiF4xigN9Kcy7HqSdB5jE4LpfAQ1mAho8ccZtkMEliQgpqQZGs8cxr95VF4bs
	mMs6u33L++03mdf9cNjQ+lq19KFzGeOB0E9/tHTdPLpUelvv//vPsUXG49mmcisF9f8e+a+9
	D07eoFehXSf6+K/sibbPqcvc9i8zj0300SjXF1j8UCWP/eKvta38t8umXp3Y5Tlb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263848>

On 02/13/2015 11:06 AM, Zheng Zhang wrote:
> I was running some test with Git 1.8.4.5, then I accidentally met a
> problem that leaded to the following error,
> 
>>> error: refs/heads/develop does not point to a valid object!
> 
> Turns out that the sha in refs/heads/develop is a bad object id, this
> happened after merging a branch X to branch develop, but packed-refs
> is updated to a corrected sha. No other merges at that point.
> 
> The fix is easy, just removed refs/heads/develop.
> 
> So there were two sha created, one is updated to refs/heads/develop,
> and the other one which is corrected, updated to packed-refs,  Weird.
> 
> I am wondering if there is a way to prevent this happening? Is this an
> ancient bug?

If you can find and document a way to reproduce this problem, then you
will have a much better chance of finding somebody who is willing to
look into it. Otherwise it's hard to know how to even get started.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
