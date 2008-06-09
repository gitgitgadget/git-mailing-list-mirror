From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-recursive: respect core.autocrlf
Date: Mon, 09 Jun 2008 16:23:00 -0700
Message-ID: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org>
 <484D3225.3020900@viscovery.net> <alpine.DEB.1.00.0806092221420.1783@racer>
 <alpine.DEB.1.00.0806092223010.1783@racer>
 <7vod6affz6.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806092305430.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qig-00028t-TZ
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbYFIXXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbYFIXXR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:23:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbYFIXXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:23:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EA555668;
	Mon,  9 Jun 2008 19:23:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B80415665; Mon,  9 Jun 2008 19:23:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 080ED632-367B-11DD-B1C0-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84451>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Mon, 9 Jun 2008, Junio C Hamano wrote:
>
> 	> Fairly straightforward fix, except that I suspect this needs to 
> 	> be done only for regular files and not symlinks.
> 	> 
> 	> I think entry.c:write_entry() shows how this should be done.
>
> 	Right.  And the relevant clause is actually already there.  D'oh.

Well, you actually have "double d'oh".  "This ought to be a symlink but
the filesystem is lacking, so we instead write out what the readlink from
such a symlink would return" codepath should not convert_to_worktree().

I'll fix it up, no need to resend.  Thanks for the fix.
