Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FA4174A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074466; cv=none; b=a2WI6VLDJQ0CDMadz2El7FZxJnGoFdP5ecpAEIuS5vXEp1rXlG/WIvtcoU6SsIKhg6XyO2XaBpLSs3BrmF3ZUg3iBYd3wKHeP9lmDNmcw4q+X9JXPwWegXWn8hPmBLT3nGg79LkTizlNB3gCIicdIngP32jsD6gsyfW0KiHudUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074466; c=relaxed/simple;
	bh=sDbBqf1iJwm/9KRUd2bopKQUDdHvJZvAd1oXQLug0l0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdKlurqVm5xVir8ao6O20F/uR10dayJsTf8VsFv0LCWscvR0NYNk5b9tA0zR4guFONr2AbzaAjakQeCe/pkpHZrAXU3g0r/Jb93lkPywm5eV/mlvR9OHro8Zawcz6yUk4wsqJLuz8bX++GhijW8qSWkjv8+QQIJr8+lAJG2PHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEN2vgcR; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEN2vgcR"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3458F25401B6;
	Tue, 19 Nov 2024 22:47:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 19 Nov 2024 22:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732074463; x=1732160863; bh=vpXZ3D7YOCMQR8dp7Iuae7nt4xZPhlUYV5k
	DsybAH3A=; b=VEN2vgcRB4JOIFrwrP0gQ+A0uEU7/64BdbEotbY4VdfZx0xFPyZ
	3qlD6Z75R2nO/aWUwgbfVVdTXA0DmeFWYBF0AI4KU1XVxgRPs2JN1V72QCkbgUnJ
	oEMa5FocaQS5RFtkDV7Zcb/68PJkzcRSFlZQTggl5KEQwKsa2XAhagS8CKMbzawL
	1zi0nxgncBXzxoc+MxCvkydPMbW7sKfWSU/QT47g6D5HT4hgbWIE+Tu6Qb3z8ZhQ
	YrkAMIPhvGXJqsLX6g2nJOzwQpG2Mhkr8r5pafo+WH/TPfjquTgmVUDe+mP0CD2B
	0Fs1E99kyLFJiO6sWUilAVGiHi02fXLYUTA==
X-ME-Sender: <xms:3ls9Z0nZA9HD-0O3nCMDHqMZoZyUTMtuMotgrh7grvEod_uG04tbjA>
    <xme:3ls9Zz02HVlLzN3Vsz4ZPeQwU7R5OvKbvfegqWPMWQye8m_yEZzXWxlOPhh6GkapC
    6lzDrf66ix9ZwFnDQ>
X-ME-Received: <xmr:3ls9Zyo-xw2LlcTSAwD0k4n59RAePHiLmZ8LSuJSMfL3s1j0t-I89vSerslpmivZGfmiFj_EJbAioSKawA0PFMKmYFm0jFMpcBU->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeetieejgfeiudehfffhteeggeegtddvfeeiiedu
    vdduteekteegfeetjeejgffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhi
    hjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:3ls9ZwmgSt_38HAJcjxMQFSiHa3qHsgbJNZgEPSET6N8PxndqwXGHA>
    <xmx:3ls9Zy3-HbGQNUM-t42BsK-kP4sO35ImsHnULmiepMiAJclGnaquSA>
    <xmx:3ls9Z3tDhDRlPavJ3SsO4AkheV9RCOK4ieYSY_pGZVmZ7lR8zUYzPA>
    <xmx:3ls9Z-XO8oJAfpbiQSVVvGQCGzvimNfCk6rhIfb9aFYrUYUx06Tqbg>
    <xmx:31s9Z_sqblAL_kt5E5-4HJDxDDrx_i_4GLh45GfPcXTxMzI-LRPmfxlo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 22:47:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 03/23] Makefile: refactor GIT-VERSION-GEN to be reusable
In-Reply-To: <20241119-pks-meson-v8-3-809bf7f042f3@pks.im> (Patrick
	Steinhardt's message of "Tue, 19 Nov 2024 12:50:40 +0100")
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
	<20241119-pks-meson-v8-3-809bf7f042f3@pks.im>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 20 Nov 2024 12:47:40 +0900
Message-ID: <xmqqjzcy7ehv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While at it, change the format of the version file by removing the
> spaces around the equals sign.

This may cause third-parties that act on the contents of the output
for their own purpose (read: may break distro scripts), but that is
part of packaging third-party software for a distro, so it may not
be considered a regression by them ;-)

> +if test "$#" -ne 3
> +then
> +    echo "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>" >&2
> +    exit 1
> +fi
> +
> +SOURCE_DIR="$1"
> +INPUT="$2"
> +OUTPUT="$3"
> +
> +if ! test -f "$INPUT"
> +then
> +	echo "Input is not a file: $INPUT" >&2
> +	exit 1
> +fi

Just a taste thing, which does not warrant a reroll on its own, but
when redirecting to the standard error stream, writing >&2 early on
the command line is easier to signal that we are reading an error
message, e.g.

    echo >&2 "This is an error message."

> +GIT_CEILING_DIRECTORIES="$SOURCE_DIR/.."
> +export GIT_CEILING_DIRECTORIES

Interesting.  Presumably this is to prevent a foreign project having
a tarball extract of us in its subdirectory, which would be a good
protection.

>  # First see if there is a version file (included in release tarballs),
>  # then try git-describe, then default.
> -if test -f version
> +if test -f "$SOURCE_DIR"/version
>  then
> -	VN=$(cat version) || VN="$DEF_VER"
> -elif { test -d "${GIT_DIR:-.git}" || test -f .git; } &&
> -	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
> +	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
> +elif { test -d "$SOURCE_DIR/.git" || test -d "${GIT_DIR:-.git}" || test -f "$SOURCE_DIR"/.git; } &&

The line has grown a bit too long...

> +	VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
>  	case "$VN" in
>  	*$LF*) (exit 1) ;;
>  	v[0-9]*)
> -		git update-index -q --refresh
> -		test -z "$(git diff-index --name-only HEAD --)" ||
> +		git -C "$SOURCE_DIR" update-index -q --refresh
> +		test -z "$(git -C "$SOURCE_DIR" diff-index --name-only HEAD --)" ||
>  		VN="$VN-dirty" ;;

VN matching this case arm is a good sign that we have "git"
available, so not squelching "Command git not found" here is
acceptable, with or without this patch.

>  	esac
>  then
> @@ -26,15 +44,31 @@ else
>  	VN="$DEF_VER"
>  fi
>  
> -VN=$(expr "$VN" : v*'\(.*\)')
> +GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)

The 2>/dev/null here is required and is good.  Even if the
source-dir is git controlled, if we do not have an installed Git
available, we set GIT_BUILT_FROM_COMMIT to an empty string, as we
cannot tell which commit we are building from (yet).

> +GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as')

This needs 2>/dev/null to squelch the case where we have no
installed git.  I suspect "%cs" is more in line with the spirit of
GIT_DATE if I understand its purpose, i.e. "this is the time this
version was recorded in the Git history, with the intention to give
it the public" and better than "%as".

> +GIT_VERSION=$(expr "$VN" : v*'\(.*\)')

I think VN is now set by the if/else cascade above to a string that
begins with 'v', as lnog as the maintainer makes sure that their
tags begin with 'v' (or a distro person prepares the 'version' file
to honor the convention), so this should be a safething to do.

> +if test -z "$GIT_USER_AGENT"
> +then
> +	GIT_USER_AGENT=git/$GIT_VERSION

Not required by the language, but Documentation/CodingGuidelines
encourages you to dq the RHS of this assignment.

> +fi
> +
> +read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
> +$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
> +EOF

And because GIT_VERSION generation is safe above, this probably is
safe, too.  In the ancient days, we had tags like "v0.99.9g" which
may not match the above convention, but with the understanding that
we establish an official convention going forward (i.e. we allow up
to four numbers, the rest is discarded so do not use more than
four), it is OK.

Who wants these broken-out versions and are they fine with
up-to-four limitation?  Just being curious.

> diff --git a/contrib/buildsystems/git-version.in b/contrib/buildsystems/git-version.in
> new file mode 100644
> index 0000000000000000000000000000000000000000..9750505ae77685ebb31a38468caaf13501b6739d
> --- /dev/null
> +++ b/contrib/buildsystems/git-version.in
> @@ -0,0 +1 @@
> +@GIT_MAJOR_VERSION@.@GIT_MINOR_VERSION@.@GIT_MICRO_VERSION@

And this one seems to discard the fourth number, so those who
prepares VN to contain the fourth digit to differenciate a new
version with previous ones would be disappointed.  Similarly,
because this requires the third number, we cannot change the
versioning scheme at 3.0 boundary to say "3.1 is the next version
after 3.0".

As this is merely setting the rule for our future, perhaps we want
to be consistently allow and require N dot-separated numbers
everywhere (e.g., we allow and require 3 numbers, not 2, not 4, but
exactly 3 numbers)?

Thanks.
