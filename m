From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 12:17:13 -0800
Message-ID: <20141209201713.GY16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRDm-0002Oj-42
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbaLIURS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:17:18 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:48506 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbaLIURR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:17:17 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so1632011igi.12
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 12:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oBAeNA+PGypL/4SXiMxiZLvsjVAuXAeWfySx2gT3ntc=;
        b=IsKKUAitK9xj/NBCec+oOEgUryrBGyQ2Ot8cKol0ig6Ab7PKgLXG9uzB1eJK+Icmk4
         Mhl/j59xrkh3GC3LLy/Piz+7xX2aZF5pW1XXjILcjzT3PErQ+iye9hDZEuutNU7mIlM5
         vEMPfY0ZhS7LvWjJbI04vz7vgFF0KGEDyYywKDXJqfqA/WaudRKr0Q9glrdnB966qgHf
         ni3mgVYt9BMbIdlxLNNRBtecknynXbSDEMwZ6JfMWmzZxQdQ0esO/MuE0kL1AIOWC29o
         vv0ukp8/RyKVY6YyyLCsHoYR9s9tQNACBMTZ7Gzruw15VhVHF2mpXksVD2l9Kx9uMAxc
         Jr4g==
X-Received: by 10.50.30.202 with SMTP id u10mr21913328igh.35.1418156236551;
        Tue, 09 Dec 2014 12:17:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41c9:2fc6:1317:4ac])
        by mx.google.com with ESMTPSA id g131sm1047548ioe.37.2014.12.09.12.17.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 12:17:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261154>

Stefan Beller wrote:
> On Tue, Dec 9, 2014 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:

>> Perhaps the API doc that currently says "Free" is the only thing
>> that needs fixing?  And perhaps add "See $doc" at the beginning of
>> the header and remove duplicated comments we already have in the
>> file?
>
> The reason I wrote this patch originally was because I seem to forget we have
> more than one place to document our APIs. If there are comments in the header
> I seem to have thought it were the only place where we have documentation.

How about this patch?

-- >8 --
Subject: put strbuf API documentation in one place

v1.8.1-rc0~61^2 (strbuf_split*(): document functions, 2012-11-04)
added some nice API documentation for a few functions to strbuf.h, to
complement the documentation at Documentation/technical/api-strbuf.
That was helpful because it meant one less hop for someone reading the
header to find API documentation.

In practice, unfortunately, it is too hard to remember that there
is documentation in two places.  The longer documentation comments
in the header made Documentation/technical/api-strbuf less
discoverable.  So move the information to
Documentation/technical/api-strbuf and drop the long comments.

Hopefully in the long term we will find a good way to
generate well organized Documentation/technical/api-* documents
from comments in headers and this problem will be eliminated
completely.

Short reminders in the header file are still okay.

Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-strbuf.txt | 20 +++++++++++++++--
 strbuf.h                               | 40 ++--------------------------------
 2 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index cca6543..a43facc 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -252,6 +252,11 @@ which can be used by the programmer of the callback as she sees fit.
 	destination. This is useful for literal data to be fed to either
 	strbuf_expand or to the *printf family of functions.
 
+`strbuf_addstr_xml_quoted`::
+
+	Append a string to a strbuf with the characters '<', '>', '&', and
+	'"' converted into XML entities.
+
 `strbuf_humanise_bytes`::
 
 	Append the given byte size as a human-readable string (i.e. 12.23 KiB,
@@ -266,6 +271,13 @@ which can be used by the programmer of the callback as she sees fit.
 	Add a formatted string prepended by a comment character and a
 	blank to the buffer.
 
+`xstrfmt`::
+`xstrvfmt`::
+
+	Create a newly allocated string using printf format.  You can do
+	this easily with a strbuf, but this provides a shortcut to save a
+	few lines.
+
 `strbuf_fread`::
 
 	Read a given size of data from a FILE* pointer to the buffer.
@@ -336,11 +348,15 @@ same behaviour as well.
 	terminator characters.  Some of these functions take a `max`
 	parameter, which, if positive, limits the output to that
 	number of substrings.
++
+For lighter-weight alternatives, see `string_list_split` and
+`string_list_split_in_place` from the
+link:api-string-list.html[string list API].
 
 `strbuf_list_free`::
 
-	Free a list of strbufs (for example, the return values of the
-	`strbuf_split()` functions).
+	Free a NULL-terminated list of strbufs (for example, the return
+	values of the `strbuf_split()` functions).
 
 `launch_editor`::
 
diff --git a/strbuf.h b/strbuf.h
index 652b6c4..f3c9bb6 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -58,56 +58,27 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 		return 0;
 }
 
-/*
- * Split str (of length slen) at the specified terminator character.
- * Return a null-terminated array of pointers to strbuf objects
- * holding the substrings.  The substrings include the terminator,
- * except for the last substring, which might be unterminated if the
- * original string did not end with a terminator.  If max is positive,
- * then split the string into at most max substrings (with the last
- * substring containing everything following the (max-1)th terminator
- * character).
- *
- * For lighter-weight alternatives, see string_list_split() and
- * string_list_split_in_place().
- */
-extern struct strbuf **strbuf_split_buf(const char *, size_t,
+extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 					int terminator, int max);
 
-/*
- * Split a NUL-terminated string at the specified terminator
- * character.  See strbuf_split_buf() for more information.
- */
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
 	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
 
-/*
- * Split a strbuf at the specified terminator character.  See
- * strbuf_split_buf() for more information.
- */
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
 	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
 
-/*
- * Split a strbuf at the specified terminator character.  See
- * strbuf_split_buf() for more information.
- */
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 					   int terminator)
 {
 	return strbuf_split_max(sb, terminator, 0);
 }
 
-/*
- * Free a NULL-terminated list of strbufs (for example, the return
- * values of the strbuf_split*() functions).
- */
 extern void strbuf_list_free(struct strbuf **);
 
 /*----- add data in your buffer -----*/
@@ -158,10 +129,7 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
-/*
- * Append s to sb, with the characters '<', '>', '&' and '"' converted
- * into XML entities.
- */
+/* append s with <, >, &, and " converted to XML entities */
 extern void strbuf_addstr_xml_quoted(struct strbuf *sb, const char *s);
 
 static inline void strbuf_complete_line(struct strbuf *sb)
@@ -200,10 +168,6 @@ extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 
-/*
- * Create a newly allocated string using printf format. You can do this easily
- * with a strbuf, but this provides a shortcut to save a few lines.
- */
 __attribute__((format (printf, 1, 0)))
 char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
-- 
2.2.0.rc0.207.ga3a616c
