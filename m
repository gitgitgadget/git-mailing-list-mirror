From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: Add --quiet option
Date: Sat, 01 Mar 2008 12:24:55 -0800
Message-ID: <7v4pbqyyy0.fsf@gitster.siamese.dyndns.org>
References: <1204322019-17788-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat Mar 01 21:26:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVYHN-0002Nm-FZ
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 21:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135AbYCAUZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 15:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757816AbYCAUZV
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 15:25:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbYCAUZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 15:25:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C2F41615;
	Sat,  1 Mar 2008 15:25:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F0A5F1612; Sat,  1 Mar 2008 15:25:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75696>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> @@ -49,6 +49,9 @@ OPTIONS
>  	required; if not, it exits without performing any work.
>  	Some git commands run `git gc --auto` after performing
>  	operations that could create many loose objects.
> +
> +--quiet::
> +	Suppress all progress reports.
>  +
>  Housekeeping is required if there are too many loose objects or
>  too many packs in the repository. If the number of loose objects

Read the surrounding text again.  "Housekeeping is..." is talking about
the --auto option.

I'll move the description of --quiet a bit down.

> @@ -197,6 +199,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			append_option(argv_repack, buf, MAX_ADD);
>  		}
>  	}
> +	if (quiet) {
> +		append_option(argv_repack, "-q", MAX_ADD);
> +	}

No { } around a single statement.

No need to resend, as I've already munged your patch and applied.

Thanks.
