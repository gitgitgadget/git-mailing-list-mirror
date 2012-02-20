From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] xdiff: remove XDL_PATCH_* macros
Date: Sun, 19 Feb 2012 18:16:24 -0800
Message-ID: <1329704188-9955-2-git-send-email-gitster@pobox.com>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 03:16:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzInu-0007il-Iz
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 03:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab2BTCQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 21:16:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2BTCQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 21:16:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F24E777D9
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BB27
	oxDJUHBtqqwQ9ggSz0duME8=; b=q57CKHFhXQJHGTyXMlhUp4DmNE+XHse0I96/
	ddsgavAKuDK7LXvSl/AdqGHbetIXCSTPPkYMVlVe0ukU40SS8IArAwdKmANKKppD
	lTTxoD3UlvEjijdWO1l6LkKGkpuzEFW5zQzq9H9SCwC1ZmoXhZakUhNisx5X9Vqz
	rjaYPmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NUILhZ
	Y2IwtHrLrQ+MmMJmreQV7PJwHpLMsm0VK2tu2fj41YXSUwBtZrWxtAmCw++rWza4
	zkv0X8DdMFEqIecuYq0xgU6ZsHQCe9m09OPm7gOJtIfopv0+Zfunw076NS5kCSS3
	9StcupjxBrVJO6b3SqqbW8Psuft3anp4+dB3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB17577D8
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 812C977D7 for
 <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:31 -0500 (EST)
X-Mailer: git-send-email 1.7.9.1.265.g25f75
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E76F4D0A-5B68-11E1-B83B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191037>

These are not used anywhere in our codebase, and the bit assignment
definition is merely confusing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiff.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 00d36c3..70c8b87 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -36,11 +36,6 @@ extern "C" {
 #define XDF_HISTOGRAM_DIFF (1 << 6)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
 
-#define XDL_PATCH_NORMAL '-'
-#define XDL_PATCH_REVERSE '+'
-#define XDL_PATCH_MODEMASK ((1 << 8) - 1)
-#define XDL_PATCH_IGNOREBSPACE (1 << 8)
-
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
-- 
1.7.9.1.265.g25f75
