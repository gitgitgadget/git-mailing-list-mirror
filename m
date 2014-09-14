From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 11/32] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Sun, 14 Sep 2014 08:38:01 +0200
Message-ID: <541537C9.1080304@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <1409989846-22401-12-git-send-email-mhagger@alum.mit.edu> <5413F51E.3060600@kdbg.org> <5415353E.8060907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Torsten_B=F6ger?= =?ISO-8859-15?Q?shausen?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 14 08:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT3Yt-0006d8-9r
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 08:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbaINGpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 02:45:09 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55382 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752365AbaINGpI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2014 02:45:08 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Sep 2014 02:45:08 EDT
X-AuditID: 1207440c-f79036d000005e77-11-541537cb24da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D8.33.24183.BC735145; Sun, 14 Sep 2014 02:38:03 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2CD3.dip0.t-ipconnect.de [93.219.44.211])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8E6c14U008905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 14 Sep 2014 02:38:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <5415353E.8060907@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqHvaXDTE4M8aK4uuK91MFg29V5gt
	nsy9y2zxo6WH2aKz4yujA6vHw1dd7B7Pevcwely8pOzxeZOcx+1n21gCWKO4bZISS8qCM9Pz
	9O0SuDO2XdzOWrCYo+LCjDVsDYyX2LoYOTkkBEwknk4+ygJhi0lcuLceKM7FISRwmVGi5dNe
	ZgjnPJPEl64tYB28AtoSk2fMZQexWQRUJQ787wPrZhPQlVjU08wEYosKBEh86HzACFEvKHFy
	5hOwGhEBBYkD+xayggxlFtjOKHFv0iSwhLBAosTeqeugVu9ilHjwr5sZJMEpoCOxZfZVoG0c
	QB26Em1rZEDCzALyEtvfzmGewCgwC8mOWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiX
	l1qka6iXm1mil5pSuokREuQ8Oxi/rZM5xCjAwajEwxtwXjhEiDWxrLgy9xCjJAeTkihvq6po
	iBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3vcPRUKEeFMSK6tSi/JhUtIcLErivKpL1P2EBNIT
	S1KzU1MLUotgsjIcHEoSvP/MgIYKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I1
	vhgYrSApHqC9t0yB2nmLCxJzgaIQracYdTnWdX7rZxJiycvPS5US51UAJiUhAZCijNI8uBWw
	lPaKURzoY2He0yCX8ADTIdykV0BLmICWvJsjBLKkJBEhJdXAKLIhPfLnScfmY9y/ftnd195f
	01zAcUb445v1LGZtwRv92DXWm8qdLtxjInRNobr+fV3Z843nWesELU/9aH5pISB+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256996>

On 09/14/2014 08:27 AM, Michael Haggerty wrote:
> On 09/13/2014 09:41 AM, Johannes Sixt wrote:
>> Am 06.09.2014 um 09:50 schrieb Michael Haggerty:
>>> It's bad manners.  Especially since, if unlink_or_warn() failed, the
>>> memory wasn't restored to its original contents.
>>
>> I do not see how the old code did not restore the file name. Except for
>> this nit, the patch looks good.
> 
> Hmmmm, you're quite right. I thought I had found some circumstance in
> which unlink_or_warn() could fail to allocate memory and die() or
> something. But I can't find anything like that now.
> 
> I will remove that sentence from the commit message.

I half withdraw my withdrawal. It's true that the failure of
unlink_or_warn() wouldn't cause a problem. But a signal could arrive
while unlink_or_warn() is executing, in which case the signal handler
would see the wrong filename and try to delete the loose reference file,
leaving the lockfile behind.

I will clarify the log message.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
