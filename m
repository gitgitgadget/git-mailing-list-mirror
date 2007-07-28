From: David Kastrup <dak@gnu.org>
Subject: Re: What's in git.git (stable)
Date: Sat, 28 Jul 2007 10:56:53 +0200
Message-ID: <85zm1g3nze.fsf@lola.goethe.zz>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 10:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEi6t-0004Lc-6L
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbXG1I5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 04:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758112AbXG1I5M
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:57:12 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:51340 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536AbXG1I5L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 04:57:11 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 1F6983664E9;
	Sat, 28 Jul 2007 10:57:10 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 10E89ABE0E;
	Sat, 28 Jul 2007 10:57:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-045.pools.arcor-ip.net [84.61.39.45])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id C5C5635E5A9;
	Sat, 28 Jul 2007 10:57:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6E7F61CFF95E; Sat, 28 Jul 2007 10:56:53 +0200 (CEST)
In-Reply-To: <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 28 Jul 2007 01\:47\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3795/Sat Jul 28 04:08:57 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54013>

Junio C Hamano <gitster@pobox.com> writes:

> It's been a while since I sent this the last time.
>
> We are nearing 1.5.3 final; I pulled gitk updates tonight, and
> expect git-gui updates to 0.8.0 over the weekend.  There are a
> handful trivial fixes since 1.5.3-rc3.

I'd like to see some changes for mergetool's Emacs support: in
moderately current versions of Emacs and XEmacs, ediff is a much
preferable tool to emerge.

Also, the mergetool determines when to use emerge for merging by
looking at the EDITOR/VISUAL variables.  While it recognizes the
presence of "emacsclient" and "gnuclient" there for offering the
emerge tool, it does not actually use those settings for calling
Emacs/XEmacs.  If you use the desktop package, this means that you get
a bear of a startup time while a _new_ instance of Emacs gets loaded
against the wishes of the setup, and the command line parameters will
be interpreted relatively to the last file restored into the desktop
rather than the current directory (arguably a bug in the desktop
package which I plan to fix eventually, but in the meantime the
current package is farspread).

I'll try to come up with a fix this weekend if nobody beats me to it.
As it stands, the mergetool is somewhere between subpar and unusable
by default for a considerable number of Emacs users.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
