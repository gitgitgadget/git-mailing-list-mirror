From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t7005-editor.sh: Don't invoke real vi when it is in
 GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 18:31:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111829250.4362@racer.site>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
 <1194802691-27610-1-git-send-email-B.Steinbrink@gmx.de>
 <Pine.LNX.4.64.0711111742010.4362@racer.site>
 <2AE2E502-7942-449E-B847-75876A5DAF37@silverinsanity.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1498005555-1194805865=:4362"
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>, aroben@apple.com,
	git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrHaz-0005Ry-My
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 19:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbXKKSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 13:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbXKKSb2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 13:31:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:57631 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754045AbXKKSb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 13:31:28 -0500
Received: (qmail invoked by alias); 11 Nov 2007 18:31:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp049) with SMTP; 11 Nov 2007 19:31:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YyqVOQJ7YeiNbz+bMw0SNcxO2aC6bW10RejpO+K
	s05U9xxj0MBFIt
X-X-Sender: gene099@racer.site
In-Reply-To: <2AE2E502-7942-449E-B847-75876A5DAF37@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64492>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1498005555-1194805865=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Brian, hi Björn,

On Sun, 11 Nov 2007, Brian Gernhardt wrote:

> On Nov 11, 2007, at 12:44 PM, Johannes Schindelin wrote:
> 
> > Probably git-commit executes your installed write-tree, commit-tree 
> > and friends, instead of the compiled ones.
> 
> You are wrong there.  From exec_cmd.c:setup_path() (lines 51-54):
> 
>    add_path(&new_path, argv_exec_path);
>    add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
>    add_path(&new_path, builtin_exec_path);
>    add_path(&new_path, cmd_path);

Ah, I forgot that --exec-path=<path> did not override GIT_EXEC_PATH.  
Thanks for clarifying!  Your patch is obviously good, then.

Ciao,
Dscho

--8323584-1498005555-1194805865=:4362--
