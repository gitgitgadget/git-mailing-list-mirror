From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Wed, 13 Oct 2010 19:15:52 +0700
Message-ID: <20101013121552.GA29486@do>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com> <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 14:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P60Fl-00056N-1k
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 14:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab0JMMQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 08:16:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51183 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab0JMMQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 08:16:09 -0400
Received: by pwi4 with SMTP id 4so121296pwi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=dCt793yac2MypT6iBaTAMyXEu1UPVvUNTL+7+EWcEWQ=;
        b=XVN2HEz46OlII9zl/R9XkHAqG7zhrkR2tTbBTimk/8mdVVduY7W5Bl17d+As+26Uw7
         GU8SsvFxozRjxzcIUGsvVvfiVCHTgvMbNU8t5wyiWVqzGnfIJv4Bf8gLwrDpj4hN11ni
         MPAG+f0Js/X+F2mshWHUFwLDGQzth4swavK3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YC38s0oCvwUIwkL/WZcroqwQEFNmvTvPwk67FvU32e9BbVMwQPUAUDaRBrdp20W76S
         SjiHVWYSckdqjWhmBRhhoPmQPCW1QsoLslJV3AGvpXJuYvZC76uEoPu28zHbcoG0OH6y
         d53LIGAyNHlqE5bocNmsuPnCa7H1ufjbfBSJ4=
Received: by 10.143.16.17 with SMTP id t17mr7417360wfi.208.1286972168648;
        Wed, 13 Oct 2010 05:16:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id x35sm3745816wfd.1.2010.10.13.05.16.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 05:16:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 13 Oct 2010 19:15:52 +0700
Content-Disposition: inline
In-Reply-To: <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158932>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2010 at 07:32:54PM -0700, Kevin Ballard wrote:
> As soon as I find the time, I'll be working on a patch for this. I
> only wrote up the proposal because I want to make sure that what I
> end up implementing is actually something that will be accepted. At
> this point I'm actually in favor of simply assuming all paths that
> don't start with / can be matched at any level but I recognize that
> this is a change to existing functionality, though I personally
> think that all patterns that are meant to match only at the current
> level should be prefixed with / anyway. Would such a change to
> existing behavior be rejected out-of-hand?

Yes, patterns that only match current level should be prefixed with a
slash. There are also other cases apart from "current level only" and
"any level": foo/a* will match only second level, not any level.

I was thinking of doing like this. It's not complete (not even build)
but it shows the idea. I don't think this way it will change existing
behaviors. Performance is something I haven't thought through.

Anyway, what do you think? I'm afraid I don't have time to work on
this. The pathspec unification work still needs to be done.
-- 
Duy

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-excluded_from_list-split-the-core-exclude-code-out-a.patch"

>From 058ed97a52a3a155655193d0ecd94506781c93c1 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Date: Wed, 13 Oct 2010 19:01:11 +0700
Subject: [PATCH 1/3] excluded_from_list: split the core exclude code out as a separate function

---
 dir.c |  114 ++++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/dir.c b/dir.c
index a44c7b3..56974e5 100644
--- a/dir.c
+++ b/dir.c
@@ -343,6 +343,64 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	dir->basebuf[baselen] = '\0';
 }
 
+static int excluded_from_list_1(const char *pathname, int pathlen, const char *basename, struct exclude *x, int *dtype)
+{
+	const char *exclude = x->pattern;
+	int to_exclude = x->to_exclude;
+
+	if (x->flags & EXC_FLAG_MUSTBEDIR) {
+		if (!dtype) {
+			if (!prefixcmp(pathname, exclude))
+				return to_exclude;
+			else
+				return -1;
+		}
+		if (*dtype == DT_UNKNOWN)
+			*dtype = get_dtype(NULL, pathname, pathlen);
+		if (*dtype != DT_DIR)
+			return -1;
+	}
+
+	if (x->flags & EXC_FLAG_NODIR) {
+		/* match basename */
+		if (x->flags & EXC_FLAG_NOWILDCARD) {
+			if (!strcmp(exclude, basename))
+				return to_exclude;
+		} else if (x->flags & EXC_FLAG_ENDSWITH) {
+			if (x->patternlen - 1 <= pathlen &&
+			    !strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
+				return to_exclude;
+		} else {
+			if (fnmatch(exclude, basename, 0) == 0)
+				return to_exclude;
+		}
+	}
+	else {
+		/* match with FNM_PATHNAME:
+		 * exclude has base (baselen long) implicitly
+		 * in front of it.
+		 */
+		int baselen = x->baselen;
+		if (*exclude == '/')
+			exclude++;
+
+		if (pathlen < baselen ||
+		    (baselen && pathname[baselen-1] != '/') ||
+		    strncmp(pathname, x->base, baselen))
+		    return -1;
+
+		if (x->flags & EXC_FLAG_NOWILDCARD) {
+			if (!strcmp(exclude, pathname + baselen))
+				return to_exclude;
+		} else {
+			if (fnmatch(exclude, pathname+baselen,
+				    FNM_PATHNAME) == 0)
+			    return to_exclude;
+		}
+	}
+	return -1;
+}
+
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
@@ -355,59 +413,9 @@ int excluded_from_list(const char *pathname,
 	if (el->nr) {
 		for (i = el->nr - 1; 0 <= i; i--) {
 			struct exclude *x = el->excludes[i];
-			const char *exclude = x->pattern;
-			int to_exclude = x->to_exclude;
-
-			if (x->flags & EXC_FLAG_MUSTBEDIR) {
-				if (!dtype) {
-					if (!prefixcmp(pathname, exclude))
-						return to_exclude;
-					else
-						continue;
-				}
-				if (*dtype == DT_UNKNOWN)
-					*dtype = get_dtype(NULL, pathname, pathlen);
-				if (*dtype != DT_DIR)
-					continue;
-			}
-
-			if (x->flags & EXC_FLAG_NODIR) {
-				/* match basename */
-				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp(exclude, basename))
-						return to_exclude;
-				} else if (x->flags & EXC_FLAG_ENDSWITH) {
-					if (x->patternlen - 1 <= pathlen &&
-					    !strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
-						return to_exclude;
-				} else {
-					if (fnmatch(exclude, basename, 0) == 0)
-						return to_exclude;
-				}
-			}
-			else {
-				/* match with FNM_PATHNAME:
-				 * exclude has base (baselen long) implicitly
-				 * in front of it.
-				 */
-				int baselen = x->baselen;
-				if (*exclude == '/')
-					exclude++;
-
-				if (pathlen < baselen ||
-				    (baselen && pathname[baselen-1] != '/') ||
-				    strncmp(pathname, x->base, baselen))
-				    continue;
-
-				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp(exclude, pathname + baselen))
-						return to_exclude;
-				} else {
-					if (fnmatch(exclude, pathname+baselen,
-						    FNM_PATHNAME) == 0)
-					    return to_exclude;
-				}
-			}
+			int to_exclude = excluded_from_list_1(pathname, pathlen, basename, x, dtype);
+			if (to_exclude != -1)
+				return to_exclude;
 		}
 	}
 	return -1; /* undecided */
-- 
1.7.0.2.445.gcbdb3


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-Set-EXC_FLAG_STARSTAR-if-a-pattern-starts-with.patch"

>From afa6ef0ee1a299aef486367792f6dcc6e4e686d5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Date: Wed, 13 Oct 2010 19:10:35 +0700
Subject: [PATCH 2/3] Set EXC_FLAG_STARSTAR if a pattern starts with "**/"

---
 dir.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 56974e5..241fbce 100644
--- a/dir.c
+++ b/dir.c
@@ -171,6 +171,10 @@ void add_exclude(const char *string, const char *base,
 		to_exclude = 0;
 		string++;
 	}
+	if (*string == '*' && string[1] == '*' && string[2] == '/') {
+		flags |= EXC_FLAG_STARSTAR;
+		string += 3;
+	}
 	len = strlen(string);
 	if (len && string[len - 1] == '/') {
 		char *s;
@@ -180,7 +184,7 @@ void add_exclude(const char *string, const char *base,
 		s[len - 1] = '\0';
 		string = s;
 		x->pattern = s;
-		flags = EXC_FLAG_MUSTBEDIR;
+		flags |= EXC_FLAG_MUSTBEDIR;
 	} else {
 		x = xmalloc(sizeof(*x));
 		x->pattern = string;
@@ -190,7 +194,7 @@ void add_exclude(const char *string, const char *base,
 	x->base = base;
 	x->baselen = baselen;
 	x->flags = flags;
-	if (!strchr(string, '/'))
+	if (!(x->flags & EXC_FLAG_STARSTAR) && !strchr(string, '/'))
 		x->flags |= EXC_FLAG_NODIR;
 	if (no_wildcard(string))
 		x->flags |= EXC_FLAG_NOWILDCARD;
-- 
1.7.0.2.445.gcbdb3


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-excluded_from_list-support-EXC_FLAG_STARSTAR.patch"

>From c11a949328b90aca3398f730a50eab35033f0334 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Date: Wed, 13 Oct 2010 19:06:07 +0700
Subject: [PATCH 3/3] excluded_from_list: support EXC_FLAG_STARSTAR

if that flag is set, try to match all full pathname, then skip one
directory and try again until it completely fails.
---
 dir.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 241fbce..11c3e7d 100644
--- a/dir.c
+++ b/dir.c
@@ -417,9 +417,23 @@ int excluded_from_list(const char *pathname,
 	if (el->nr) {
 		for (i = el->nr - 1; 0 <= i; i--) {
 			struct exclude *x = el->excludes[i];
-			int to_exclude = excluded_from_list_1(pathname, pathlen, basename, x, dtype);
-			if (to_exclude != -1)
-				return to_exclude;
+			const char *new_pathname = pathname;
+			int new_pathlen = pathlen;
+
+			while (1) {
+				int to_exclude = excluded_from_list_1(new_pathname, new_pathlen, basename, x, dtype);
+				if (to_exclude != -1)
+					return to_exclude;
+				if (x->flags & EXC_FLAG_STARSTAR) {
+					const char *p = strchr(new_pathname, '/');
+					if (p) {
+						new_pathlen -= p - new_pathname - 1;
+						new_pathname = p + 1;
+						continue;
+					}
+				}
+				break;
+			}
 		}
 	}
 	return -1; /* undecided */
-- 
1.7.0.2.445.gcbdb3


--fdj2RfSjLxBAspz7--
