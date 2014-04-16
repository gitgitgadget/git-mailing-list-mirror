From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 18/25] struct lock_file: declare some fields volatile
Date: Wed, 16 Apr 2014 17:36:14 +0200
Message-ID: <534EA36E.1030208@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu> <1397483695-10888-19-git-send-email-mhagger@alum.mit.edu> <534CD7D2.4060005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torst?= =?ISO-8859-15?Q?en_B=F6gershausen?= 
	<tboegi@web.de>, Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 17:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaRsu-0000H2-2V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 17:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161761AbaDPPgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 11:36:19 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47252 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161645AbaDPPgS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 11:36:18 -0400
X-AuditID: 12074414-f79d96d000002d2b-25-534ea371bfea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 95.A2.11563.173AE435; Wed, 16 Apr 2014 11:36:17 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9722C.dip0.t-ipconnect.de [79.201.114.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3GFaEic017967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Apr 2014 11:36:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <534CD7D2.4060005@viscovery.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqFu42C/Y4MYPFYuuK91MFg29V5gt
	Vv6ssfjR0sNsceZNI6NFZ8dXRgc2j2e9exg9Ll5S9lj8wMvj8yY5j7v/dzJ53H62jSWALYrb
	JimxpCw4Mz1P3y6BO+Pdt2+MBZcFKnrenGNqYFzP28XIySEhYCJx7/5tJghbTOLCvfVsXYxc
	HEIClxklXneeZoFwzjNJ7Oi/BFbFK6At0XlpKjOIzSKgKnFn9jl2EJtNQFdiUU8zUA0Hh6hA
	kMSfs4oQ5YISJ2c+YQGxRQR8JH6+bwZrZRbYwyjxcrMSSLkwULx/Th3EqvmMEv1nPjCC1HCC
	jOx8xQZSIyEgLtHTGATRqivxo2klG4QtL7H97RzmCYyCs5Bsm4WkbBaSsgWMzKsY5RJzSnN1
	cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQiJBZAfjkZNyhxgFOBiVeHhXVPkGC7EmlhVX
	5h5ilORgUhLlFVnkFyzEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNdyGlCONyWxsiq1KB8mJc3B
	oiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCNxtkqGBRanpqRVpmTglCmomDE2Q4l5RIcWpe
	SmpRYmlJRjwofuOLgREMkuIB2rsRpJ23uCAxFygK0XqKUZfjQsOKFiYhlrz8vFQpcd5kkCIB
	kKKM0jy4FbC094pRHOhjYd4akCoeYMqEm/QKaAkT0JJD4b4gS0oSEVJSDYxlrgJfC5aaVH8I
	2fi1xOj1k8v6610LOBmMlszZXMQr3DjzV3Bb6p7wup/TFgnqN54X+ahVsaKnQbHo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246338>

On 04/15/2014 08:55 AM, Johannes Sixt wrote:
> Am 4/14/2014 15:54, schrieb Michael Haggerty:
>> The function remove_lock_file_on_signal() is used as a signal handler.
>> It is not realistic to make the signal handler conform strictly to the
>> C standard, which is very restrictive about what a signal handler is
>> allowed to do.  But let's increase the likelihood that it will work:
>>
>> The lock_file_list global variable and several fields from struct
>> lock_file are used by the signal handler.  Declare those values
>> "volatile" to increase the chance that the signal handler will see a
>> valid object state.
> 
> Yes, it's important that the signal handler sees a valid object state, and
> "volatile" can help here. But I think the reason why it helps is not
> obvious, and it should be mentioned in the commit message:
> 
> It is not so much that "volatile" forces the compiler to lay down each
> access of the variable coded in C in the assembly code, but more
> importantly, that "volatile" disallows any re-ordering of these accesses.
> Then:
> 
> - 'lock->active = 1' must be the last assignment during setup
> 
> - 'lock->active = 0' must be the first assignment during tear-down.
> 
> - Ideally, all members of struct lock_file should be "volatile".
> 
> The last point is important because the compiler is allowed to re-order
> accesses to non-"volatile" variables across "volatile" accesses. I say
> "ideally" because if filename were defined "volatile filename[PATH_MAX]",
> strcpy() could not be used anymore. OTOH, it is unlikely that a compiler
> re-orders a strcpy() call across other expressions, and we can get away
> without "volatile" in the "filename" case in practice.

Thanks for the clarification.  I will edit the commit message to better
explain the rationale.

>> Suggested-by: Johannes Sixt <j.sixt@viscovery.net>
> 
> Not a big deal, but just in case you re-roll again and you do not forget:
> 
>   Johannes Sixt <j6t@kdbg.org>
> 
> is preferred.

ACK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
