From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add 'sane' mode to 'git reset'
Date: Wed, 03 Dec 2008 18:03:15 -0800
Message-ID: <7vk5ag7l3w.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org>
 <7vr64oc30p.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812031634520.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 03:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L83a4-0002f8-L5
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 03:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYLDCDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 21:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbYLDCDX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 21:03:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYLDCDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 21:03:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25EC5180DF;
	Wed,  3 Dec 2008 21:03:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9B2D180D3; Wed, 
 3 Dec 2008 21:03:17 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812031634520.3256@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Wed, 3 Dec 2008 16:39:49 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B9C5B398-C1A7-11DD-ABCC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102320>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 3 Dec 2008, Junio C Hamano wrote:
>> 
>> The recovery procedure I would use in such a case (and I rarely pull while
>> managing git.git even though I do so in my day job) would be:
>> 
>> 	$ git checkout -b this-needs-more-work
>>      $ git checkout master
>
> No, that won't work. The second 'git checkout' does nothing, since 
> 'master' still has all the broken code in it.

Yeah, brain-o.  I should have said

	git checkout -b needs-more-work
        git branch -f master master~$n
        git checkout master

or something like that.
