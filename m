From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug was
 fixed
Date: Tue, 21 Jul 2009 13:24:46 -0700
Message-ID: <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josef Bacik <josef@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLu8-0003Vp-7o
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbZGUUYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756194AbZGUUYw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:24:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbZGUUYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:24:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A0968E0D8;
	Tue, 21 Jul 2009 16:24:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03012E0D2; Tue,
 21 Jul 2009 16:24:47 -0400 (EDT)
In-Reply-To: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
 message of "Tue\, 21 Jul 2009 16\:16\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B612298-7634-11DE-B83C-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123707>

Jeff Moyer <jmoyer@redhat.com> writes:

> As a distro kernel grunt, I sometimes find myself in the situation of
> having to track down the commit that fixed a given problem so that I can
> backport it to an older kernel.  Sometimes I'm smart enough to figure it
> out myself, other times I'm not.  ;-)  It would be helpful if git bisect
> could help figure out in what commit a bug was fixed as opposed to
> introduced.  Is there any interest in implementing such a feature?

Doesn't that already exist?

You are hunting for an existence of the bug, so any commit that is buggy
(with respect to the bug you are interested in) is *GOOD*.  The tip of the
upstream is *BAD* in that it does not have your favourite bug anymore.

You bisect that history down, and will find the first *BAD* commit.

Now, why is that commit the procedure finds is *BAD*, again?  Yup, because
it does not have your favourite bug anymore.  And why is that so?

Because the commit fixed that bug.
