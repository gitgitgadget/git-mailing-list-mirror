Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923123B83FE
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990060; cv=none; b=LOjxUQ/kRVHrQVWDqmcdl0MogyPd5KsKoGVUM22IBpFdpP9mmctFD8peK4AZE7Apof2YIJ4mZqi486bgp+DBtF+in7BGfgLhDMSg3zTQ8vLdam6iQBeKhLNqMdnH0SI5+DcOSJ4qdL5a98JLFyP9xS0ESBZF7Lyp4LWsuiNtTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990060; c=relaxed/simple;
	bh=HbMx/P++BI/38HhIsYSCgoNZEiOO87RNAXJCtX3v3/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTJ+oauEPTfwidK1ZbpWd1GliD0wr+ABFfW6TYBYMRHn6ume0KdCYa1528eueJZ5gJKlxZZLtdJDwSJZzL45mm2ZOeTOweFmTDixmj6kPP3V/7VbWLwYdKtaoFKO9FzHL+8d4UF/E0TVMV99Vy9qLtnlexxGyWQxY8HOzXrj82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kT/l7zVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1Y9exh+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kT/l7zVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1Y9exh+"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id C15B61D0005B;
	Tue,  9 Jun 2026 03:27:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 09 Jun 2026 03:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780990058; x=1781076458; bh=GJSQyHN00c
	siPkG4Zki1ezIpnYYClAiAn+3Ck1Z7SxU=; b=kT/l7zVWZ9tzJ+/Jj8trmo+koy
	wGVTdpOh2xmqAeqZkcdbr3GGXr1gn0DFKnJZ6csp/1E2wAPH9agbVSv09HXmXMZg
	0FWsvkm9LJx/1bY0WR44hzTnIbdvqEEawiL1nmskcDK4FfH3pIrs2n1gUPlZ+inC
	E7Q3t+TlwBXmZgBRhP7p1m5Y8R0BuEY+k7k9PEroM42/fbPI7s4kyN1KbHioXEg6
	nlxbIwO92ILEl/CJ/3psclAylrOpvBsImnJl+1ceF/IO6zupryoKNgYNN8iLugeh
	+MG9Pt0qIUcpiGqP6m5WsPUfxSs3EKuAu4HYhLzgcGPBErF9QsAguvKsz5ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780990058; x=1781076458; bh=GJSQyHN00csiPkG4Zki1ezIpnYYClAiAn+3
	Ck1Z7SxU=; b=M1Y9exh+7ACuXkBtJf62E2MGmx/KMrsIOSDf1ZX0C1rGQm3SdyF
	AvfYXzSQHSu49InnOI/NaVJoaN91UCgoFomklVs7woGxrKlXNs5laIP5CC6DKhqW
	JStWUkiDZIShie/8t+qVZZ3nQ0/VmvU34+avYGmp9Q2x9SAilusuw955tXTk0Zy8
	uR2R2jDHG9zLnxkNn+qQdLyRs1mLPTuGkOtX0joXlq1Od2I5pzd14/2CT0s+K/HD
	q+dltIhaaw99PPJK4Xu0QdXfjUvNuxpgbN0ckKUZrwYfnIMSmAShC8OX+cXp1hTE
	tM5f1xdTKgRO1FiVEHovBPVnyNH/N5jhvuA==
X-ME-Sender: <xms:asAnarzUGCYPbAGfYGa3UkgXjxBMFUdvk9hRCQfwQelMPE5Spk5p6A>
    <xme:asAnapQbl4X-rONQt6QiNZ0w78GrbS9Y_Ci2ikwo4nfZAlVgSRAK1E4WqaAka53Y4
    PR06cny8yhwhlJjdMOyBtyoKxv3c-149kf90mwsmMa4QsOgj07bsfY>
X-ME-Received: <xmr:asAnai-s1pzX7iuxgPCnlnQ2BMuEW44b7KL_AmbRLmgus32BeU3QFrWzzQgR0JSfPhbvsaaCX_tW5-6mNsV6TTxR7tu7uOjLHOCDfaFlZNc>
X-ME-Proxy-Cause: dmFkZTE+WiGn93e6aTjpyM1udZTIsILEIP+SMuzxLvAFU5zzzpYSehhDJVkVTdq/uU+Iwg
    avpPTWXyukFYrwMIGwhMWsiePNkRF7jj2GHrDkLERwpQT7lIfyYgfBAi8WaTZv0bNcUALb
    YB4/odYLUPOjvJHTn8qTZlJroTnzCUJzjPoYgO0w6e8gHtJ2RGvVg95G8ZiFsM9YcXyXkB
    mDNnAPmbvXfakYAAOA3rIxcQ991eEt6JQlzG0EK5SKNrIUMkfFgThoHb/MY/iaf8aeZvbH
    bn0vxksPxmNVeyb43q8Sfdq/nO2Sq5OWrHYw9pUt3q+V0+gHL1XGxiYoTTJBl5EC7LiPYV
    ggBlF9x1dTsNUGxjBSDe4w+27lJx0iac5IlhQ9DR2SaQxCxG7YBiMI+96TmIm/65Tu++Ut
    sBh++ovm+C+BSRnWJgAlabL3GQwVGtLTOvQL+At51GPmQhgllWwTzQWBIbTOw0JB0v0LQl
    Ef17ogPIBcMNJAUCtDC6JiKv9p8RE1a+YdcuI+hB8iKpZv+3pO/mFKzggot9IlncI86uHe
    HnXel+z9ult3EGunuBY9ltoNzXkIZU8j0q7zGQ25DmUiHdi4dVYMQZxL/OzJnKbN740LUt
    F5HiYmOa9oITs5GKhlTv29hY/0iYUO87StgrkEDcN6mi65cmYgEHCjY+RFCw
X-ME-Proxy: <xmx:asAnagrTR0swJ0TgAXxp2qrM46QiSfPHxzZKFOd-6H0pubBBch5P0w>
    <xmx:asAnavlULri60hNlUY1jDczpux-jmmm0yjhWoATNKgPPF7D7M8dfeQ>
    <xmx:asAnanLPNe3_D-b1p9AYlbU2bmTbf8z1XQc30JKE8jrynFckQ36sLg>
    <xmx:asAnakxy9kxTGwrRyc6Pe_n9b5unWLRPaYveKSVUujPKRj1hNhrH0A>
    <xmx:asAnani7vR-YUmHZGnj9EC3MJ-T2H8G4DAb2LwMlWYQxT-0gXLipw3uA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 03:27:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 255b52d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 07:27:31 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:27:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/16] odb/source-packed: wire up `count_objects()`
 callback
Message-ID: <aifAYcq4lQEO_yWq@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <20260604-pks-odb-source-packed-v1-11-2e7ab31b4b5c@pks.im>
 <CAOLa=ZQdGMo83KggkmeeKYMR475TFqLn=o-nJz4QEUX2njgaOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQdGMo83KggkmeeKYMR475TFqLn=o-nJz4QEUX2njgaOA@mail.gmail.com>

On Mon, Jun 08, 2026 at 09:12:06AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > index a61c809c8c..013d8a50f8 100644
> > --- a/odb/source-packed.c
> > +++ b/odb/source-packed.c
> > @@ -338,6 +338,39 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
> >  	return ret;
> >  }
> >
> > +static int odb_source_packed_count_objects(struct odb_source *source,
> > +					   enum odb_count_objects_flags flags UNUSED,
> > +					   unsigned long *out)
> > +{
> > +	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> > +	struct packfile_list_entry *e;
> > +	struct multi_pack_index *m;
> > +	unsigned long count = 0;
> > +	int ret;
> > +
> > +	m = get_multi_pack_index(&packed->files->base);
> > +	if (m)
> > +		count += m->num_objects + m->num_objects_in_base;
> > +
> > +	for (e = packfile_store_get_packs(packed); e; e = e->next) {
> > +		if (e->pack->multi_pack_index)
> > +			continue;
> > +		if (open_pack_index(e->pack)) {
> > +			ret = -1;
> > +			goto out;
> > +		}
> > +
> > +		count += e->pack->num_objects;
> > +	}
> > +
> > +	*out = count;
> > +	ret = 0;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +
> 
> Nit: extra newline.

Good catch, fixed locally.

Patrick
