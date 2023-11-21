Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q2wgDh6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+hhi54/"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B21712
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 05:46:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 1A0285C0E37;
	Tue, 21 Nov 2023 08:46:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Nov 2023 08:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1700574417; x=1700660817; bh=L+LewG991CCfdP/nGgGFJqkBL
	/yT9XvilI42sJHU1jQ=; b=Q2wgDh6TpBG2RjLxPI1ljpo73MCX9u6/7JfzbbTc1
	ZNGwhAprzZpUBhptku/OTUIB816R0Z75yqV81nfsA/INCLycy4i4Ttkekc62/Qaj
	EJkMV1rnH8+aGonXmf26m57fqeMUHQjWj0FXfRPCTEUN+VOPLWnLI5uYq2WLUKOR
	pD81woGCl8tERP+b2MsITtkSuBNrKN209Ffcx5DSgmzGtZIjikdQlh02jZVeQOQQ
	qrj0q8IazbHA8R2wziukvmqondIm8SnYHP7fmfVX5xENkEeIV3lgoHyjfoZE8++X
	2CYzdGjA+sfjgtsuss8gT1nRZmYCeDNws0KyKvzfeaVYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700574417; x=1700660817; bh=L+LewG991CCfdP/nGgGFJqkBL/yT9XvilI4
	2sJHU1jQ=; b=b+hhi54/b2fzaITQ+zvxih/AOrA3o9srvXLnGAy81oNUX/I2t/H
	JRbnrgO2xkB0KIbl+7M2PqgHJ7VzPUFq0O8ZRV6NmDEmNBc8clG0RoVH+vzbBPDW
	pJXpDhtDZbOR1FbDvbxZdVd5vjUEoXHxzPmm9SQSqOckd72XpLxLH7s5ZQb5Ntv9
	bIotwrswhyx/aa/ujo7fKDo3STKefSzaSrPgsmaRvfHmD5VAed9fdmE5J2Asadju
	5f+tzKkTjnMTN2ioMaeDPecx53ylmNE9r25gGJzWy7SgkyuT+mhjeFVNwb2e8cZx
	vJXA7nwLcIhZUFCDkUlQE3IkiObunAYIjGA==
X-ME-Sender: <xms:0LRcZeB_JI4rW_Y23ucjBXigYr7GPlR8ot4IVHsCYqeq1NvqPn8W5A>
    <xme:0LRcZYjO47oAitvu5bcId72QxfCRHn6CLCwa637nLaOzfNCr61LPo6aBLOp-ld_jf
    tWRoUCC1nJc8WzjXQ>
X-ME-Received: <xmr:0LRcZRl4TYsaHdX0zBOB9MeNG3G9U7WcRg_DEQTdHBUcV-qcahgf2gxol1Ywjd7LHdiPoY1gTVwDhqZBzK5MpY5wn77ljheQ5Ga7PwdiQmDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:0LRcZcwE0pPW8vBSYlJMKOOm33sILr8hXD8xz7awXA79Gq8qatXSJg>
    <xmx:0LRcZTQXDzF4G11DbP6yNIG9S82B0VT3yl_qRs-9EBCMl6vUb4uuwA>
    <xmx:0LRcZXY1HG9rc6qkVArNlqMkHQPHQJ9TkV8GwS4HjTmAc0nkaUhoRQ>
    <xmx:0bRcZedWqhUSCODKyO1ec6mILdi6urHy284K6p76e8eh8sZVqfCgsw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 08:46:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68c557d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 13:46:01 +0000 (UTC)
Date: Tue, 21 Nov 2023 14:46:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Terry Parker <tparker@google.com>
Subject: reftable: How to represent deleted referees of symrefs in the reflog?
Message-ID: <ZVy0zKcmc8tjmgzs@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A1JSs48Iwvy1Zmik"
Content-Disposition: inline


--A1JSs48Iwvy1Zmik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm currently trying to fully understand how exactly reflogs and reflog
entries are supposed to be deleted in the reftable backend. For ref
records it's easy enough, as explained in the technical documentation
for reftables that is part of our tree:

> Deletion of any reference can be explicitly stored by setting the type
> to 0x0 and omitting the value field of the ref_record. This serves as
> a tombstone, overriding any assertions about the existence of the
> reference from earlier files in the stack.

So you simply create a new ref record with type 0x0 and are done.

For log records it seems to be a bit of a different story though.
Again, quoting the technical documentation:

> The log_type = 0x0 is mostly useful for git stash drop, removing an
> entry from the reflog of refs/stash in a transaction file (below),
> without needing to rewrite larger files. Readers reading a stack of
> reflogs must treat this as a deletion.

To me it seems like deletions in this case only delete a particular log
entry instead of the complete log for a particular reference. And some
older discussion [1] seems to confirm my hunch that a complete reflog is
deleted not with `log_type = 0x0`, but instead by writing the null
object ID as new ID.

So: a single entry is deleted with `log_type = 0x0`, the complete reflog
entry is deleted with the null object ID as new ID. Fair enough, even
though the documentation could be updated to make this easier to
understand. I'll happily do so if my understanding is correct here.

In any case though, this proposed behaviour is not sufficient to cover
all cases that the files-based reflog supports. The following case may
be weird, but we do have tests for it in t1400:

```
 $ git init repo
Initialized empty Git repository in /tmp/repo/.git/
 $ cd repo/
 $ git commit --allow-empty --message initial-commit
[main (root-commit) 9f10b3f] initial-commit
 # Everything looks as expected up to this point.
 $ git reflog show HEAD
9f10b3f (HEAD -> main) HEAD@{0}: commit (initial): initial-commit

 # This behaviour is a bit more on the weird side. We delete the
 # referee, and that causes the files backend to claim that the reflog
 # for HEAD is gone, as well. The reflog still exists though, as
 # demonstrated in the next command.
 $ git update-ref -m delete-main -d refs/heads/main
 $ git reflog show HEAD
fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

 # We now re-create the referee, which revives the reflog _including_
 # the old entry.
 $ git update-ref -m recreate-main refs/heads/main 9f10b3f
 $ git reflog show HEAD
9f10b3f (HEAD -> main) HEAD@{0}: recreate-main
9f10b3f (HEAD -> main) HEAD@{2}: commit (initial): initial-commit

 $ cat .git/logs/HEAD
0000000000000000000000000000000000000000 9f10b3f9b20962690fdeff76cd592722fbf57deb Patrick Steinhardt <ps@pks.im> 1700573003 +0100	commit (initial): initial-commit
9f10b3f9b20962690fdeff76cd592722fbf57deb 0000000000000000000000000000000000000000 Patrick Steinhardt <ps@pks.im> 1700573060 +0100	delete-main
0000000000000000000000000000000000000000 9f10b3f9b20962690fdeff76cd592722fbf57deb Patrick Steinhardt <ps@pks.im> 1700573078 +0100	recreate-main
```

It kind of feels like the second step in the files backend where the
reflog is claimed to not exist is buggy -- I'd have expected to still
see the reflog, as the HEAD reference exists quite alright and has never
stopped to exist. And in the third step, I'd have expected to see three
reflog entries, including the deletion that is indeed still present in
the on-disk logfile.

But with the reftable backend the problem becomes worse: we cannot even
represent the fact that the reflog still exists, but that the deletion
of the referee has caused the HEAD to point to the null OID, because the
null OID indicates complete deletion of the reflog. Consequentially, if
we wrote the null OID, we'd only be able to see the last log entry here.

It may totally be that I'm missing something obvious here. But if not,
it leaves us with a couple of options for how to fix it:

    1. Disregard this edge case and accept that the reftable backend
       does not do exactly the same thing as the files backend in very
       specific situations like this.

    2. Change the reftable format so that it can discern these cases,
       e.g. by indicating deletion via a new log type.

    3. Change the files backend to adapt.

None of these alternatives feel particularly great to me. In my opinion
(2) is likely the best option, but would require us to change the format
format that's already in use by Google in the context of multiple
projects. So I'm not quite sure how thrilled you folks at Google and
other users of the reftable library are with this prospect.

Anyway, happy to hear about alternative takes or corrections.

Patrick

[1]: <CAFQ2z_P-cf38yR-VyvfDSgPUO_d38mgsi32UkRSPWMZKJOmjZg@mail.gmail.com>

--A1JSs48Iwvy1Zmik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVctMcACgkQVbJhu7ck
PpSqKA/9GHgYallwO5wsSWu8qbtR/Nia83/5CZ5aTbFqbUpJHrQqt71nuGNRjflA
d7fE/7+DX0zpk9dhppTI0jAui+F4c/4od1KILwkSexz1iG3x7x4CuRux4Cnbc60s
Hl8HCDhDyrBNWjnZubD7RM3xAjz55uWbwp2BRPIn7M2dc0Y+monf9sGtZh2YEJaO
lhRCdwufDY5N1XxYRF5r0oSF2wqUZXFBgXPZgNwAtSFIbJLA6KqlKViWi2foQPRs
3zvX++PYW0fExwjZGqLpv3X0YYU8yjSn7XvV7SXA4Amw9hO6KMXsfjZ/JkFk2kBl
MIIVW6XwlwsMrJDTEzbiUXqwPHV+0w4gbrVKWPZU5Io58ne9758wy0Q6CM3vFF9X
6LbTkPurnVj36Xcw8khsZPgfsc1QFP/3MTmJlqo4uH3sgvEfi1FRZON9WBgWnzVE
nOzEzW5LrY77g0OVJ3mb/NMznEXDOParM3o9WdBG+t8mImu5hP+hl9oBYd/38ZAN
6IUJA/MGgSN3YBpVv0O88nbp51xRNl616hFTifWJ6obuL8wqiXHLj4PXQUztKVma
tfZedab2Rj+8BstDwUOfI7qzal9paH+LTkapohO45BoAdx5IGZgzRtfS/UVH93me
4c+J2ukDolGTdxaghUKT+zDuMk7OpIY9BF7zZUVV52ultpYeLJA=
=7AVb
-----END PGP SIGNATURE-----

--A1JSs48Iwvy1Zmik--
