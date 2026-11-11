Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415445;
	b=qzDexjrUOCThf9kUzf50sJlO0Kl7LzdXDIYf9NDVUPBl0rFcRPSx8qq12Gb0An6fayij
	 wu3WWgFFyTjo/ylfEbQ/hs/iwrFoOO8pZGedZYKg4LAhnBPO69R8p/dXhklMK6rGZ+Q9m
	 LC0ecQ9D3yMzWm6m9qpCCjQHTOLd3b1BDdwrlJUFJNz6Gq1qb6h0gmamSID7lD0n/uCkr
	 gtqnu1A2S5ms+nYiUSV9Voq/4/1aVp45rKJVhguO1mbeC+fbGvfCu+PIYZXAb39HG/AIj
	 +q9c+qfpQD22AyrqNZYaSPVlrE7UFHKXBN7O7jOV4AODLhqaXsW82/efiUxKH0XscPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=yfdTeBD0hURkB/YL2l7CHO5Xr5HFZKhXIJ/6/Z/LoNU=;
	b=CHDFg5H/kP1z0Gt9yHJ5UQtATOWxkxJ8LRaUgygBYbHeM9hWNUtr4bVv0yB8w11a80oL
	 fFmL/0QIOE4OJouM2LF2bIFJW1uyX69ZYdFvqg3LiJHFJm1KXsfECmrvcPwohVk+taoJe
	 WZ+m3ysjLq1hGi/bUJ1YJ3TecO5ByNYJfZmaGEWMXzvsvnDUzR59G38Pr8KHmrL3y9XCS
	 h/P7es1OzZlZfqm/ffx4PO4uWnIhyafJXeTG/nA0swPFfY5KBAtNoeZGLbZB3ZS7bNpUn
	 VS4e+eShQlfFHdQ76qImycyR367rqkRVDRpZuzXSkvRCrA0Lc4BmJEuXdpYdNshtY8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrK6lRb5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F2606A326
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 176F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrK6lRb5
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso1111811e0c.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794415444; cv=none;
        d=google.com; s=arc-20260327;
        b=LkBPFhz6s06iDBcC5hMRjVM3vkw0Q8oG0rYQ//DvweKevVphoahjVMwDbB4UgSSd8m
         sWIQff01aYmPxqxGe5LhLXfG6aWihlK6rSow8YnJVduR/AZXPtZUpPjfLDeslY0CNMFN
         GNT13QzBv+gnxqgcVi51hwNDcBjnir08DhO7rVwRxJnzULdBPXuiQ6Id/5e+bcRq/iEm
         iEdgFhF4wHBjIUaHEYBti9RC1DwqlAkNN/pSkrkHGpj+etxxT/dHkEDCB3+iMbXPsI/7
         5sdFH4rs/Dc4FSJ+DrMzv9W8nqh02dEwi2sO/jGNpgFhZwvIUnvZah0xcliGktqB5HYT
         XLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=yfdTeBD0hURkB/YL2l7CHO5Xr5HFZKhXIJ/6/Z/LoNU=;
        fh=S2Mjb6qtwXGDUcEpCk4/Ldywj+EsOIKMcAAgqBFaHdo=;
        b=iPtS2DMkHewzteieM9xlPhgITLF2rqJ9NrCgLSbhsyEvaE7XaNIWxIA2jL2E3D641d
         q4xnsWgbu4mfG5M+U+d2fNYS4A/+P5lUUD44rOxdgMSKlKGhmZpI3ni4b1B4EkT46QAW
         0VfvUKdEwIZbPraet5lLrfGCwOMvFNJL0njv9BoxkdIvVxQnbtqFx3SOkmi+/r9yr4Xd
         CCyBXnnVcmpEsR1Blkc0qbPznhWEiER0JTyHjHi1jTIl+7mSXn/ml4BD0y0mLtKL+p+k
         6AwtSlnGXGid+aRIqmiL57B2mkyeR6CQU4/k47uQLH2euRLqRillJmOanLqJVu4SVmAK
         oIcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415444; x=1795020244; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfdTeBD0hURkB/YL2l7CHO5Xr5HFZKhXIJ/6/Z/LoNU=;
        b=BrK6lRb5ezFa+BBJ4X7XuDydfyU68QU9BNEXMyUlStFq6ip6vUrpfGrlx2yHj2TGU6
         iYYXbdAj+p3SU3KQdowu84NQ2frE5YD/PtMilRlLof+qrss2CHMYVlHHdW49MCnYgWWR
         7mRz873tZ36b0ms185GPcFbFrm6oCak96G/R7na9AYt+2ylNthIakhNvAdEDR/mafV2y
         OkAiV4dwpzP9zEU2JxMBYK1NMano84GCtVIXNlajE8ua45kQuxdSKYTU1RKTkk9dxcQH
         BGEQ+Y9+dgabt+q6ktzMLh+zT01TluM1QSBSIaq/lvFgan4RpLiGHFjochESJQuUBThq
         yJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415444; x=1795020244;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yfdTeBD0hURkB/YL2l7CHO5Xr5HFZKhXIJ/6/Z/LoNU=;
        b=ND0oyY9Hd8IM1LO6l6suJYmupd5p+vMLczhByl1ShN5RGn0L/vHiUdYEZwZZdVu1ZG
         MP7MrpwAXfXgTeq1tE3Q2yGzAees/v6J1yKGoT2w6zqIZg+HKA+sGJJzpCOYSU+KN3la
         LnR4FuuDEfEEMVxjwgdWsspPPCKWgGdXm2O4ShZrzT4Hkmilg6qsX7r1StJqZ7j99iwW
         eubLrVfRBNXMwJBn80z5RSKl9YqlWO+XQpKgNxbo9xhUMtbKhh2K1BWpokkbkNuGmBsL
         DfHNqc5N7mMOY9ultP2ai114wx+XyDnGliGdNv+fOyFHhMfoxhY6GshpTEbzvyzupHWK
         uyxw==
X-Forwarded-Encrypted: i=1; AL+hErFL3MKhsWAsrbYnprZgqTD9Y4gu1RXGvV3MuvUaAP7xHXCkhmEdLvpKilZzoXFj35EMnKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qD8RgvUfMZtO9irsgl5UiMsr93FItCahIpNRfrfjVYXivQ9fR
	IL8APiqHeKTqwv7CUNBWOeJEbfO45r3zu8SHfjeeyof8cifbGCWFObpi4HPx1FrTIRogNh8IJCG
	xXg1cZDPwSUjkTQJWhMJy32WMrjmBq90=
X-Gm-Gg: AYBFou3mPvzLGDdycfgezHXmD8AKH/kqVJQ1HWIrQi0SIhzz9Nn7rORAs+hl8ntyleA
	xP1n9X4s3i1FYQz/IT/0Eo/jNzWKHfZoYL88h8MovTHq1pp4OEUpVUk5P3UUxTnPdWMvG/zNQ2n
	CDCxA5gHtisCBEK3HqPFXCxsoN+uXoDZKhI9ugIPcFw2wDxosjqoDYfcXlvxPhQxXI9Oc3dYEEv
	agcPab4lXhkvdnZlVEJzihiJUNBu9+33/xLSwUwvvvJXH+MLhmqa8Xi61ssWbiE4xdXjbpkqRYo
	WYNcfthm9Q3EWZokrXnB0aUAMnBTUN7BNkroHWgvJMPMnmaOAHZMeKx8cxSho9bwYbp6aK48zw6
	s7b8t5hJO+rTs1FHe1AXURdTmpFkfkxa9Z0X+0AZ+spXdkkgh2i+F+DIxATbl6D94O6LhR1KdZA
	r9XD0vSDaB11RwXplIxpSItknfxw==
X-Received: by 2002:a05:6122:e448:b0:5ea:e324:7c0c with SMTP id
 71dfb90a1353d-5ee1c4674a0mr975921e0c.22.1794415443995; Wed, 11 Nov 2026
 08:44:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 08:44:02 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261110002251.2007617-4-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com> <20261110002251.2007617-4-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 08:44:02 -0800
X-Gm-Features: AclHuK8mT-nRNYPUaS1mqdF7ctCdMJszZ9hvT59pFKeSBqKJI5rcQ4RG9KtP8S0
Message-ID: <CAOLa=ZSonhP78j2sJdTwctp2h101jWZbvU_jcg1_TR41cRK7dA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tmp-objdir: preserve errno when directory creation fails
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001e97fc066002e773"

--0000000000001e97fc066002e773
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> When `tmp_objdir_create()` fails to create the temporary object
> directory, it cleans up after itself before returning NULL. Depending on
> where the failure occurred, this cleanup may clobber `errno`, leaving
> callers without a way to reliably tell why creating the directory
> failed.
>
> In a subsequent commit, ODB transactions create their temporary object
> directory eagerly and report a more specific error regarding creation
> failure. Preserve `errno` across the cleanup so that callers can inspect
> it accordingly.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  tmp-objdir.c | 8 ++++++++
>  tmp-objdir.h | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 5307717354..4b91d86787 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -148,10 +148,13 @@ static int setup_tmp_objdir(const char *root)
>  {
>  	char *path;
>  	int ret = 0;
> +	int saved_errno;
>
>  	path = xstrfmt("%s/pack", root);
>  	ret = mkdir(path, 0777);
> +	saved_errno = errno;
>  	free(path);
> +	errno = saved_errno;
>

This and the below pattern of save+restore seems a bit finicky to me.
Could we instead do:

1. Move this function inline

modified   tmp-objdir.c
@@ -144,18 +144,6 @@ static void env_replace(struct strvec *env, const
char *key, const char *val)
 	strvec_pushf(env, "%s=%s", key, val);
 }

-static int setup_tmp_objdir(const char *root)
-{
-	char *path;
-	int ret = 0;
-
-	path = xstrfmt("%s/pack", root);
-	ret = mkdir(path, 0777);
-	free(path);
-
-	return ret;
-}
-
 struct tmp_objdir *tmp_objdir_create(struct repository *r,
 				     const char *prefix,
 				     int will_destroy)
@@ -163,6 +151,8 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	struct odb_source_files *files =
odb_source_files_downcast(r->objects->source);
 	static int installed_handlers;
 	struct tmp_objdir *t;
+	char *path;
+	int ret;

 	if (the_tmp_objdir)
 		BUG("only one tmp_objdir can be used at a time");
@@ -196,7 +186,11 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		installed_handlers++;
 	}

-	if (setup_tmp_objdir(t->path.buf)) {
+	path = xstrfmt("%s/pack", t->path.buf);
+	ret = mkdir(path, 0777);
+	free(path);
+
+	if (ret) {
 		tmp_objdir_destroy(t);
 		return NULL;
 	}

--8<---

2. Then we can only set the errno we actually care about and jump to
exit

modified   tmp-objdir.c
@@ -151,6 +151,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	struct odb_source_files *files =
odb_source_files_downcast(r->objects->source);
 	static int installed_handlers;
 	struct tmp_objdir *t;
+	int saved_errno;
 	char *path;
 	int ret;

@@ -175,9 +176,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		chdir_notify_register(tmp_objdir_reparent, t);

 	if (!mkdtemp(t->path.buf)) {
+		saved_errno = errno;
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
-		return NULL;
+		goto fail;
 	}

 	the_tmp_objdir = t;
@@ -191,8 +193,9 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	free(path);

 	if (ret) {
+		saved_errno = errno;
 		tmp_objdir_destroy(t);
-		return NULL;
+		goto fail;
 	}

 	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
@@ -215,6 +218,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	t->repo->disable_ref_updates = true;

 	return t;
+
+fail:
+	errno = saved_errno;
+	return NULL;
 }

--8<---

This avoids having to care about other syscalls which may be added in
the future and breaking our setup as done in the patch here.

[snip]

--0000000000001e97fc066002e773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 965805e1d779a7cc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMG0xRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmpQREFDR1VVR0YyV01pUGVORHFJdGUyeTdReUlkNgpIZjRKNVRKeWpC
MnFhaU5wTkdUbWxZUkZrOFJobmtXQnVScE1RckE4Q2R0L3RncXVibjV3Nys1OVdJRGJPdkE1CnBp
R0w1MTU4Y3h2d0dDSngyZFhrVmhLN081dTVQK0V3cjYvTmhlTXdKbjdHVFQzK3VYV0U1MGpkeGhy
MjJsaTUKeldBc1hhZkxGTk1QVVZUTERMV1JDZk81L1hnUFlYUFN0THJpWjl1N3YydnNnZWtsL0Uy
S2JPbWpqaFNiSHpoSQpEaEQzZlN6b09acEFVSHhvdWpObDFJSGgxdXJhYitVT2l4U1I5VndsTlhY
bHJZM0xUVkI2VnBXNVdCOEdUbWZhCnFReGlSaldVYWJxMjBjODlHSmVkVXBnVmQxeVpXamZjMWdR
QjgvTGdvRW1IWUVpTFQ3eTU4RVlHVVNwVEhnRWoKRUtzZUp4OUhyMGpvWTBsZzlKWWdXemYzUHVQ
QWNCb2dUVTF0NVY1N2VacmtvQlducUR2YjFNK1o3NjJKYXdPaApIR05uUXhNMWhNTEM4OWZjVnVm
NWZOZ3F0eTY1c2d3SVh3RUIreTJUeW1kSXMrUzZBajhXbklNbldUTW1zM0dXCmJmVGwwdXFkOTNw
VHVaVFZTQkZiT2tBMHArQy9hbUo1bTU1R1JmOD0KPUQwbksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001e97fc066002e773--
