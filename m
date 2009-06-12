From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 0/6] send-email threading fixes
Date: Fri, 12 Jun 2009 12:49:26 +0200
Message-ID: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
References: <7vd49afjbv.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4KU-0001Hm-Ba
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZFLKtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZFLKtk
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:49:40 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39387 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbZFLKtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:49:39 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id C6AC81053DC41;
	Fri, 12 Jun 2009 12:49:40 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF4KK-0003TK-00; Fri, 12 Jun 2009 12:49:40 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <7vd49afjbv.fsf@alter.siamese.dyndns.org>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19SJms28bUvSUcO27cmk7HggMKGiyjTAHQP//Fq
	AJjkyvG8+oEDG4UULxyh15CmdVgCM1fJrfsr9qWoL2cr9nisql
	t27ouE1DhCehChRq3iCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121400>

Junio C Hamano, 12.06.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > HTH and I got everything explained correctly.
> 
> Now, you can summarize the series with a proper [0/6], perhaps modelling
> after how I explained the order of application and merge structure ;-).

OK, I'll try :)
For easier understanding I kept the wording from your reshuffled series.

[PATCH 1/6] add a test for git-send-email for non-threaded mails
[PATCH 2/6] send-email: fix non-threaded mails
[PATCH 3/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
[PATCH 4/6] add a test for git-send-email for threaded mails without chain-reply-to
[PATCH 5/6] send-email: fix threaded mails without chain-reply-to
[PATCH 6/6] send-email: fix a typo in a comment

The first three patches apply to the tip of 'maint', which is currently at
94af7c3 (Documentation: git-send-mail can take rev-list arg to drive
format-patch, 2009-06-11).  The first one exposes breakage introduced by
3e0c4ff and then the second one fixes it.

The last three patches apply to the tip of 'master'. Patch 4/6 exposes
breakage introduced by 15da108, patch 5/6 fixes it.

Changes compared to 'pu':

 * adjusted the description of 2/6 to hopefully add less confusion
 * changed the order of 4/6 and 5/6 and applied 5/6 directly on top of 4/6,
   since the regression was immediately noticable
 * also change test_expect_failure to test_expect_success in 5/6 then
 * instead of in the former merge commit a6f8abc "Merge branch
   'mh/master-send-email-threaded-fix' into mh/master-send-email"
