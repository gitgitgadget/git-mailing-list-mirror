From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Bug: /usr/local/bin/git-daemon starts /usr/sbin/git-upload-pack?
Date: Wed, 9 Jul 2008 22:20:10 +0200
Message-ID: <200807092220.10655.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:21:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGgA8-0000m6-Iu
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYGIUUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 16:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbYGIUUR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 16:20:17 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:4457 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYGIUUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 16:20:16 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m69KKBdZ070121
	for <git@vger.kernel.org>; Wed, 9 Jul 2008 22:20:15 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87908>

Hi,

After upgrade to SuSE 11.0 I was forced to update GIT (changed libcurl).
I did (with some trickery) a pull of the latest git and built it using
make prefix=/usr/local ..., to find out that /usr/local/bin/git-daemon
starts /usr/sbin/git-upload-pack.

After creating a symlink to /usr/local/bin/git-upload-pack all works fine
again, but I guess this is a mistake?

	Cheers --- Jan

P.s.	This is quite nasty to debug.  I was forced to to run git-daemon
	stand-alone (not xinetd) another port and run strace -f -p <pid>
	to discover the	cause of this problem.  Even with --verbose, the
	only error response was the client complaining on unexpected EOF.
