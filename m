From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Pushing into a repository with alternates
Date: Tue,  9 Sep 2008 01:27:06 -0700
Message-ID: <1220948830-3275-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 10:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyaD-0005K4-JB
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYIII1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbYIII1P
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:27:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbYIII1O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:27:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C2C2F5F88A
	for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E98F5F889 for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:13
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.415.g7bb82
X-Pobox-Relay-ID: 1AC58A30-7E49-11DD-99C3-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95351>

Here is a re-rolled series of the topic we discussed earlier.

Junio C Hamano (4):
  is_directory(): a generic helper function
  receive-pack: make it a builtin
  push: prepare sender to receive extended ref information from the receiver
  push: receiver end advertises refs from alternate repositories

 Makefile                                 |    2 +-
 abspath.c                                |   13 ++++++++-
 builtin-clone.c                          |    9 +-----
 builtin-fetch-pack.c                     |    2 +-
 receive-pack.c => builtin-receive-pack.c |   44 +++++++++++++++++++++++++++--
 builtin-send-pack.c                      |   21 +++++++++++---
 builtin.h                                |    1 +
 cache.h                                  |    9 +++++-
 connect.c                                |   17 +++++++++++-
 daemon.c                                 |   10 ++-----
 git.c                                    |    1 +
 rerere.c                                 |    3 +-
 sha1_file.c                              |   13 +++++++-
 transport.c                              |    4 +-
 14 files changed, 115 insertions(+), 34 deletions(-)
 rename receive-pack.c => builtin-receive-pack.c (91%)
