From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 01:06:20 -0700
Message-ID: <7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 09:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlfDP-0005hd-Le
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248AbZCWIG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 04:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757289AbZCWIG2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 04:06:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462AbZCWIG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 04:06:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D537886E2;
	Mon, 23 Mar 2009 04:06:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40CCD86E1; Mon,
 23 Mar 2009 04:06:22 -0400 (EDT)
In-Reply-To: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> (David
 Reitter's message of "Sun, 22 Mar 2009 23:33:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80E88FF2-1781-11DE-A089-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114260>

David Reitter <david.reitter@gmail.com> writes:

> Suppose I have a bzr branch that has been converted (somehow) to a git
> branch, is it then possible to merge new revisions from the bzr branch
> into the git one?

It entirely depends on how that "somehow" goes.

If that "somehow" procedure performs a reliably reproducible conversion
(i.e. not only it will produce the identical git history when you feed the
same bzr history to the procedure twice, but it will produce the identical
git history followed by new history if you feed the bzr history after new
commits are added to the bzr history), you should be able to re-convert
the updated bzr history to git and merge the result with the result of the
earlier conversion.  The re-conversion process may not even have to be a
whole re-conversion; it could be incremental.  But that is entirely up to
the quality of the conversion "somehow" procedure implements.
