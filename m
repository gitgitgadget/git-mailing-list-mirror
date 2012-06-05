From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: have ls-files and ls-tree "see also" each
 other
Date: Tue, 05 Jun 2012 08:03:38 -0700
Message-ID: <7v62b5reb9.fsf@alter.siamese.dyndns.org>
References: <1338873037-4343-1-git-send-email-mmogilvi_git@miniinfo.net>
 <7vehpuqpob.fsf@alter.siamese.dyndns.org> <20120605062935.GA4683@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbvIU-0007Iw-91
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab2FEPDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:03:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab2FEPDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:03:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 680778B61;
	Tue,  5 Jun 2012 11:03:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUKKaz7CEr0beZ1ZWurRSTU/BJg=; b=Wy6IuP
	OJTaHsIJsxxKg+rJx2FLzxxDMCQsizBCvTa3+l/hLOqgvEHDoEg0CYCp/ZqD/TQd
	b64/0878JzjlpR8tWKBMrypTNB9u+h60/N/d78DshiY+7Uote/FBa0RWXzfi+dxN
	7MY8qMwi9dXS91hWDpWusjUDnrwT3y1Ak5k+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lhf2jxgwleum8PINVeoiOfiQi2ou5e0/
	dhyeDpYAYia2IOqYsQpbtJ3toVfjQda5ch/0HW9IQaa+1dpGo1vBat6pWE149Fli
	DVQIWiIGSCIybwq9Y7FIbTY2WHTRDgIz0lXBH5AlofsAVrNyE+07ebpZXlmoGlKB
	nWYyFC1Emeo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED0C8B60;
	Tue,  5 Jun 2012 11:03:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDECE8B5E; Tue,  5 Jun 2012
 11:03:39 -0400 (EDT)
In-Reply-To: <20120605062935.GA4683@comcast.net> (Matthew Ogilvie's message
 of "Tue, 5 Jun 2012 00:29:35 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2466410-AF1F-11E1-B89F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199248>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> On Mon, Jun 04, 2012 at 10:43:32PM -0700, Junio C Hamano wrote:
>> ...
>> That kind of overfiew is what the tutorial (for concepts like the
>> index, tree objects, commit objects, etc.) and the list of commands
>> in git(1).  Is there compelling reason other than "I didn't bother
>> to look, and it is likely other people wouldn't" to apply patches
>> like this?
>
> Not really.  Certainly this is a low priority change.
>
> But why do many of the man pages have "SEE ALSO"
> sections?  Should we just get rid of such sections?  Does anyone
> have any guidelines/rules for what makes sense to be in a
> "SEE ALSO" section?

Two questions that sound similar, somewhat related to each other,
but fundamentally different are [*1*]:

 - Does it help knowing B to make good use of A?

 - Do you need to know what is in the documentation for B in order
   to understand what is in the documentation for A?

If the answer to either one is yes, it may be a good idea to have
"See also B" in the documentation for A.

The ls-files and ls-tree pair does not pass either of the above two
tests. They both give list of paths (but so do "diff --name-only"
and other things), but the similarity between them stops there, and
more importantly, similarity does not play any role in the above two
tests.

If we had a third test:

 - Does it help knowing B to avoid wasting time attempting to use A
   for a task for which A is not a suitable tool?

then ls-files and ls-tree pair would qualify.  I however am not
convinced it is particularly a good test.


[Footnote]

*1* Note that the latter is a sign that A is described in terms of B
(i.e. "We assume you understand B; otherwise stop now, go there and
learn B, and come back. Now we will describe A"); it is preferrable
to avoid it if we can do so without duplication of the information
at the source level.
