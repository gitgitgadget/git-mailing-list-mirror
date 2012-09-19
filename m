From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] string_list API: document what "sorted" means.
Date: Wed, 19 Sep 2012 09:35:55 +0200
Message-ID: <505975DB.7070802@alum.mit.edu>
References: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu> <7vy5k8s622.fsf@alter.siamese.dyndns.org> <505829AB.8000506@alum.mit.edu> <7vmx0noi8s.fsf@alter.siamese.dyndns.org> <5058371C.8060209@alum.mit.edu> <7va9wnnt5h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 09:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEEpL-00089y-NM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 09:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab2ISHf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 03:35:58 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:47660 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754843Ab2ISHf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 03:35:57 -0400
X-AuditID: 12074412-b7f216d0000008e3-2a-505975dc2744
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BB.FB.02275.CD579505; Wed, 19 Sep 2012 03:35:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8J7ZtWI026126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Sep 2012 03:35:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7va9wnnt5h.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqHunNDLAYNlua4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE749bVjewFV/gq3na+YmpgvMfdxcjJISFgIvF7
	UycrhC0mceHeerYuRi4OIYHLjBJ/511mhXCOM0m03uhhAaniFdCWWLXgCjOIzSKgKjH1zGYm
	EJtNQFdiUU8zmC0qECIx4/JkZoh6QYmTM5+A9YoIqElMbDsEZHNwMAuIS/T/AzOFBZwlTr+N
	BakQEmhkkmhuqgWxOQXMJFrv7ADrZBbQkXjX94AZwpaX2P52DvMERoFZSBbMQlI2C0nZAkbm
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghQSq0g3H9SblDjAIcjEo8vAp3
	IgKEWBPLiitzDzFKcjApifKqlEQGCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhtc8EyvGmJFZW
	pRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfBuAxkqWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4rT+GJgpIKkeID28paC7C0uSMwFikK0nmLU5bj7ccV9RiGWvPy8
	VClx3gUgOwRAijJK8+BWwFLSK0ZxoI+Fea+AVPEA0xncpFdAS5iAllQ8CQNZUpKIkJJqYLRh
	zFC6G+pX+NH0k56o1MJFXx/4XeS5vcDCJnH1gk2zA0qYM+K6dZZbWa3gyjW12flrbVnWW/2b
	3z5u5xJenW26SZNlynP1yiTNXQKu01XeaXYGO3AvaJMSPL0q8FBcyeowBgdZjV1x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205914>

On 09/18/2012 07:21 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If another sort order is needed, then we will either have to audit
>> existing string_list users to make sure that they don't rely on strcmp()
>> ordering, or we will have to implement strcmp() ordering *plus* the new
>> ordering.
> 
> What I was envisioning was to pass in an optional custom comparison
> when you instantiate a string_list object.  Existing callers that
> rely on (or can live with, because they do not care about the exact
> order) the default order will continue to use the byte-value ordering,
> so there is no need for auditing.  Only the new callers that want
> different ordering would set custom comparison routine.
> 
> But now I wrote it down, I realize that there is no _harm_ in
> documenting "we sort in byte-value order, so expect iterations on
> sorted string list to give them in that order to you" at all.
> 
> So let's go with your documentation patch as-is.
> 
>> It's not that I'm unwilling to implement 2; it's just that I still don't
>> see any advantage to doing so before there is a demonstrated need for it.
> 
> As I said, I have this suspicion that the lack of demonstrated need
> is largely because the existing code that do _not_ use string-list
> don't do so because the interface is limited, so the argument is
> sort of self-fulfilling.

I've been looking for places in the code where string_list can be used,
so hopefully I'll get a feeling for what new functionality will increase
its applicability.

Now that my string_list enhancements are in master, I will start
trickling in patches to convert other code to using string_list when it
seems to benefit code length and/or understandability.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
