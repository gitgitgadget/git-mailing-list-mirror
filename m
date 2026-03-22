Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA337BE8F
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205440; cv=none; b=AvIrox/b+URKhD2iURyjNr5sqOu+W7zj32nw8CyY9Fp8GJcMsKtsb8CDgcD2hefq1KsTjbpkAlqhDwKQVqJmOe9CXJElnijZBKQzSyQs2IZTBmChHdBYtuUKrUXls9+Y8WXYgJdaxtEolYDiZlTjhEzl6c/VNcc7n9LAetiXBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205440; c=relaxed/simple;
	bh=WvABEJH6gDG42+57ZJB5HWEzE2bQIsrN34sT6jssnDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j55LrWBkZus2n1gqwJAiBPANOjBXxpMmgz3d0fRDvF56U1tpD8TxrGiUrdOuwiYjjxFeQOz1023rL7h44Gbz8Y1T+60PcNM/nD9xfVw9ZAvMmjr7xQRQa/FCnuZ3U7VqvDUii3HuL3JD9hUNjwwv88qrXxoc8MUHKvC77K6/zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4/bZyqF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4/bZyqF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439d8df7620so2248705f8f.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774205437; x=1774810237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsiIvebCJj84zaQNpqdmCwXZWx4CF2EdYGFc0drNXAE=;
        b=L4/bZyqFAo/dUXO6zDTnC0V481hjIufURKREM3BHK0xHhDNrdv1kkp7gLEEEhlDsA9
         VSexUzz0sUE7MNAvw1LQ+xLWZ7nf5q9nvjfXiSg+kRboBrCVURfrkjOjZWW1cNf0jGyF
         M1NRBIdm2GlNBDuMtaOxJtJsq/eujFWFrnplkuggWotqRoMkyJleEzjplGjb+0GjLquy
         KhCI9QMux+xc1647uYVR1dTEfIqbT0I6y1a/Y02ASKYDGw6i2BwRHra5wRZztx7TAg4r
         z/bLH+tgC9adN8cy38de57oIAB31VjHHFY3dP47HAEVEUXGuf3xCjD82WB7l2myGOMEd
         azsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774205437; x=1774810237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsiIvebCJj84zaQNpqdmCwXZWx4CF2EdYGFc0drNXAE=;
        b=Z9pi+Uor7jCfcXIzpBU1SEc/GT4HhQDEgx6fwX7koP1u6itz8MD2l1h8CVvS2sZI5+
         FhNCCOsSNvhb43k/6u0wXzqnHGPxVwbnyLp320NzhS9jM+ImGMVH8eg3XZPYJryvU2zg
         S8BU+s3vW18Gmubb3e3IknDy0erz5ovkJK1PjVBdMGVT6ye0fpEPG+ySd6hyLQNU7Nhn
         ROx55wBK7VzVi1iJuYmdcIPjS+jmaOeKtl/MrxL4sbhIvbNt/ZD0LAujewpsyJFxhEvG
         K2/avDxippTRIeQEZi1blP6kYPW6paUZy2S9wLh+fN9yBzc5Ey3H3pc0fQ2zN0Q6IXxB
         +KaQ==
X-Gm-Message-State: AOJu0YxfHLFTdnWQlTPXR5kQJMhQPGTy3Xey7ZKj+0aPHNZxB79KqnGU
	sXSDJnXN48hNVUkUVieC+W/UJy/DYwIvJK0yw2M4BI49I9iqMlB0FQno
X-Gm-Gg: ATEYQzxy97sNd6E3my+iCfZbQ/PO8nfwfbzblaOwECi1u57y6C+hIzDWUzjFBc89CSv
	D+V7DFFhyBPw9qKW6FGFiFgqxrGVz/hWlXBP7zJ6D0eXuC4NAmEOnUkwv3zX/R2XYG43/IPnF1e
	Y2VjZTxhXIZ+SXXEXRJLcNTGjbNnlNJk9tcduogIMehCT0crZVbXjHy745FykRuEFPhVFYe6lQA
	bNiULip2Bx5qvWT7Kx8uRHSMIld2MxhEY01of1tVM4BTTDX2/dTU1D6zD8zDrElg9SPFEmOX3nl
	zLfjKJReGC19pNMKcWhGECGJXjoFtW2eSLKOQN9CFN8iXpvqVGk23yiawJjZ5ZHo7lzBZuQmXFG
	HkILoqOyKIXiKLEU0zQZM+fMfUw7BaKfehGdbunfEMtmgBxqfuU7silHmCQBcUPGvXN95FsUYP8
	z8sG2p3NGmiUemWfs8U8kgAY9Nx4gelNrX
X-Received: by 2002:a05:6000:3113:b0:43b:5003:e300 with SMTP id ffacd0b85a97d-43b642814fbmr14645056f8f.43.1774205436773;
        Sun, 22 Mar 2026 11:50:36 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm24684428f8f.17.2026.03.22.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 11:50:36 -0700 (PDT)
Date: Sun, 22 Mar 2026 19:50:34 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH 2/3] pack-write: add helper to fill promisor file
 after repack
Message-ID: <acA5-pIc9zVbqY1e@lorenzo-VM>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <3c0702f81b3e4a57cd38284ab90f8277da3fcd40.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <CAPig+cQSsMfvHJnwuXGQ1Je8ekz=Rqbaibn-3shbya5y-5xTKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQSsMfvHJnwuXGQ1Je8ekz=Rqbaibn-3shbya5y-5xTKg@mail.gmail.com>

On Sat, Mar 21, 2026 at 10:04:01PM -0400, Eric Sunshine wrote:
> On Sat, Mar 21, 2026 at 5:29 PM LorenzoPegorari
> <lorenzo.pegorari2002@gmail.com> wrote:
> > Create a `copy_all_promisor_files()` helper function used to copy the
> > contents of all ".promisor" files in a `repository` inside another
> > ".promisor" file.
> >
> > This function can be used to preserve the contents of all ".promisor"
> > files inside a new ".promisor" file, for example when a repack happens.
> >
> > This function is written in such a way so that it will read all the
> > ".promisor" files inside the given `repository` line by line, and copy
> > only the lines that are not already present in the destination file. This
> > is done to avoid copying the same lines multiple times that may come from
> > multiple (redundant) packfiles. A better way to achieve this might be (is
> > definitely) possible.
> >
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> > diff --git a/pack-write.c b/pack-write.c
> > @@ -621,3 +621,65 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
> > +void copy_all_promisor_files(struct repository *repo, const char *promisor_name)
> > +{
> > +       struct strbuf promisor_source_name = STRBUF_INIT;
> > +       struct strbuf read_source = STRBUF_INIT, read_dest = STRBUF_INIT;
> > +       struct strbuf write_dest = STRBUF_INIT;
> 
> These strbufs don't seem to be released, thus are leaked.

Of course... trivial mistake. Will fix it in v2.

> > +       int err;
> > +
> > +       FILE *dest = xfopen(promisor_name, "r+");
> > +
> > +       struct packed_git *p;
> 
> Style nit: Place all the variable declarations together (without blank
> lines), followed by a blank line.

Ack.

> > +       repo_for_each_pack(repo, p) {
> > +               if (!p->pack_promisor)
> > +                       continue;
> > +
> > +               strbuf_reset(&promisor_source_name);
> > +               strbuf_addstr(&promisor_source_name, p->pack_name);
> > +               strbuf_strip_suffix(&promisor_source_name, ".pack");
> > +               strbuf_addstr(&promisor_source_name, ".promisor");
> > +               FILE *source = xfopen(promisor_source_name.buf, "r");
> 
> This project still frowns upon variable declaration after code. You
> will want to declare `FILE *source;` at the top of this loop body and
> then assign `source = xfopen(...)` here.

Ack.

> > +               /*
> > +                * For each line of the promisor source file, check if it already
> > +                * is in the promisor dest file. If not, add it to write_dest, so
> > +                * that it will be written in the dest file.
> > +                */
> > +               while (strbuf_getline(&read_source, source) != EOF) {
> > +                       if (fseek(dest, 0L, SEEK_SET))
> > +                               die_errno(_("fseek failed"));
> > +                       int is_source_in_dest = 0;
> 
> Ditto regarding variable declaration following code.

Ack.

> > +                       while (strbuf_getline(&read_dest, dest) != EOF) {
> > +                               if (!strbuf_cmp(&read_source, &read_dest)) {
> > +                                       is_source_in_dest = 1;
> > +                                       break;
> > +                               }
> > +                       }
> > +                       if (!is_source_in_dest) {
> > +                               strbuf_addbuf(&write_dest, &read_source);
> > +                               strbuf_addstr(&write_dest, "\n");
> > +                       }
> 
> The commit message talks about this, and it is indeed very ugly that
> this re-reads `dest` from the beginning for *every* `source` line. Is
> there a reason you can't simply read `dest` into a `strset` (see Git's
> `strmap.h`) in its entirety before entering the repo_for_each_pack()
> loop and then merely check the strset for existence using
> strset_add()?

No reason at all, except for me to knowing about `strset`! Thanks for
suggesting it to me. Will use it in v2.

> > +               }
> > +
> > +               if (write_dest.len) {
> > +                       strbuf_strip_suffix(&write_dest, "\n");
> > +                       if (fseek(dest, 0L, SEEK_END))
> > +                               die_errno(_("fseek failed"));
> > +                       fprintf(dest, "%s\n", write_dest.buf);
> > +                       fflush(dest);
> > +                       strbuf_reset(&write_dest);
> > +               }
> > +
> > +               err = ferror(source);
> > +               err |= fclose(source);
> > +               if (err)
> > +                       die(_("could not read '%s' promisor file"), promisor_source_name.buf);
> > +       }
> > +
> > +       err = ferror(dest);
> > +       err |= fclose(dest);
> > +       if (err)
> > +               die(_("could not write '%s' promisor file"), promisor_name);
> > +}
