From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/8] imap-send: change msg_data from storing (char *,
 len) to storing strbuf
Date: Sun, 02 Dec 2012 07:03:20 +0100
Message-ID: <50BAEF28.6000400@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu> <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu> <7vboegp04x.fsf@alter.siamese.dyndns.org> <50B8B66F.3090300@alum.mit.edu> <7v624lns00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 07:15:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf2q8-0001UP-3K
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 07:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab2LBGD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 01:03:27 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:64684 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab2LBGD0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2012 01:03:26 -0500
X-AuditID: 1207440d-b7f306d0000008b7-23-50baef2df7dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F6.95.02231.D2FEAB05; Sun,  2 Dec 2012 01:03:25 -0500 (EST)
Received: from [192.168.69.140] (p57A25023.dip.t-dialin.net [87.162.80.35])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qB263L14008511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Dec 2012 01:03:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7v624lns00.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqKv7fleAQeNdSYuuK91MFg29V5gt
	+pd3sVlcPjmX0eJHSw+zA6vHl6uNTB4fPsZ5POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGWtu72UpuM1aMWHmPZYGxv0sXYycHBICJhJnP/yHssUkLtxbz9bFyMUhJHCZUeLxpUss
	EM4pJolL/84yglTxCmhL/PrxFqyDRUBVYtuBqawgNpuArsSinmYmEFtUIEBi8ZJz7BD1ghIn
	Zz4BqxcRUJOY2HYIbCizwFxGid9/ZzGDJIQFkiQ+LT8KtkBI4COjxLQ3AiA2p4CZRGPvHLAa
	ZgEdiXd9D6BseYntb+cwT2AUmIVkxywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5da
	pGukl5tZopeaUrqJERLkvDsY/6+TOcQowMGoxMMbNWdXgBBrYllxZe4hRkkOJiVR3uY3QCG+
	pPyUyozE4oz4otKc1OJDjBIczEoivCwmQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU
	1ILUIpisDAeHkgRv4TugRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQtMYXA+MV
	JMUDtNcVpJ23uCAxFygK0XqK0Zhjzsz2J4wcG9YDSSGWvPy8VClx3laQUgGQ0ozSPLhFsPT2
	ilEc6G9h3jyQKh5gaoSb9wpoFRPQqjfLtoOsKklESEk1MPpPbPFTmFGrfWxbilEiK3PLpTTn
	i5NvdWyNPinI+Tt6Vtn+0wqBE3bt0dN8dFbhNE8t985gnX7TjQZvdt1beS/R8rC0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211001>

On 12/02/2012 02:48 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 11/29/2012 10:30 PM, Junio C Hamano wrote:
>>
>>>> A side effect of this change is that the memory for each message is
>>>> freed after it is used rather than leaked, though that detail is
>>>> unimportant given that imap-send is a top-level command.
>>>>
>>>> --
>>>
>>> ?
>>
>> If by "?" you are wondering where the memory leak was, it was:
> 
> No, I was wondering if you meant to say "---" to mark te remainder
> of what you wrote does not exactly belong to the log message.

Oh.  Yes, that was my intention.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
