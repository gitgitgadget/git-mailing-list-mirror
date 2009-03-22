From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] format-patch: --attach/inline uses filename
 instead of SHA1
Date: Sat, 21 Mar 2009 22:36:06 -0700
Message-ID: <7vr60q86gp.fsf@gitster.siamese.dyndns.org>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <1237696363-6819-2-git-send-email-bebarino@gmail.com>
 <1237696363-6819-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 06:37:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlGNW-00067L-6O
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 06:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZCVFgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 01:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbZCVFgN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 01:36:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZCVFgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 01:36:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BFBB583E3;
	Sun, 22 Mar 2009 01:36:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40CB683E2; Sun,
 22 Mar 2009 01:36:08 -0400 (EDT)
In-Reply-To: <1237696363-6819-3-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Sat, 21 Mar 2009 21:32:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59AE2EDA-16A3-11DE-B9A0-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114119>

Stephen Boyd <bebarino@gmail.com> writes:

> Currently when format-patch is used with --attach or --inline the patch
> attachment has the SHA1 of the commit for its filename. This replaces
> the SHA1 with the filename used by format-patch when outputting to files.
>
> Fix tests relying on the SHA1 output and add a test showing how the
> --suffix option affects the attachment filename output.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
> Is modifying the rev_info struct correct?

Most of the rev_info is about the overall traversal not about individual
commits, and I think the new field you are adding is about a single commit
you will update every time you switch to a new commit to process, so in
that sense it may violate the general idea of what rev-info is, but I do
not think it matters too much.
