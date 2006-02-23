From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: Fix to properly handle files with spaces, tabs, newlines, etc.
Date: Wed, 22 Feb 2006 17:07:47 -0800
Message-ID: <7vbqwylw64.fsf@assigned-by-dhcp.cox.net>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl>
	<87slqcs4y5.wl%cworth@cworth.org> <87r75ws48c.wl%cworth@cworth.org>
	<7vaccjst3x.fsf@assigned-by-dhcp.cox.net>
	<8764n7rl6s.wl%cworth@cworth.org> <873biasyew.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 02:08:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC4xa-0005vH-Nk
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 02:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWBWBHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 20:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWBWBHw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 20:07:52 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39840 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030356AbWBWBHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 20:07:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223010424.USBR17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 20:04:24 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <873biasyew.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	22 Feb 2006 16:37:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16628>

Carl Worth <cworth@cworth.org> writes:

>  Please ignore the previous patch. This is what I intended to send.

Ahh.  I was wondering...

>  (For as useful as the index is---and yes, I have found it very
>  useful---I still find it easy to inadvertently commit stale data with
>  it. I guess what might help me is a command to update into the index
>  all files that are currently in the "updated but not checked in (will
>  commit)" state as reported by git status. Does such a command exist?)

No.  I do not do this myself, but this one-liner should work:

	git diff --name-only "$@" | git update-index --stdin

[from another message]

> PS. What's the syntax/tool support for just replying to an existing
> message, and at the end inserting a patch with its own subject and
> commit message? Here I've manually whacked the subject and put the
> commit message above my reply (in the style of git-format-patch) but
> that seems inelegant.

YMMV depending on the MUA you use, of course.

I start [REPLY], have my MUA quote the original and write
response while trimming excess quote, just as usual.  When I
need to add a patch, then I remove all that with \C-w
(kill-region), read a format-patch output into the same mail
buffer, and then \C-y (yank) to paste the "usual correspondence"
part below the three-dash lines.  Yes, it's all manual.  I
presume it would be easy to write a few-liner Emacs macro to do
this though...
