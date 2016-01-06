From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Wed, 6 Jan 2016 13:02:47 +0100
Message-ID: <568D0267.7080707@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
 <567AA2DF.1020408@alum.mit.edu> <1452014787.3892.40.camel@twopensource.com>
 <xmqqk2nnkio4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:03:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGmns-0006MO-D0
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 13:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcAFMCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 07:02:52 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55494 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094AbcAFMCu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2016 07:02:50 -0500
X-AuditID: 12074414-f794f6d000007852-7e-568d02692d48
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 37.44.30802.9620D865; Wed,  6 Jan 2016 07:02:49 -0500 (EST)
Received: from [192.168.69.130] (p4FC97A29.dip0.t-ipconnect.de [79.201.122.41])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u06C2lqE004296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 6 Jan 2016 07:02:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <xmqqk2nnkio4.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqJvJ1BtmcPGTpsX8TScYLbqudDNZ
	NPReYXZg9rh4SdljwfP77B6fN8kFMEdx2yQllpQFZ6bn6dslcGe837ODsWAZe0Xj+fwGxues
	XYycHBICJhKdjyYwQdhiEhfurWfrYuTiEBK4zCjx5fZGKOcck8ScFTfBOoQFgiU23NvKBmKL
	CERINLxqYYQoamWSaPnTzQySYBYQl1g39zw7iM0moCuxqKcZaAUHB6+AtsT/8/IgYRYBFYl7
	r7vBNosKhEjs3dnBAmLzCghKnJz5BMzmFLCWuLD1DyvESD2JHdd/QdnyEtvfzmGewCgwC0nL
	LCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREroiOxiPnJQ7
	xCjAwajEwysg0xMmxJpYVlyZe4hRkoNJSZR33cruMCG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vCHFQOW8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8soy9YUKCRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoEiNLwbGKkiKB2jvBQagdt7igsRcoChE6ylG
	XY4FP26vZRJiycvPS5US51UH2SEAUpRRmge3ApaoXjGKA30szOsJUsUDTHJwk14BLWECWsJQ
	1A2ypCQRISXVwOj8p3mWXcf6T2n94bMli7ZlS96M0j85c9PFFc0a051u2Co/fex/NOHL9wee
	SsXi7wS9cs2rp/qvXmEgeyg+5MHOkns2zOk6K+W0SrKFbCUn7pL+u0UlXNN/0neh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283434>

On 01/05/2016 07:03 PM, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
>> I'm working on the rest now, but wanted to comment on this first.  I
>> went ahead and made this change, but I'm not sure I like it.  In the
>> git codebase, the concept will continue to be called "backend"; there
>> are already-accepted patches using that terminology.  Having two
>> separate names for the same thing seems confusing to me.
> 
> We have the option to update whatever "are already-accepted" [*1*].
> That would allow us to uniformly call it "ref storage", if we wanted
> to.

...whereas whatever we name the option, we have to live with forever
because it is user-facing. It's more important to get the option name
correct (though I agree that it would be nice for the nomenclature used
in the code to be reminiscent of the option name).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
