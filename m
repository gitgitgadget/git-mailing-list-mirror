From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 13:25:15 -0700
Message-ID: <7v7h4j6v9w.fsf@alter.siamese.dyndns.org>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu>
 <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E8C9A35.5030504@svario.it>
 <7vvcs370d1.fsf@alter.siamese.dyndns.org> <4E8CBB4C.4000408@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Wed Oct 05 22:25:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBY24-00041J-9w
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 22:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935329Ab1JEUZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 16:25:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935423Ab1JEUZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 16:25:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E7944E0B;
	Wed,  5 Oct 2011 16:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dXcpNpYd+yCFv2XfBWiiTbrb6nY=; b=BIgFVf
	0D96K7bkmfjxXwV8hOIK54v/mewLh88ypEg/V+uaS2OmlfM0ICAhheyjxNQjQsKZ
	hW1jBSK1YNMvUQgBE3ynJAaDbaTA8Wv2ZvW+3Px1blSrbK5lS105CLe7HeT3K+yA
	oHPpx+41ssb+2nG5XcMo83dzKX9ErX75CZr1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W3Ht6OjJAevg+GfbKCSrNySZ50UaPBJB
	mDqTEI5ZTWvk8NG6ns7a7Sb8YrIthH64GpUUTLoKK0/kqjslsl1UPGWQf2Vjegvp
	n6u/LDgEwg3xE9qp9y4dIfn06o1ycqGBde9tMPS2kjBd1xPV2CU4c1n/G3kLxgC7
	U6ZXfezAISE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74D4D4E0A;
	Wed,  5 Oct 2011 16:25:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B9694E09; Wed,  5 Oct 2011
 16:25:16 -0400 (EDT)
In-Reply-To: <4E8CBB4C.4000408@svario.it> (Gioele Barabucci's message of
 "Wed, 05 Oct 2011 22:17:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 237925CC-EF90-11E0-A891-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182881>

Gioele Barabucci <gioele@svario.it> writes:

> ...  As you quoted,
>
>> If the pattern ends with a slash, it is removed for the purpose
>> of the following description, but it would only find a match with
>> a directory. In other words, foo/ will match a directory foo and
>> paths underneath it

But the "will match a directory foo and" part in that description, while
makes it easier to read, is technically unnecessary and even misleading.

The ignore patterns ultimately decides which paths are not to be added to
the index. Colloquially we could say "foo directory is ignored", but such
a statement is just a short-hand for "everything in foo is ignored";
technically "foo directory is ignored" is not necessary because we never
add the directory itself to the index.
