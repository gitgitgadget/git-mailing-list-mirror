From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 14:32:41 -0800
Message-ID: <20141212223241.GA19972@google.com>
References: <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
 <20141212091625.GA9049@peff.net>
 <20141212183114.GA29365@google.com>
 <20141212192417.GA21132@peff.net>
 <20141212193552.GB29365@google.com>
 <20141212212726.GA26284@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYlT-00018F-MF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbaLLWco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:32:44 -0500
Received: from mail-pa0-f73.google.com ([209.85.220.73]:63507 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaLLWcm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:32:42 -0500
Received: by mail-pa0-f73.google.com with SMTP id rd3so1140398pab.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 14:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dwHGKPQPovFHMecA1fAZGK89KkRgAPpFfvjlNBY5bMo=;
        b=oKWm8/CctKWq5A7Xf6+SSnvbFCbVjQd0gLmxVKk4UwObDc1OnyfoW9LnGuSA2DxqG2
         /QoHSmi7bmSJSR0QWYWtlOV7UvINK4zVAY9u4QKfY3ugQIqG9AJifVF+41fmEwISCNEp
         At4R3LT4nQ0il9aTjb4BWubs6a1pKOsgBGAhCWY/uCPICiORYlre1+r7QIDNZ8clUSSW
         uWFFUjXmvq/2tLa8Q47kON+T+5nxzPEDnGVpUE5xZhz/Nj+MiZy/KoUv1ss+XDSA/pc+
         WLljJj/Ziv23pupf11vNM9J3gzYPf23o+MO3TFcy4tvYYASvAdPcXsfG08gMtSjEJk65
         iCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dwHGKPQPovFHMecA1fAZGK89KkRgAPpFfvjlNBY5bMo=;
        b=HvXOtMLhR7vVO3ttSMDI+tcdsTmxrxA+z7CrstDxc63f9zH+CNCw36kn1CRjNuF9OQ
         tGrKWQvl6RrrQZ4QmlyJ4CSET13N3VhnP0hJuDKXAgjr62yylP3zOiEU//RqiSIfGDS3
         LKUz+xm8N3h9CvfJeR9KvcMxF1KZtVyjEtcrj5zklsRKXcTQaFrHiX1z/TrG8X4UTFj+
         4ScI8VTqw0BAH7QRGz9JNY4lwCDLOHd1d4ag1xowJHLSS6ba9/RfbBSg5pYzhfyJUsBA
         EFCwv/FVxt1IHg9SFGLRldl7Nvd289Zou7V2BS4ECj9K2wVV2s0Xm+nRCV1yALRyWSvs
         Ek8A==
X-Gm-Message-State: ALoCoQlVdLhjW0xtPjPDkCPoEjf8EN/PYI/chslHUFZZaEnrf/lppjzgZb2ZOd5wOXzX6+4/fo0O
X-Received: by 10.68.203.170 with SMTP id kr10mr15309318pbc.0.1418423562271;
        Fri, 12 Dec 2014 14:32:42 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si132958yhf.0.2014.12.12.14.32.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Dec 2014 14:32:42 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id i19V6i2a.1; Fri, 12 Dec 2014 14:32:42 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 3B891140B71; Fri, 12 Dec 2014 14:32:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212212726.GA26284@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261386>

On Fri, Dec 12, 2014 at 04:27:26PM -0500, Jeff King wrote:
> On Fri, Dec 12, 2014 at 11:35:52AM -0800, Jonathan Nieder wrote:
> 
> > If I were doing it, I would first de-asciidoc within technical/ and
> > then move into the header in a separate patch.  Or first move with
> > asciidoc intact and then de-asciidoc in a separate patch.  Combining
> > the two into a single patch is also fine.  Please don't change wording
> > at the same time.
> 
> Here's what I came up with. The first patch probably does more than
> you'd like (and more than I would have done if I were starting from
> scratch today). But I didn't want to get into undoing the stripping of
> each function-name list item that I showed earlier, as it would be a lot
> of tedious manual work. If we decide we want to keep those, I'm happy to
> do the work to restore them, but it didn't seem like a good tradeoff
> just to create an intermediate state to make the patch prettier.
> 
> I did split out some of the other formatting decisions, though, so they
> can be evaluated individually.
> 
>   [1/4]: strbuf: migrate api-strbuf.txt documentation to strbuf.h

(optional nit):
The subject of this patch is slightly different than the others.
How about: 
strbuf.h: integrate api-strbuf.txt documentation

>   [2/4]: strbuf.h: drop asciidoc list formatting from API docs
>   [3/4]: strbuf.h: format asciidoc code blocks as 4-space indent
>   [4/4]: strbuf.h: reorganize api function grouping headers
> 
> -Peff

I have reviewed the series and I personally like it as I am more
often in the learners/discovery stage than the fast lookup stage
as Junio mentioned.

Another inconsistency I found specifically related to the strbuf.h
documentation is the apparent changeing style.

At the beginning we have 
	extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);

Even with the documentation attached, which size_t is the length and what the 
amount of allocated memory? Later we have more explaining names, such as

extern struct strbuf **strbuf_split_buf(const char *, size_t,
					int terminator, int max);


Please append the following patch to your series. I noticed this as
the text editor I use uses different colors for 

	/** comments starting with double stars used with i.e. doxygen */
	/* random comments in the file */

Thanks,
Stefan


-----------8<------------------
From 5d0f98aba65e8b1415ebfcd8e06b67203e9305a7 Mon Sep 17 00:00:00 2001
From: Stefan Beller <sbeller@google.com>
Date: Fri, 12 Dec 2014 14:27:15 -0800
Subject: [PATCH] strbuf.h: Unify documentation comments beginnings

We want to preserve the meaning of "/**" to start a documentary
in depth comment, so all of the documenting comments should start with
a "/**".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 strbuf.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 8649a0a..95d49e1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -438,7 +438,7 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 		return 0;
 }
 
-/*
+/**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
  * holding the substrings.  The substrings include the terminator,
@@ -454,7 +454,7 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 extern struct strbuf **strbuf_split_buf(const char *, size_t,
 					int terminator, int max);
 
-/*
+/**
  * Split a NUL-terminated string at the specified terminator
  * character.  See strbuf_split_buf() for more information.
  */
@@ -464,7 +464,7 @@ static inline struct strbuf **strbuf_split_str(const char *str,
 	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
 
-/*
+/**
  * Split a strbuf at the specified terminator character.  See
  * strbuf_split_buf() for more information.
  */
@@ -474,7 +474,7 @@ static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
 
-/*
+/**
  * Split a strbuf at the specified terminator character.  See
  * strbuf_split_buf() for more information.
  */
@@ -484,7 +484,7 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 	return strbuf_split_max(sb, terminator, 0);
 }
 
-/*
+/**
  * Free a NULL-terminated list of strbufs (for example, the return
  * values of the strbuf_split*() functions).
  */
@@ -492,7 +492,7 @@ extern void strbuf_list_free(struct strbuf **);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
-/*
+/**
  * Append s to sb, with the characters '<', '>', '&' and '"' converted
  * into XML entities.
  */
-- 
2.2.0.38.g71d6cb7
