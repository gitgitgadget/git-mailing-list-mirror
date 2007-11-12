From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff woes
Date: Mon, 12 Nov 2007 13:30:53 -0800
Message-ID: <7vhcjr2lte.fsf@gitster.siamese.dyndns.org>
References: <4738208D.1080003@op5.se>
	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgsH-0005BJ-2U
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXKLVbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbXKLVbB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:31:01 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47931 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbXKLVbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:31:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 213432FA;
	Mon, 12 Nov 2007 16:31:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A69B95032;
	Mon, 12 Nov 2007 16:31:17 -0500 (EST)
In-Reply-To: <47382C84.50408@op5.se> (Andreas Ericsson's message of "Mon, 12
	Nov 2007 11:35:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64712>

Andreas Ericsson <ae@op5.se> writes:

> In the check_ntpd.c program, there is no bug. I found the git diff output
> surprising, so I reported it.

This is what I get from "GNU diff -pu" which makes me surpried
that anybody finds "git diff" hunk header surprising.  Notice
that hunk at line 84.

--- read-cache.c	2007-11-12 12:08:00.000000000 -0800
+++ read-cache.c+	2007-11-12 12:07:54.000000000 -0800
@@ -60,7 +60,7 @@ static int ce_compare_data(struct cache_
 	return match;
 }
 
-static int ce_compare_link(struct cache_entry *ce, size_t expected_size)
+static int ce_compare_lonk(struct cache_entry *ce, size_t expected_size)
 {
 	int match = -1;
 	char *target;
@@ -84,7 +84,7 @@ static int ce_compare_link(struct cache_
 		match = memcmp(buffer, target, size);
 	free(buffer);
 	free(target);
-	return match;
+	return match + 0;
 }
 
 static int ce_compare_gitlink(struct cache_entry *ce)
