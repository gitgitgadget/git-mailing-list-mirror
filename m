From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 07/48] lockfile.c: make lock_file return a meaningful
 errno on failurei
Date: Tue, 08 Jul 2014 13:47:41 +0200
Message-ID: <53BBDA5D.7090608@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 13:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4TsJ-0007LM-0o
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 13:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbaGHLrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 07:47:47 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42248 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753322AbaGHLro (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 07:47:44 -0400
X-AuditID: 1207440f-f79156d000006a5c-41-53bbda5feb75
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 46.D7.27228.F5ADBB35; Tue,  8 Jul 2014 07:47:44 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68BlgTp028654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 07:47:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-8-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1E24tTvY4P55RouuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfG796LTAWPWCrebehgb2C8x9zFyMkhIWAi0b64
	G8oWk7hwbz1bFyMXh5DAZUaJgxv+s0A455kkFl9dyNTFyMHBK6At8bVHC8RkEVCV+HbJCaSX
	TUBXYlFPMxOILSoQJDH78zx2EJtXQFDi5MwnLCC2iICdxPpbC5lBWoUFEiUurLEBMYUEqiV2
	NJqCmJwCLhKHrguAmBIC4hI9jUEgfcwCOhLv+h4wQ9jyEtvfzmGewCgwC8n4WUjKZiEpW8DI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJDT5dzB2rZc5xCjAwajEw7vi
	4K5gIdbEsuLK3EOMkhxMSqK8R4/vDhbiS8pPqcxILM6ILyrNSS0+xCjBwawkwvvlFFCONyWx
	siq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTB63wTqFGwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFJ/xxcAIBUnxAO3lA2nnLS5IzAWKQrSeYlSUEud9eAMoIQCS
	yCjNgxsLSzivGMWBvhTmDQVp5wEmK7juV0CDmYAGf36/A2RwSSJCSqqBcfXxTVMm/eU/tDnl
	+zLb+RxWxtMmnF+1JlNSZK593faXSz36/x7ifXfy6uPNmT9PPZu5+MuFna0qIVtsLsxojqr1
	PhdSbp5UzDTPYLGQ/nqlkztSD/Csedt49/WMpOAp6Y9+KE+eGRrMsOpz7/8G3hnC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253012>

On 06/20/2014 04:42 PM, Ronnie Sahlberg wrote:
> Making errno when returning from lock_file() meaningful, which should
> fix
> 
>  * an existing almost-bug in lock_ref_sha1_basic where it assumes
>    errno==ENOENT is meaningful and could waste some work on retries
> 
>  * an existing bug in repack_without_refs where it prints
>    strerror(errno) and picks advice based on errno, despite errno
>    potentially being zero and potentially having been clobbered by
>    that point
> [...]

Typo in subject line:

s/failurei/failure/

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
