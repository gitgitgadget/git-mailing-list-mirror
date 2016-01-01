From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Fix "inside work tree" detection on case-insensitive
 filesystems
Date: Fri, 1 Jan 2016 17:24:13 +0100
Message-ID: <5686A82D.6020105@alum.mit.edu>
References: <ac9733a6b922572ec10f09f89e07cde37ba43f13.1443456630.git.johannes.schindelin@gmx.de>
 <56829D08.1060107@alum.mit.edu>
 <alpine.DEB.2.20.1601011554240.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 01 17:32:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF2cX-0006ge-So
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 17:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbcAAQb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 11:31:28 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:42840 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751718AbcAAQb0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jan 2016 11:31:26 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jan 2016 11:31:26 EST
X-AuditID: 12074412-f79a76d000007c8b-65-5686a830c1ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A6.27.31883.038A6865; Fri,  1 Jan 2016 11:24:16 -0500 (EST)
Received: from [192.168.69.130] (p4FC97A93.dip0.t-ipconnect.de [79.201.122.147])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u01GOEZO024504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 1 Jan 2016 11:24:15 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <alpine.DEB.2.20.1601011554240.14434@virtualbox>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqGuwoi3M4EaboEXXlW4mi4beK8wW
	/cu72ByYPT58jPO4eEnZ4/MmuQDmKG6bpMSSsuDM9Dx9uwTujPurtjEXzJCq2HPnNEsDY4No
	FyMnh4SAicSNpauZIWwxiQv31rN1MXJxCAlcZpSYce0nO4RznkliwuJ7jCBVwgLhEocnP2AD
	sUWAuht3NkB1bGWU2PnsJQtIglnAWmLZ6WdgNpuArsSinmYmiBVyEr3dk8DivALaEmvWzQIb
	xCKgIvGo+SOYLSoQIrF3ZwdUjaDEyZlPwGxOAVuJF1svQ83Xk9hx/RcrhC0v0bx1NvMERsFZ
	SFpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQoBbawbj+
	pNwhRgEORiUe3hndrWFCrIllxZW5hxglOZiURHkfVAOF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifBGeAPleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZDU4OAQmXl6zj1GKJS8/
	L1VJgrdheVuYkGBRanpqRVpmTglCKRMHJ8giLimR4tS8lNSixNKSjHhQdMcXA+MbJMUDdEMG
	SDtvcUFiLlAUovUUo6KUOG8qSEIAJJFRmgc3FpbCXjGKA30szOsBUsUDTH9w3a+ABjMBDf7R
	1QwyuCQRISXVwKht++xb2eGcQ9FpLLOyLsz0+jAlLGTCiXsftuz+4B13/m2QbfvExHmPBS5m
	eSZX3V2x5fGmpXkPOcRyKqbzK6UIC7Pc/MJz9OC1ZF0ZkY0H1D8UhZevm3+8MWaO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283258>

On 01/01/2016 03:58 PM, Johannes Schindelin wrote:
> Hi Michael,
> 
> On Tue, 29 Dec 2015, Michael Haggerty wrote:
> 
>> On 09/28/2015 06:12 PM, Johannes Schindelin wrote:
>>> Git has a config variable to indicate that it is operating on a file
>>> system that is case-insensitive: core.ignoreCase. But the
>>> `dir_inside_of()` function did not respect that. As a result, if Git's
>>> idea of the current working directory disagreed in its upper/lower case
>>> with the `GIT_WORK_TREE` variable (e.g. `C:\test` vs `c:\test`) the
>>> user would be greeted by the error message
>>>
>>> 	fatal: git-am cannot be used without a working tree.
>>>
>>> when trying to run a rebase.
>>>
>>> This fixes https://github.com/git-for-windows/git/issues/402 (reported by
>>> Daniel Harding).
>>
>> I was just going through the 2.7 release notes when I saw this patch.
> 
> Thanks for your diligence!
> 
>> My understanding was that many of the case-insensitive filesystems also
>> support Unicode. Is the byte-oriented code in this patch adequate? I
>> would have thought it necessary to use a Unicode-aware algorithm here,
>> that knows:
>>
>> * that bytes != characters
> 
> I am not sure that we can in general assume that the file name is UTF-8...
> Or does Git always assume that?

No, it does not. I would say that Git resolutely refuses to take a stand
on whether/what encoding is used for filenames within its object database.

But as far as I understand, here we have a slightly different situation:
we have a string from an environment variable, and we have the current
working directory. Neither of these things are paths from the Git ODB,
and we don't have to take a stand about whether two paths from the ODB
are equivalent.

>> * how to do a case-insensitive comparison of strings that include
>> non-ASCII characters
> 
> I was worrying about that, too, but decided to punt on it when I realized
> that no other case-insensitive code in Git bothers about those characters.
> 
>> * (possibly) insensitivity to NFC vs. NFD vs. non-normalized forms
> 
> Whoa... I really would like to stay away from that collection of
> potholes...
> 
>> I suppose that such OSs have built-in functions for deciding whether two
>> paths are equivalent. Possibly these could be used?
> 
> We could, in theory, try to do that, but what about the OSes that do *not*
> have those functions? We would need our own fallback anyway, so why not
> guarantee consistency and use our own functions only?

I don't see why consistency across OSes is an issue here. Whenever we
are talking about paths on a particular filesystem, it is the
filesystem's idea of equivalence that is relevant.

Suppose we had a wrapper `filesystem_paths_equivalent(path1, path2)`. If
an OS provides a function that can be used for such a comparison, we can
use that. If not, but `ignore_case` is set, we can use your
`cmp_icase()`-based function. Otherwise, the default implementation
would be `!strcmp()`.

I don't think it would be worth going to all this trouble for this one
callsite (at least under my assumption that this has no security
implications). But I would have expected this issue to come up in enough
places that such an abstraction would be helpful.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
