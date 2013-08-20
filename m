From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 15:40:02 +0200
Message-ID: <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <peff@peff.net>, <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 15:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmAM-0002uQ-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 15:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab3HTNkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 09:40:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:56606 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab3HTNkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 09:40:04 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 20 Aug
 2013 15:39:57 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 20 Aug 2013 15:40:02 +0200
In-Reply-To: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Tue, 20 Aug 2013 15:22:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232595>

Stefan Beller <stefanbeller@googlemail.com> writes:

> The condition as it is written in that line was most likely intended to
> check for the pointer passed to free(), rather than checking for the
> 'repo_abbrev', which is already checked against being non null at the
> beginning of the function.
[...]
> -			if (repo_abbrev)
> +			if (*repo_abbrev)
>  				free(*repo_abbrev);

But now the test is useless, because free(NULL) is defined to be a
no-op.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
