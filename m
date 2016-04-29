From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 15:55:00 +0200
Message-ID: <572367B4.4050207@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
 <57230F71.2020401@alum.mit.edu>
 <xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
 <57233E19.4000200@alum.mit.edu>
 <20160429121228.GA27952@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 15:55:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw8tU-0005ul-KP
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 15:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbcD2Nzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 09:55:40 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59141 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753773AbcD2NzR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 09:55:17 -0400
X-AuditID: 1207440c-c53ff70000000b85-2e-572367b7b287
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D5.BF.02949.7B763275; Fri, 29 Apr 2016 09:55:03 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3TDt0NW029926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 09:55:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160429121228.GA27952@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqLs9XTnc4OdJTYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrR3YPHbOusvu8ax3D6PHxUvKHvuXbmPzWPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZnw/sZS24Il/xae1ktgbGeZJdjJwcEgImEptnrWfqYuTiEBLYyijR
	tew0K4Rznkli5uZDjCBVwgI2Env6rrCD2CICshLfD29khCi6zyRx694lsA5mgY+MEmdX9rKB
	VLEJ6Eos6mkGmsvBwSugLfHrrz9ImEVAVWLSo79gQ0UFQiS2rfvGCmLzCghKnJz5hAWknFPA
	WmLphmiQMLOAusSfeZeYIWx5ie1v5zBPYOSfhaRjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdTLzSzRS00p3cQICW+eHYzf1skcYhTgYFTi4Z1xTylciDWxrLgy9xCjJAeT
	kijvVV3lcCG+pPyUyozE4oz4otKc1OJDjBIczEoivNVpQDnelMTKqtSifJiUNAeLkjiv6hJ1
	PyGB9MSS1OzU1ILUIpisDAeHkgRvBkijYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlG
	PCgm44uBUQmS4gHaawu2t7ggMRcoCtF6ilFRSpz3bCpQQgAkkVGaBzcWlrReMYoDfSnMuxSk
	nQeY8OC6XwENZgIaLLBJEWRwSSJCSqqBsX3qm70/hT7Hyrv8vDDHW65x1tM8W6brh0576F3d
	8opnZqpCrMJmv8Q5vis6TP0tlylrO95jqnnS8obzUKRTmNm7dd9/JbyVTvjGu/te 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292998>

On 04/29/2016 02:12 PM, Jeff King wrote:
> On Fri, Apr 29, 2016 at 12:57:29PM +0200, Michael Haggerty wrote:
> 
>> Remember, we're talking about rename_ref() only, not reference deletion
>> in general. rename_ref() is not very robust anyway--it doesn't happen in
>> a single transaction, and it is vulnerable to being defeated by
>> simultaneous reference updates by other processes. It *does* wrap the
>> deletion of newrefname in a transaction; the only question is whether an
>> old_sha1 is supplied to that transaction.
>>
>> So, suppose that newrefname starts at value A, and there are two updates
>> running simultaneously:
>>
>> 1. An update of reference newrefname from A -> B
>>
>> 2. A rename of reference oldrefname to newrefname, which includes
>>    a. read_ref_full("newrefname") and
>>    b. delete_ref("newrefname").
> 
> I wondered at first if you meant "oldrefname" in 2b. That is, a rename
> would involve writing to "newrefname" and then deleting "oldrefname",
> and not doing the old_sha1 and normal locking on the deletion of
> oldrefname would be bad (in case somebody else updated it while we were
> operating).
> 
> But reading the patch again, that's not what's going on. You're talking
> just about the case where we force-overwrite an existing newrefname, and
> delete it first to do so. But what I don't understand is:

It's beyond the ambition of this patch to fix this old rename_ref()
code, but...

>   1. Why do we read_ref_full() at all? Since it is not done under lock
>      anyway, it is useless for helping with race conditions, and I think
>      that is what you are arguing (that we should just be deleting
>      regardless). But then why not just call delete_ref(), and handle
>      the ENOENT case as a noop (which closes another race if somebody
>      deletes it between your 2a and 2b).

I thought about that too, and agree it would be an improvement. But it's
not quite so trivial. The ENOENT doesn't make it out of delete_ref()
(which does a full-fledged ref_transaction internally). The error is
only reported via "strbuf *err".

>   2. Why delete it at all? The point is to overwrite, so I guess it is
>      trying to make room. But we could just rename the loose ref file
>      and reflog overtop the old, couldn't we?
>
> Or am I totally misreading the purpose of this code?

I wouldn't want to just rename the files, because (1) I think it is
better to use the existing ref_transaction code, and (2) that wouldn't
work if there is a D/F conflict between the old and new reference names,
which the existing code handles (though honestly I'm skeptical that it
comes up a lot).

It would be more plausible to use ref_transaction_update() to write
oldrefname's *value* on top of newrefname without actually moving the
file. oldrefname could even be deleted in the same transaction, if you
were willing to stop supporting old/new refnames that D/F conflict with
each other. But we also want to move the reflog, and that should be done
while the newrefname lock and (contrary to the current code) also the
oldrefname lock are held. There's currently no way to slip an arbitrary
action like that into the middle of a transaction.

If I had lots of time and interest to work on this, I think the best
approach would be to add a ref_transaction_rename(), which takes an old
and a new reference name as arguments, and adds a whole rename operation
(including of the reflog) to a transaction. This could probably be
implemented by adding one ref_update() and one ref_delete(), and using
the parent_update pointer that is introduced later to link the two so
that ref_transaction_commit() knows to move the reflog too.

If you were willing to punt on D/F conflicts, you would be done. If not,
then it would be better to teach ref_transaction_commit() to deal with
D/F conflicts in the general case rather than using special-purpose code
in rename_ref().

Then rename_ref() could be omitted from the vtable entirely.

Michael
