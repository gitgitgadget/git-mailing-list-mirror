From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 next 0/4] format-patch --cover-letter --in-reply-to
Date: Fri, 20 Feb 2009 20:55:36 +0100
Message-ID: <cover.1235158956.git.trast@student.ethz.ch>
References: <alpine.LNX.1.00.0902191734110.19665@iabervon.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LabV2-0006tb-M1
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 20:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbZBTTzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 14:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbZBTTzy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 14:55:54 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:36209 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbZBTTzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 14:55:53 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:51 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:51 +0100
X-Mailer: git-send-email 1.6.2.rc1.310.ga3b4a
In-Reply-To: <alpine.LNX.1.00.0902191734110.19665@iabervon.org>
X-OriginalArrivalTime: 20 Feb 2009 19:55:51.0428 (UTC) FILETIME=[3B7DCC40:01C99395]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110879>

Daniel Barkalow wrote:
> On Thu, 19 Feb 2009, Thomas Rast wrote:
> 
> > Currently, format-patch can only track a single reference (the
> > In-Reply-To:) for each mail.  To ensure proper threading, we should
> > list all known references for every mail.
> > 
> > Change the rev_info.ref_message_id field to a string_list
> 
> It would be nice to change the field name to "ref_message_ids", which is 
> more likely to suggest that it's a list of ids, rather than a single id 
> stored strangely.

Good point, I changed that.

> Aside from that, parts 2-4 look good to me (I'm not up on reviewing shell 
> code).

Thanks.

I also noticed that there is a textual conflict with 0db5260 (Enable
setting attach as the default in .gitconfig for git-format-patch.,
2009-02-12), which is already in 'next'.  So I rebased the series to
'next'.



Thomas Rast (4):
  format-patch: threading test reactivation
  format-patch: track several references
  format-patch: thread as reply to cover letter even with in-reply-to
  format-patch: support deep threading

 Documentation/config.txt           |   10 ++
 Documentation/git-format-patch.txt |   10 ++-
 builtin-log.c                      |   66 ++++++++--
 log-tree.c                         |   11 +-
 revision.h                         |    2 +-
 t/t4014-format-patch.sh            |  265 ++++++++++++++++++++++++++++++------
 6 files changed, 308 insertions(+), 56 deletions(-)
