Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62A3033E0
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417618; cv=none; b=ZlkHtE4Z/N1llPfkkXrBUjuzNv3gkRS49F8qwgg0SLGM4cMhY+kqPr8TOlnyC0j8DhHkmKVMj1urfhHYDrcq885NYiOveEy5jI3NIcrtvdo/iJjAEsjHwkDCM1bztpDj8JkIV71Qj0ScMQSyrJaJbROP4RkXE3iJT11AO9igwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417618; c=relaxed/simple;
	bh=W8ZcwAWcgL5lZ0QVk3bnEAJlG5zT1SWdMLFBJEvBH7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8u03VNB3T8VMqtzaxo1PB5AsvwlR41mXzg9ivr/hikayy19+X1GIUnnF3hSRYYVgJB0czUx2P9b4WB7T15TbgBLK2yORwpwL2NDJJEkMnnNv6BhI9nqsuHJJCcqtPyh1yNqW1534f0hEoCxKGk3h8escMEPLCorYUXRUYtJn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AZngm2VX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZ/gdtd4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AZngm2VX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZ/gdtd4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED6B37A0108;
	Mon, 26 Jan 2026 03:53:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 03:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769417615; x=1769504015; bh=J2z9PyzeJz
	qNfFdytZbmtKZSeWjrwsBgJyg4RinOV7E=; b=AZngm2VXoosQKMjOnFP7hzrRKx
	6QeTVZFe43booEOEsRfhFoJ+HOkKl++is2nKfolFY3EkpHgNcsGkYBYAOe8fYfYU
	jhUyZbNR+uMbrhG5LH9aHTCzh9+pveoFeGQBbdpXdzJx5/BCmrJJQXzlwVdpv8p8
	AVfPeA6C0oPcj2E8YzyZkBZon1GmOrNqgJl2gQ4edfRHVrMP5FuX/pscFVKix8X6
	NVX0FqLsdNnKsX4ts/z6SJ0SK442OujlnXCR8IDhqveNDMeODCGv+bmIaAqYauK5
	WQDDu0tPgZPGuHyShrYWWbHph2JySU/R3ZplarnixvYW2CAdKOkU/YSwujEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769417615; x=1769504015; bh=J2z9PyzeJzqNfFdytZbmtKZSeWjrwsBgJyg
	4RinOV7E=; b=tZ/gdtd4rPx7+SHga2jZzFeVRCW4LpyEnuZEfAQ4y6dUL0Y4jtF
	KvF/UipvE8rNzMdptxe2ZZ0FHOrd1N238NY04esL1lDovxiIhQ38An+nqBaUbKUp
	EW0ZWEW0ec0AxYHasUfz7c7n8setZa+2bH21tgGEh6tEktrP4ZGkECmOzYbRTnJj
	hT66uk4qGXiQ9H65R4TSAQlMbdTrXcG13E4ZHxoFyqrKuLFaBn7AoTupxmLNARDD
	782e2X3iCeQ20mr4L6ZS58zSvHnrthQZGm+cAc2a+o16E0Z+ooEmSTVAnLyHTqvc
	e5ZArBxmc47rrgv7rrrrta/SjC4quSC5slA==
X-ME-Sender: <xms:jyt3aeXr21Ypuq6BlSWAEzQNUPj-aNiL_W1ZDJehXNfd6Nl7AMoWPw>
    <xme:jyt3aRcV3Lk2Ngl4xa3f1PIgEgxcHqEaEuL-tMPY963A65VLkRAXYt5qKonvG-0_o
    TF0s9WmTB9pfdaqM8aARMOuCX-4vIj3AAOkJ2GE6MNGbAlEsOv5n1M>
X-ME-Received: <xmr:jyt3aas37uNVvFE3vskbFRJoDjEZzPnbmkfzQSMEU-c4CFn8ceWa6zGUkMDfUYAk9Yk4QScXE5XgGzJota7wkQlVqpZhIH890HmxeWwPyW-y4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:jyt3aQ-AtjO3091NSH9WHqvxT2xEV3oeNgFdXRzJYmkEhh4Qvlvtrg>
    <xmx:jyt3aV29q0DS81CX44ASAC1vqsFkE6gwOxBtHf6UKhddput5BY1zvw>
    <xmx:jyt3aVCI-RCCa2Q1F_1DvMVYmZLwJHZ1I1g4AP6jaTcB-qdEYwR5pg>
    <xmx:jyt3aRcysMpu0ucxxfpBqg2nKHfkJrb6tqYp9ac_kcdG9wBK3CHIYw>
    <xmx:jyt3afX4cvkemK_7Hx-rJ22pp_x5yEULrw88QRtnqox3A9COGLHeylIr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 03:53:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb389c70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 08:53:33 +0000 (UTC)
Date: Mon, 26 Jan 2026 09:53:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/14] odb: introduce mtime fields for object info
 requests
Message-ID: <aXcrii58bIdLttI2@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-11-12c4dfd24227@pks.im>
 <aXLJoDdoEyKXKtBf@nand.local>
 <aXNCq8h94i2Z6uSa@pks.im>
 <aXO0cNaY3DWu6aQ2@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXO0cNaY3DWu6aQ2@nand.local>

On Fri, Jan 23, 2026 at 12:48:32PM -0500, Taylor Blau wrote:
> On Fri, Jan 23, 2026 at 10:43:07AM +0100, Patrick Steinhardt wrote:
> > > > diff --git a/odb.c b/odb.c
> > > > index 65f0447aa5..67decd3908 100644
> > > > --- a/odb.c
> > > > +++ b/odb.c
> > > > @@ -702,6 +702,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
> > > >  				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> > > >  			if (oi->contentp)
> > > >  				*oi->contentp = xmemdupz(co->buf, co->size);
> > > > +			if (oi->mtimep)
> > > > +				*oi->mtimep = 0;
> > >
> > > Assuming that you do not change the object_info request/response
> > > semantics, I wonder if it might make sense to zero out the entirety of
> > > the response section as a belt-and-suspenders mechanism in case future
> > > contributors forget to assign zero to the new fields themselves.
> >
> > Splitting up the request/response structure as you proposed in a
> > previous patch could definitely help with this. I'd prefer to rather do
> > such a bigger change as a follow-up though as it would lead to a lot of
> > churn.
> 
> I'm OK with pushing the larger change down the road, but I am a little
> uncomfortable with the interim state being introduced here. Perhaps a
> compromise here would be to have the caller supply a pointer to an
> object_info struct, whose request fields we honor. The response fields
> would then be written into a separate object_info struct via an
> out-parameter.
> 
> I don't know. I think that ^ this suggestion is kind of ugly, but I'm
> trying to come up with something that doesn't introduce the risk I
> described above in the interim between this patch series and the one
> you're proposing later on.

I think it's actually not _that_ ugly, and I like the additional safety
that it brings us.

Thanks!

Patrick

diff --git a/object-file.c b/object-file.c
index bc5209f2fe..6785821c8c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1804,7 +1804,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 
 struct for_each_object_wrapper_data {
 	struct odb_source *source;
-	struct object_info *oi;
+	const struct object_info *request;
 	odb_for_each_object_cb cb;
 	void *cb_data;
 };
@@ -1814,21 +1814,28 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 				      void *cb_data)
 {
 	struct for_each_object_wrapper_data *data = cb_data;
-	if (data->oi &&
-	    read_object_info_from_path(data->source, path, oid, data->oi, 0) < 0)
+
+	if (data->request) {
+		struct object_info oi = *data->request;
+
+		if (read_object_info_from_path(data->source, path, oid, &oi, 0) < 0)
 			return -1;
-	return data->cb(oid, data->oi, data->cb_data);
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
 }
 
 int odb_source_loose_for_each_object(struct odb_source *source,
-				     struct object_info *oi,
+				     const struct object_info *request,
 				     odb_for_each_object_cb cb,
 				     void *cb_data,
 				     unsigned flags)
 {
 	struct for_each_object_wrapper_data data = {
 		.source = source,
-		.oi = oi,
+		.request = request,
 		.cb = cb,
 		.cb_data = cb_data,
 	};
diff --git a/object-file.h b/object-file.h
index af7f57d2a1..d9979baea8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -128,12 +128,13 @@ int for_each_loose_file_in_source(struct odb_source *source,
 
 /*
  * Iterate through all loose objects in the given object database source and
- * invoke the callback function for each of them. If given, the object info
- * will be populated with the object's data as if you had called
- * `odb_source_loose_read_object_info()` on the object.
+ * invoke the callback function for each of them. If an object info request is
+ * given, then the object info will be read for every individual object and
+ * passed to the callback as if `odb_source_loose_read_object_info()` was
+ * called for the object.
  */
 int odb_source_loose_for_each_object(struct odb_source *source,
-				     struct object_info *oi,
+				     const struct object_info *request,
 				     odb_for_each_object_cb cb,
 				     void *cb_data,
 				     unsigned flags);
diff --git a/odb.c b/odb.c
index 67decd3908..9d9a3fad62 100644
--- a/odb.c
+++ b/odb.c
@@ -998,7 +998,7 @@ int odb_freshen_object(struct object_database *odb,
 }
 
 int odb_for_each_object(struct object_database *odb,
-			struct object_info *oi,
+			const struct object_info *request,
 			odb_for_each_object_cb cb,
 			void *cb_data,
 			unsigned flags)
@@ -1011,12 +1011,14 @@ int odb_for_each_object(struct object_database *odb,
 			continue;
 
 		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
+			ret = odb_source_loose_for_each_object(source, request,
+							       cb, cb_data, flags);
 			if (ret)
 				return ret;
 		}
 
-		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);
+		ret = packfile_store_for_each_object(source->packfiles, request,
+						     cb, cb_data, flags);
 		if (ret)
 			return ret;
 	}
diff --git a/odb.h b/odb.h
index 72d69ffcb3..8ad0fcc02f 100644
--- a/odb.h
+++ b/odb.h
@@ -492,6 +492,9 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
  * Iterate through all objects contained in the object database. Note that
  * objects may be iterated over multiple times in case they are either stored
  * in different backends or in case they are stored in multiple sources.
+ * If an object info request is given, then the object info will be read and
+ * passed to the callback as if `odb_read_object_info()` was called for the
+ * object.
  *
  * Returning a non-zero error code from the callback function will cause
  * iteration to abort. The error code will be propagated.
@@ -500,7 +503,7 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
  * an arbitrary non-zero error code returned by the callback itself.
  */
 int odb_for_each_object(struct object_database *odb,
-			struct object_info *oi,
+			const struct object_info *request,
 			odb_for_each_object_cb cb,
 			void *cb_data,
 			unsigned flags);
diff --git a/packfile.c b/packfile.c
index e455150d65..57fbf51876 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2329,7 +2329,7 @@ int for_each_object_in_pack(struct packed_git *p,
 
 struct packfile_store_for_each_object_wrapper_data {
 	struct packfile_store *store;
-	struct object_info *oi;
+	const struct object_info *request;
 	odb_for_each_object_cb cb;
 	void *cb_data;
 };
@@ -2341,28 +2341,31 @@ static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
 {
 	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
 
-	if (data->oi) {
+	if (data->request) {
 		off_t offset = nth_packed_object_offset(pack, index_pos);
+		struct object_info oi = *data->request;
 
 		if (packed_object_info_with_index_pos(pack, offset,
-						      &index_pos, data->oi) < 0) {
+						      &index_pos, &oi) < 0) {
 			mark_bad_packed_object(pack, oid);
 			return -1;
 		}
-	}
 
-	return data->cb(oid, data->oi, data->cb_data);
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
 }
 
 int packfile_store_for_each_object(struct packfile_store *store,
-				   struct object_info *oi,
+				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
 				   unsigned flags)
 {
 	struct packfile_store_for_each_object_wrapper_data data = {
 		.store = store,
-		.oi = oi,
+		.request = request,
 		.cb = cb,
 		.cb_data = cb_data,
 	};
diff --git a/packfile.h b/packfile.h
index 8e0d2b7661..1a1b720764 100644
--- a/packfile.h
+++ b/packfile.h
@@ -343,14 +343,15 @@ int for_each_object_in_pack(struct packed_git *p,
 
 /*
  * Iterate through all packed objects in the given packfile store and invoke
- * the callback function for each of them. If given, the object info will be
- * populated with the object's data as if you had called
- * `packfile_store_read_object_info()` on the object.
+ * the callback function for each of them. If an object info request is given,
+ * then the object info will be read for every individual object and passed to
+ * the callback as if `packfile_store_read_object_info()` was called for the
+ * object.
  *
  * The flags parameter is a combination of `odb_for_each_object_flags`.
  */
 int packfile_store_for_each_object(struct packfile_store *store,
-				   struct object_info *oi,
+				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
 				   unsigned flags);

