From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: Give friendlier errors when there is nothing
 to apply
Date: Fri, 14 Aug 2009 12:52:28 -0700
Message-ID: <7v3a7ujhqb.fsf@alter.siamese.dyndns.org>
References: <200908111409.04506.trast@student.ethz.ch>
 <4a81787d.0e0f660a.5238.4c8b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ori Avtalion <ori@avtalion.name>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc2pd-0001OA-AX
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 21:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085AbZHNTwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757081AbZHNTwd
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 15:52:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075AbZHNTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 15:52:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52DDCADAE;
	Fri, 14 Aug 2009 15:52:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FC59ADAD; Fri, 14 Aug
 2009 15:52:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01F6A5A6-890C-11DE-8E3B-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125943>

Ori Avtalion <ori@avtalion.name> writes:

> The change makes sure a stash (given or default) exists before
> checking if the working tree is dirty.
>
> If the default stash is requested, the old message was scary and
> included a 'fatal' error from rev-parse:
>      fatal: Needed a single revision
>      : no valid stashed state found
>
> It is replaced with a friendlier 'Nothing to apply' error, similar to
> 'git stash branch'.
>
> If a specific stash is specified, the 'Needed a single revision' errors
> from rev-parse are suppressed.
>
> Signed-off-by: Ori Avtalion <ori@avtalion.name>
> Acked-by: Thomas Rast <trast@student.ethz.ch>

I do not see anything that might break existing usage of the command.
Comments?

A tangent; we might want an analogue to "shortlog -s -n" but based on
"blame".
