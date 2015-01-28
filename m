From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] config.txt: clarify that add.ignore-errors is deprecated
Date: Wed, 28 Jan 2015 14:33:11 -0800
Message-ID: <1422484393-4414-2-git-send-email-gitster@pobox.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
 <1422484393-4414-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 02:12:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdev-0002eJ-GF
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbbA2BMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:12:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751702AbbA2BM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:12:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19B4533A8D;
	Wed, 28 Jan 2015 17:33:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yLvZ
	wKCt5AuRGbEDhnruBlFLbMU=; b=OvX9W0S/PVQs8slFfMRktA0mhRNBcqM97GLF
	iCASFVfhLo+KGiy6DtmK8X0X57Vj3RHOdYVWNo6BCe7Xk9RgDlPhk41KG20ZC+9G
	hDq3L2+LtAe/dchUs9gZMlFG8wXvvNWb1LpSOH4l7HpE/qkT4W/wddbA+5/lajhw
	RLOrt1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=L6PdwB
	6+4W1Anwx3MoHcZ6IN1W7UQlUZEr5Wp/gqmVXvEdlASuKhvyK/pQiHnw/igk8Uef
	BWgReQLQHBfuu+eIMF+UcqceZaQGJYSd5Pi4hKinzUova1K1RdadCkZKx10rGfpe
	7ha9+9MGif5lKWzrNApnAGls1R6zC37Tg2zyY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E47933A8C;
	Wed, 28 Jan 2015 17:33:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8595E33A8B;
	Wed, 28 Jan 2015 17:33:16 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-149-gdd42ee9
In-Reply-To: <1422484393-4414-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A70ED284-A73D-11E4-B94E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263123>

The old text gave an impression that even in a new repository using
old form might be safer.  Only Git from pre 1.7.0 days choke on the
correctly named variable, which is ancient by today's standard.

We have no intention to remove the support for deprecated ones, but
let's make sure that we do not give room for confused questions such
as "why does core.sparse-checkout not work, when add.ignore-errors
does?"

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0a4d22a..69f30d6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -664,14 +664,13 @@ core.abbrev::
 	for abbreviated object names to stay unique for sufficiently long
 	time.
 
-add.ignore-errors::
 add.ignoreErrors::
+add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
-	option of linkgit:git-add[1].  Older versions of Git accept only
-	`add.ignore-errors`, which does not follow the usual naming
-	convention for configuration variables.  Newer versions of Git
-	honor `add.ignoreErrors` as well.
+	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
+	as it does not follow the usual naming convention for configuration
+	variables.
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
-- 
2.3.0-rc2-149-gdd42ee9
