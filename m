Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235626E17F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765324383; cv=none; b=J9Soh9Vfa3PNgTFtIk8++TDynrC4d3y7PhaEmoceN6PsJ36lPK3X6dc4b+bJTMf3cZvR+H+4p36q7aEern9W23LAAy6xRhV9q3NGEUNXWA4FFnDO35tjEEC8CkGIAtdK/+m8oBNUvLGWpRJoNs+N8DtqoUX0dFC268bUZepxyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765324383; c=relaxed/simple;
	bh=bEbm2hAaDZF5emPINVib2x30kSqG4hUoWZ1k+et+e7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNE7UEHEkc9bNlEeZE8If9zhVjJ3lW6ixxSmGGxBdfWL6Ru4o9CnXZow5BZEIMylPDwre0+35b14ZJOyPUUwY2EcM4JeydD1gcMLgA9RTWsLIei5gVWHEKNO02YSdPulnE3FrtYs0dO1895d94NnVZFQgWGQqppqCTHz8W98GpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=inuChRz8; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="inuChRz8"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso542061d50.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 15:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765324381; x=1765929181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HL3LhnIQKxiDNfe/6+yrnNhEwW4hjLi0ga2NUjDnB0=;
        b=inuChRz8X7kCiIxLIvbopVli44WnfokYc+pXhMKYyqc+9YWgEhpelSq84I8FnE8YO/
         eCQLQmQryjamjizp3mLSTw2ELQTBJZTXA2hWMvINGbz0sg3H88/k7dtf0bw0vGIE73nd
         FMC/Sd7jzukiosOqc3gnw9zVnZpA8hjlpbf7X1pm5HQojc2Zg5KsuCxuc/9/SS60Th/b
         Nvbg1tCNmNWoZUOfaiTfDWHqisWUe5Qx01Lcbh4pBPaX8wol+C8/iYHwY3gBBfybgcU4
         P2IcyAsn7TVVyaJX0K0eIQMlPFpl8Q/Cie6j4a5OhXXK2pVgyS/KemnpgLhpF+foapJJ
         ze3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765324381; x=1765929181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HL3LhnIQKxiDNfe/6+yrnNhEwW4hjLi0ga2NUjDnB0=;
        b=L95O0h7x/nBYpe44uW9TfJBflfLJRUqw+aqaTxBdjQvKmMuJtXqoB1BPhGxBHA6dbv
         OcfC/GSUnLTD3b9RQpy8SC2AY69B6k/s8tHcP6NXfDPnBxIGY/MuWUBgX7g4/BfUJNTY
         YY9vv2iR7KbqXi/memIY8wzfzcj40QQ9DDdax+MxcAzkjK7H+auEMiISmUV15FmWUfMR
         k2l3jjhVT0Q9e9xnar+v+2z+Pse61WsMzgkiHF/LYwb8EJI2hmGXr25VSllFOeAJQDcK
         O6DJ2KSXB/Dzgn2FzcuDPLxG4FNl6I84PbjeVkAN9GvgcLtHszOzPSzpo67dYJ/jWaOt
         AGNg==
X-Gm-Message-State: AOJu0YylYO7yHGh+5vB3xqouWBGxBeVMWi0NzYaNTirbZcQdUe68ajaj
	bLCz9ptMZOxzgfwmGyca+hLXqtZgi1WdKquikCgGqXiorPvi7cYdFUQTIBQN1bGcZ50yZ+kgdku
	5M93HnOQ=
X-Gm-Gg: AY/fxX72z+JGcYeG5LFZxRBN0PSjGzBIu+lvXoXv5D49hUbUrtRmoW+kHcJkk9ZWtGr
	DgDdWCJsc8Id1wC4V0ZKkcfH8wxn6iovuFplCX+u8TiTMaBZ+Jy6Wz4qhlHz0LmiwJatH5kjr5O
	NB3fzjLlxX83R9CeBCn8L1uDOoKYT7kN3cxjX4Rddcvf96IX3hb6THFKNf8n5qgv0u45iiovWsW
	8sTmArfqAiuakmSLOIguUJbwWOprCkNVIKOGAsbZ7nfQCji3DxEzSFmjwlaRxNpMOe7PelYaNYl
	xIlZiA/cL2OwYiSjg/b+TJWlCrkUAVleeEIgVI+TDxm2itUCTO6WjrUaUChPSIZen7EK26fFzc8
	QA6+cucOdeS1m+3p0ox7ILe9GOMWemb9dOUduPceGRZqOD7O3lXTSEAYa7MkGZqQgzxyPy0c/AY
	gsmffvKJaDT81rPghfjgUlZ5ysu0pxAAoz3sLOBhcYBcshEr43EZPB58qGBf7tgWXmcxtkdLxIB
	p0jKIMSjXWEi4e8aA==
X-Google-Smtp-Source: AGHT+IFTu7BAcS0WvDEJVMx1wSdakM4IXeiGNQch3yLPZI91vBGOzkHH0YYgo+GjbNF+JvnkGNfPQA==
X-Received: by 2002:a05:690e:bc3:b0:63f:a65f:106f with SMTP id 956f58d0204a3-6446e948afamr567856d50.12.1765324380852;
        Tue, 09 Dec 2025 15:53:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4acfcesm65900137b3.1.2025.12.09.15.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 15:53:00 -0800 (PST)
Date: Tue, 9 Dec 2025 18:52:59 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH 2/3] remote-curl: fix memory leak in show_http_message()
Message-ID: <aTi2W0f03kwf0ONx@nand.local>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <438223792264169082db8a1be5cb419b657bda26.1764160227.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <438223792264169082db8a1be5cb419b657bda26.1764160227.git.gitgitgadget@gmail.com>

On Wed, Nov 26, 2025 at 12:30:26PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
> diff --git a/remote-curl.c b/remote-curl.c
> index 5959461cd3..dd0680e5ae 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -371,6 +371,7 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
>  			     struct strbuf *msg)
>  {
>  	const char *p, *eol;
> +	struct strbuf msgbuf = STRBUF_INIT;
>
>  	/*
>  	 * We only show text/plain parts, as other types are likely
> @@ -378,19 +379,24 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
>  	 */
>  	if (strcmp(type->buf, "text/plain"))
>  		return -1;
> +
> +	strbuf_addbuf(&msgbuf, msg);

Hmm. Looking at the list of show_http_message() callers, it looks like
they all follow the pattern of constructing a strbuf "msg", passing it
to this function, and then calling die() with some user-friendly
message.

I agree that the patch here does address that leak, but I wonder if we
should do it in a way that doesn't involve copying the "msg" buffer. One
thing we could do is rename 'show_http_message()' to make it clear that
it's fatal and then free the re-encoded buffer ourselves (along with the
other buffers type and charset), perhaps like so (on top of the previous
patch in lieu of this one):

--- 8< ---
diff --git a/remote-curl.c b/remote-curl.c
index 5959461cd34..9d8359665ee 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -367,23 +367,25 @@ static void free_discovery(struct discovery *d)
 	}
 }

-static int show_http_message(struct strbuf *type, struct strbuf *charset,
-			     struct strbuf *msg)
+static void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
+				    struct strbuf *msg, const char *fmt, ...)
 {
 	const char *p, *eol;
+	va_list ap;
+	report_fn die_message_routine = get_die_message_routine();

 	/*
 	 * We only show text/plain parts, as other types are likely
 	 * to be ugly to look at on the user's terminal.
 	 */
 	if (strcmp(type->buf, "text/plain"))
-		return -1;
+		goto out;
 	if (charset->len)
 		strbuf_reencode(msg, charset->buf, get_log_output_encoding());

 	strbuf_trim(msg);
 	if (!msg->len)
-		return -1;
+		goto out;

 	p = msg->buf;
 	do {
@@ -391,7 +393,15 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
 		p = eol + 1;
 	} while(*eol);
-	return 0;
+
+out:
+	strbuf_release(type);
+	strbuf_release(charset);
+	strbuf_release(msg);
+
+	va_start(ap, fmt);
+	die_message_routine(fmt, ap);
+	va_end(ap);
 }

 static int get_protocol_http_header(enum protocol_version version,
@@ -518,25 +528,27 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &charset, &buffer);
-		die(_("repository '%s' not found"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("repository '%s' not found"),
+					transport_anonymize_url(url.buf));
--- >8 ---

(...and so on for the remaining cases).

Thanks,
Taylor
