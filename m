From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-gc: add a --no-verify option to bypass the
 pre-auto-gc hook
Date: Mon, 31 Mar 2008 22:02:55 -0700
Message-ID: <7v1w5qjhfk.fsf@gitster.siamese.dyndns.org>
References: <e755e3fd6b48cd43c61ae6c0c610aaa7b5e166f0.1206929014.git.vmiklos
 @frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 07:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYf9-0007uJ-1u
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 07:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbYDAFDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 01:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYDAFDQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 01:03:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYDAFDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 01:03:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91829261A;
	Tue,  1 Apr 2008 01:03:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 727F82606; Tue,  1 Apr 2008 01:03:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78630>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index d424a4e..396da5c 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -62,6 +62,10 @@ automatic consolidation of packs.
>  --quiet::
>  	Suppress all progress reports.
>  
> +--no-verify::
> +	This option bypasses the pre-auto-gc hook.
> +	See also link:hooks.html[hooks].

The purpose of "gc --auto" is not about running it interactively yourself,
but to sprinkle calls to it at strategic places in your script.  If this
option is about disabling the hook temporarily for one-shot, it is not
like it is easier to rewrite such script to add --no-verify than actually
chmod -x the hook yourself.  So I am puzzled what the expected use is for
this option.
