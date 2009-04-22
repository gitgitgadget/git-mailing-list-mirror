From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bad object
Date: Wed, 22 Apr 2009 12:58:42 -0700
Message-ID: <7vbpqo31fx.fsf@gitster.siamese.dyndns.org>
References: <20090422184842.GC9541@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwicK-0003QP-I5
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbZDVT6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZDVT6t
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:58:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbZDVT6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:58:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D0141157F;
	Wed, 22 Apr 2009 15:58:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 96CCC1157C; Wed,
 22 Apr 2009 15:58:43 -0400 (EDT)
In-Reply-To: <20090422184842.GC9541@fieldses.org> (J. Bruce Fields's message
 of "Wed, 22 Apr 2009 14:48:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD1B8FF8-2F77-11DE-8103-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117245>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Just today operations started warning:
>
> 	error: Could not read 4e69489a0ac11a9b62a25923975bfc370a30eae5
>
> This is Documentation/networking/baycom.txt from
> 518e6540831c69422faecceee8f964bd439ac9d0 (pre-2.6.13), which is easy
> enough to find from another repository and fix the problem.
>
> But I'm curious--how do I find out what pack file that object should be
> in, and what the corruption looks like?

The former you should be able to read from either "verify-pack -v" or
"show-index" output.  After finding the offset for the object data in the
pack, a bit of "dd seek=" would be needed to extract the data.

>
> This is the third time I've found corruption in a repository on this
> laptop, so I'm a little suspicious of the hardware.  (The second time I
> reported here: http://marc.info/?l=git&m=121968278319668&w=2.)
>
> --b.
