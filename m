From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 12:11:57 -0700
Message-ID: <7v4o4i4mte.fsf@alter.siamese.dyndns.org>
References: <20110524210758.GH16052@localhost>
 <20110524224525.GI16052@localhost> <vpqfwo3ush3.fsf@bauges.imag.fr>
 <20110525150631.GA29161@localhost> <4DDD3A01.6040407@elegosoft.com>
 <20110525184514.GA20005@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>
To: Chris Wilson <cwilson@vigilantsw.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:12:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJVD-0006sQ-Sb
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab1EYTMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:12:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab1EYTMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:12:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 015825804;
	Wed, 25 May 2011 15:14:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZiP0mUPxAEP/QGPiCzZ6IehPYQ0=; b=HbZFcS
	hIcefvfFRn8SA6ie9rEICVtGRpbAod2RrINpF3+yEDqOAwH/AmT5kXC2YZgsQpJZ
	pjAfZylnBQRva9a46VzHW0u1k3mDEoZQzYuMv9o2pVQzIyNDX2qGJnQ9QEQvn4iz
	+5Axa2uZnLMKgxaRF1p9X5T3+qLZQplHhuerY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sQQRD9FcH8vVyOsgDdpJv7sxW7MNY+MI
	GzoeGBgMExSLgROiKJKSXVKk+A6UqqcqLwNBpyU9Ywm+aPBLv/hCVVtLQQyOY/k7
	F6kFlOTuDrGgEocW111bDPBgBYslQPl+c346L77H2dOdJwd4TmFx6l6pSDUuOUAg
	qhanAVSU6cc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91CE657E8;
	Wed, 25 May 2011 15:14:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9BB4C57E6; Wed, 25 May 2011
 15:14:06 -0400 (EDT)
In-Reply-To: <20110525184514.GA20005@localhost> (Chris Wilson's message of
 "Wed, 25 May 2011 14:45:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DDC07AA-8703-11E0-9510-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174448>

Chris Wilson <cwilson@vigilantsw.com> writes:

> Thanks! Well, I wasn't going to report this dead assignment since
> it wasn't done recently, but now I want to figure out how to properly
> submit a patch. :) Am I there yet? and thanks for the help.

The compiler does not understand the meaning of the code, so after seeing
such a "set but unused" statement, you should wonder why such a seemingly
useless statement is there, before sending a mechanical patch to remove it
without thinking things through.

>  pretty.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index dff5c8d..5667c7f 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1082,7 +1082,6 @@ void userformat_find_requirements(const char *fmt, struct userformat_
>         if (!fmt) {
>                 if (!user_format)
>                         return;
> -               fmt = user_format;
>         }
>         strbuf_expand(&dummy, user_format, userformat_want_item, w);
>         strbuf_release(&dummy);

The if statement says "we might be passing NULL in fmt and in that case
please fall back to user_format" to human readers, but the compiler is too
stupid to infer such an intention, so you have to help it with your brain.
I have to wonder if the strbuf_expand() should be passing fmt instead of
user_format.  "git blame -L1082,+7 pretty.c" points at 5b16360 (pretty:
Initialize notes if %N is used, 2010-04-13).

The only callsite that is introduced by that patch passes NULL to fmt, so
a better fix might be to do something like this instead.

 builtin/log.c |    3 +--
 commit.h      |    2 +-
 pretty.c      |   10 ++++------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f621990..9e05d46 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -110,8 +110,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
 
-	memset(&w, 0, sizeof(w));
-	userformat_find_requirements(NULL, &w);
+	userformat_find_requirements(&w);
 
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
diff --git a/commit.h b/commit.h
index 3114bd1..b652c22 100644
--- a/commit.h
+++ b/commit.h
@@ -92,7 +92,7 @@ extern char *reencode_commit_message(const struct commit *commit,
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
-extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
+extern void userformat_find_requirements(struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index dff5c8d..ca24925 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1075,15 +1075,13 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
 	return 0;
 }
 
-void userformat_find_requirements(const char *fmt, struct userformat_want *w)
+void userformat_find_requirements(struct userformat_want *w)
 {
 	struct strbuf dummy = STRBUF_INIT;
 
-	if (!fmt) {
-		if (!user_format)
-			return;
-		fmt = user_format;
-	}
+	memset(w, 0, sizeof(*w));
+	if (!user_format)
+		return;
 	strbuf_expand(&dummy, user_format, userformat_want_item, w);
 	strbuf_release(&dummy);
 }
