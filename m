From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git add: rephrase -A/--no-all warning
Date: Mon, 22 Apr 2013 13:43:55 -0700
Message-ID: <1366663435-13598-3-git-send-email-gitster@pobox.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
 <1366663435-13598-1-git-send-email-gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 22:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNav-0002UE-BA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab3DVUoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:44:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab3DVUoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 16:44:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C4FA18198;
	Mon, 22 Apr 2013 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vf7m
	OZAZRnzQFQ+bDj5IWEBA/YI=; b=rR/o0hMqJ+5jsot2rpACFCgtvr4fEBOknXvD
	GWsOYnoIevHKIhScyhO32HzoUdnsMO2ivK08WxwjoYI2T50AlIt/v7ygVTgsNg+p
	ujq/ES9J+PTgXGp+Wzn3OSxveHw8FJ6BKqh81sxXUPcU76ccAmN3Y20/u9xgf3Qb
	8UPN38U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	IeVUMHyismRrem5HVRHiRbiy8x4a3JMdrRYwmC4LJRl2wojMZBIGtsoAb4yDWA18
	QjssDZqx+w7nVnmyM2+PGMjd0G4J12MOT77KgTssjMblExwmj2dbFe0rGlMrpCbZ
	09EiD9njjOxIthCCZfdkCrpPozg2m6EOw53ezUJrG2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 516CB18197;
	Mon, 22 Apr 2013 20:44:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6A2118193;
	Mon, 22 Apr 2013 20:44:00 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-683-g39c426e
In-Reply-To: <1366663435-13598-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5CA47012-AB8D-11E2-8FD7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222089>

With the synonym "--ignore-removal" for "--no-all", we can rephrase
the Git 2.0 transition warning message in a more natural way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index aefbc45..c55615b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -97,13 +97,13 @@ static int fix_unmerged_status(struct diff_filepair *p,
 }
 
 static const char *add_would_remove_warning = N_(
-	"You ran 'git add' with neither '-A (--all)' or '--no-all', whose\n"
-"behaviour will change in Git 2.0 with respect to paths you removed from\n"
-"your working tree. Paths like '%s' that are\n"
-"removed are ignored with this version of Git.\n"
+	"You ran 'git add' with neither '-A (--all)' or '--ignore-removal',\n"
+"whose behaviour will change in Git 2.0 with respect to paths you removed.\n"
+"Paths like '%s' that are\n"
+"removed from your working tree are ignored with this version of Git.\n"
 "\n"
-"* 'git add --no-all <pathspec>', which is the current default, ignores\n"
-"  paths you removed from your working tree.\n"
+"* 'git add --ignore-removal <pathspec>', which is the current default,\n"
+"  ignores paths you removed from your working tree.\n"
 "\n"
 "* 'git add --all <pathspec>' will let you also record the removals.\n"
 "\n"
-- 
1.8.2.1-683-g39c426e
