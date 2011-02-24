From: Marco <netuse@lavabit.com>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 19:45:14 +0100
Message-ID: <20110224194514.2ca47772@glyph>
References: <20110224112246.3f811ac2@glyph>
	<7v7hcp2vi6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 19:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsgCE-0003ss-3k
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 19:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab1BXSp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 13:45:29 -0500
Received: from lo.gmane.org ([80.91.229.12]:55066 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756226Ab1BXSp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 13:45:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PsgBp-0003gS-G6
	for git@vger.kernel.org; Thu, 24 Feb 2011 19:45:25 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 19:45:25 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 19:45:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167846>

On 2011-02-24 Junio C Hamano <gitster@pobox.com> wrote:

> > I don't understand why there's not switch (is there?) for commit to
> > commit new and deleted files, like -A for git add?
> 
> Historical accident.  In the early days of git, there was no .gitignore
> mechanism, so a mode that operates on everything under the working tree
> was almost always an undesired thing to have (think *.o files).
> 
> Then .gitignore mechanism came, and "add ." has become usable.  But
> "commit -a" has been widely used way before that.
> 
> If you look at "commit -a" within that context, you would understand why
> it should only look at the paths git knows about.
> 
> Of course, "add -A" is a much later invention.  The option was named "-A"
> with capital letter, even though there is no "add -a".
> 
> This was because I knew we would eventually want to have "commit -A" that
> grabs everything and new files (honoring the gitignore mechanism), and
> aimed for consistency between "add -A" that I was adding, and "commit -A"
> that was yet to be written.  See 3ba1f11 (git-add --all: add all files,
> 2008-07-19).
> 
> I think it now is sensible to add "commit -A" if somebody is inclined to
> do so.  Nobody felt the need for it strongly enough to do so, it seems.

Thank you for the detailed explanation.

To sum this up: -A would be a nice-to-have feature but it's not necessary to
implement since we have add -A. But if I'm willing to implement it myself I'm
free to do that.


Regards
Marco
