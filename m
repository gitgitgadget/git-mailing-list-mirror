Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FF30F958
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473099; cv=none; b=JoQNROtgQsHhkR1OUCSuHWNoUMTTdJW2bMApw4F0vh531y5PqFXOxB2165cu3nOECiu20L2SP+unV93wB/hyT/L3kgWW1a+rM5lq41xZ4pOKk8RTO0AGDYyV6hfZAYPCfjG7VADt6jj/nQYXyDj3Z8QJeHuDCvnuMw7sA4fB+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473099; c=relaxed/simple;
	bh=Pc6Hi9tOQHkNjNppoOQ/dUVezUu68nL+K9qkeM+jQbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukJl5+epwkQWO9Hi/n829yVVJcUCeswPypbKx17BSNE8VKhd14r9IiXcPE5yowQa9tVTRnKja1eyU+JO8V5r/JaLGB6Vvrpx2PBEDXwGGOdhJNSdBlBw2dFnQdJtP7rUzqK1vY60/DVWT7C/+n/ogiWFnGzvhjKmGuwXsh0R8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzHr0myl; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzHr0myl"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d1872504cbso2331154a34.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772473097; x=1773077897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORqLPxC3O3/n3i7TjHxgGZWDXHKItX3oN2f9nYQVc2E=;
        b=ZzHr0mylqKm4JT5kphhEIlfNJoH+dG0rG3sGTE4BuH1K0vUzxq5M6YMUcx0owbqyTq
         ys21h4GhZqCIqYwvaqYDQUUB8f9e9adnU9CQrxhsRGmZS+jihNRURSK3aggC1mFwvvry
         xExo2Kq61Coh6t+SjjLua0DKFhB2kgYn1JGrlWe/9CGONNHIm16llbaV6McfkTEy+/Bv
         e//vlbQ8B6WpzfFSKZ4RHJbBnu1EmkXSl45B61sEUacVqP972br77YlcVJH4zlOW1fRN
         wLWG4YAn+hFK9pKXnz0ETDOE2L8i9pymqQoF4WWJm/Q1nW4DRqE2JVQK21yFi0AQY2eY
         WTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473097; x=1773077897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORqLPxC3O3/n3i7TjHxgGZWDXHKItX3oN2f9nYQVc2E=;
        b=WaMTFwNOBD2WtsCltrqhnoOIJbgTgC+i1XWb6ZXXGxlVFPFXbM0fwfANXH3yFIpIXN
         4yZWMdeaOO7PjvtIgUYVic/TnOtIiWXZ43+iaz6FwuIhsm+c+J2H4edtOinUVz6F/KCl
         XtxFj5CKN5fkQE42fd8wCUgptlQExkAdPT0ZV1pShdNMD68aOQD0sF4ULU80x3ic5hrA
         UWyo6pwdxfbLaSaEnbyRbWl9CDra3Wvnvoti6C4nKGEjjFDfRjTK2K+L6bPL6vwsD/ik
         a2GVrmh7E57JfUEnmiZ+PCwrlSIgCvuIldQsh4eUzwVTHXSerPttsEq+o2eWtB5sIooB
         BKDg==
X-Gm-Message-State: AOJu0Yw0V83Es5MitQ5vJ3f1ok86Ajg4Bm7o4RczIF1rq4/ECaEYrAde
	MSmsieMfjP+dwKNPF+ijc8qRaNVfYlLX19MtAlR7u8MyfXHsF9xZQcuO
X-Gm-Gg: ATEYQzz3FDZrLKQ1Em4dKNceemLgvwvIVzWSlQg5q9krbF+3usmcXE1WV0xE/GTIE0J
	fUh3DBN5xb9+Qb6EgiKuvpuMCYsXzyh4YtnJAUd4IvMzHlZIbCFA16Ir4ETNYfQ3yNro6RNxEFk
	KCWZL587/7mFr/vdi0uQ0i4rp1jRtBHDh5XoX9NXvchfu421iPFQ4C9x/n3CB5Py/UZWtsTT/v3
	rTcTC76g2ZR/UP4U2P8/Ej44PqBQShQGTQKfKiXFMiQ3tW9kZmzrN7nZHazhbo70njcNRhV23Bu
	4PfmNOPqJIFW0kqPeOK0Zv9qCtYPrNXmxjZjNlymqF4eOtJTItgSltOsKs7N0K1iZA5R2KoTnGT
	2VgPbGV5bblv0yp4KVFcLvzl+cie3nrb2imJfYODNrk+iDlxFpLCi5dlzrtEzQ5h9TatBL/M+NP
	XIFz2X4kq3mCT16DN3
X-Received: by 2002:a05:6830:6a16:b0:7d4:c276:7484 with SMTP id 46e09a7af769-7d591e6e72amr8582793a34.7.1772473097206;
        Mon, 02 Mar 2026 09:38:17 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644dd17sm11074477a34.5.2026.03.02.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:38:16 -0800 (PST)
Date: Mon, 2 Mar 2026 11:38:16 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	kristofferhaugsbakk@fastmail.com, eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 2/5] builtin/repo: collect largest inflated objects
Message-ID: <aaXI0M7Ztk-Swm18@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
 <20260223174120.2356504-3-jltobler@gmail.com>
 <C99EBCF9-7980-495A-94C5-576AC6D140F3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C99EBCF9-7980-495A-94C5-576AC6D140F3@gmail.com>

On 26/02/28 08:36PM, Lucas Seiki Oshiro wrote:
> 
> > struct repo_structure {
> > @@ -371,6 +385,21 @@ static void stats_table_setup_structure(struct stats_table *table,
> >      "    * %s", _("Blobs"));
> > stats_table_size_addf(table, objects->disk_sizes.tags,
> >      "    * %s", _("Tags"));
> > +
> > + stats_table_addf(table, "");
> > + stats_table_addf(table, "* %s", _("Largest objects"));
> > + stats_table_addf(table, "  * %s", _("Commits"));
> > + stats_table_size_addf(table, objects->largest.commit_size.value,
> > +      "    * %s", _("Maximum size"));
> 
> I don't know if it's the best place to comment this, but it would be
> nice if we could find the commit that introduced the largest change,
> in terms of size or number of lines.
> 
> This would be useful for people who are asking "what's the largest
> commmit?" thinking about the introduced changes (like what we see in
> GitLab's interface) instead of the size of the commit object, which
> generally is proportional to the message size + the number of
> parents.

I assume by largest change we are referring to finding the commit that
has the most lines changed between it and its parent. This could be
interesting, but I suspect it could be quite costly to compute for large
repositories with many commits. This type of information is not actually
stored in the repository and would have to be computed on the fly. Since
this information is not really part of the repository structure, it
might not be a great fit for this command either. I'm not quite sure
about this one.

Thanks,
-Justin
