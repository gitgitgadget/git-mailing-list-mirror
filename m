From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 05/12] delete_refs(): improve error message
Date: Fri, 19 Jun 2015 16:20:46 +0200
Message-ID: <5584253E.9030001@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>	<64949bba1031b19abf86629267b8bc40666a4631.1434206062.git.mhagger@alum.mit.edu> <xmqq7fr4akr7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 16:21:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5xA9-0007u5-2I
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 16:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbbFSOUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 10:20:53 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57361 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752882AbbFSOUv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 10:20:51 -0400
X-AuditID: 12074412-f79a76d000007c8b-c1-558425413c31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F5.74.31883.14524855; Fri, 19 Jun 2015 10:20:49 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3F26.dip0.t-ipconnect.de [93.219.63.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5JEKlXr016703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 19 Jun 2015 10:20:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqq7fr4akr7.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqOuo2hJqcPq1gkXXlW4mi4beK8wW
	P1p6mC02b25ncWDxWLCp1ONZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M64uUuj4KhA
	xcqPT5kbGBfwdjFyckgImEgc2zOBHcIWk7hwbz1bFyMXh5DAZUaJn91/mSGcc0wSj2fsYgWp
	4hXQljg8bR5YB4uAqsTRN31sIDabgK7Eop5mpi5GDg5RgSCJ1y9zIcoFJU7OfMICYosIqElM
	bDsEZjMLxEtsbb/KDFIuLOAk0ThfDWLVVkaJ+x8fgY3kFLCWOLejF6peT2LH9V+sELa8RPPW
	2cwTGAVmIVkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKE
	hLLQDsb1J+UOMQpwMCrx8Bp8aw4VYk0sK67MPcQoycGkJMq7R6klVIgvKT+lMiOxOCO+qDQn
	tfgQowQHs5IIb4ECUI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYKX
	VwWoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Up/HFwEgFSfEA7d0O0s5bXJCY
	CxSFaD3FqCglzvtFGSghAJLIKM2DGwtLUK8YxYG+FOZ9DlLFA0xucN2vgAYzAQ2eUN4EMrgk
	ESEl1cDot///D+V5thfOHAnOW6UTsf7HxFlXblX8jUgQi9zuEz+byXx3ydqQFRd8Mpc3HZv+
	bG6xcEDww4jOT4cse3eXsx+xuX0g6cDcgJgbzuVujhYfjgXobuTddZ0nauWjjuJN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272159>

On 06/15/2015 08:29 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Subject: Re: [PATCH v2 05/12] delete_refs(): improve error message
> 
> I'd call this "make error message more generic".
> 
>> Change the error message from
>>
>>     Could not remove branch %s
>>
>> to
>>
>>     could not remove reference %s
>>
>> * s/branch/reference/. This change makes sense even for the existing
>>   caller, which uses the function to delete remote-tracking
>>   branches.
> 
> and replace this bullet with something like:
> 
> * Originally 'branch -d' was the only caller of this, but as part
>   of the refs API, we will allow it to be called on refs that is not
>   a branch or a remote-tracking branch.
> 
> as calling a remote-tracking branch a 'branch' is not incorrect
> per-se.

True, but "branch refs/remotes/origin/foo" is not how we would usually
refer to that reference. Usually we would say "reference
refs/remotes/origin/foo" or "remote-tracking branch origin/foo". But I
will make approximately the change that you suggest.

> What would count as true improvement is ...
> 
>> * Convert it to lower case, as per our usual convention.
> 
> ... this one.  If somebody eventually chooses to make the message
> finer grained by switching on the prefix refs/{what}, so that the
> user can differentiate between branches, remote-tracking branches,
> tags, etc., that would also count as improvement as well.

I thought about proposing a function that changes a reference name into
its prose equivalent, but I'm pretty sure that the result would not be
internationalizable. Probably such a function would have to look like

enum refname_kind { REFNAME_KIND_BRANCH, REFNAME_KIND_TAG,
REFNAME_KIND_REMOTE, ...(?), REFNAME_KIND_OTHER};

enum refname_kind shorten_refname(const char *refname, const char
**short_refname);

and callers would still need logic to pick the correct
(internationalized) formatting string based on the return value of the
function.

Someday...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
