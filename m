From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 11:37:12 -0700
Message-ID: <7v8w9qkd5z.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de>
 <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
 <7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA11D8C.5020007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nry7X-00056S-K5
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab0CQShZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 14:37:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0CQShY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 14:37:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 957BFA27A4;
	Wed, 17 Mar 2010 14:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=67ItUspEMBaBQIL6Oda3cYnoDbE=; b=xr6pmm
	pzZTAnNnbu+hkhTG2z0GAEQGWIu4tiBwbP60bBMHkOmyNRnGIKQi6bzGYQ42X15J
	No8uHyK8nPBQj1H9RTQM78hFcJZHSH87oDvrUv5zS1OIkxRL/+VUPVUoWCbbMUcy
	Dg7RrH+mvV1qpQsQhyqQkSO5S2pmwVGl9fAbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gz3U37dIoTspmKsW5XxA+cc4mx0K+qAu
	0VDQxhmg8VwwPZEM2BnRVNTN2CgymJVRC08OgX3pKEwZ9pCbxZW3vzbMUGnS5QbS
	R18bb3P2pWipnl2t7eo/+SBSRt/g2dAu/5nXYC0HTtC4ks29FIZq0SAazLV0Ka/M
	58mFbvw4KAs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5464FA279A;
	Wed, 17 Mar 2010 14:37:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82ABCA278F; Wed, 17 Mar
 2010 14:37:13 -0400 (EDT)
In-Reply-To: <4BA11D8C.5020007@web.de> (Markus Elfring's message of "Wed\, 17
 Mar 2010 19\:21\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D9F3886-31F4-11DF-9345-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142425>

Markus Elfring <Markus.Elfring@web.de> writes:

>>      If you made changes to paths that are different from the current
>> branch and the new branch, the command will stop you in order to prevent
>> you from losing your uncommited changes in potential conflicts between
>> them and the changes between two branches.
>
> I find it hard to realise what will be inside or outside of a path structure
> under the mentioned conditions.

Sorry, but I didn't say anything about path structure, and I am unsure
what you were talking about.  Here is what I meant:

Imagine you are on branch A and trying to switch to branch B.  There are
changed paths between these two branches (i.e. the paths that appear in
the output from "git diff --name-only A B") and there are unchanged paths.
If you have local changes to the former, such local changes may conflict
with the change made between A and B, and stops the command.
