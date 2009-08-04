From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] technical-docs: document tree-walking API
Date: Mon, 03 Aug 2009 22:38:25 -0700
Message-ID: <7v4oso87fy.fsf@alter.siamese.dyndns.org>
References: <1249359201-7672-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 07:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYCjU-0006jT-Dg
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 07:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbZHDFig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 01:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbZHDFig
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 01:38:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbZHDFig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 01:38:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C3E31CB7F;
	Tue,  4 Aug 2009 01:38:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1F2C31CB7E; Tue,  4 Aug 2009
 01:38:28 -0400 (EDT)
In-Reply-To: <1249359201-7672-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon\,  3 Aug 2009 21\:13\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D86E274-80B9-11DE-9D99-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124750>

Stephen Boyd <bebarino@gmail.com> writes:

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> This is a minor update incorporating feedback from Junio. Plus, I decided to
> add an authors section.

I think the primary author is Linus for this API, but once you finished
the documentation, I do not think "authors" section is particularly
needed (git knows who the code came from reasonably well anyway).  The
names of people in these stub documents were there for people like you;
see 530e741 (Start preparing the API documents., 2007-11-24).

It might be a bit misleading to say that the path member of struct
name_entry is a "pathname".  It is _one_ path component, and by stringing
multiple struct traverse_info's (each of which has one struct name_entry)
together with their prev pointer, make_traverse_path() can reconstruct the
full pathname from the toplevel down to the level you have traversed into.
We may want to say "path component" to clarify the distinction.

But these are minor points.  I'll apply the patch as-is.

Thanks.
