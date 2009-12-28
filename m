From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 10:04:24 -0800
Message-ID: <7vd41zrn4n.fsf@alter.siamese.dyndns.org>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org>
 <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st>
 <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com>
 <20091228153701.GA2252@spearce.org>
 <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st>
 <20091228155346.GB2252@spearce.org>
 <be6fef0d0912280915k1320110o6a361a0950aa60f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Martin Storsj\?" <martin@martin.st>,
	=?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr.eu.org>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 19:05:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPJxW-0001vR-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 19:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbZL1SEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 13:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbZL1SEm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 13:04:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbZL1SEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 13:04:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B253AAB4B;
	Mon, 28 Dec 2009 13:04:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNDYTx9qQu9/qiKSWiSE/6PFba8=; b=kMO+el
	uYG0LOXsKl5nWl4eN/Wn9tdGnAxhg5a1X5TNZ4cYMhn24ehKGYF3Zg/YWO8UqGgS
	k2ud/82teSjA4c7KK2Y6iwbSjsCjeE8rmVaHMZ2TcII+IfY86gz8LZNeBC950LJ+
	Zowzpwb/ZjiPF+anCcURkwP9kkMfa9fyrHfH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C/6aUEIZEte6oXmzKqS36emYABxJaV1n
	+gQtqXXJWGA8QEnsLkJe0pJsd0R5L3o2D5SPOpZFQXo2M1kT1Ne1XMNWinH/jjbr
	ZniLhE6EksL+omN683PhX54G6hpm08LzwZAgYjRwHKHCKvn+Ei3sahfrNnuV+I3k
	sbY7faKonvk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F37E6AAB45;
	Mon, 28 Dec 2009 13:04:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7042AAB3F; Mon, 28 Dec 2009
 13:04:25 -0500 (EST)
In-Reply-To: <be6fef0d0912280915k1320110o6a361a0950aa60f6@mail.gmail.com>
 (Tay Ray Chuan's message of "Tue\, 29 Dec 2009 01\:15\:48 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 742393D4-F3DB-11DE-8DCC-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135750>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Mon, Dec 28, 2009 at 11:53 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Martin Storsj? <martin@martin.st> wrote:
>>> Should I send in a new patch that removes the http.authAny option and
>>> always enables this, or send a rewritten version of the patch that already
>>> is in 'next'?
>>
>> I'm not Junio, but I would suggest sending in a new patch series,
>> and asking Junio politely to revert the one that is currently in
>> next before merging in the new series.
>>
>> If we really are killing http.authAny before it hits master, there
>> is no reason for it to appear in the final project history.
>
> hmm, a few days back Junio (added to Cc list) sent out an email
> regarding branch shuffling and dropping topics from 'next'. Junio,
> could we piggyback on this?

If people want to go that way that is fine by me, but unlike the ones that
are _ejected_ from next without trace, if we are going to have the primary
feature the patch introduces and changing only a minor detail of external
interface, I don't think we gain much by hinding that story from the
history, especially for something that has been cooking in 'next'.

A separate follow-up commit would be more honest about the feature's
history.  Also a follow-up patch to remove conditionals is much easier to
review than a resend of a rewritten patch, especially when the original
was reviewed adequately for its primary codepath to implement the feature.

Would it be just a matter of queueing something like this on top of
b8ac923 (Add an option for using any HTTP authentication scheme, not only
basic, 2009-11-27)?

-- >8 -- 
From: "Shawn O. Pearce" <spearce@spearce.org>,
Subject: Remove http.authAny

Back when the feature to use different HTTP authentication methods was
originally written, it needed an extra HTTP request for everything when
the feature was in effect, because we didn't reuse curl sessions.

However, b8ac923 (Add an option for using any HTTP authentication scheme,
not only basic, 2009-11-27) builds on top of an updated codebase that does
reuse curl sessions; there is no need to manually avoid the extra overhead
by making this configurable anymore.

---
 Documentation/config.txt |    7 -------
 http.c                   |   17 +----------------
 2 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a54ede3..b77d66d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1158,13 +1158,6 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
 
-http.authAny::
-	Allow any HTTP authentication method, not only basic. Enabling
-	this lowers the performance slightly, by having to do requests
-	without any authentication to discover the authentication method
-	to use. Can be overridden by the 'GIT_HTTP_AUTH_ANY'
-	environment variable. Default is false.
-
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index aeb69b3..01e0fdc 100644
--- a/http.c
+++ b/http.c
@@ -40,9 +40,6 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-static int curl_http_auth_any = 0;
-#endif
 
 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
@@ -197,12 +194,6 @@ static int http_options(const char *var, const char *value, void *cb)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
 	}
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	if (!strcmp("http.authany", var)) {
-		curl_http_auth_any = git_config_bool(var, value);
-		return 0;
-	}
-#endif
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
@@ -254,8 +245,7 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	if (curl_http_auth_any)
-		curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
 	init_curl_http_auth(result);
@@ -408,11 +398,6 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
 
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	if (getenv("GIT_HTTP_AUTH_ANY"))
-		curl_http_auth_any = 1;
-#endif
-
 	if (remote && remote->url && remote->url[0]) {
 		http_auth_init(remote->url[0]);
 		if (!ssl_cert_password_required &&
