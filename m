From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 14:17:25 +0000
Message-ID: <20060706141725.28115.qmail@775c2aaf180a85.315fe32.mid.smarden.org>
References: <20060706124025.G325584e9@leonov.stosberg.net> <20060706161011.ccc2ea1c.tihirvon@gmail.com> <E1FyUNT-0007Ko-JR@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Dennis Stosberg <dennis@stosberg.net>
X-From: git-owner@vger.kernel.org Thu Jul 06 16:17:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyUfG-0002YB-PL
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 16:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWGFORH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 10:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWGFORH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 10:17:07 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59104 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1030275AbWGFORG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 10:17:06 -0400
Received: (qmail 28116 invoked by uid 1000); 6 Jul 2006 14:17:25 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Timo Hirvonen <tihirvon@gmail.com>,
	Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <E1FyUNT-0007Ko-JR@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23390>

On Thu, Jul 06, 2006 at 03:58:47PM +0200, Matthias Lederhofer wrote:
> This will not work with spaces in $PATH. I'd do something like this if
> cut is portable (I have only freebsd and linux to test):

This should work with shell/builtins only, no sed/cut:

 path=${PATH}:
 while test -n "$path"; do
   p=${path%%:*}/$1
   test ! -x "$p" || { echo "$p"; return 0; }
   path=${path#*:}
 done
 test ! -x "$1" || { echo "$1" && return 0; }
 return 1

Regards, Gerrit.
