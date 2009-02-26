From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/21] git remote: set-head and new show output
Date: Thu, 26 Feb 2009 09:04:19 -0800
Message-ID: <7v8wntuo30.fsf@gitster.siamese.dyndns.org>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 18:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcjgP-0007Tb-Ml
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 18:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbZBZREe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 12:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbZBZREd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 12:04:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbZBZREd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 12:04:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D7829DB25;
	Thu, 26 Feb 2009 12:04:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2594F9DB22; Thu,
 26 Feb 2009 12:04:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 885A5B0C-0427-11DE-A079-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jay Soffian <jaysoffian@gmail.com> writes:

> This series replaces three related topics from pu:
>
>   js/remote-set-head
>   jk/head-lookup
>   js/remote-display
> ...
> So I think this series is clean, and doesn't need an extensive
> re-review, but a quick look-over would be appreciated.

I have looked at the diff between:

 (1) the above three topics merged to 'next'; and

 (2) this 21-patch series applied to 'master' then merged to 'next'.

There indeed does not seem major changes, but there are some:

 - get_head_names() lost "const char *remote_name" parameter that was
   unused (good);

 - guess_remote_head() uses a local variable "r" instead of using an
   additional variable "m" (does not matter);

 - "builtin-send-pack.c" lost otherwise unused inclusion of "tag.h"
   (good);

 - one_local_ref() and get_local_heads() are moved around (does not
   matter);

 - t5505-remote.sh has one more test (ok).

 - The old series had distracting removal of a few blank lines in
   cmd_clone() and get_remote_ref_states(), but with this round these are
   gone (good).

Overall, the new series certainly looks cleaner.

> I signed off on Jeff's patches; please remove my SoB from those if it is
> inappropriate for me to have done so.

That is perfectly fine.

Thanks.
