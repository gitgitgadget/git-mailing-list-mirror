From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 13:42:41 -0800
Message-ID: <xmqqa900l57y.fsf@gitster.dls.corp.google.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
	<20150226030416.GA6121@peff.net>
	<xmqqmw40l777.fsf@gitster.dls.corp.google.com>
	<20150226213356.GA14464@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR6Co-0003ev-Dc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbbBZVmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:42:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754094AbbBZVmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:42:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B31B3B28C;
	Thu, 26 Feb 2015 16:42:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wnt5z6KxOZH4QDk95pI2QTaDnOs=; b=E6Sk4r
	UapXffJre/BnzEzYsCtBEGwhrEpuiVXQm19hxHQb5tz67rxqK+t4w6+1chR9wMRe
	N17qAshm/WCMTr8HWBD1QIzk0GTVA5nCHg74M/3HtyeUXFvPj4DprVxc6WipBRCg
	aGoeHOCMyxNIrmqeStTR8etLlb3JXfEkuCd1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mdv7UW1V8PwKNtK9fwM2MBzogaEnR0Ks
	OferzdFExcQBGMxvcAGylAgYNTDN7ijMuYKISn/3lzit/u3PKPLfm03AviNQEjzB
	vh8iPuFhaZfB6QK/X1QtAnc0a24vGaDbRvVpENiO39OK4Zbci5yZ1EL+YRhPaO46
	20+fYM/lAXA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 523193B28B;
	Thu, 26 Feb 2015 16:42:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEBD23B28A;
	Thu, 26 Feb 2015 16:42:42 -0500 (EST)
In-Reply-To: <20150226213356.GA14464@peff.net> (Jeff King's message of "Thu,
	26 Feb 2015 16:33:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64D0F0D0-BE00-11E4-AFF3-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264469>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 26, 2015 at 12:59:56PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Perhaps it would be less risky to stick get_preferred_languages() into
>> > gettext.c, like the patch below. Then we do not have to worry about
>> > locale.h introducing other disruptive includes. The function is not
>> > technically about gettext, but it seems reasonable to me to stuff all of
>> > the i18n code together.
>> 
>> Yeah, I like that a lot better.  Thanks.
>
> Are you just using it for inspiration, or did you want me to wrap it up
> with a commit message?

Here is what I queued.  Thanks.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Wed, 25 Feb 2015 22:04:16 -0500
Subject: [PATCH] gettext.c: move get_preferred_languages() from http.c

Calling setlocale(LC_MESSAGES, ...) directly from http.c, without
including <locale.h>, was causing compilation warnings.  Move the
helper function to gettext.c that already includes the header and
where locale-related issues are handled.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gettext.c | 25 +++++++++++++++++++++++++
 gettext.h |  2 ++
 http.c    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/gettext.c b/gettext.c
index 8b2da46..7378ba2 100644
--- a/gettext.c
+++ b/gettext.c
@@ -18,6 +18,31 @@
 #	endif
 #endif
 
+/*
+ * Guess the user's preferred languages from the value in LANGUAGE environment
+ * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
+ *
+ * The result can be a colon-separated list like "ko:ja:en".
+ */
+const char *get_preferred_languages(void)
+{
+	const char *retval;
+
+	retval = getenv("LANGUAGE");
+	if (retval && *retval)
+		return retval;
+
+#ifndef NO_GETTEXT
+	retval = setlocale(LC_MESSAGES, NULL);
+	if (retval && *retval &&
+		strcmp(retval, "C") &&
+		strcmp(retval, "POSIX"))
+		return retval;
+#endif
+
+	return NULL;
+}
+
 #ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
diff --git a/gettext.h b/gettext.h
index 7671d09..e539482 100644
--- a/gettext.h
+++ b/gettext.h
@@ -65,4 +65,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 /* Mark msgid for translation but do not translate it. */
 #define N_(msgid) msgid
 
+const char *get_preferred_languages(void);
+
 #endif
diff --git a/http.c b/http.c
index 8b659b6..71ed418 100644
--- a/http.c
+++ b/http.c
@@ -8,6 +8,7 @@
 #include "credential.h"
 #include "version.h"
 #include "pkt-line.h"
+#include "gettext.h"
 
 int active_requests;
 int http_is_verbose;
-- 
2.3.1-280-g2531f2d
