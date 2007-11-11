From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t7005-editor.sh: Don't invoke real vi when it is in
 GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 17:44:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111742010.4362@racer.site>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
 <1194802691-27610-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-87721356-1194803054=:4362"
Cc: benji@silverinsanity.com, aroben@apple.com, dak@gnu.org,
	git@vger.kernel.org
To: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGrS-0008J3-H9
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbXKKRo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbXKKRo1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:44:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:53413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756142AbXKKRo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:44:26 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:44:24 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp055) with SMTP; 11 Nov 2007 18:44:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ijc5qtydIkRpxEdTfzTn5J/466ELf7V7h8w6Qw/
	+cCgWfcC4YMcUI
X-X-Sender: gene099@racer.site
In-Reply-To: <1194802691-27610-1-git-send-email-B.Steinbrink@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64486>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-87721356-1194803054=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 11 Nov 2007, Björn Steinbrink wrote:

> The git wrapper executable always prepends the GIT_EXEC_PATH build
> variable to the current PATH, so prepending "." to the PATH is not
> enough to give precedence to the fake vi executable.
> 
> The --exec-path option allows to prepend a directory to PATH even before
> GIT_EXEC_PATH (which is added anyway), so we can use that instead.

Hmm.  This will probably stop working when you do not have git installed, 
because you now tell git to search for git programs in ".", where they are 
not.  Probably git-commit executes your installed write-tree, commit-tree 
and friends, instead of the compiled ones.

Ciao,
Dscho

--8323584-87721356-1194803054=:4362--
