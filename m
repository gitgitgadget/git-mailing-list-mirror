From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as static"
Date: Sat, 2 Mar 2013 20:16:13 +0100
Message-ID: <87haktwr2a.fsf@pctrast.inf.ethz.ch>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Mar 02 20:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBrvM-0001xu-2T
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 20:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab3CBTQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 14:16:16 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:18573 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab3CBTQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 14:16:16 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 2 Mar
 2013 20:16:09 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 2 Mar
 2013 20:16:13 +0100
In-Reply-To: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
	(John Keeping's message of "Sat, 2 Mar 2013 12:46:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217333>

John Keeping <john@keeping.me.uk> writes:

> This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
>
> CGit uses these symbols to output the correct HTML around graph
> elements.  Making these symbols private means that CGit cannot be
> updated to use Git 1.8.0 or newer, so let's not do that.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>
> I realise that Git isn't a library so making the API useful for outside
> projects isn't a priority, but making these two methods public makes
> life a lot easier for CGit.
>
> Additionally, it seems that Johan added graph_set_column_colors
> specifically so that CGit should use it - there's no value to having
> that as a method just for its use in graph.c and he was the author of
> CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).

Perhaps you could add a comment in the source to prevent this from
happening again?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
