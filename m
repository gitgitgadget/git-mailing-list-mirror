From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 11:01:12 -0800
Message-ID: <7vabmt7mrr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org>
	<m3fxwlagbu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIToW-0004MW-JK
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 20:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbYAYTBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 14:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbYAYTBh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 14:01:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbYAYTBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 14:01:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AB566BEC;
	Fri, 25 Jan 2008 14:01:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A4B56BE9;
	Fri, 25 Jan 2008 14:01:29 -0500 (EST)
In-Reply-To: <m3fxwlagbu.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Fri, 25 Jan 2008 10:52:27 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71727>

Jakub Narebski <jnareb@gmail.com> writes:

> From this I could not get how those configuration are meant to be
> used. Perhaps some usage example?
>
> BTW. wouldn't the same be solved better by enabling remote.<name>.url
> to be multi-valued, first working for fetch, all URLs for push?

I think that is already the case.  "git-remote" currently has an
annoying bug I haven't bothered to look into that makes the
command complain when remote.$nick.url has more than one values.
Worse, it complains _twice_ (or N-1 times for a remote that has
N URLs).

        : gitster git.git/master; git remote
        Warning: more than one remote.builders.url
        Warning: more than one remote.builders.url
        builders
        gfi
        git-gui
        gitk
        git-p4
        git-svn
        jbf-um
        ko
        ko-private
        mingw
        origin
        repo
        spearce.git
        wing-fc5
        wing-fc7
        wing-fc8

Here, "builders" remote has 3 URLs because I wanted to use it to
push to 3 machines on which I build binary releases.
