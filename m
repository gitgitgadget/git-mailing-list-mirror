From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Convention for help in git commands?
Date: Tue, 25 Oct 2005 15:08:43 +0200
Message-ID: <200510251508.43552.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 15:10:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUOYE-00017e-6b
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 15:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJYNIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 09:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVJYNIn
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 09:08:43 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:15862 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751188AbVJYNIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 09:08:43 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id C258B2350
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 15:08:39 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10585>

Hi,

is there a commonly accepted way how to handle help messages
in git commands? In git-mv/git-rename, there is a full help
message with description of options when "-h" is given.
This seems to be the Cogito way; git commands seem to be used
to output an one-liner usage only, and rely on the man
page otherwise.

This should be more consistent. Proposal:
* All git commands should react on command line option "-h"
for help, dumping a few lines to stderr, prefixed by "usage:", giving
the command usage without further descriptions. For the usage
output, use the base name of the command, and not the absolute
path to the binary.
* For commands which need at least one argument, the usage
is also printed, if the command is run without argument
* On a error condition, prefix the message with "error:", and
do not print out anything else (like the usage line, or things
produced by the PERL "die", which appends "at scriptname line nn").

Perhaps these things should be done only for commands of the
git lightwight porcelain?

Josef
