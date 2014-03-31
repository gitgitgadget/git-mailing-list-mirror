From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 16/27] t1400: Test one mistake at a time
Date: Tue, 01 Apr 2014 00:32:53 +0200
Message-ID: <5339ED15.6040201@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-17-git-send-email-mhagger@alum.mit.edu> <xmqq38hy3umr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:33:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUklM-0003Qi-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbaCaWc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:32:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52246 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbaCaWc5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 18:32:57 -0400
X-AuditID: 1207440d-f79d86d0000043db-88-5339ed18d7d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D7.4B.17371.81DE9335; Mon, 31 Mar 2014 18:32:56 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VMWrs0017030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 18:32:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqq38hy3umr.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqCvx1jLYoO+SicXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4kdLD7PFx84FzA5sHjtn3WX3uPTyO5vHx2fL2T2e9e5h9Lh4Sdnj8ya5ALYo
	bpukxJKy4Mz0PH27BO6M3p4pLAVnOCsu/ClrYHzM3sXIySEhYCJxqOEXE4QtJnHh3nq2LkYu
	DiGBy4wS5xe3sUM4Z5kkLv7ZygpSxSugLXH30R9mEJtFQFVi4eVJYJPYBHQlFvU0g00SFQiS
	OLzhFFS9oMTJmU9YQGwRATWJiW2HWECGMgusZpRYOmUGG0hCWMBe4vDkFiaIbWsZJe7Ma2UE
	SXAKWEts2foVyOYAuk9coqcxCCTMLKAj8a7vATOELS+x/e0c5gmMgrOQ7JuFpGwWkrIFjMyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MULigXcH4/91MocYBTgYlXh4Lcot
	g4VYE8uKK3MPMUpyMCmJ8j58DBTiS8pPqcxILM6ILyrNSS0+xCjBwawkwhv7EijHm5JYWZVa
	lA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgtXoD1ChYlJqeWpGWmVOCkGbi4AQZ
	ziUlUpyal5JalFhakhEPiuH4YmAUg6R4gPZGgLTzFhck5gJFIVpPMepybNi2ppFJiCUvPy9V
	Spz31GugIgGQoozSPLgVsOT3ilEc6GNh3nKQUTzAxAk36RXQEiagJW5FZiBLShIRUlINjO2c
	1912mQQx/lw3a66ufuec496PO7dmH3sSNCH/awnnMdOuZ10/+TxtHNplOPrmX+qY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245561>

On 03/31/2014 11:50 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This case wants to test passing a bad refname to the "update" command.
>> But it also passes too few arguments to "update", which muddles the
>> situation: which error should be diagnosed?  So split this test into
>> two:
>>
>> * One that passes too few arguments to update
>>
>> * One that passes all three arguments to "update", but with a bad
>>   refname.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> t1400: Add a test of "update" with too few arguments
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> What's happening here?

That was a squashing accident, also pointed out by Brad [1].  The last
three lines should be deleted.  This and an error in a comment in patch
14/27 that was also pointed out by Brad are both fixed in my GitHub repo
[2].  I haven't sent the fixed version to the list, though; let me know
if I should.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/245205
[2] Branch "ref-transactions" at https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
