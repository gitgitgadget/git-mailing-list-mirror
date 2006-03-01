From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: What's in git.git
Date: Wed, 1 Mar 2006 15:01:53 -0800
Message-ID: <20060301230153.GA32286@agluck-lia64.sc.intel.com>
References: <7vmzgagxox.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 00:02:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEaKe-000498-3W
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 00:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWCAXCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 18:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCAXB7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 18:01:59 -0500
Received: from fmr22.intel.com ([143.183.121.14]:43413 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751945AbWCAXB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 18:01:57 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k21N1suj023240;
	Wed, 1 Mar 2006 23:01:54 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k21N1qmh008322;
	Wed, 1 Mar 2006 23:01:52 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id E87FF19F63;
	Wed,  1 Mar 2006 15:01:53 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k21N1rSu032298;
	Wed, 1 Mar 2006 15:01:53 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzgagxox.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17026>

On Wed, Mar 01, 2006 at 04:24:14AM -0800, Junio C Hamano wrote:
> * The 'master' branch has these since the last announcement.
>   - compilation warning fixes (Timo Hirvonen, Tony Luck, Andreas Ericsson)

In commit 8fcf1ad9c68e15d881194c8544e7c11d33529c2b you put in a
combination of my double cast and Andreas' switch to using
unsigned long ... just the latter is sufficient (and a lot less
ugly than using the double cast).

Signed-off-by: Tony Luck <tony.luck@intel.com>

--

diff --git a/pack-objects.c b/pack-objects.c
index 21ee572..136a7f5 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -99,7 +99,7 @@ static int reused_delta = 0;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
-	unsigned long ui = (unsigned long)(long)p;
+	unsigned long ui = (unsigned long)p;
 	int i;
 
 	ui = ui ^ (ui >> 16); /* defeat structure alignment */
