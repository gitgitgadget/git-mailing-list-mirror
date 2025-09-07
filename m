Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72A2773DE
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757262151; cv=none; b=Sp/q3QMrfIjOOWtK6+wAvdiFriXXqUbRUFoM3gIbLsTtUTQS7lfDZmRBWYKfMpSLwM1pXlkbqdME18VV/PSk45ewoSVokEff1LlHpTX/MX0JW3wyuHRsXkYDjEf0oPF0rox4scqDS5R3YMAQjoT8mfUlXUow8qxSojsqc9VbC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757262151; c=relaxed/simple;
	bh=jGfUCu5iWCxaUIEaxfYZsy0mh4xDDZsP1RewY/dl6EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDDhGVqiN9P3BRWSFNqVNbm5zyzrLvkiUCmF5YmzfSUSWF+dT3WuRlLGGtN7JkbLVWF1UYdCJZLTmJSTt2istBFQAJqJrLHQWlSwa+ZHnw0JxoiqTuF51ONok/Qqe7IzbCLf7QZBleLid81xX55WOPS7jKqzr6XG8nMTegTkPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jQogANq6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jQogANq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757262138; x=1757866938; i=l.s.r@web.de;
	bh=iJJIge9D9YeaHUaj/7IiuEGya8HqRjGngdXe3chgD/0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jQogANq6bYoZaRf9EYf0hbP9eLvA/PMoVBr8qTLZ9ZFmqnV9ikpOI9yynfP+cysf
	 J3af+JLDnfuHzwmZTVXdPlAjbgn/f2YneeX/Er/Sr65obxEdLxgfmppbQC5CkBGzE
	 nuATfrXiYG/c4K19JpeJ1eTe/racbn48LvZAy/BAKZMmcYBN2G3sUQzzei1AW049i
	 utkU9QQakWEovIaW8PzBppvzLIchUEm7jMoQ2icKS0GtdspYavHEwc5Ky76Xvl40t
	 dFxv0yyyyzd24dquvCyYDBC/JINQU1EOjbs1ZuRJkSy/EOO9b+1DG7reTcukYdgCl
	 K0BUFE4ndjjzVN9k0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1u7Knv2gbd-00kiYB; Sun, 07
 Sep 2025 18:22:18 +0200
Message-ID: <81d10b44-5b3a-42af-acf4-ae76f2fee298@web.de>
Date: Sun, 7 Sep 2025 18:22:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] object-name: declare pointer type of
 extend_abbrev_len()'s 2nd parameter
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <e0bc9a67-faa9-4218-a55a-c7d53c15cfce@web.de>
 <xmqqv7ly6kup.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqv7ly6kup.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mjXmohFK4HLGzw51hF6mzdYBvtYxzdHSmoMlTSJMImY8RfXfj4s
 fUPeIrqYLrjh3ZzTIFAJfsIcN84qehPw7kWmvkLkIHD3jaFrOaPADZ9IO63CVbYLe4PhMZB
 Q8OsfRcaC2Y38p8V2ESOPKV1VCSty+1+/9ld5u76D6exfTK4azV5LCFtp0LRzRRnPV1bcfV
 ozznxXEBgdGTOPh48hrTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d9kl4ntGprE=;+htKMV1vZ8T4LGwJwdb9IT+9tOR
 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
 0RihLIFAADZMpdV5XfK81sNy2dz+NXVA==

On 9/4/25 10:09 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Expose the expected type of the second parameter of extend_abbrev_len()
>> instead of casting a void pointer internally.  Just a single caller
>> passes in a void pointer, the rest pass the correct type.  Let the
>> compiler help keeping it that way.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  object-name.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> We obviously do *not* have to, but I have to wonder if we want to go
> one step further to have that single caller explicitly cast it down
> to make the intent more clear, i.e.e.g.,
>=20
>  object-name.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git c/object-name.c w/object-name.c
> index 11aa0e6afc..8335d0239e 100644
> --- c/object-name.c
> +++ w/object-name.c
> @@ -714,7 +714,9 @@ static int repo_extend_abbrev_len(struct repository =
*r UNUSED,
>  				  const struct object_id *oid,
>  				  void *cb_data)
>  {
> -	return extend_abbrev_len(oid, cb_data);
> +	struct min_abbrev_data *mad =3D cb_data;
> +
> +	return extend_abbrev_len(oid, mad);
>  }
> =20
>  static void find_abbrev_len_for_midx(struct multi_pack_index *m,

I can see the appeal, even though (or because) it's kinda half a step
back as it keeps the original local variable, in a better place.

We could _lunge_ forward and add type checks to allow the compiler to
tell us whether the pointers' journey through the void is safe.  The
trick below is simple enough, but requires bespoke macros AFAICS.

Ren=C3=A9


=2D--
 object-name.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/object-name.c b/object-name.c
index 1e0118e8a6..c37a3826d0 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -52,6 +52,22 @@ struct disambiguate_state {
 	unsigned always_call_fn:1;
 };
=20
+#define DEFINE_DISAMBIGUATE_HINT_CB(scope, fn_name) \
+scope int fn_name##__void(struct repository *r, const struct object_id *o=
id, \
+			  void *cb_data) \
+{ \
+	return fn_name(r, oid, cb_data); \
+} \
+scope int fn_name##__void(struct repository *, const struct object_id *, =
void *)
+
+#define SET_DISAMBIGUATE_HINT_CB_DATA(ds, fn_name, data) do { \
+	struct disambiguate_state *dsp =3D (ds); \
+	if (0) \
+		fn_name(NULL, NULL, (data)); \
+	dsp->fn =3D fn_name##__void; \
+	dsp->cb_data =3D (data); \
+} while (0)
+
 static void update_candidates(struct disambiguate_state *ds, const struct=
 object_id *current)
 {
 	/* The hash algorithm of current has already been filtered */
@@ -510,11 +526,13 @@ static int collect_ambiguous(const struct object_id =
*oid, void *data)
=20
 static int repo_collect_ambiguous(struct repository *r UNUSED,
 				  const struct object_id *oid,
-				  void *data)
+				  struct oid_array *collect)
 {
-	return collect_ambiguous(oid, data);
+	return collect_ambiguous(oid, collect);
 }
=20
+DEFINE_DISAMBIGUATE_HINT_CB(static, repo_collect_ambiguous);
+
 static int sort_ambiguous(const void *va, const void *vb, void *ctx)
 {
 	struct repository *sort_ambiguous_repo =3D ctx;
@@ -654,8 +672,7 @@ int repo_for_each_abbrev(struct repository *r, const c=
har *prefix,
 		return -1;
=20
 	ds.always_call_fn =3D 1;
-	ds.fn =3D repo_collect_ambiguous;
-	ds.cb_data =3D &collect;
+	SET_DISAMBIGUATE_HINT_CB_DATA(&ds, repo_collect_ambiguous, &collect);
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
=20
@@ -711,11 +728,13 @@ static int extend_abbrev_len(const struct object_id =
*oid,
=20
 static int repo_extend_abbrev_len(struct repository *r UNUSED,
 				  const struct object_id *oid,
-				  void *cb_data)
+				  struct min_abbrev_data *mad)
 {
-	return extend_abbrev_len(oid, cb_data);
+	return extend_abbrev_len(oid, mad);
 }
=20
+DEFINE_DISAMBIGUATE_HINT_CB(static, repo_extend_abbrev_len);
+
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
 				     struct min_abbrev_data *mad)
 {
@@ -871,9 +890,8 @@ int repo_find_unique_abbrev_r(struct repository *r, ch=
ar *hex,
 	if (init_object_disambiguation(r, hex, mad.cur_len, algo, &ds) < 0)
 		return -1;
=20
-	ds.fn =3D repo_extend_abbrev_len;
 	ds.always_call_fn =3D 1;
-	ds.cb_data =3D (void *)&mad;
+	SET_DISAMBIGUATE_HINT_CB_DATA(&ds, repo_extend_abbrev_len, &mad);
=20
 	find_short_object_filename(&ds);
 	(void)finish_object_disambiguation(&ds, &oid_ret);
=2D-=20
2.51.0

