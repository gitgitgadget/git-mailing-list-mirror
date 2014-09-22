From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 09/35] lockfile.c: document the various states of lock_file
 objects
Date: Mon, 22 Sep 2014 17:20:45 +0200
Message-ID: <54203E4D.7030800@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-10-git-send-email-mhagger@alum.mit.edu> <20140916210317.GJ29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:27:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW5Wt-0001OB-MB
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 17:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbaIVP1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 11:27:51 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46906 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753905AbaIVP1u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2014 11:27:50 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Sep 2014 11:27:50 EDT
X-AuditID: 1207440d-f797f6d000000a4a-d5-54203e50d73e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id EF.A9.02634.05E30245; Mon, 22 Sep 2014 11:20:48 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB23E6.dip0.t-ipconnect.de [93.219.35.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8MFKjcb026888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 22 Sep 2014 11:20:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916210317.GJ29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsUixO6iqBtgpxBisHCDgkXXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBnzF7Wzl6wnrvi8/pLbA2MXzm6GDk5JARMJF7+/coE
	YYtJXLi3ng3EFhK4zCgxdS1QDReQfZ5JYtbKw+wgCV4BbYl7XXcZQWwWAVWJI99WMoPYbAK6
	Eot6msEGiQoESHzofMAIUS8ocXLmExYQW0RAQ+L5p29sIEOZBT4wSiy+NZsVJCEsECPR0XSL
	GWLbIkaJ1zeagTo4ODgFDCT63wuC1DALqEv8mXeJGcKWl2jeOpt5AqPALCQ7ZiEpm4WkbAEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkEjg3cH4f53MIUYBDkYlHt4F
	TfIhQqyJZcWVuYcYJTmYlER575sqhAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2SBsrxpiRW
	VqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4m2yBGgWLUtNTK9Iyc0oQ0kwc
	nCDDuaREilPzUlKLEktLMuJBsRpfDIxWkBQP0N44kHbe4oLEXKAoROspRmOOSRvf9zJxrOv8
	1s8kxJKXn5cqJc673waoVACkNKM0D24RLAW+YhQH+luYdxfIQB5g+oSb9wpoFRPQqvvH5UFW
	lSQipKQaGJXkDR7HrLv2d7W3E88yl//8azh5T2iWmG1Q++ddl8l4QqtLa0/Q2Qix 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257366>

On 09/16/2014 11:03 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -4,6 +4,63 @@
>>  #include "cache.h"
>>  #include "sigchain.h"
>>
>> +/*
>> + * File write-locks as used by Git.
>> + *
>> + * When a file at $FILENAME needs to be written, it is done as
>> + * follows:
> 
> This overlaps a lot with the API doc, which makes me worry a little
> about it going out of date.  Would improving the API doc help, or if
> aspects are especially relevant here, is there a way to summarize them
> more quickly to avoid some of the redundancy?
> 
> [...]
>> + * A lock_file object can be in several states:
> 
> Would it make sense for this information to go near the definition of
> 'struct lock_file'?  That's where I'd start if I were looking for
> information on what states a lock_file can be in.

I agree with your point about overlap. I will split the documentation
into two parts with less redundancy:

* Documentation/technical/api-lockfile.txt: How to use the API.

* lockfile.{c,h}: Internal implementation details.

I think the implementation details would get lost among the thousand
things in cache.h. So instead, I will add a commit on top of the patch
series that splits out a lockfile.h header file (which I think is a good
idea anyway), and moves the internal documentation there. Sound good?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
