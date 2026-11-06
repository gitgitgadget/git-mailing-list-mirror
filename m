Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957705;
	b=kaF+oTY4JTe1Ij44agxkdjfTqRcVPe+RNj+Ej4FmXqCVAC4E/hBHyVvmNckHXlVLupfF
	 HELWKkWxgoFelZW6dr2RQlyE/Aolo7+MzxNGfE6qg4y8X6xkFA1tWLwW0PT8VuCnLyJl1
	 X4pbkyJZSEKuVP2sheLU/vVZwTxS3esjzvYBjeet0md8CXhgLNMCXeYJZIEdAHy5gOddv
	 2GTDJa0++53K2bjoWfeBeiZuc8zc3DzcQ8JaAK6zkGAsanvp9ioxJ/IBVnbQhgELMeAdS
	 CDLnv+zzz2PjAINqsweRThinaOZ5wjefKsdHyZ6gdGj7qgpZ+RZlKThTFshBV33ESTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957705;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Subject:
	 Cc:To:X-Mailer:References:In-Reply-To;
	bh=TyVJTI4hyr/J8/fNYOeKi36zEv3nL7fhP/izpj+sn/8=;
	b=x9nY5ON+sKfy4pdMTcLoKmlo13EbPEw0AuBRJepDcTCAbNpKgAqc6MWu5yEBw7YnMgyd
	 NHbFkPQW2nIuF98YWrL+mhzH9qN+wF7FZE37uOlLc0rJXs4L8OqtwBUW75hsDNfrsA8EF
	 ox321m0q4flydTu90QUfYyxnqITmn5wUCOB5rqaIXHntjxTHeu9spHag41IdVpo9sx3QP
	 LKh6qmkYog0IDu7LkeakZPmxGnbD4d4Ug6UcT3CW0n1i7hja855MjWowe7ohf/sPK8RJr
	 Gqf1OauwfZ0Tu7SZS59rGow4k7zqE0IxSF6Lm/7WzTn5lpCV4YzpnsSYbsnOp+fP85A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=lVZzzpZJ;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C3606A333
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5C3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=lVZzzpZJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1793957697; bh=pvFF8G9c2tZO8RrlWpGLXADvkvS1QU6kTl27c4LINU8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=lVZzzpZJGjNWyQ8F6cN0/6icU5diswNkZmDsJnVEWXS4lWyp9a8l5gxC5sRNm5Y2M
	 Ia5h/NAS3LyBxnQNkApSP2QZg5i5DoCDqucnOZPgevs/3mb6ySSffA6c02LW5eFhGo
	 X66et6Fb22XAxgYJb1mmsoWSsUNAG343slWu7ip4=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id AD2436117A;
	Fri,  6 Nov 2026 09:34:57 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 04:34:46 -0500
Message-Id: <DMO0XC1PL4MP.1J5830XZ4GCS5@lfurio.us>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
Cc: "Colin Hinton" <colinlewishinton@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <20261023185007.21642-1-colinlewishinton@gmail.com>
 <xmqqecdezfr1.fsf@gitster.g>
 <CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
 <xmqqmrrxdhox.fsf@gitster.g> <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
 <xmqq33tnz0hb.fsf@gitster.g> <DMJFKJCI5DLL.12R7AMFO4DK2Y@lfurio.us>
 <xmqqjymqobc3.fsf@gitster.g>
In-Reply-To: <xmqqjymqobc3.fsf@gitster.g>

On Thu Nov 5, 2026 at 11:03 PM EST, Junio C Hamano wrote:
>
> Hmph, interesting.  Can you rewrite Colin's patch using this, and
> then merge the result into 'seen' (after reverting Colin's topic
> ch/remote-defer-follow-remote-head-validation from 'seen' first) to
> see how badly it crashes with other topics in flight?

I still have the commit sitting around.  I tried this and a replay of
the current topic to compare -- the conflict is the same in both
cases.  eg: Nothing else in flight is touching the
get_follow_remote_head() function.


static int do_fetch(struct transport *transport,
		    struct refspec *rs,
		    const struct fetch_config *config,
		    struct list_objects_filter_options *filter_options,
		    struct oidset *updated_tips)
{
	struct ref_transaction *transaction =3D NULL;
	struct ref *ref_map =3D NULL;
	struct display_state display_state =3D { 0 };
	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
	int retcode =3D 0;
	const struct ref *remote_refs;
	struct transport_ls_refs_options transport_ls_refs_options =3D
		TRANSPORT_LS_REFS_OPTIONS_INIT;
	struct fetch_head fetch_head =3D { 0 };
	struct strbuf err =3D STRBUF_INIT;
	struct ref_update_display_info_array display_array =3D { 0 };
	struct strmap rejected_refs =3D STRMAP_INIT;
	int summary_width =3D 0;
	int follow_remote_head =3D FOLLOW_REMOTE_NEVER;
<<<<<<< HEAD
	bool apply_follow_remote_head_config =3D false;
=3D=3D=3D=3D=3D=3D=3D
	const char *no_warn_branch =3D NULL;
>>>>>>> try-merge

	if (tags =3D=3D TAGS_DEFAULT) {
		if (transport->remote->fetch_tags =3D=3D 2)
			tags =3D TAGS_SET;
		if (transport->remote->fetch_tags =3D=3D -1)
			tags =3D TAGS_UNSET;
	}

	/* if not appending, truncate FETCH_HEAD */
	if (!append && write_fetch_head) {
		retcode =3D truncate_fetch_head();
		if (retcode)
			goto cleanup;
	}

	if (rs->nr) {
		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
	} else if (transport->remote->fetch.nr) {
		refspec_ref_prefixes(&transport->remote->fetch,
				     &transport_ls_refs_options.ref_prefixes);
		apply_follow_remote_head_config =3D true;

<<<<<<< HEAD
		/*
		 * The configured refspec may not cover the current
		 * branch's upstream (e.g. a narrowed -t refspec), so
		 * make sure we can still fetch it regardless.
		 */
		collect_upstream_from_remote(the_repository, transport->remote,
					      NULL, &transport_ls_refs_options.ref_prefixes);
	} else {
		/*
		 * The --refmap command line option, if given, takes
		 * precedence over remote.<name>.fetchRefmap.
		 */
		struct refspec *effective_refmap =3D refmap.nr ? &refmap :
			&transport->remote->refmap;

		if (effective_refmap->nr) {
			branches_tracking_remote(the_repository, transport->remote,
						  &transport_ls_refs_options.ref_prefixes);
			apply_follow_remote_head_config =3D true;
		} else {
			collect_upstream_from_remote(the_repository, transport->remote,
						      NULL, &transport_ls_refs_options.ref_prefixes);
=3D=3D=3D=3D=3D=3D=3D
		if (transport->remote->fetch.nr) {
			refspec_ref_prefixes(&transport->remote->fetch,
					     &transport_ls_refs_options.ref_prefixes);
			follow_remote_head =3D
				get_follow_remote_head(transport, config,
						&no_warn_branch);
		}
		if (branch && branch_has_merge_config(branch) &&
		    !strcmp(branch->remote_name, transport->remote->name)) {
			int i;
			for (i =3D 0; i < branch->merge_nr; i++) {
				strvec_push(&transport_ls_refs_options.ref_prefixes,
					    branch->merge[i]->src);
			}
>>>>>>> try-merge
		}

		/*
		 * If there are no refs specified to fetch, then we just
		 * fetch HEAD; mention that to narrow the advertisement.
		 */
		if (!transport_ls_refs_options.ref_prefixes.nr)
			strvec_push(&transport_ls_refs_options.ref_prefixes,
				    "HEAD");
	}
