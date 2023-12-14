Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lfYNeWV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kc6At+JW"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4241B9
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:05:58 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C62543200A03;
	Thu, 14 Dec 2023 03:05:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 14 Dec 2023 03:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702541157; x=1702627557; bh=pqncejcRdZ
	o5zeOcPj7FLdtjhiXkA6ZLK3VLDh0e3pE=; b=lfYNeWV3Va7bjXQ49hWFgFAPGt
	Vd0AVaHRIAgW2qkxTQ7Zz2C61q9qCj1SH11p5TGVbfzfWcqXkeZo55ZWKeCBgNWi
	2arKiFHuqhH+eh7q6XHpa/iMDqZHa2QvWpZCmX+LKF+KeBuRfIUqOUQP98tzC3pZ
	3BunAPwNI59pODcBDcwcm09cZXlimuX02bkeaVAJIPLdJN5C2Q9PY/HtX2N60Brw
	q9HrPM7a6isib/lsvErInBPlpWS7GEsNMryACaPTCBgNSGpAKUHl5toU6Bu1PRQK
	WS2mr6moBYE054sHhudj1tWvvDco9xo87aOpakJsWjp9V/0lU4txBr1Q/hug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702541157; x=1702627557; bh=pqncejcRdZo5zeOcPj7FLdtjhiXk
	A6ZLK3VLDh0e3pE=; b=Kc6At+JWbfaWbAc+qXCiFO/1z6pFed34TtvaqPXX/hye
	1/SZpwBYe1lVBrTEIan7CGVMiZUoWCTd1W8455sghkpC68oCc8YnJU2FDmivFg5A
	hm1T3+3VP6Ku28AmPphdL0VnYlTFi1WlmHox8vpe4M7Coy0pzG6VlZANLgqYVMrg
	2Xhbhw4K+2994EQKqRWztAwsA1huIo2OJGiZp4Q28vweDdgdwmMYOG+tNfmuGUb9
	MA8MLY2mnh2L2l2Bdb682VyCSkB9pUvnxcc1WkoO+OXnY5PmXOMxpAHPYWC0Kzgr
	xvPKb+FDZuzTv0u2A88vnAj651yGpBeZu7fKJLa1ww==
X-ME-Sender: <xms:Zbd6ZX8AvEJQxkSN2dpjPbxYUJq2OWHgdMjqZuTGv5vRd5cPJhacQw>
    <xme:Zbd6ZTtsiDH1_2AD-iDNQNjmRlOdguhKLA0bCMeNJSXWpSyT3bucDqlBZxIZDXmch
    C6fU4X4EUrIUPFl5g>
X-ME-Received: <xmr:Zbd6ZVBvF5AyhmGmdKprE5X1vq-0V5FSuwCLbo42Gp39KpR9aqI1whqTtMIZ_iaB1IOCiaYsr9vnGfxbG8Qu_S1uK971xW7AieHL4DBVSQuTSwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Zbd6ZTexn6qopXcrWGDmH2b7neelK0LF3wLQJYtR0tVi6WBfGo9SGw>
    <xmx:Zbd6ZcOiLWxG2e5f6WA3N5F-n3P0_XlYANuK1F3o9mPZbFLh1fUnvg>
    <xmx:Zbd6ZVkbVLaGMr9QS9plh73tdLniq2XrVZJ9cZgg-K7yziar_M_-qw>
    <xmx:Zbd6ZRozWd7avHCQuZr3gt5a8Oo8P3igOEatnku8UyY7KO0Jc8Ayvg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 03:05:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0eb2cc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 08:04:12 +0000 (UTC)
Date: Thu, 14 Dec 2023 09:05:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tests: drop dependency on `git diff` in check-chainlint
Message-ID: <ZXq3YdK2RSKF3npE@tanuki>
References: <20231214032248.1615-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anzYZjrXRtFlqWac"
Content-Disposition: inline
In-Reply-To: <20231214032248.1615-1-ericsunshine@charter.net>


--anzYZjrXRtFlqWac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:22:48PM -0500, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>=20
> The "check-chainlint" target runs automatically when running tests and
> performs self-checks to verify that the chainlinter itself produces the
> expected output. Originally, the chainlinter was implemented via sed,
> but the infrastructure has been rewritten in fb41727b7e (t: retire
> unused chainlint.sed, 2022-09-01) to use a Perl script instead.
>=20
> The rewrite caused some slight whitespace changes in the output that are
> ultimately not of much importance. In order to be able to assert that
> the actual chainlinter errors match our expectations we thus have to
> ignore whitespace characters when diffing them. As the `-w` flag is not
> in POSIX we try to use `git diff -w --no-index` before we fall back to
> non-standard `diff -w -u`.
>=20
> To accommodate for cases where the host system has no Git installation
> we use the locally-compiled version of Git. This can result in problems
> though when the Git project's repository is using extensions that the
> locally-compiled version of Git doesn't understand, in which case `git`
> may refuse to run and thus cause the checks to fail.
>=20
> Work around this issue by normalizing whitespace via sed before invoking
> diff, which allows any platform diff implementation to be used, thus
> eliminating the dependency upon `git diff` and the non-POSIX `-w` flag.
>=20
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>=20
> This is an alternative solution to the issue Patrick's patch[1]
> addresses. Hopefully, this approach should avoid the sort of push-back
> Patrick's patch received[2].

Thanks for chiming in!

> I shamelessly stole most of Patrick's commit message.
>=20
> The sed expressions for normalizing whitespace prior to `diff` may look
> a bit hairy, but they are simple enough in concept:
>=20
> * collapse runs of whitespace to a single SP
> * drop blank lines (this step is not new)
> * fold out possible SP at beginning and end of each line
> * fold out SP surrounding common punctuation characters used in shell
>   scripts, such as `>`, `|`, `;`, etc.
>=20
> By the way, I'm somewhat surprised that this issue crops up at all
> considering that --no-index is being used with git-diff. As such, I
> would have thought that the local repository's format would not have
> been interrogated at all. If that's a bug in `git diff --no-index`, then
> fixing that could be considered yet another alternative solution to the
> issue raised here.

This strongly reminds me of the thread at [1], where a similar issue was
discussed for git-grep(1). Quoting Junio:=20

> I actually do not think these "we are allowing Git tools to be used
> on random garbage" is a good idea to begin with X-<.  If we invented
> something nice for our variant in "git grep" and wish we can use it
> outside the repository, contributing the feature to implementations
> of "grep" would have been the right way to move forward, instead of
> contaminating the codebase with things that are not related to Git.

So this might not be the best way to go.

> [1]: https://lore.kernel.org/git/4112adbe467c14a8f22a87ea41aa4705f8760cf6=
=2E1702380646.git.ps@pks.im/
> [2]: https://lore.kernel.org/git/xmqqr0jqnnmn.fsf@gitster.g/
>=20
>  t/Makefile | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/t/Makefile b/t/Makefile
> index 225aaf78ed..656ff10afa 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -103,20 +103,12 @@ check-chainlint:
>  		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
>  		for i in $(CHAINLINTTESTS); do \
>  			echo "# chainlint: $$i" && \
> -			sed -e '/^[ 	]*$$/d' chainlint/$$i.expect; \
> +			sed -e 's/[ 	][ 	]*/ /g;/^ *$$/d;s/^ //;s/ $$//;s/\([<>|();&]\) /\1/g=
;s/ \([<>|();&]\)/\1/g' chainlint/$$i.expect; \

These sed expressions do look hairy indeed. I have to wonder: all that
we're doing here is to munge the expected files we already have in our
tree. Can't we fix those to look exactly like the actual results instead
and then avoid any kind of post processing altogether? If I understand
correctly the only reason we do this post processing is because the
original implementation of the chainlinter produced slightly different
whitespace.

Patrick

[1]: https://lore.kernel.org/git/xmqq7cnnpy3z.fsf@gitster.g/

--anzYZjrXRtFlqWac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV6t2AACgkQVbJhu7ck
PpQWJA/+Ihp1f568bzdt8QIX2MpqA73SD7DUAyt/oRT0TwVFTk/8ESD5hxdSxBw/
D1LTFc5/PClwBpF6N5kf0rPTHmvmULA96O4v0ST/766hEW9K8hZznqR3nxmlgPgN
86MtUUH0f9dZtn1SG9FcDowY8W3br9gPfWl02YpfLA5+k39xmxzl6CoCgsvJ+tpE
pHjtOna2f9DKKeorhmqhou1YQJG9NQs8wUxhryMkd30KLBFbrkjnRlpG8ftS7e+F
Ik7FJtUOgqVbAT1bv77L7enHUKkBoClJOb4cDniy+jkyTb2fNkeCkvCvRg1StOtD
qB++AxPYGg9zP8mHUehe8XwFk3MZFBrH3GenjcJflt9QxnYJPC44KNC04Wfv6c7x
MnSimaMTvsojisdjzVun1bD61owPr+VXfsC35bzWpX2cL2E1bBaDwEOazqePWoCu
in7gK/nb0sM8C3QwpGhstczJDZ7dV9D61uy+TfBFaqGCV2zHvANTIRkDt/zLVzNT
PJsIM5C9FpfwThRtu26RnyHrHOS3WILBUyGiFqkS+XPlD4tKLTo17TW7VGshVGvU
96c1zOz9r8XtaJBd0J70MYOMhgVD7GF5la84cdHBT5NKOalO9J0lWhbvsKqN+/qf
B6tlerVYYNCHqwzjzUN0Nx+7kk0VbhPxhiDq5fRVuN0HbVa6U4c=
=kQ1O
-----END PGP SIGNATURE-----

--anzYZjrXRtFlqWac--
