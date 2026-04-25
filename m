Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C23542D1
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777160824; cv=none; b=l5WoYyBbqpnKTjeyBxOKv4XrmXu86F1b6G6CWavYflF13YTeIxPJsaiyauke+EQ25Cuh9SisYd6ZaIJitQD9hhugH3LwxgzawMS1u5MStruJGDXWvUAHXVx89qE5A5sxPkJBNzTR5R2ShjGXHGtZuv7uEvxhkblEVKlwA6WBFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777160824; c=relaxed/simple;
	bh=S7a6a6JTztMAw6J/ZDnwZVg41m5pwU+jfq9bkSL1jL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkJTa2Lld/4mG7E+hYogd7Z6JhD7dhBD6eIxkXnONPC2K7PVUoY42GQrsfccRbbYJ4RQiU9NsDrHZyk2Nj5hmaA/EkJz/NqpnSnDr3SO186qbLsaVQBganXg9Tkb/gkQ1zHXjVcngniHp5CYSLN9KfiAah38uZtxGd9QfY2DYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VCUAC8tN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VCUAC8tN"
Received: (qmail 457489 invoked by uid 106); 25 Apr 2026 23:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S7a6a6JTztMAw6J/ZDnwZVg41m5pwU+jfq9bkSL1jL0=; b=VCUAC8tNo2X6MJU02ojVVgffo8NeYpQujXX6maoGmdKKkFIfiWXo9QSmx4DIBIh440nGrjigBgN4Y2abV0rnd5Bj8qlNNlVDhcsU/njN4dsKqNLYIpcNbiH+v6Hqax+33qOe9FU7A7vKBEpcvGOVUvCX+KYLadw7GkTk+N2bBgNbM6cd1R0KKZZVtp2Lto60Lwv2A3xT+BYblfnnzpqpQ5ZSNjNNXeDMq9CCo2VbPEBCMPGre7hMhPh7B1Hnmi+2YbfyUBYp4cPBSkI3I5derp4Dxp+wOYl0xeYodxlyGJN/iQwLdQYLPHml0ECNDtfrnLXzny3HeS6l/2OsC+mojg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Apr 2026 23:47:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1037530 invoked by uid 111); 25 Apr 2026 23:47:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Apr 2026 19:47:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Apr 2026 19:47:00 -0400
From: Jeff King <peff@peff.net>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, rsch@web.de,
	michael.grossfeld@amd.com
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
Message-ID: <20260425234700.GB29816@coredump.intra.peff.net>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page>
 <xmqqpl3ovuvq.fsf@gitster.g>
 <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
 <20260425232916.GA29816@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260425232916.GA29816@coredump.intra.peff.net>

On Sat, Apr 25, 2026 at 07:29:16PM -0400, Jeff King wrote:

> On Sat, Apr 25, 2026 at 11:57:24AM +0200, Jonatan Holmgren wrote:
> 
> > That is a challenge we are going to have to consider. I think reserving
> > `command` is a worthwhile compromise, but obviously we cannot do that for
> > arbitrary future keys such as `help`, `hidden`, etc.
> 
> We don't necessarily have to reserve them. When we see alias.foo.bar, we
> could consider it as both alias "foo.bar" and the "bar" key of alias
> "foo", without regard to what is in "bar" (i.e., whether it is "command"
> or "help", etc). I.e., don't "fall back" but allow two overlapping
> namespace.s
> 
> That is the most backwards-compatible thing we could do, but does create
> some interesting situations.

For reference, I mean something like this:

diff --git a/alias.c b/alias.c
index ec9833dd30..07c6bd3645 100644
--- a/alias.c
+++ b/alias.c
@@ -34,16 +34,20 @@ static int config_alias_cb(const char *var, const char *value,
 	if (subsection && !subsection_len)
 		subsection = NULL;
 
-	if (subsection && strcmp(key, "command"))
-		return 0;
-
 	if (data->alias) {
 		int match;
 
 		if (subsection)
-			match = (strlen(data->alias) == subsection_len &&
-				 !strncmp(data->alias, subsection,
-					  subsection_len));
+			/*
+			 * alias.foo.command always matches "foo", but for
+			 * historical compatibility also match alias.foo.bar as
+			 * "foo.bar", even when "bar" is "command" or any other
+			 * key we happen to know about.
+			 */
+			match = (!strcmp(key, "command") &&
+				 strlen(data->alias) == subsection_len &&
+				 !strncmp(data->alias, subsection, subsection_len))
+				|| !strcmp(data->alias, subsection);
 		else
 			match = !strcasecmp(data->alias, key);
 
@@ -59,8 +63,23 @@ static int config_alias_cb(const char *var, const char *value,
 			return config_error_nonbool(var);
 
 		if (subsection)
+			/*
+			 * If it's not alias.foo.command, then either it's a
+			 * historical alias (git "foo.bar"), or it's some
+			 * metadata not support yet by this version
+			 * ("alias.foo.help" or similar).
+			 *
+			 * We'll guess it's the former and include the whole
+			 * "foo.bar" in the list.
+			 *
+			 * We might want to suppress duplicates when we see both
+			 * alias.foo.command and alias.foo.help, since that's
+			 * what a hypothetical future version might understand.
+			 */
 			item = string_list_append_nodup(data->list,
-				xmemdupz(subsection, subsection_len));
+							!strcmp(key, "command")
+							? xmemdupz(subsection, subsection_len)
+							: xstrdup(subsection));
 		else
 			item = string_list_append(data->list, key);
 		item->util = xstrdup(value);

-Peff
