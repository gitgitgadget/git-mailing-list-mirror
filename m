From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 11:59:32 -0800
Message-ID: <7v3adzk5wb.fsf@gitster.siamese.dyndns.org>
References: <20090227192708.6266.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 21:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8tg-0003FG-6v
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbZB0T7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbZB0T7p
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:59:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZB0T7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:59:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35ED89B12F;
	Fri, 27 Feb 2009 14:59:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 19D179B12B; Fri,
 27 Feb 2009 14:59:33 -0500 (EST)
In-Reply-To: <20090227192708.6266.qmail@science.horizon.com> (George
 Spelvin's message of "Fri, 27 Feb 2009 14:27:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2935C3D6-0509-11DE-A218-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111706>

"George Spelvin" <linux@horizon.com> writes:

> There's one more change that was suggested that I'd like to propose:
> - Make "git grep" search the whole repository by default; include an
>   explicit "." path limiter to search only the current directory.
>
> In addition to being more consistent with other commands like "git log",
> this saves a lot of typing working in drivers/net/usb/ if the identifier
> you're looking for is in include/.  Typing the additional space-dot
> is pretty trivial if you want the current directory only.

I do not remember it was ever suggested, let alone coming to anything near
consensus.

The only way you could justify such a default change is to say:

    Almost all the time, everybody wants to use this new behaviour; the
    old behaviour is almost never useful in any situation other than a
    narrow corner case; and if somebody wants to do such a useless thing
    in a corner case, he can always add " ." at the end, so nothing is
    lost.

I do not think that is true for the change you are proposing here.  'He
can always add " ." at the end' alone is not a good enough justification.

I however think your use case deserves to be supported, and I would not
mind at all accepting a new "--full-tree" (or some shorter synonym) option
if the patch is cleanly done (hint, hint).

I'd rather not add this to "future changes that are backward incompatible"
list.  It may be a useful new feature, but that is not what the topic of
this thread is about.
