From: jidanni@jidanni.org
Subject: why not preserve file permissions?
Date: Sat, 06 Dec 2008 04:08:08 +0800
Message-ID: <87tz9igzbr.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 21:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8h57-0000Qi-N6
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 21:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbYLEUN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 15:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbYLEUN5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 15:13:57 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:47223 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753148AbYLEUN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2008 15:13:56 -0500
Received: from jidanni2.jidanni.org (122-127-32-222.dynamic.hinet.net [122.127.32.222])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id E7E81119E0F
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 12:13:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102409>

Why not preserve permissions the way you find them, instead of just
using 644 and 755? It certainly couldn't be more complicated than what
you are doing now, and that way one could do things like use git to
update system administration files across a sneakernet containing e.g.,
# dlocate -lsconf exim4-config|sed 's/ .*//'|sort -u
-rw-r-----
-rw-r--r--
-rwxr-xr-x

> git was made for tracking source code, not 640 files.

On the sneakernet no public patches would be sent, and the
administrator would remember to make the sensitive .git directories
700. And sure, git should enforce umask or no set-uid or whatever when
doing a checkout etc. The deluxe edition of git could even print a
warning: "you are trying to track a 640 file but your .git permissions
are less restrictive." However I recommend no premium or deluxe
editions for now.

> Patches welcome.

Trust me, you don't want "grandpa who forgot the parking brake"
anywhere near your code.
