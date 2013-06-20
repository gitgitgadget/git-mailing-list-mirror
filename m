From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/12] Fix some reference-related races
Date: Thu, 20 Jun 2013 11:09:49 +0200
Message-ID: <51C2C6DD.90107@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu> <20130619185645.GB23647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 11:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpasU-0003tL-3g
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab3FTJJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 05:09:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59051 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755509Ab3FTJJy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 05:09:54 -0400
X-AuditID: 12074412-b7f656d00000102f-df-51c2c6e12179
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CB.BC.04143.1E6C2C15; Thu, 20 Jun 2013 05:09:53 -0400 (EDT)
Received: from [192.168.69.140] (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K99n5O002877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 05:09:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130619185645.GB23647@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqPvw2KFAg9lbxSy6rnQzWTT0XmG2
	mHd3F5PFj5YeZovd0xawObB6XHr5nc3jWe8eRo+Ll5Q9Hk88werxeZNcAGsUt01SYklZcGZ6
	nr5dAnfGtpc9zAUNohW3vpxhbGD8J9DFyMkhIWAi8X3RRlYIW0ziwr31bF2MXBxCApcZJQ4t
	OsUK4Zxlkug90MEIUsUroCnxfMNlsA4WAVWJV7/2gNlsAroSi3qamUBsUYEwiffLprJC1AtK
	nJz5hAXEFhGQlfh+eCMjyFBmgUmMErO33WYGSQgL2Ens+DQZrEhIoFhiw/ILYDangLVEy5d2
	oBoOoAZ1ifXzhEDCzALyEtvfzmGewCgwC8mKWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFuc
	nJiXl1qka6aXm1mil5pSuokREuJCOxjXn5Q7xCjAwajEw6tx+WCgEGtiWXFl7iFGSQ4mJVFe
	tiOHAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8KbOAcrxpiRWVqUW5cOkpDlYlMR5fy5W9xMS
	SE8sSc1OTS1ILYLJynBwKEnwbj0K1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEP
	itT4YmCsgqR4gPaCtfMWFyTmAkUhWk8x6nIc+LHlPaMQS15+XqqUOO9BkCIBkKKM0jy4FbCE
	9opRHOhjYd4lIFU8wGQIN+kV0BImoCV7VoMtKUlESEk1MO56En//Vu6zc4Y1+7Vdtj1xWzI/
	u3C92Msevus+zrGMa4OCLt9rDtsbfzH9bGGtTQD3e9GpvA28zPnSPh6Tb4o/W6I0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228467>

On 06/19/2013 08:56 PM, Jeff King wrote:
> On Wed, Jun 19, 2013 at 09:51:21AM +0200, Michael Haggerty wrote:
> 
>> Re-roll of mh/ref-races.  Thanks to Peff, Junio, and Ramsay for
>> reviewing v1.
> 
> Thanks. I just read through them again. Everything looks good to me.
> 
> Patches 10 and 11 are missing my signoff, but obviously:
> 
>   Signed-off-by: Jeff King <peff@peff.net>
> 
>> The last patch is still optional--it avoids a little bit of work when
>> rewriting the packed-refs file, but relies on the stat-based freshness
>> check not giving a false negative.
> 
> I don't have a real problem with it, but given the cygwin confusions
> that Ramsay mentioned, maybe it is better to hold back on it for now? It
> sounds like the cygwin problems go the other way (false positives
> instead of false negatives).

I just realized that there is another long-standing problem in
loose/packed refs handling:

Suppose there is a loose reference for which an old version is still
present in the packed-refs file.  If the reference is deleted:

1. delete_ref() gets a lock on the loose reference file

2. delete_ref() deletes the loose reference file while retaining the lock

3. delete_ref() calls repack_without_ref()

4. repack_without_ref() tries to acquire a lock on the packed-refs file
to delete the packed version of the reference.

If the packed-refs file is already locked by another process (and there
is no reason why that cannot be, and there is only one attempt to
acquire the lock), then repack_without_ref() emits an error and returns
with an error code.  delete_ref() passes the error along, but doesn't
restore the loose ref.

The net result is that an old version of the ref (namely the one in the
loose refs file) has been revived.  That version might even point at an
object that has already been garbage collected.

This problem is similar to race conditions that have been discussed
earlier, but this problem has nothing to do with the freshness/staleness
of the packed-refs file WRT to the loose reference; it only depends on
the packed-refs file being locked by another process at an inopportune time.

I think this problem would also be fixed by the locking scheme that I
proposed earlier [1]: to acquire and hold the packed-refs lock across
the modification of *both* files, and to rewrite the packed-refs file
*before* deleting the loose-refs file (because rewriting the packed-refs
file without the to-be-deleted reference is a logical NOP).

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/212131

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
