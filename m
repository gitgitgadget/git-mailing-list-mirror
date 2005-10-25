From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: gitweb: charset problem
Date: Tue, 25 Oct 2005 12:01:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510251138290.25300@iabervon.org>
References: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.64.0510241743280.25300@iabervon.org> <7vwtk2k08z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 18:10:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EURGJ-0006Xl-F3
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 18:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVJYQBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVJYQBs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 12:01:48 -0400
Received: from iabervon.org ([66.92.72.58]:30738 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932190AbVJYQBr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 12:01:47 -0400
Received: (qmail 6057 invoked by uid 1000); 25 Oct 2005 12:01:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2005 12:01:15 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtk2k08z.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10594>

On Mon, 24 Oct 2005, Junio C Hamano wrote:

> > IIRC, we actually define that to be UTF-8, unlike most of the
> > other stuff, for which we don't actually insist on a policy.
> 
> No, we do not define nor insist on a particluar policy as far as
> I know.  We suggest the use of UTF-8 merely from common sense to
> help interoperability, and make UTF-8 slightly easier to use
> than other encodings by giving specific support for it in some
> tools, namely -u flag in git-mailinfo.

I thought we'd decided on uninterpreted byte values for blobs, filenames, 
and trees (and everything in the working tree), but using UTF-8 for tag 
and commit objects.

Consider if you started a project in EUC-JP, and then decided to switch to 
UTF-8 later (when your environment handled it cleanly, perhaps). You could 
convert all the file contents and move files to re-encoded names, but 
you'd then want to commit these changes and have the log before and after 
simultaneously intelligable.

> [Footnote]
> 
> *1* For example, I've never made GNU emacs to work well with
> Japanese in UTF-8 , so if people in my company internal project
> wanted to use Japanese in commit logs, I would probably
> standardize on EUC-JP for such a project.  Luckily so far I have
> not been forced to make that decision.

It wouldn't be hard to convert at some point between the editor and the 
commit object, and you don't re-edit the commit objects like you do 
tracked files. It probably wouldn't even be hard for commit-tree to 
convert its input based on locale. (And stuff which prints commit contents 
for user consumption probably ought to re-encode it if necessary, too)

	-Daniel
*This .sig left intentionally blank*
