From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Our merge bases sometimes suck
Date: Fri, 20 Jun 2014 10:53:14 +0200
Message-ID: <53A3F67A.80501@alum.mit.edu>
References: <539A25BF.4060501@alum.mit.edu>	<xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>	<53A06264.9080205@alum.mit.edu> <xmqqtx7gdqbt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 10:53:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxuZY-0007hU-TN
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 10:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934297AbaFTIxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 04:53:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42386 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933833AbaFTIxR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2014 04:53:17 -0400
X-AuditID: 1207440f-f79536d000000bcf-2b-53a3f67cc695
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DD.87.03023.C76F3A35; Fri, 20 Jun 2014 04:53:16 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96616.dip0.t-ipconnect.de [79.201.102.22])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5K8rFFb023662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 20 Jun 2014 04:53:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqqtx7gdqbt.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqFvzbXGwwZb9OhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xpVlX1gLnghXrNy8h62BcYJAFyMnh4SAiUTn
	nm9MELaYxIV769m6GLk4hAQuM0qsXXuPCcI5zyTRs2kNM0gVr4CmxPu/f8A6WARUJfYv28MG
	YrMJ6Eos6mkGi4sKBEnM/jyPHaJeUOLkzCcsILaIgJrExLZDQDYHBzNQ/cM3iSBhYQFtiQUv
	/oK1CgmsZJS4vy0exOYUsJZ4fvQoWLmEgLhET2MQSBik8+aJj0wQtrzE9rdzmCcwCs5CsmwW
	krJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJXv4djF3rZQ4x
	CnAwKvHwdpguDhZiTSwrrsw9xCjJwaQkyvv/M1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/c
	e6Acb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mCl+srUKNgUWp6akVa
	Zk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KH7ji4ERDJLiAdprCNLOW1yQmAsUhWg9xWjMcerO
	sTYmjhNPTrYxCbHk5eelSonzSoCUCoCUZpTmwS2Cpa1XjOJAfwvzyoNU8QBTHty8V0CrmIBW
	Le5ZBLKqJBEhJdXAuHWTZpNDvDNrUnVaavtjpjan/uQ9ssZvcjUTjp5fnmfO0L/i7NqqTauy
	RHdHb1n1kLVydr6d5odLrtvD5OOeTnTcJupwbNc3H6uISbmzLmo77+3RuWUW3Nnp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252220>

On 06/20/2014 08:53 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> It just looks asymmetric, but actually it is symmetric, which was kindof
>> surprising when I realized it....
>>
>> Since "|branch ∧ master|" is the same for all candidates, minimizing N
>> is the same as maximizing |candidate|, which is the same as
>>
>>     git rev-list --count --no-merges $candidate
>>
>> This is clearly symmetric in master vs. base.
> 
> Hmph, but that obviously will become very expensive to compute as
> project grows.

This formulation is theoretically interesting because it shows the
symmetry of the criterion, but that doesn't mean it is the most
practical to use.  Given that multiple formulations are equivalent, any
of them can be used.

> When we (potentially) have multiple merge-bases, after finding all
> the candidates by traversing from the two commits to be merged, we
> already make another set of traversals, starting from the candidates
> and painting the ancestors down to their common ancestors.  This is
> done to discover if each candidate is reachable from any other
> candidate (in which case the reachable one is not a merge-base).
> 
> The resulting graph of this traversal is currently used only to cull
> non-merge-bases out of the candidates, but I wonder if you can
> *count* the nodes in it in each color and use that number (which is
> essentially the number of commits that can be reached only from one
> candidate and not from other candidates) to derive a score for each
> candidate, and use it to assess the goodness of merge-bases, just
> like the number you are counting in the above full traversal.

It sounds promising.  Let's see if I correctly understand the algorithm
that you described:

"common_ancestors" = intersection of all candidates' histories
"painting_from($candidate)" = $candidate - common_ancestors
discard $candidate if $candidate is in painting_from($other_candidate)
(i.e., it is not a merge base)

If that is correct, then the candidate with the most commits in
painting_from($candidate) should be the best merge base, because
common_ancestors is a subset of the candidate's history, so

    |painting_from($candidate)| = |$candidate| - |common_ancestors|

Since |common_ancestors| is the same for all candidates, minimizing
|painting_from($candidate)| is the same as minimizing |$candidate|.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
