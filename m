From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when
 --edit-description is used
Date: Sun, 29 Jan 2012 13:49:33 -0800
Message-ID: <7vzkd6dvrm.fsf@alter.siamese.dyndns.org>
References: <2443.1327701165@plover.com>
 <7vr4ykybnl.fsf@alter.siamese.dyndns.org> <4F2399B6.8020507@alum.mit.edu>
 <7vbopoxp5q.fsf@alter.siamese.dyndns.org> <4F24E78A.7060502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 29 22:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrcdL-0006uS-J4
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 22:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab2A2Vth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 16:49:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab2A2Vtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 16:49:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FD326BFF;
	Sun, 29 Jan 2012 16:49:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sqFVkU6+uEd57bmKIwoDRVqKjzw=; b=htssFV
	T9sHi9swFWji01T1Q8oi9AneYdZezifdEYdHtAWg68VSuAn0nt+Pb8kD7+0sWmJb
	58bBX2JFNXaZ8CpSxsOSiAJnruVk4mkT3T7AbNeX3JO6j0MZ/olHe59ORrD/oM2K
	LB50i1eIdFKPNMPl0hVMcogJF/iJlzjJeKuJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jc/DMDvoje/rDIa5JLyNh2GOyYLf55d+
	CvAKpmWK1OSH0yuUuqAuRE5vtXLLQVwIoXFC8ntDThOnC4FYXzVKn8xEpaVmvhvJ
	Y6819W0h8hpRe0kVOcw15Hozmf6mesiqDblYWBeysjxivdL+Zcjjb0MEhyi/A5Zy
	NlAtOhRKG5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6799D6BFE;
	Sun, 29 Jan 2012 16:49:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D24CA6BFC; Sun, 29 Jan 2012
 16:49:34 -0500 (EST)
In-Reply-To: <4F24E78A.7060502@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 29 Jan 2012 07:30:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2215A460-4AC3-11E1-995D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189298>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/28/2012 08:27 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
> I vote for an error.  Otherwise a typo in the branch name would lead to
> the description's apparent disappearance into Nirvana.  An error would,
> for example, have made it clear to the OP what was happening.

I agree with this statement.

Unless or until we update --edit-description to create a new branch when
given a name of a branch that does not exist, the existing behaviour is
simply an accident waiting to happen.
