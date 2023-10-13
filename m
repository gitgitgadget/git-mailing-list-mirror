Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E97101F8
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rqOV82vY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aGFb2PDi"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CF5D9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 01:38:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1B7205C035B;
	Fri, 13 Oct 2023 04:38:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 13 Oct 2023 04:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697186334; x=1697272734; bh=mf
	XXr67VgbbOxD8VvuZetLIGlEtMIICxpmccBSe0RIk=; b=rqOV82vYuC6+yaOKpQ
	1OOHS7HmwV6jI2NOWiMGDzIzh+PWzvXDj5y64fwcByQDg6lxvH1bDZ5m/DYlA0VY
	WlMr/JPHFpjQSboSBnRkg0W6iM8JPqz81wefWR2W11dB9Ad5KuYDxZzJlBQAEqlc
	+UfVj39qSFh6LKqx94+dpJmKSl3Uyy6ppY2x1UPM4LTR3SOBI9+55q9WSkr+RLUw
	x47e9E5PW8U9gw806X9bV/3lqNGmeVH6IVfmg81hi3V8WZU6ZUsb2FOSJqa1XHy2
	t/V1p5qlaBVmQ1PgSkr9C3EoQz28pHN4/t5SjhAAORc8+TENtvmV/ihBRf3Jw7b7
	FqYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1697186334; x=1697272734; bh=mfXXr67VgbbOx
	D8VvuZetLIGlEtMIICxpmccBSe0RIk=; b=aGFb2PDibIwEnhkQZ4tz6hK+qBUB6
	Je7ptBXFSdH+y1XgvaQ36gNER/3+oydWdkCg3cxq1mjd/6wZciZZct+6IgGE+5g+
	geLa4bXlZ4IvOmqA62WEV8SVzr/88haTziZTuywmFGCMr9Rzv589iRuIj/ZzZa2u
	5s0myouNanrXHK2jGsOy/hP+ZNqueGagk1sG1tEe0LBrDuml7+77wP9kyDM6QIz0
	FNQFm9g0qdgyBLZyzsJHyONjBsq/xSGt/gtXZ8VdQBRsmlq+TVRBBiQDfgcp4PGs
	Sodwz2Od8WAuZFRYC2rL0O6kYjPRXmAmOg+FVjRKeUWc1QCSauoJ8EuJA==
X-ME-Sender: <xms:HQIpZYq_XSNsHTFOaMvzypdRjUXZBAUtFEza10W51hlk-1JhcvsBkw>
    <xme:HQIpZeqlLtB3jO_kGEHG1ai8fdO44h_LnrWfKFTsth8a8S1xgmQ0MH5FSDbwrB99Z
    kk3UGOXCd7sjjU2Zg>
X-ME-Received: <xmr:HQIpZdM4BWSTTTUzKOiDlYSdgQv5cAzLS7KENwqhZPDCWd3nPtemi6MYIZKQcoVFCzYhOkEdqaIY6DOQLizAIE3x58X2ITFbXR6X0zoT3_gZjek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HQIpZf4vruj15f5tCo6wMEy_KjZd8xgBOLk_CSKrF4TNNQmGIJXz9g>
    <xmx:HQIpZX5ntE_odsfw0Z66OXBtSqMDc6tYKxYVWJcv4xkALD4hEmM-DA>
    <xmx:HQIpZfjg2TFAtRvzN0dFYUuY7h4caOObvjmukuPy4Cuw4SCshqK_WQ>
    <xmx:HgIpZRT9T_s5sRxy3RVAwk8HSgzN99oIoyeJR4-r9UZGUKEt0amkkA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Oct 2023 04:38:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad1984ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Oct 2023 08:38:50 +0000 (UTC)
Date: Fri, 13 Oct 2023 10:38:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
Message-ID: <ZSkCGS3JPEQ71dOF@tanuki>
References: <20231009105528.17777-1-karthik.188@gmail.com>
 <ZSTs3BUVtaI9QIoA@tanuki>
 <xmqqil7etndo.fsf@gitster.g>
 <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
 <xmqqbkd5nlq0.fsf@gitster.g>
 <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
 <ZSfSt4tXx8sE68Bn@tanuki>
 <xmqqy1g7hl2y.fsf@gitster.g>
 <ZSjbYCXfSUtEIkAt@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VkWqUycrE03RvqbU"
Content-Disposition: inline
In-Reply-To: <ZSjbYCXfSUtEIkAt@tanuki>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--VkWqUycrE03RvqbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 07:53:36AM +0200, Patrick Steinhardt wrote:
> On Thu, Oct 12, 2023 at 09:17:09AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > My assumption also has been that there is no point in running
> > "rev-list --missing" if we know there is no repository corruption,
> > and those who run "rev-list --missing" wants to know if the objects
> > are really available, i.e. even if commit-graph that is out of sync
> > with reality says it exists, if it is not in the object store, they
> > would want to know that.
> >=20
> > If you can show me that it is not the case, then I may be pursuaded
> > why producing a result that is out of sync with reality _quickly_,
> > instead of taking time to produce a result that matches reality, is
> > a worthy "optimization" to keep.
>=20
> Note that I'm not saying that it's fine to return wrong results -- this
> is of course a bug that needs to be addressed somehow. After all, things
> working correctly should always trump things working fast. But until now
> it felt more like we were going into the direction of disabling commit
> graphs without checking whether there is an alternative solution that
> allows us to get the best of both worlds, correctness and performance.
>=20
> So what I'm looking for in this thread is a reason why we _can't_ have
> that, or at least can't have it without unreasonable amounts of work. We
> have helpers like `lookup_commit_in_graph()` that are designed to detect
> stale commit graphs by double-checking whether a commit that has been
> looked up via the commit graph actually exists in the repository. So I'm
> wondering whether this could help us address the issue.
>=20
> If there is a good reason why all of that is not possible then I'm happy
> to carve in.

I've had a quick look at this problem so that I can solidify my own
train of thought a bit. The issue is `repo_parse_commit_internal()`,
which calls `parse_commit_in_graph()` without verifying that the object
actually exists in the object database. It's the only callsite of that
function outside of "commit-graph.c", as all other external callers
would call `lookup_commit_in_graph()` which _does_ perform the object
existence check.

So I think that the proper way to address the regression would be a
patch similar to the following:

diff --git a/commit.c b/commit.c
index b3223478bc..109e9217e3 100644
--- a/commit.c
+++ b/commit.c
@@ -572,8 +572,13 @@ int repo_parse_commit_internal(struct repository *r,
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(r, item))
+	if (use_commit_graph && parse_commit_in_graph(r, item)) {
+		if (!has_object(r, &item->object.oid, 0))
+			return quiet_on_missing ? -1 :
+				error(_("commit %s exists in commit-graph but not in the object databa=
se"),
+				      oid_to_hex(&item->object.oid));
 		return 0;
+	}
=20
 	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
 		return quiet_on_missing ? -1 :

I wouldn't be surprised if there are other edge cases where this can
lead to buggy behaviour.

Also, this issue may not necessarily stem from repository corruption. It
could for example happen that commits are getting garbage collected
without the commit graph having been updated, whatever the reason may be
for this. In that case we would happily continue to return these commits
=66rom the commit graph even though the underlying object has since been
deleted. The repository itself is not corrupt though, we merely look at
an out-of-date commit graph. And for what it's worth, I think that we
should always gracefully handle that case or otherwise the commit graph
becomes less useful overall.

I didn't dig much deeper yet. And while the above patch fixes some of
the test failures, it doesn't fix them all. If we agree that this is the
way to go then I'd be happy to turn this into a proper patch.

Patrick

--VkWqUycrE03RvqbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUpAhgACgkQVbJhu7ck
PpTxOQ//bnOrsvci3HpOqBlQn/BbZdcxMU4yX+fHrccB8FdDh6ZIJnvXIjSNL3ZN
x50mllv0gkIeiS29uw60mm236R5OIlg8Uh/lv1qeASn2QfsUvEwnK83YA8istLEc
QIKquHBdJSC9FqJFf0B26hGIKwLbDbn5Z8Tt3cboIulMu2Y7hnrL7FYTL/P3n7n1
fZ2ES0/bbPXemLflnIKe3yZII21NFz8mpAFN85CmqQzMPCcak8vWJk1Q1/7q76/g
rEXXIBlSfCbtWREoUi15/Wv8j1epIl95sT6bIEorCrpbmn0jPS3IssLnSYrGYiwx
6wsChvEQvsaljh+zTyZ0kuswg2kxJihoRjq4cbbpfMd5TfhC6B0DjAlG+Q2LvNjb
XfijbkJ2IEYSQrO4g3zsaxqnNFcS3usODsTlK88oGyu9Y5bwuM2irQjgDeTkZVXQ
KRt1RFt4p21xx7LoqVYMmQPO4B4MPaHXbC4wFtU339jUvQr0o4yu2Sb3PgQre9wP
W/2cubbFP+0INp6aErT1mVqSxG3pphlO04en5wzznszyg4cl+pt4nMCDqy7QFjlU
mpBIYzWrszpk1jhK3CXmETCQ5lgcL8bgc4xosQTPohxYvMf2AOwX8Fr6pOf2s6fL
0oklNH343J8uMKKbK4uu9yyyXUoK7GEfCxMs6MLRSrox0fqlacI=
=7g/H
-----END PGP SIGNATURE-----

--VkWqUycrE03RvqbU--
