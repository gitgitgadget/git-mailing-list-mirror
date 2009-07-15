From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "mailinfo: Remove only one set of square brackets" considered
 harmful
Date: Wed, 15 Jul 2009 15:09:55 -0700
Message-ID: <7vljmpegy4.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907150821280.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRCg1-0003wM-HS
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZGOWKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZGOWKD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:10:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZGOWKC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 18:10:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AAAA65EE7;
	Wed, 15 Jul 2009 18:10:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA7315EE6; Wed,
 15 Jul 2009 18:09:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907150821280.13838@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 15 Jul 2009 08\:30\:58 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D5C7E5A-718C-11DE-BEA1-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123337>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I see why Andreas did it, and I don't disagree violently, BUT...
>
> The fact is, we have mailing lists etc that add their own headers to the 
> subject, and they know they can add things in brackets. The most obvious 
> example is the Linux kernel security list, which adds a prefix of
>
> 	"[Security] "
>
> to the subject line in order to stand out (I'm on other lists that do 
> this too, but those generally don'thave patches).
>>
> So I have emails witgh subjects like
>
> 	Subject: [Security] [patch] random: make get_random_int() more random
>
> but I also have people who do the same thing themselves, eg:
>
> 	Subject: [PATCH -rc] [BUGFIX] x86: fix kernel_trap_sp()
> 	Subject: [BUGFIX][PATCH] fix bad page removal from LRU (Was Re: [RFC][PATCH] ..
>
> so people did kind of depend on the "remove square brackets" behavior.

Thanks.  The reason why I have merged some questionable stuff (including
this one) early in this cycle was exactly because we would want to catch
real world breakages caused by such changes.

Even though it is silly not to rely on already well established
conventions such as X-Mailing-List and List-ID but instead to waste
precious real estate at the initial part of the Subject in this century
merely for list identification purposes, this change regresses the end
result.
