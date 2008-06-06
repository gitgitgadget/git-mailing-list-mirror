From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and run git.
Date: Fri, 06 Jun 2008 15:39:21 -0400
Message-ID: <87bq2ez72u.fsf@jeremyms.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 21:40:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4hna-0001kq-3b
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 21:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbYFFTjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 15:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754692AbYFFTjh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 15:39:37 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:51600 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYFFTjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 15:39:36 -0400
Received: from [128.237.246.44] (helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1K4hme-0003re-RG; Fri, 06 Jun 2008 15:39:32 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com> (Boyd Lynn
	Gerber's message of "Fri, 6 Jun 2008 13:34:03 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84101>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

[snip]

> diff --git a/progress.c b/progress.c
> index d19f80c..11a0841 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress **p_progress, const
> char *msg)
>  	*p_progress = NULL;
>  	if (progress->last_value != -1) {
>  		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		/* char buf[strlen(msg) + 5]; */
> +		char *buf = malloc (strlen(msg) + 5 );

This change will result in the allocated memory being leaked, which is
probably not correct.  Perhaps change it to alloca instead.

-- 
Jeremy Maitin-Shepard
