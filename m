From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Thu, 14 Mar 2013 12:28:53 +0100
Message-ID: <5141B475.1000707@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu> <7vwqtb2ood.fsf@alter.siamese.dyndns.org> <20130313215800.GA23838@sigill.intra.peff.net> <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 12:29:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG6Lc-0002Dj-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 12:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab3CNL25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 07:28:57 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:65146 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754890Ab3CNL25 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 07:28:57 -0400
X-AuditID: 1207440f-b7f466d0000009dc-6e-5141b478e621
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 20.25.02524.874B1415; Thu, 14 Mar 2013 07:28:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2EBSs48026374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Mar 2013 07:28:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130314052448.GA2300@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqFuxxTHQ4O8lIYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Blrl09nKvgoX3F0+yr2BsYd
	kl2MnBwSAiYSz790s0DYYhIX7q1n62Lk4hASuMwo8WbLKhYI5ziTRPfNI8wgVbwC2hIrlz4A
	s1kEVCXW7ToA1s0moCuxqKeZCcQWFQiTeLlkBxtEvaDEyZlPwGpEBGQlvh/eyAhiMwtESZx/
	+R8sLiygJrF66nNGiGWXGCXeHrvJCpLgFLCS6N+6HKiIA6hBXWL9PCGIXnmJ7W/nME9gFJiF
	ZMUshKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJXf4djF3r
	ZQ4xCnAwKvHw7uhwCBRiTSwrrsw9xCjJwaQkypu2yTFQiC8pP6UyI7E4I76oNCe1+BCjBAez
	kgivpxdQjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwRu7GahRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtDQJp5y0uSMwFikK0nmLU
	5dj97tELRiGWvPy8VClxXnOQIgGQoozSPLgVsET1ilEc6GNhXh+QKh5gkoOb9ApoCRPQkvQc
	e5AlJYkIKakGxo0vQo3d//I6vNq9/z7/ssqIK39FAzjXRX6M+eYgUyCcFV582LGKvX1C8/Nl
	tlPaTqrnx2y4yLhTWE95z4apkT7PDaWZzBny459K2OgLL4xzqnze87Tr9f8FD7/G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218127>

On 03/14/2013 06:24 AM, Jeff King wrote:
> On Thu, Mar 14, 2013 at 05:41:58AM +0100, Michael Haggerty wrote:
> 
>> Here is analysis of our options as I see them:
>>
>> 1. Accept that tags outside of refs/tags are not reliably advertised in
>>    their peeled form.  Document this deficiency and either:
>>
>>    a. Don't even bother trying to peel refs outside of refs/tags (the
>>       status quo).
> 
> When you say "not reliably advertised" you mean from upload-pack, right?
> What about other callers? From my reading of peel_ref, anybody who calls
> it to get a packed ref may actually get a wrong answer. So this is not
> just about tag auto-following over fetch, but about other places, too
> (however, a quick grep does not make it look like this other places are
> all that commonly used).

Yes, this is a good point.  I didn't audit all of the callers to see
whether any of them need 100% reliability, but I guess I should:

upload-pack.c:763: in send_ref(): This is the caller that we have been
talking about.

builtin/pack-objects.c:559: in mark_tagged(): This function is only
called for references under refs/tags.

builtin/pack-objects.c:2035: in add_ref_tag(): peel_ref() is called only
for refnames under refs/tags.

builtin/describe.c:147: in get_name(): peel_ref() is called only for
refnames under refs/tags.

builtin/show-ref.c:81: in show_ref(): this is broken too, as I showed in
my original email.  This breakage was also introduced in 435c833.

Perhaps if peel_ref() *were* 100% reliable, we might be able to use it
to avoid object lookups in some other places.

> Another fun fact: upload-pack did not use peel_ref until recently
> (435c833, in v1.8.1). So while it is tempting to say "well, this was
> always broken, and nobody cared", it was not really; it is a fairly
> recent regression in 435c833.

I didn't realize that; thanks for pointing it out.  Although peel_ref()
itself has been broken since it was introduced, at least in the sense
that it gives wrong answers for tags outside of refs/tags, prior to
435c833 it appears to only have been used for refs/tags.

>> I think the best option would be 1b.  Even though there would never be a
>> guarantee that all peeled references are recorded and advertised
>> correctly, the behavior would asymptotically approach correctness as old
>> Git versions are retired, and the situations where it fails are probably
>> rare and no worse than the status quo.
> 
> Thanks for laying out the options. I think 1b or 2c are the only sane
> paths forward. With either option, a newer writer produces something
> that all implementations, old and new, should get right, and that is
> primarily what we care about.
> 
> So the only question is how much work we want to put into making sure
> the new reader handles the old writer correctly. Doing 2c is obviously
> more rigorous, and it is not that much work to add the fully-packed
> flag, but I kind of wonder if anybody even cares. We can just say "it's
> a bug fix; run `git pack-refs` again if you care" and call it a day
> (i.e., 1b).
> 
> I could go either way.

On 03/14/2013 06:32 AM, Jeff King wrote:
> [...]
> So it's really not that much code. The bigger question is whether we
> want to have to carry the "fully-peeled" tag forever, and how other
> implementations would treat it.

I agree that 2c is also an attractive option.  Its biggest advantage is
that it make peel_ref() reliable and therefore potentially usable for
other purposes.  And probably the effort of carrying forward the
"fully-peeled" tag is no more work than the alternative of carrying
forward the knowledge that peel_ref() is unreliable.

Your patch looks about right aside from its lack of comments :-).  I was
going to implement approximately the same thing in a patch series that I
am working on, but if you prefer then go ahead and submit your patch and
I will rebase my branch on top of it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
