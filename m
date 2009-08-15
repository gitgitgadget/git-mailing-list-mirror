From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 13:16:08 -0700
Message-ID: <7viqgoestz.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>
 <200908152119.56606.trast@student.ethz.ch>
 <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 22:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McPfr-00045N-Go
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 22:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbZHOUQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 16:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZHOUQP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 16:16:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbZHOUQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 16:16:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F262D2A377;
	Sat, 15 Aug 2009 16:16:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A29C22A372; Sat, 15 Aug 2009
 16:16:10 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain>
 (Linus Torvalds's message of "Sat\, 15 Aug 2009 12\:50\:49 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BBC2646-89D8-11DE-9D58-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126024>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 15 Aug 2009, Thomas Rast wrote:
>
>> Granted, it makes it equivalent to --pretty=tformat:foo, but isn't
>> tformat the better choice in many cases?
>
> Not really. Look at what happens with
>
> 	git log --stat --pretty=format:%s
>
> and then try tformat instead. 'tformat' is broken, as is our current 
> --format=%s.
>
> In other words, all of that crud is totally illogical, and our "short 
> versions" (--oneline and --format=) were done entirely incorrectly (well, 
> --oneline probably has the _right_ semantics, and --pretty=oneline is just 
> wrong, but whatever).

If you try that without --stat, i.e.

    $ git log -4 --pretty=format:%s | cat -e
    $ git log -4 --pretty=tformat:%s | cat -e

I suspect you may then find that --pretty=format (not --pretty=tformat) is
broken.
