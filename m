From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 09 Nov 2012 23:52:50 +0200
Message-ID: <87a9uq5tql.fsf@Niukka.kon.iki.fi>
References: <20121109192336.GA9401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 23:01:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWwdb-0003pS-1y
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 23:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab2KIWBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 17:01:06 -0500
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:44616 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755851Ab2KIWBE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2012 17:01:04 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2012 17:01:04 EST
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id D00E83F9A9
	for <git@vger.kernel.org>; Fri,  9 Nov 2012 23:51:30 +0200 (EET)
X-Virus-Scanned: DNA Postiturva at dnainternet.net
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id z06-xS1N7rcE for <git@vger.kernel.org>;
	Fri,  9 Nov 2012 23:51:30 +0200 (EET)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net [83.102.40.212])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 3EE8E3F855
	for <git@vger.kernel.org>; Fri,  9 Nov 2012 23:51:30 +0200 (EET)
Received: from Niukka.Niemitalo.private (85-131-104-149.bb.dnainternet.fi [85.131.104.149])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 219AB2BAF4
	for <git@vger.kernel.org>; Fri,  9 Nov 2012 23:51:29 +0200 (EET)
In-Reply-To: <20121109192336.GA9401@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 9 Nov 2012 14:23:36 -0500")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209251>

Jeff King <peff@peff.net> writes:

>  Comments welcome from people using unusual editors (e.g., a script that
>  starts an editor in another window then blocks, waiting for the user to
>  finish).

I often run a shell in Emacs in X, then start git commit in that
shell.  $EDITOR is emacsclient --current-frame, which asks the
existing Emacs instance to load the file and waits until I press
C-x # in Emacs to mark the file done.  If I want to abort the
commit, it is most intuitive to return to the *Shell* buffer in
Emacs and press C-c C-c (comint-interrupt-subjob) to send SIGINT
to git from there.  (I see that "an empty message aborts the
commit", and indeed it does, but well, I prefer not to trust such
a feature if I can instead just interrupt the thing.)

With pf/editor-ignore-sigint, C-c C-c in the *Shell* buffer kills
neither git nor the emacsclient started by git.  This is not good.
SIGQUIT from C-c C-\ (comint-quit-subjob) still works though.
