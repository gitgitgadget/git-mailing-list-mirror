From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/18] t1404: new tests of D/F conflicts within ref transactions
Date: Tue, 05 May 2015 17:27:16 +0200
Message-ID: <5548E154.7020506@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>	<1430483158-14349-2-git-send-email-mhagger@alum.mit.edu> <CAPig+cQabRiiMhNyYJM4_bZsQ4OTfrSbJ51XAido3V49baLhHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypgp0-00067u-2v
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993860AbbEEQGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 12:06:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47020 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993386AbbEEP1V (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 11:27:21 -0400
X-AuditID: 1207440e-f79bc6d000000c43-ec-5548e1573f07
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B0.36.03139.751E8455; Tue,  5 May 2015 11:27:19 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97BF5.dip0.t-ipconnect.de [79.201.123.245])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t45FRGix022792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 5 May 2015 11:27:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAPig+cQabRiiMhNyYJM4_bZsQ4OTfrSbJ51XAido3V49baLhHA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqBv+0CPU4FULu0XXlW4mi4beK8wW
	P1p6mC02b25nsTjzppHRgdVjwaZSj2e9exg9Ll5S9lj8wMvj8ya5ANYobpukxJKy4Mz0PH27
	BO6M39efMBW85ai4vqebuYFxOXsXIyeHhICJxKljO5ghbDGJC/fWs3UxcnEICVxmlLj7cCMr
	hHOeSeJR31ZGkCpeAW2JhUt+gXWwCKhK7DgwD2wSm4CuxKKeZiYQW1QgSKL12lSoekGJkzOf
	sIDYIkC9HzZsYgQZyizQxyhxuekuWIOwQIjEzLm3mCC2HWKUWHTuEFgHp0CgxJ7GdWwgNrOA
	usSfeZeYIWx5ie1v5zBPYBSYhWTJLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qk
	a6yXm1mil5pSuokREuR8Oxjb18scYhTgYFTi4Y3g8ggVYk0sK67MPcQoycGkJMrLeAsoxJeU
	n1KZkVicEV9UmpNaDHQyB7OSCO+eC0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC
	1CKYrAwHh5IEr+ADoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4ULzGFwMjFiTF
	A7SXHaSdt7ggMRcoCtF6ilFRSpz3832ghABIIqM0D24sLHW9YhQH+lKY9wtIFQ8w7cF1vwIa
	zAQ0eFUh2OCSRISUVAMjZ1PahE1z2s/FdFcHVFoutDhzPthrnlz7/y29bhNOXNX6rKnss880
	PNtw/Z2Q9y38OdemHlwqmOJk67be/IiEg7XS1BviSp+ufwySMAvvjQk/sGfD/OyY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268403>

On 05/05/2015 07:12 AM, Eric Sunshine wrote:
> On Fri, May 1, 2015 at 8:25 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Add some tests of D/F conflicts (as in, the type of directory vs. file
>> conflict that exists between references "refs/foo" and "refs/foo/bar")
>> in the context of reference transactions.
>> [...]
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  t/t1404-update-ref-df-conflicts.sh | 107 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100755 t/t1404-update-ref-df-conflicts.sh
>>
>> diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
>> new file mode 100755
>> index 0000000..2fc2ac6
>> --- /dev/null
>> +++ b/t/t1404-update-ref-df-conflicts.sh
>> @@ -0,0 +1,107 @@
>> +#!/bin/sh
>> +
>> +test_description='Test git update-ref with D/F conflicts'
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +
>> +       git commit --allow-empty -m Initial
> 
> Broken &&-chain.

Thanks, Eric. I'll fix it in v2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
