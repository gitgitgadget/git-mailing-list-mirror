From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 14:32:33 -0700
Message-ID: <7v8vfjyolq.fsf@alter.siamese.dyndns.org>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch>
 <7v8vfj17de.fsf@alter.siamese.dyndns.org> <4FE0E493.1010308@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:32:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh62S-0004gg-MA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2FSVcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:32:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab2FSVcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:32:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA31081DD;
	Tue, 19 Jun 2012 17:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=heULg918dAAlgLqBAGyBGwZmbGk=; b=UXMsW9
	BLybKpEVHGpcLATSCNGgYHYTjr68nZQVOoep2TwPwmnsj7R1R9QrKCjybVD76Nie
	BAS13WnMxvvnb5XqKGuoW9c3S44GmvGjFaRc2izeY7Y8WUeUcQdnzGKFKDq5maSL
	TWJ3GJyUp2IdOu1nTfG/Fz1fpFnCKC66zANXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rUwk0ze7iUsQDPzwTEOQFdE2hUG/C0tA
	a5g/yx/ewE4hdBMPITorS9eZ3QF4R4T15X8Ah9Iu/BKO3XaRORW+zJ5vrrBTfHja
	iMlTjfvqT2WDCfaavw3WWi21pLu9Jy7hRd7yo4CY9R3kmC9yDjq2OJlvawvlXTj1
	V8LpqCeaM2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C15EA81DC;
	Tue, 19 Jun 2012 17:32:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3280681DB; Tue, 19 Jun 2012
 17:32:35 -0400 (EDT)
In-Reply-To: <4FE0E493.1010308@desrt.ca> (Ryan Lortie's message of "Tue, 19
 Jun 2012 16:44:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48FAC0A8-BA56-11E1-AE94-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200248>

Ryan Lortie <desrt@desrt.ca> writes:

> So to restate the feature request more clearly: "git branch X" with no
> explicitly specified start-point should prevent the branch "X" from
> being created when a branch with the same name already exists on a
> remote (perhaps only considering 'origin').
>
> When stated in this more explicit way, it becomes clear that a --force
> option would not even be required; you could just say:
>
>   git branch gtk-3-4 HEAD
>
> to make it clear that this was your intention.

Won't happen.  "git branch new-branch-name" has always been the way
to create from HEAD.  Suddenly requiring an extra argument is a
grave usability regression.
