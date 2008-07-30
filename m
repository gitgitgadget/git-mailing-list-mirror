From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 13:01:03 -0700
Message-ID: <7vtze73zwg.fsf@gitster.siamese.dyndns.org>
References: <20071205172125.GF12636@yugib.highrise.ca>
 <20080730184956.GF10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Boyd Lynn Gerber <gerberb@zenez.com>
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHsW-0003qO-L7
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbYG3UBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756660AbYG3UBN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:01:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbYG3UBM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:01:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26D46431B1;
	Wed, 30 Jul 2008 16:01:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 55F26431B0; Wed, 30 Jul 2008 16:01:06 -0400 (EDT)
In-Reply-To: <20080730184956.GF10399@yugib.highrise.ca> (Aidan Van Dyk's
 message of "Wed, 30 Jul 2008 14:49:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 41A31F56-5E72-11DD-9FE7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90845>

Aidan Van Dyk <aidan@highrise.ca> writes:

> SCO OpenServer also hides the definitions of (at least) u_short and
> friends if _XOPEN_SOURCE is defined.

I thought that was covered by 457bb45 (Port to 12 other Platforms., 2008-06-08).

> ---
> Same patch as last time, updated for current master.

Sign-off?

Boyd, does this make any of the earlier symbols you added redundant?

>
>  git-compat-util.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cf89cdf..42e3e0b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -39,7 +39,7 @@
>  /* Approximation of the length of the decimal representation of this type. */
>  #define decimal_length(x)      ((int)(sizeof(x) * 2.56 + 0.5) + 1)
>
> -#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
> +#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(__OPENSERVER__)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
> --
> 1.6.0.rc1.dirty
