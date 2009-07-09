From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 09 Jul 2009 01:18:59 -0700
Message-ID: <7vskh646bw.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOoqb-00075b-VO
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZGIITI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbZGIITI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:19:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbZGIITH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 04:19:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 62CA5261DF;
	Thu,  9 Jul 2009 04:19:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A9D70261DE; Thu, 
 9 Jul 2009 04:19:00 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 8 Jul 2009 19\:43\:50 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A3C96AA-6C61-11DE-B994-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122942>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 8 Jul 2009 19:31:49 -0700
> Subject: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have an up-to-date cache entry
>
> On filesystems without d_type, we can look at the cache entry first.
> Doing an lstat() can be expensive.

Thanks.

I was wondering if we could also say that D exists as a directory when we
know there is D/F in the index and is up to date.
