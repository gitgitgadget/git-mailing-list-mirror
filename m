From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sun, 5 Feb 2006 00:04:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602042346380.25300@iabervon.org>
References: <20060203114133.GA11499@kvasir.watson.ibm.com>
 <7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net> <20060205003741.GB29021@kvasir.watson.ibm.com>
 <7voe1msef0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Amos Waterland <apw@us.ibm.com>, git@vger.kernel.org,
	boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Sun Feb 05 06:02:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5c2r-0002ai-9K
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 06:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWBEFCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 00:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWBEFCS
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 00:02:18 -0500
Received: from iabervon.org ([66.92.72.58]:57102 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030264AbWBEFCR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 00:02:17 -0500
Received: (qmail 16140 invoked by uid 1000); 5 Feb 2006 00:04:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2006 00:04:40 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe1msef0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15619>

On Sat, 4 Feb 2006, Junio C Hamano wrote:

> I know of an editor that works fine even when invoked with
> TERM=dumb, and I explicitly told programs to use it by exporting
> EDITOR environment variable with the name of that editor.  I am
> entitled to expect that programs honor that wish, instead of
> insulting me by saying "Hey dummy, you cannot run any editor on
> a dumb terminal".  Be the editor "emacsclient" or "ed", they
> both work fine for me, thank you ;-).

I think that "ed" is a bit too obscure as something for people to use 
interactively, and emacsclient is obviously not a sane default (since 
people might not be using emacs in server mode). Probably the right thing 
is to have it supply a default if the terminal isn't dumb, and abort with 
an error if there is no editor set after defaults are supplied.

(I think the only editors people use in dumb terminals these days are ones 
that do the editing somewhere else, although I'm not sure of that.)

	-Daniel
*This .sig left intentionally blank*
