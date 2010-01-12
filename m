From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/18] mailmap.c: remove unused function
Date: Mon, 11 Jan 2010 23:52:56 -0800
Message-ID: <1263282781-25596-14-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZU-0004h8-IH
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab0ALHxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480Ab0ALHxi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0ALHxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C7498E8A5;
	Tue, 12 Jan 2010 02:53:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=o6os
	iykbBZ2Q+tu94J2kl1QVr+M=; b=GwufFWncORLN7vLHwgR1ZCrLqW3Sti0nq7mZ
	IBw7vNIC9EZHMl2ism/75LACCeiWoIAx/5vds8dmRfWEszgiZcq+GMIkqbWfojuG
	6WobIjMUygXbdZ0pb07V4M7KpdUeoGhSJW1diHySp20162zMAVqujhcEyTR+EdIp
	tldPtlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DKboCBcRfKLH91g+zmwRUMlGZEpfsZLgGTYfftxaI8qjZu0Z2K0zPGMQ791wB2PJ
	kQDHsyDrKud60jfWKBeItfaDC/QJa269PnzlXR4O94EdWoVhIlvVStcxkAhbxx44
	wgIPPNTOPORXEi7MMOIsKcTwDPWAMcZgXd9+Ic6T1tE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 85AE78E8A4;
	Tue, 12 Jan 2010 02:53:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE6F78E8A3; Tue, 12 Jan
 2010 02:53:32 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 959A4A10-FF4F-11DE-A07A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136695>

map_email() is not used anywhere since d20d654 (Change current mailmap
usage to do matching on both name and email of author/committer.,
2009-02-08).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c |    5 -----
 mailmap.h |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index f167c00..b68c1fe 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -243,8 +243,3 @@ int map_user(struct string_list *map,
 	debug_mm("map_user:  --\n");
 	return 0;
 }
-
-int map_email(struct string_list *map, const char *email, char *name, int maxlen)
-{
-	return map_user(map, (char *)email, 0, name, maxlen);
-}
diff --git a/mailmap.h b/mailmap.h
index 4b2ca3a..d5c3664 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -4,7 +4,6 @@
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
 
-int map_email(struct string_list *mailmap, const char *email, char *name, int maxlen);
 int map_user(struct string_list *mailmap,
 	     char *email, int maxlen_email, char *name, int maxlen_name);
 
-- 
1.6.6.280.ge295b7.dirty
