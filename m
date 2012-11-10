From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 10:52:09 -0500
Message-ID: <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
References: <20121109192336.GA9401@sigill.intra.peff.net> <87a9uq5tql.fsf@Niukka.kon.iki.fi> (sfid-20121109_170108_918500_78DEE168)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sat Nov 10 16:52:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXDM9-0003b8-19
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 16:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab2KJPwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 10:52:12 -0500
Received: from colo.foxharp.net ([166.84.7.52]:60646 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab2KJPwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 10:52:10 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id 70420540E4;
	Sat, 10 Nov 2012 10:49:17 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 406)
	id 75EFC2E8B68; Sat, 10 Nov 2012 10:52:09 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 73FE92E8985;
	Sat, 10 Nov 2012 10:52:09 -0500 (EST)
In-reply-to: <87a9uq5tql.fsf@Niukka.kon.iki.fi> (sfid-20121109_170108_918500_78DEE168)
Content-ID: <4294.1352562729.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209281>

kalle olavi niemitalo wrote:
 > Jeff King <peff@peff.net> writes:
 > 
 > >  Comments welcome from people using unusual editors (e.g., a script that
 > >  starts an editor in another window then blocks, waiting for the user to
 > >  finish).
 > 
 > I often run a shell in Emacs in X, then start git commit in that
 > shell.  $EDITOR is emacsclient --current-frame, which asks the
 > existing Emacs instance to load the file and waits until I press
 > C-x # in Emacs to mark the file done.  If I want to abort the
 > commit, it is most intuitive to return to the *Shell* buffer in
 > Emacs and press C-c C-c (comint-interrupt-subjob) to send SIGINT
 > to git from there.  (I see that "an empty message aborts the
 > commit", and indeed it does, but well, I prefer not to trust such
 > a feature if I can instead just interrupt the thing.)
 > 
 > With pf/editor-ignore-sigint, C-c C-c in the *Shell* buffer kills
 > neither git nor the emacsclient started by git.  This is not good.
 > SIGQUIT from C-c C-\ (comint-quit-subjob) still works though.

when i implemented the change, i wondered if some twisted emacs
workflow would be an issue. ;-)  and i almost blocked SIGQUIT as
well -- the two programs i looked at for precedent (CVS and MH) both
block both SIGQUIT and SIGINT when spawning an editor.

but since emacs users must have dealt with CVS for a long time before
dealing with git, how might they have done so?

the existing git behavior is bad for non-emacs users, and git itself
provides an abort-the-operation mechanism (i.e., writing an empty
message), so i'm not convinced your use case invalidates the new
behavior.  (though it might spotlight a need for this being prominent
in release notes.)

paul
=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 40.6 degrees)
