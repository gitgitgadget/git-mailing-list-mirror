Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BCSNKNax";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMEKthOw"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0769D49
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 06:39:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 81DFF5C027F;
	Wed,  6 Dec 2023 09:39:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 09:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701873557; x=1701959957; bh=8F
	tT55yPFsXR+PcRNmbdv9mjfjKk/m9l0HTIJDYypQg=; b=BCSNKNax/RG0EswRXl
	RRMWvzeKTUCK/2V7eE++T/4dR6+tChAub9otjIVpJh6sgbc+AYueF+4imhBKXesQ
	XLGKfLy7SXf3zHvCcLTQygNhlBd4mv69ClqeTQi3+lai1SZHIRAS5OMFdbeFT7Us
	wliP7pXhyp41J1l1v2BZ4uYUjE5FfB5miteJdY+9ryi85belS2TqrcJPZ9vpG+tW
	q0hqvRvm5ioGRpKoyws8As6WgWMHIA9blzAbTJhoHJCXGDVGjK7KmSGWRyeWvKNf
	NG+Wt74sI10GFGPb82oaG0rSdEa9wF7aXaNhEyYM4GXOG+fBXzxEHcfc+71C92ZQ
	Ur4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701873557; x=1701959957; bh=8FtT55yPFsXR+
	PcRNmbdv9mjfjKk/m9l0HTIJDYypQg=; b=rMEKthOw7V2zDU4PJOYjp3PlWG4/H
	8fMEqWSODESYwiqm8WK4BDQPIjVFqmeS1Eqh/Un46Kz00MhitcjuFK9EBpvWZPX4
	4BD8gOyxobx+891HqTAHe3aQ1YR0ZCwbv1OipCp5uwpXuU66iBHFw+7l1D1WSHvc
	7rYE3e886tnTeJfUG2pNKWH+/HxsHOzSyvellk5XatUXmgFgpyr/L2HDJgMGU/GN
	BRN7m2Dd1m2V9+nKIfe6iEFGsrbYQkBYzSDjk1JuWFe8UWIJXVFs19TJ2XKrVdB+
	lKxO7y0tZQ2jMP8LaXJgb0TYHW53UhXxLPHxSF3W08lcYGszGUrPCAdzA==
X-ME-Sender: <xms:lYdwZXdCqICVnD-sN2q4LCAEbY4y3v9DU-U9Hi4mlemLkKWn8kLCMQ>
    <xme:lYdwZdNSBbM-_xIm4RahsDRM1nEAvsvF8K5qsoUNWCfCx25MHCpNAvY7dy-5UmHtw
    cKvP1jcSSYv5UCe8g>
X-ME-Received: <xmr:lYdwZQgukk30y_wYQyLAhYTmpivp0irY9Z3jP-imjQBP_CgXmADQ0eOb9vy9J_vLIolbtFkS89phLTh7oJKDirzp_jUzT3fbZ9Q8FRN4K2Hrph8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lYdwZY813ACVlm5Ar1kyEW3ilz3GpPNMET12tXyN7JiHYIZ8Y_Zjig>
    <xmx:lYdwZTsM-dOFuF2EpwEcCJZp1QLaP9bb_Tw1exUGgISZU-ijmzq5Cw>
    <xmx:lYdwZXHTUfPuYpVGdHfVr8_z5xPmg0HOeBcxSBCSySMdIpRRA6Q87Q>
    <xmx:lYdwZR0E5JGKYkGbPovksbIfR2kPgTcCJzw0D88AdVrhIQhN07nbug>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 09:39:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dedf3302 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Dec 2023 14:37:47 +0000 (UTC)
Date: Wed, 6 Dec 2023 15:39:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] revision, rev-parse: factorize incompatibility
 messages about --exclude-hidden
Message-ID: <ZXCHj3hIpQb900WX@tanuki>
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-5-l.s.r@web.de>
 <ZXByOXWo6cIy71s2@tanuki>
 <389cd7b3-2350-4dc6-b282-e9d6e25fa68c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/hsKsrkbPVKIKSLd"
Content-Disposition: inline
In-Reply-To: <389cd7b3-2350-4dc6-b282-e9d6e25fa68c@web.de>


--/hsKsrkbPVKIKSLd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 03:21:15PM +0100, Ren=E9 Scharfe wrote:
> Am 06.12.23 um 14:08 schrieb Patrick Steinhardt:
> > On Wed, Dec 06, 2023 at 12:51:58PM +0100, Ren=E9 Scharfe wrote:
> >> Use the standard parameterized message for reporting incompatible
> >> options to report options that are not accepted in combination with
> >> --exclude-hidden.  This reduces the number of strings to translate and
> >> makes the UI a bit more consistent.
> >>
> >> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> >> ---
> >>  builtin/rev-parse.c                |  9 ++++++---
> >>  revision.c                         | 18 ++++++++++++------
> >>  t/t6018-rev-list-glob.sh           |  6 ++----
> >>  t/t6021-rev-list-exclude-hidden.sh |  4 ++--
> >>  4 files changed, 22 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> >> index fde8861ca4..917f122440 100644
> >> --- a/builtin/rev-parse.c
> >> +++ b/builtin/rev-parse.c
> >> @@ -893,13 +893,15 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
> >>  			}
> >>  			if (opt_with_value(arg, "--branches", &arg)) {
> >>  				if (ref_excludes.hidden_refs_configured)
> >> -					return error(_("--exclude-hidden cannot be used together with --=
branches"));
> >> +					return error(_("options '%s' and '%s' cannot be used together"),
> >> +						     "--exclude-hidden", "--branches");
> >
> > The repetitive nature of this patch and subsequent ones made me wonder
> > whether it would be useful to have a function similar to the
> > `die_for_incompatible_*()` helper that knows to format this error
> > correctly.
>=20
> I wondered the same and experimented with a die_for_incompatible_opt2().
> It would allow the compiler to detect typos.
>=20
> Passing in the conditions as parameters is a bit tedious and unlike its
> for its higher-numbered siblings there is not much to win by doing that
> instead of using an if statement or two nested ones.  We could pass in
> 1 if we want to integrate that function into an if cascade like above,
> but it would look a bit silly.  And here we'd need a non-fatal version
> anyway.

Maybe the easiest solution would be to have `error_incompatible_usage()`
that simply wraps `error()`. You'd pass in the incompatible params and
it makes sure to format them accordingly. It could either accept two
args or even be a vararg function with sentinel `NULL`. It's not perfect
of course, but would at least ensure that we can easily convert things
over time without having to duplicate the exact message everywhere.

But ultimately I do not mind the current duplication all that much, the
patch series looks good to me even without such a new helper.

> Perhaps a build step that lists all new translatable strings would help?
> Nah, that would require building each commit.
>=20
> A LLM-based tool to find translatable strings with the same meaning?
> Don't know how difficult that would be.

I don't think it's a problem to not convert everything in one go. The
current series is a good step in the right direction, and any additional
instances that were missed can be fixed in follow-ups.

Patrick

--/hsKsrkbPVKIKSLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwh44ACgkQVbJhu7ck
PpTObw//TCEgqtzm7/TqsxIlOQaWUi82iVL89mTN72r4tYlK22gx/6Ry+DN03bpb
vH/x+BUvDP56p91q8PpOxGUQeEYvtNtgkAUK6MVU/WS4FAlymFBCjli3QBmFjHEW
Ip2X56+d23mf1K2sokMQpuuyHxTmLJJz5MiRzspT2wYMCkfiFRyzyaa1jCYj0rLc
G3rQ2WccvZaTZk+JiqdRhVmMM8t/PQJxns5mtyBnyVhXlEt5i0uG7AQ/Oi6lkEbr
NcmKbyeveTizz5bFueMZ/nVNOi4ZkuQajyIbn/yrYwQVwc96770+UPgLQYLA78DL
oRSR/LABD5Hm8Dplu686Nx4ENnpu1eIwuQDuXkhN29/yy7VXA1oMkfDyll89u/BA
u+nXALsNYXfp4OtvOeybEWCXcXGD3hjQLepLMyKIe7Uhr29mRxCuA72yO75uEq20
Y00hqPjAFCPnB6oJJr+RaoCuUhgK/r9IRqAJvoyH+WdTZ6yF5P0sBxUYCWkHi4m1
tH54Wcg42oEYzUAKU7MzmuqMh1x3AY3RWCLQUuq66UnAX+QDd63G0IGEbI7Zv/Pm
aJOjcmnoddipl5KvfKaijrALs5e3bsP38m/EJnNu8N19FK9Ms8vXgJF+NI81t+Ie
3IZPA8nKWRh7rK7qDpLjp23OJN3kW+EzZb1mPR5tWTkjT3RSIGY=
=N7lq
-----END PGP SIGNATURE-----

--/hsKsrkbPVKIKSLd--
