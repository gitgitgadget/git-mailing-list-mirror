From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Refactoring hardcoded SHA-1 constants
Date: Sat, 19 Apr 2014 02:06:27 +0200
Message-ID: <5351BE03.2070604@alum.mit.edu>
References: <20140418221841.GC57656@vauxhall.crustytoothpaste.net> <20140418224049.GA15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:07:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbIoI-0003wg-EV
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 02:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbaDSAGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 20:06:32 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51436 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779AbaDSAGa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 20:06:30 -0400
X-AuditID: 12074412-f79d46d000002e58-a1-5351be05b5ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 32.F7.11864.50EB1535; Fri, 18 Apr 2014 20:06:29 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9714E.dip0.t-ipconnect.de [79.201.113.78])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3J06Rrh005533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 18 Apr 2014 20:06:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140418224049.GA15516@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqMu6LzDY4NkKI4uuK91MFm9vLmG0
	aJv5g8mB2WP5zb9MHjtn3WX3+LxJLoA5itsmKbGkLDgzPU/fLoE7o2XBV6aCKVwVN58cY2lg
	7OHoYuTkkBAwkbj/aRIThC0mceHeerYuRi4OIYHLjBIzf3cyQzjnmSR+zPzBAlLFK6AtcXve
	B7AOFgFVie5HtxhBbDYBXYlFPc1AcQ4OUYEgiT9nFSHKBSVOznwC1ioikCLxct5pZpASZgFx
	if5/LCCmsICRxPwjoiAVQgJpEusX3WEFsTkFDCSu7r4EViIBVN3TGAQSZhbQkXjX94AZwpaX
	2P52DvMERsFZSHbNQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSml
	mxgh4Sy0g3H9SblDjAIcjEo8vBsCAoOFWBPLiitzDzFKcjApifIeWgsU4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMJbtAEox5uSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wZu1B6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhS78cXA6AVJ8QDtnQvSzltc
	kJgLFIVoPcWoy3GhYUULkxBLXn5eqpQ4LzNIkQBIUUZpHtwKWPJ6xSgO9LEwbwVIFQ8w8cFN
	egW0hAloyd8zASBLShIRUlINjHs+H2yc7SlpI9S1f5+LrLVI3G79/aszq2ZOYnHdbLvIOHSS
	W3B71Zzl+3RKF1S8+hpUEG65IT0k+ebSyrzXnnwpdr0zStOaVh/TdNX/8SK+qjLv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246491>

> brian m. carlson wrote:
>> I'd like to introduce a set of preprocessor constants that we'd use
>> instead of hard-coded 20s and 40s everywhere.

I agree that it would help code clarity to have symbolic constants for
these numbers.

On 04/19/2014 12:40 AM, Jonathan Nieder wrote:
> Lukewarm on that.  It's hard to do consistently and unless they're
> named well it can be harder to know what something like
> BINARY_OBJECT_NAME_LENGTH means than plain '20' when first reading.

OK, so let's see if we can name them well.  (Though I think if the names
come into wide use then we'll get familiar with them quickly.)

libgit2 seems to use the name "oid" (for "object ID") where we tend to
use "sha1" or "name".  That might be a good convention for us to move
towards.

Their constants are called GIT_OID_RAWSZ (== 20) and GIT_OID_HEXSZ (==
40).  They don't exactly roll off the tongue, I'll admit.

We wouldn't need a "GIT_" prefix, I think, since our code is not meant
to be used as a library.

Let the brainstorming (and bikeshedding) begin!

1. GIT_OID_RAWSZ / GIT_OID_HEXSZ

2. OID_RAWSZ / OID_HEXSZ

3. OID_BINARY_LEN / OID_ASCII_LEN

4. BINARY_OID_LEN / ASCII_OID_LEN

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
