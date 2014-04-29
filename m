From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/19] refs.c: pass **transaction to commit and have
 it clear the pointer
Date: Tue, 29 Apr 2014 11:25:17 +0200
Message-ID: <535F6FFD.90004@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>	<1398442494-23438-20-git-send-email-sahlberg@google.com>	<535B0C6F.509@alum.mit.edu> <CAL=YDWkSdiUd-6A60ncGaDrFV2pc5WtRMv8iCSHHqFLkKH=pfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:25:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf4IB-00028T-2v
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbaD2JZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:25:23 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50017 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933232AbaD2JZU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 05:25:20 -0400
X-AuditID: 12074411-f79ab6d000002f0e-69-535f6fff0dd6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.E1.12046.FFF6F535; Tue, 29 Apr 2014 05:25:19 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96C32.dip0.t-ipconnect.de [79.201.108.50])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3T9PHTt013168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 29 Apr 2014 05:25:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <CAL=YDWkSdiUd-6A60ncGaDrFV2pc5WtRMv8iCSHHqFLkKH=pfw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqPs/Pz7Y4P0ufYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGpoXTWQv+yVS8/WnfwLhftIuRk0NCwERi6ud2
	NghbTOLCvfVANheHkMBlRokVGz6xQzjnmSS2XbjCDFLFK6ApMf/RSbAOFgFVib+fv4HZbAK6
	Eot6mpm6GDk4RAWCJP6cVYQoF5Q4OfMJC4gtAtR6s/80E4jNLKAv8enPAbByYYEkiePHkyBW
	3WWUePbiJdgqToFAiTWLjrOA1EgIiEv0NAaBmMwC6hLr5wlBTJGX2P52DvMERsFZSJbNQqia
	haRqASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQoBXcwTjjpNwhRgEO
	RiUe3o6YuGAh1sSy4srcQ4ySHExKorwG2fHBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4862A
	crwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCd5NwOgUEixKTU+tSMvM
	KUFIM3FwggznkhIpTs1LSS1KLC3JiAdFbnwxMHZBUjxAe6fmgewtLkjMBYpCtJ5i1OW40LCi
	hUmIJS8/L1VKnNcNpEgApCijNA9uBSxFvWIUB/pYmLcP5BIeYHqDm/QKaAkT0JJgX7AlJYkI
	KakGRpe8D6tXXYvacOlFbKb6reeH/+sFvbQLvj7vr6FEseSW9o6DTw/Udxmc9D+59OuydGXn
	+xF92p7qNSwmF4qzX+vdK7c8fPtnnqud8sxVvp8/e/5l+ehXWSL+koVhr5nf/E0S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247555>

On 04/28/2014 07:59 PM, Ronnie Sahlberg wrote:
> On Fri, Apr 25, 2014 at 6:31 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>>> Change ref_transaction_commit to take a pointer to a pointer for the
>>> transaction. This allows us to clear the transaction pointer from within
>>> ref_transaction_commit so that it becomes NULL in the caller.
>>>
>>> This makes transaction handling in the callers much nicer since instead of
>>> having to write horrible code like :
>>>       t = ref_transaction_begin();
>>>       if ((!t ||
>>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>>>                                  !!oldval)) ||
>>>           (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
>>>               ref_transaction_rollback(t);
>>>
>>> we can now just do the much nicer
>>>       t = ref_transaction_begin();
>>>       if (!t ||
>>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>>>                                  !!oldval) ||
>>>           ref_transaction_commit(&t, action, &err)) {
>>>               ref_transaction_rollback(t);
>>
>> I understand the motivation for this change, but passing
>> pointer-to-pointer is unconventional in a case like this.  Unfortunately
>> I ran out of steam for the night before I could think about alternatives.
> 
> I see.
> Yes passing a pointer to pointer is not ideal.
> But I still want to be able to use the pattern
>        t = ref_transaction_begin();
>        if (!t ||
>            ref_transaction_update(t, ...) ||
>            ref_transaction_commit(t, ...)) {
>                ref_transaction_rollback(t);
> 
> Maybe the problem is that ref_transaction_commit() implicitely also
> frees the transaction.
> 
> 
> What about changing ref_transaction_commit() would NOT free the
> transaction and thus a caller would
> always have to explicitely free the transaction afterwards?
> 
> Something like this :
>        t = ref_transaction_begin();
>        if (!t ||
>            ref_transaction_update(t, ...) ||
>            ref_transaction_commit(&t, ...)) {

You wouldn't need the "&" here then, right?

>                ref_transaction_rollback(t);
>        }
>        ref_transaction_free(t);

That sounds like a better solution.  We would want to make sure that
ref_transaction_commit() / ref_transaction_rollback() leaves the
ref_transaction in a state that if it is accidentally passed to
ref_transaction_update() or its friends, the function calls die("BUG: ...").

Unless we want to make ref_transaction objects reusable.  But then we
would need an explicit "allocation" step in the boilerplate code:

    t = ref_transaction_alloc();
    while (something) {
            if (ref_transaction_begin(t) ||
                 ref_transaction_update(t, ...) ||
                 ref_transaction_commit(t, ...)) {
                    ref_transaction_rollback(t);
            }
    }
    ref_transaction_free(t);

Note that ref_transaction_begin() should in this case be converted to
return 0-on-OK, negative-on-error for consistency.

This would bring us back to the familiar pattern alloc...use...free.

I was going to say that the extra boilerplate is not worth it, and
anyway reusing ref_transaction objects won't save any significant work.
 But then it occurred to me that ref_transaction_alloc() might be a
place to do more expensive work, like creating a connection to a
database, so reuse could potentially be a bigger win.

All in all, either way is OK with me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
