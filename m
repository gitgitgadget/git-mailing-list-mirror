From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Thu, 2 Aug 2007 12:10:56 +0200
Message-ID: <20070802101056.GA31182@moooo.ath.cx>
References: <86abtbnzpr.fsf@lola.quinscape.zz> <7vd4y75gcy.fsf@assigned-by-dhcp.cox.net> <85r6mnrs1z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXeF-0005RH-65
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbXHBKLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbXHBKLI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:11:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:34937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752800AbXHBKLF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:11:05 -0400
Received: (qmail invoked by alias); 02 Aug 2007 10:11:02 -0000
Received: from pD9EBB361.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.179.97]
  by mail.gmx.net (mp051) with SMTP; 02 Aug 2007 12:11:02 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18TnIlVjaET8OgYewuL9IKIn3TqbTLC/GWjRXQaWF
	+dHGHmb3lAXtg9
Content-Disposition: inline
In-Reply-To: <85r6mnrs1z.fsf@lola.goethe.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54535>

David Kastrup <dak@gnu.org> wrote:
> a) Using system and shell-quoting the filename.  Advantage: one can
> set EDITOR='"/home/dak/My Programs/editor"' and have it work.
> Disadvantage: shell-quoting a file name seems shell- and
> system-dependent.

What about this instead of quoting the argument?

    sh -c '$EDITOR "$1" "$2"' editor +5 /path/to/file

(i.e. for C execvp("/bin/sh", "-c", "$EDITOR \"$1\" \"$2\"", "editor",
    "+5", "/path/to/file"))
