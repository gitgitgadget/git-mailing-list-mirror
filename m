From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/19] refs.c: pass **transaction to commit and have
 it clear the pointer
Date: Wed, 30 Apr 2014 16:20:12 +0200
Message-ID: <5361069C.1020108@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>	<1398442494-23438-20-git-send-email-sahlberg@google.com>	<535B0C6F.509@alum.mit.edu>	<CAL=YDWkSdiUd-6A60ncGaDrFV2pc5WtRMv8iCSHHqFLkKH=pfw@mail.gmail.com>	<535F6FFD.90004@alum.mit.edu> <CAL=YDWmrWT_N8k19t86tfHoTNSbpKh6qRSh-XMUvO9u4fdGk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfVN3-0006EO-3i
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933913AbaD3OUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 10:20:17 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53919 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933820AbaD3OUP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2014 10:20:15 -0400
X-AuditID: 1207440e-f79c76d000003e2c-a3-5361069f245c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E9.F9.15916.F9601635; Wed, 30 Apr 2014 10:20:15 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96793.dip0.t-ipconnect.de [79.201.103.147])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3UEKDC1024273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 30 Apr 2014 10:20:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <CAL=YDWmrWT_N8k19t86tfHoTNSbpKh6qRSh-XMUvO9u4fdGk=Q@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqDufLTHYYM4fLouuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfG1KfPWQv+sVTsX7eLpYGxkaWLkZNDQsBE4lrz
	JTYIW0ziwr31QDYXh5DAZUaJY8e62SGcC0wS7ZdegnXwCmhL7H86D8xmEVCV2N8zH6ybTUBX
	YlFPM1MXIweHqECQxJ+zihDlghInZz4BKxcR0JS42X+aCcRmFtCX+PTnAFi5sECSxPHjSSBh
	IYEDTBJX/nqD2JwCgRInjp9jBCmREBCX6GkMAjGZBdQl1s8TghgiL7H97RzmCYyCs5DsmoVQ
	NQtJ1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIUHLt4Oxfb3MIUYB
	DkYlHl6BrfHBQqyJZcWVuYcYJTmYlER59/9PCBbiS8pPqcxILM6ILyrNSS0+xCjBwawkwnv0
	H1CONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBG8aaGCwkWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rc+GJg7IKkeID21oO08xYXJOYCRSFaTzHqclxo
	WNHCJMSSl5+XKiXOywRSJABSlFGaB7cClqJeMYoDfSzM2w1SxQNMb3CTXgEtYQJaEuwbD7Kk
	JBEhJdXAGJSdkGUh5ueofpXTfZ2Xoe2PzJD/z9TfajLZbwxuKVjpcnru6tfaId2sSwOE7r9m
	v8tQ2crLMrdtieOaXUdYbiz1btvOkSm1c5Y+R0LyxGrFu7Kety9WHLctuduaE/Ig 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247715>

On 04/29/2014 08:58 PM, Ronnie Sahlberg wrote:
> On Tue, Apr 29, 2014 at 2:25 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> Unless we want to make ref_transaction objects reusable.  [...]
> ACK, but I don't think we need reusable transaction yet. Once the API
> is cleaned up
> it should be reasonably easy to add in the future if we see a need for it.
> Sounds reasonable to you ?

Yes, reusable transaction objects would be pretty straightforward to
retrofit, so I agree that there is no need to implement it now.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
