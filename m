From: "Ferry Huberts" <ferry.huberts@pelagic.nl>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 12:43:35 +0200 (CEST)
Message-ID: <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 12:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDcMF-0007g6-5p
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 12:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbZFHKni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 06:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbZFHKnh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 06:43:37 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:33910 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753353AbZFHKnh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 06:43:37 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id F090358BDD4; Mon,  8 Jun 2009 12:43:35 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 8 Jun 2009 12:43:35 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121058>

On Sun, June 7, 2009 16:33, Johannes Schindelin wrote:
> Hi,
>
> this mail informs you that Git for Windows 1.6.3.2 is out.  Soon is the
> time that we switch to git.git's master.
>
> - The user home directory is inferred from $HOMEDRIVE\$HOMEPATH instead of
>   $HOME (Issue 108).

this does not work for me.
win xp sp3, 32bits

with this patch it is fixed/reverted:

--- Program Files/Git/etc/profile.org	2009-06-08 12:31:29.968750000 +0200
+++ Program Files/Git/etc/profile	2009-06-08 12:31:16.718750000 +0200
@@ -29,7 +29,7 @@

 # Set up USER's home directory
 if [ -z "$HOME" -o ! -d "$HOME" ]; then
-  HOME="$HOMEDRIVE$HOMEPATH"
+  HOME="$USERPROFILE"
 fi

 if [ ! -d "$HOME" ]; then
