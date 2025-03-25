Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C525332E
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921727; cv=none; b=YsjJkiTQR+GVsnqzVwITo3SilaVI5hx/M2vQAG7v0iKgegh7htg0eCqyhaeRSAwTJqqlchCv1iLcSCsRy07y1idygwKw/ycc50cjGgGQPn+dWspdDWSvFC4QUuSNnmq5Nf/PeAIXRYNOozUq2k1qi9q/1yH0a0629MxwUd2gXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921727; c=relaxed/simple;
	bh=VBCaVk7WSQ8e966zBBKgoqc07NS0kNjdCqzq/SNfCIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kks+eSh2pjzlzGqs7tqcExsenedxK1a54lTmZ/1h4pPHVZ4OuS4pZvyzhl2vOKPVz4/Ptl7wbrJy7l7LYvhmEXQFBMbnEwu9YoRtHTgz07Xq7zcARQcF+qJxUsNrQgtMvXRsJM7kX2OpVndGszekvv/ncpOjyWEVk3XUCo+NdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eQ51AATB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eQ51AATB"
Received: (qmail 30941 invoked by uid 109); 25 Mar 2025 16:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VBCaVk7WSQ8e966zBBKgoqc07NS0kNjdCqzq/SNfCIc=; b=eQ51AATBw+uEPEEOYgDECHVYubxNA9OTDUPf/vXlC1/40B23ubph6aC8baWyiWeYqf6+DGh5aRWns4ONw1A++an77PBSofq1WU9PJt5SD+Bz0Hi2PugE8wGP/Yy/AuZToy94c6ZELGZFHNFOOAUGokx0gL9AsedbUZ72NuvTshE5uIP6v4yTMIYCKU3zaVC8qmAlxzIfxdcasNiM0C5W4RtsY5xpr5s+EkEywlXBLC89WI7KxBFAADkLlj5TuU9GnaYJzNOjAPXo/g5E4/ECaR7h6YvK1V/7GsQZZG3gm7VSAnSrKj8j88bkwEuR6J0gM8ZjecaBdqXN65QJzZxyhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Mar 2025 16:55:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31122 invoked by uid 111); 25 Mar 2025 16:55:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Mar 2025 12:55:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Mar 2025 12:55:14 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: avoid using the comma operator
 unnecessarily
Message-ID: <20250325165514.GA1902258@coredump.intra.peff.net>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <e3069fd4564bac68bdaf2079151b9b921867e277.1742889711.git.gitgitgadget@gmail.com>
 <930b4c9a-826f-4124-a70b-e0400a3fea5b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <930b4c9a-826f-4124-a70b-e0400a3fea5b@gmail.com>

On Tue, Mar 25, 2025 at 04:28:32PM +0000, Phillip Wood wrote:

> On 25/03/2025 08:01, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > The comma operator is a somewhat obscure C feature that is often used by
> > mistake and can even cause unintentional code flow. Better use a
> > semicolon instead.
> 
> clang's -Wcomma finds another instance in this file
> 
> @@ -1239,7 +1239,7 @@ static int fetch_git(struct discovery *heads,
>  	packet_buf_flush(&preamble);
> 
>  	memset(&rpc, 0, sizeof(rpc));
> -	rpc.service_name = "git-upload-pack",
> +	rpc.service_name = "git-upload-pack";
>  	rpc.gzip_request = 1;
> 
>  	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
> 
> In fact it finds a surprising number in our code base. I was worried there
> would be a lot of false positives but so far all of the ones I've looked at
> would be better not using a ","

It looks like there are a few tricky cases. Inside a loop condition,
a comma can be used to smuggle in an extra line. E.g., in wildmatch:

  do {
    ...
  } while (prev_ch = p_ch, (p_ch = *++p) != ']');

or there are a few spots in clar like:

  while ((d = (errno = 0, readdir(source_dir))) != NULL) {
    ...
  }
  cl_assert_(errno == 0, "Failed to iterate source dir");

These could probably be re-written, but it's not a totally trivial
change.

The rest of them seem pretty straight-forward (though you do have to
watch out for conditionals using it to stuff multiple lines into a
single "statement"):

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d..62bdf7276f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1843,7 +1843,7 @@ int cmd_rebase(int argc,
 	strbuf_addf(&msg, "%s (start): checkout %s",
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
-	ropts.orig_head = &options.orig_head->object.oid,
+	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
diff --git a/diff-delta.c b/diff-delta.c
index a4faf73829..71d37368d6 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -438,19 +438,31 @@ create_delta(const struct delta_index *index,
 			op = out + outpos++;
 			i = 0x80;
 
-			if (moff & 0x000000ff)
-				out[outpos++] = moff >> 0,  i |= 0x01;
-			if (moff & 0x0000ff00)
-				out[outpos++] = moff >> 8,  i |= 0x02;
-			if (moff & 0x00ff0000)
-				out[outpos++] = moff >> 16, i |= 0x04;
-			if (moff & 0xff000000)
-				out[outpos++] = moff >> 24, i |= 0x08;
-
-			if (msize & 0x00ff)
-				out[outpos++] = msize >> 0, i |= 0x10;
-			if (msize & 0xff00)
-				out[outpos++] = msize >> 8, i |= 0x20;
+			if (moff & 0x000000ff) {
+				out[outpos++] = moff >> 0;
+				i |= 0x01;
+			}
+			if (moff & 0x0000ff00) {
+				out[outpos++] = moff >> 8;
+				i |= 0x02;
+			}
+			if (moff & 0x00ff0000) {
+				out[outpos++] = moff >> 16;
+				i |= 0x04;
+			}
+			if (moff & 0xff000000) {
+				out[outpos++] = moff >> 24;
+				i |= 0x08;
+			}
+
+			if (msize & 0x00ff) {
+				out[outpos++] = msize >> 0;
+				i |= 0x10;
+			}
+			if (msize & 0xff00) {
+				out[outpos++] = msize >> 8;
+				i |= 0x20;
+			}
 
 			*op = i;
 
diff --git a/kwset.c b/kwset.c
index 1714eada60..23ab015448 100644
--- a/kwset.c
+++ b/kwset.c
@@ -197,10 +197,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
       while (link && label != link->label)
 	{
 	  links[depth] = link;
-	  if (label < link->label)
-	    dirs[depth++] = L, link = link->llink;
-	  else
-	    dirs[depth++] = R, link = link->rlink;
+	  if (label < link->label) {
+	    dirs[depth++] = L;
+	    link = link->llink;
+	  }
+	  else {
+	    dirs[depth++] = R;
+	    link = link->rlink;
+	  }
 	}
 
       /* The current character doesn't have an outgoing link at
@@ -257,14 +261,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 		  switch (dirs[depth + 1])
 		    {
 		    case L:
-		      r = links[depth], t = r->llink, rl = t->rlink;
-		      t->rlink = r, r->llink = rl;
+		      r = links[depth]; t = r->llink; rl = t->rlink;
+		      t->rlink = r; r->llink = rl;
 		      t->balance = r->balance = 0;
 		      break;
 		    case R:
-		      r = links[depth], l = r->llink, t = l->rlink;
-		      rl = t->rlink, lr = t->llink;
-		      t->llink = l, l->rlink = lr, t->rlink = r, r->llink = rl;
+		      r = links[depth]; l = r->llink; t = l->rlink;
+		      rl = t->rlink; lr = t->llink;
+		      t->llink = l; l->rlink = lr; t->rlink = r; r->llink = rl;
 		      l->balance = t->balance != 1 ? 0 : -1;
 		      r->balance = t->balance != (char) -1 ? 0 : 1;
 		      t->balance = 0;
@@ -277,14 +281,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 		  switch (dirs[depth + 1])
 		    {
 		    case R:
-		      l = links[depth], t = l->rlink, lr = t->llink;
-		      t->llink = l, l->rlink = lr;
+		      l = links[depth]; t = l->rlink; lr = t->llink;
+		      t->llink = l; l->rlink = lr;
 		      t->balance = l->balance = 0;
 		      break;
 		    case L:
-		      l = links[depth], r = l->rlink, t = r->llink;
-		      lr = t->llink, rl = t->rlink;
-		      t->llink = l, l->rlink = lr, t->rlink = r, r->llink = rl;
+		      l = links[depth]; r = l->rlink; t = r->llink;
+		      lr = t->llink; rl = t->rlink;
+		      t->llink = l; l->rlink = lr; t->rlink = r; r->llink = rl;
 		      l->balance = t->balance != 1 ? 0 : -1;
 		      r->balance = t->balance != (char) -1 ? 0 : 1;
 		      t->balance = 0;
@@ -567,22 +571,22 @@ bmexec (kwset_t kws, char const *text, size_t size)
       {
 	while (tp <= ep)
 	  {
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	  }
 	break;
       found:
@@ -649,7 +653,7 @@ cwexec (kwset_t kws, char const *text, size_t len, struct kwsmatch *kwsmatch)
     mch = NULL;
   else
     {
-      mch = text, accept = kwset->trie;
+      mch = text; accept = kwset->trie;
       goto match;
     }
 
diff --git a/remote-curl.c b/remote-curl.c
index 1273507a96..590b228f67 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1239,7 +1239,7 @@ static int fetch_git(struct discovery *heads,
 	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
-	rpc.service_name = "git-upload-pack",
+	rpc.service_name = "git-upload-pack";
 	rpc.gzip_request = 1;
 
 	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
@@ -1401,7 +1401,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
-	rpc.service_name = "git-receive-pack",
+	rpc.service_name = "git-receive-pack";
 
 	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
 	if (rpc_result.len)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 8889b8b62a..5a96e36dfb 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -211,8 +211,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			for (d = fmax; d >= fmin; d -= 2) {
 				i1 = XDL_MIN(kvdf[d], lim1);
 				i2 = i1 - d;
-				if (lim2 < i2)
-					i1 = lim2 + d, i2 = lim2;
+				if (lim2 < i2) {
+					i1 = lim2 + d;
+					i2 = lim2;
+				}
 				if (fbest < i1 + i2) {
 					fbest = i1 + i2;
 					fbest1 = i1;
@@ -223,8 +225,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			for (d = bmax; d >= bmin; d -= 2) {
 				i1 = XDL_MAX(off1, kvdb[d]);
 				i2 = i1 - d;
-				if (i2 < off2)
-					i1 = off2 + d, i2 = off2;
+				if (i2 < off2) {
+					i1 = off2 + d;
+					i2 = off2;
+				}
 				if (i1 + i2 < bbest) {
 					bbest = i1 + i2;
 					bbest1 = i1;

-Peff
