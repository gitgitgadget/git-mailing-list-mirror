From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 05 Feb 2012 19:16:22 -0800
Message-ID: <7vy5sgaby1.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
 <20120205234750.GA28735@sigill.intra.peff.net>
 <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
 <20120206030339.GA29123@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 04:16:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuF4A-0002J4-RD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 04:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab2BFDQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 22:16:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab2BFDQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 22:16:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F1E26BF9;
	Sun,  5 Feb 2012 22:16:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mHxJJSOD25F2uSDwyXBeKSlfWcA=; b=e1hHuT
	djDusVq19DoFdUsakVvkvbRXZgQJosdZAk8+Fmc5p2OdFCiyeh0+/bXHF9KH1aZZ
	1Ohxa32WJ6U0q4tPdIUMEvWt8fpa5F9xj6PXZo/aPVmxEmEKQi9sos5Tysgfdb1H
	+Gv2q5fNTH45NuaDfAzvib/ECNyzFRPKNdXK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdgwmfo1pyPIWQ7h2Svyf1mhVRw2yE0w
	9KFCxeNfzy0pAIUbuOR84qbJeFKFfC3YihD0PZwnFSo1gARmrflfwIyVMmpW6feX
	oyDqDPwV+/b9yjNYIqB0BCv0nx0Glo6iTr4MYnqXyYqP4aqZNF92dsK3CtJP64vy
	5VYi+YDewvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B206BF8;
	Sun,  5 Feb 2012 22:16:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D3DD6BF7; Sun,  5 Feb 2012
 22:16:24 -0500 (EST)
In-Reply-To: <20120206030339.GA29123@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 5 Feb 2012 22:03:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F33CF860-5070-11E1-8BB8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190003>

Jeff King <peff@peff.net> writes:

> Ugh, yeah. I was thinking about how it would improve this call site, but
> I don't want to get into auditing the others. Let's drop it and go with
> your patch.

In any case, here is what I queued for tonight.

-- >8 --
Subject: [PATCH] mailmap: do not leave '>' in the output when answering "we did something"

The callers of map_user() give email and name to it, and expect to get an
up-to-date versions of email and/or name to be used in their output. The
function rewrites the given buffers in place. To optimize the majority of
cases, the function returns 0 when it did not do anything, and it returns
1 when the caller should use the updated contents.

The 'email' input to the function is terminated by '>' or a NUL (whichever
comes first) for historical reasons, but when a rewrite happens, the value
is replaced with the mailbox inside the <> pair.  However, it failed to
meet this expectation when it only rewrote the name part without rewriting
the email part, and the email in the input was terminated by '>'.

This causes an extra '>' to appear in the output of "blame -e", because the
caller does send in '>'-terminated email, and when the function returned 1
to tell it that rewriting happened, it appends '>' that is necessary when
the email part was rewritten.

The patch looks bigger than it actually is, because this change makes a
variable that points at the end of the email part in the input 'p' live
much longer than it used to, deserving a more descriptive name.

Noticed and diagnosed by Felipe Contreras and Jeff King.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 8c3196c..47aa419 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -190,27 +190,27 @@ void clear_mailmap(struct string_list *map)
 int map_user(struct string_list *map,
 	     char *email, int maxlen_email, char *name, int maxlen_name)
 {
-	char *p;
+	char *end_of_email;
 	struct string_list_item *item;
 	struct mailmap_entry *me;
 	char buf[1024], *mailbuf;
 	int i;
 
 	/* figure out space requirement for email */
-	p = strchr(email, '>');
-	if (!p) {
+	end_of_email = strchr(email, '>');
+	if (!end_of_email) {
 		/* email passed in might not be wrapped in <>, but end with a \0 */
-		p = memchr(email, '\0', maxlen_email);
-		if (!p)
+		end_of_email = memchr(email, '\0', maxlen_email);
+		if (!end_of_email)
 			return 0;
 	}
-	if (p - email + 1 < sizeof(buf))
+	if (end_of_email - email + 1 < sizeof(buf))
 		mailbuf = buf;
 	else
-		mailbuf = xmalloc(p - email + 1);
+		mailbuf = xmalloc(end_of_email - email + 1);
 
 	/* downcase the email address */
-	for (i = 0; i < p - email; i++)
+	for (i = 0; i < end_of_email - email; i++)
 		mailbuf[i] = tolower(email[i]);
 	mailbuf[i] = 0;
 
@@ -236,6 +236,8 @@ int map_user(struct string_list *map,
 		}
 		if (maxlen_email && mi->email)
 			strlcpy(email, mi->email, maxlen_email);
+		else
+			*end_of_email = '\0';
 		if (maxlen_name && mi->name)
 			strlcpy(name, mi->name, maxlen_name);
 		debug_mm("map_user:  to '%s' <%s>\n", name, mi->email ? mi->email : "");
-- 
1.7.9.204.gdf845
