From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 0/2] fix "log --graph" issues with uninteresting parents
Date: Fri, 23 May 2008 19:24:09 -0700
Message-ID: <1211595851-11992-1-git-send-email-adam@adamsimpkins.net>
References: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 04:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzjRq-0006aC-IE
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928AbYEXCYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 22:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757086AbYEXCYN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 22:24:13 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:58828 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbYEXCYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 22:24:12 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 420311B448A;
	Fri, 23 May 2008 22:24:12 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 27D491B423A;
	Fri, 23 May 2008 22:24:12 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 6A89514100C8; Fri, 23 May 2008 19:24:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.384.g3f697
In-Reply-To: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82790>

This fixes the issues pointed out by Junio when graphing commits that
have parents that aren't printed in the log output.

Adam Simpkins (2):
  graph API: fix graph mis-alignment after uninteresting commits
  graph API: don't print branch lines for uninteresting merge parents

 graph.c |   54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 44 insertions(+), 10 deletions(-)
