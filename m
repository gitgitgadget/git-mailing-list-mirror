From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Fri, 27 Jun 2008 14:55:32 -0700
Message-ID: <7vod5mpmp7.fsf@gitster.siamese.dyndns.org>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:56:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCLw3-0005yv-Un
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 23:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765416AbYF0Vzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 17:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765536AbYF0Vzq
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 17:55:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765562AbYF0Vzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 17:55:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB270D17A;
	Fri, 27 Jun 2008 17:55:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 19EB2D175; Fri, 27 Jun 2008 17:55:35 -0400 (EDT)
In-Reply-To: <1214602538-7888-1-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Sat, 28 Jun 2008 01:35:38 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C93EC26A-4493-11DD-A44B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86639>

Dmitry Potapov <dpotapov@gmail.com> writes:

> diff --git a/abspath.c b/abspath.c
> new file mode 100644
> index 0000000..4becedf
> --- /dev/null
> +++ b/abspath.c
> @@ -0,0 +1,80 @@
> +/*
> + * I'm tired of doing "vsnprintf()" etc just to open a
> + * file, so here's a "return static buffer with printf"
> + * interface for paths.
> + *
> + * It's obviously not thread-safe. Sue me. But it's quite
> + * useful for doing things like
> + *
> + *   f = open(mkpath("%s/%s.git", base, name), O_RDONLY);
> + *
> + * which is what it's designed for.
> + */

This is not a comment you would want to move to the resulting file that
contains only make_absolute_path().
