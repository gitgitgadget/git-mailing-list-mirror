Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EB20E02B
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440730; cv=none; b=I1v6yDG+WyExu+tOOmMgMwS7esiskzMLIHgkF8pSanMLB52aLJXwNRlYSgoPlmHeMqMVHjgM6JMwfPuyckW3Q8oc3Yf4BL9oE7olH/4Qj9ZKDRVGSGv62O57QmxJ07et0Da55smkonfa1yVhDeeRG/38d98XqZln6ViCSM3os8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440730; c=relaxed/simple;
	bh=vbafuN0DET14SRiRzQqnQPY+C0ogSVZFZgC7+NnblRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKZul57kqLGdQAIwf5xfXDx7CUgVfEMBcv8yOtcCz9oEkA2739PYKPH4BKFxEhyl4pSyvYd9494fvyDPhQr1JwykwI1q9hcf/VZZBgW/Z6JmI5e7QmD+Dyl6iyZ3lk2qPztzpSfwFzz9i1d4Z613c6lflqGFT8QOWDjNkIOW+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WkhT+UXZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WkhT+UXZ"
Received: (qmail 21324 invoked by uid 109); 24 Feb 2025 23:45:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vbafuN0DET14SRiRzQqnQPY+C0ogSVZFZgC7+NnblRw=; b=WkhT+UXZOWftZpGBvKk962bnxpkTPG26NnxxEjfV4qGFhPXrdYQsOWRJ/tnCefyhBxJ8+/UQohudapjnRzd5W41ja5UgTncVrxkUYYwHAdMPhyYvBbJkX1sMxc70sIezHLdS3TS0nm2hfxUyBXQjYag5sheR/Ck2nnfnxN44a+yIBzVg+hn3xlrTZT68TjHtx1ADzi/fKRFATRd91lrkdoM2/IjH7REMMn/H1tc7GtgzWYK/RVMq7xVah1sFfW1px582JgP89/woeqcVVarvBCcKaa292fLkfMZIQIeFXGDyAlZTdKeUqVM8XWClbMtJSgrb1+qSd1EiLYW+xy9Z0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Feb 2025 23:45:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30568 invoked by uid 111); 24 Feb 2025 23:45:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2025 18:45:26 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Feb 2025 18:45:25 -0500
From: Jeff King <peff@peff.net>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v10 8/8] cat-file: add remote-object-info to batch-command
Message-ID: <20250224234525.GB729825@coredump.intra.peff.net>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
 <20250114021502.41499-9-eric.peijian@gmail.com>
 <20250201020321.GA4081169@coredump.intra.peff.net>
 <CAN2LT1AFA8AG58NNVvW2nvWR27qisPXDzSTR-tUycWGi96kcaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN2LT1AFA8AG58NNVvW2nvWR27qisPXDzSTR-tUycWGi96kcaw@mail.gmail.com>

On Fri, Feb 21, 2025 at 10:34:44AM -0500, Peijian Ju wrote:

> Thank you. Revised to use xstrdup() in v11.
> 
> >   2. Are there any bounds on the size of "line"? E.g., is it coming in
> >      as a single pkt, or can it be arbitrarily large if an attacker
> >      wants (it looks like maybe the latter, since it comes from a strbuf
> >      in batch_objects_command(), but I didn't look at how network data
> >      gets passed in to that). At any rate, I think we ran into problems
> >      before with split_cmdline() and integer overflow, since it returns
> >      an int (CVE-2022-39260). I thought we fixed it by rejecting long
> >      lines in git-shell, but it looks like we also hardened
> >      split_cmdline() in 0ca6ead81e (alias.c: reject too-long cmdline
> >      strings in split_cmdline(), 2022-09-28).
> >
> >      So we are maybe OK, but I wonder if we should punt on absurd lines.
> >      Related, can an attacker just flood input into that strbuf, making
> >      it grow forever and waste memory? That's just a simple resource
> >      attack, but we have tried to avoid those elsewhere in upload-pack,
> >      etc.
> >
> 
> Thank you. Adding a check in v11 for the length of `lines`. Please let
> me know if something like this makes sense:
> 
> if (strlen(line) >= INT_MAX) {
>         die(_("remote-object-info command input overflow"));
> }

I took a look at what you ended up with in v11, and...I think I totally
misunderstood what was going on in your series, or when this code would
be run.

I had thought the cat-file here was running on the server side, and that
we needed to protect ourselves against malicious clients. But your new
parse_cmd_remote_object_info() is purely a client-side function that
will then access the server behind the scenes. And its input will be
coming from the stdin of cat-file locally.

So I'm not sure that we need to protect it unless we think there's some
way that an attacker can automatically trigger arbitrary
remote-object-info requests.

That said, I'm not sure why you need split_cmdline() at all. The format
seems to be:

  remote-object-info <url> <oid>...

The only thing that _might_ need quoting is the url, but is shell
quoting a reasonable thing there? I'd think that it would be
URL-encoded, and thus contain no spaces. The <oid> has to be a real full
oid, I think, because the object-info on the server side insists on
that.

So why not just split on space? Something like this:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9de1016acd..aedbcba347 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -597,7 +597,7 @@ static void batch_one_object(const char *obj_name,
 	object_context_release(&ctx);
 }
 
-static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
+static int get_remote_info(struct batch_options *opt, const char *url, const char *oid_list)
 {
 	int retval = 0;
 	struct remote *remote = NULL;
@@ -613,16 +613,19 @@ static int get_remote_info(struct batch_options *opt, int argc, const char **arg
 	if (!opt->format)
 		opt->format = "%(objectname) %(objectsize)";
 
-	remote = remote_get(argv[0]);
+	remote = remote_get(url);
 	if (!remote)
 		die(_("must supply valid remote when using remote-object-info"));
 
 	oid_array_clear(&object_info_oids);
-	for (size_t i = 1; i < argc; i++) {
-		if (get_oid_hex(argv[i], &oid))
-			die(_("Not a valid object name %s"), argv[i]);
+	while (*oid_list) {
+		if (parse_oid_hex(oid_list, &oid, &oid_list))
+			die(_("Not a valid object name %s"), oid_list);
 		oid_array_append(&object_info_oids, &oid);
+		while (*oid_list == ' ')
+			oid_list++;
 	}
+
 	if (!object_info_oids.nr)
 		die(_("remote-object-info requires objects"));
 
@@ -747,21 +750,15 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 					 const char *line, struct strbuf *output,
 					 struct expand_data *data)
 {
-	int count;
-	const char **argv;
-	char *line_to_split;
-
-	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
-		die(_("remote-object-info command input overflow "
-			"(no more than %d objects are allowed)"),
-			MAX_ALLOWED_OBJ_LIMIT);
+	char *url;
+	const char *space;
 
-	line_to_split = xstrdup(line);
-	count = split_cmdline(line_to_split, &argv);
-	if (count < 0)
-		die(_("split remote-object-info command"));
+	space = strchr(line, ' ');
+	if (!space)
+		return; /* report error somehow? */
+	url = xmemdupz(line, space - line);
 
-	if (get_remote_info(opt, count, argv))
+	if (get_remote_info(opt, url, space + 1))
 		goto cleanup;
 
 	data->skip_object_info = 1;
@@ -774,16 +771,15 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 			 */
 			data->size = *remote_object_info[i].sizep;
 			opt->batch_mode = BATCH_MODE_INFO;
-			batch_object_write(argv[i+1], output, opt, data, NULL, 0);
+			batch_object_write(oid_to_hex(&data->oid), output, opt, data, NULL, 0);
 		}
 	}
 	data->skip_object_info = 0;
 
 cleanup:
 	for (size_t i = 0; i < object_info_oids.nr; i++)
 		free_object_info_contents(&remote_object_info[i]);
-	free(line_to_split);
-	free(argv);
+	free(url);
 	free(remote_object_info);
 }
 

You'd need to adjust t1017 to remote the quotes from the inputs, and I
think you'd have to correctly url-encoded the file:// one to avoid
spaces (but that is technically true already! If the filesystem path has
a "%" in it, it would be misinterpreted).

-Peff
