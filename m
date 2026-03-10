Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E433A717
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164369; cv=none; b=i+4Ayve6s5NwKnwyXaniaFgFpPnUbSRQaHvYijTfk2AwfOhbzBndhVoX0r7DiCSkk5RLk80HGy83jhHZuA0M3nciIIN5VWSZlxep1PPb4PjazKU6s18+4a6Fk1GucxbnHGr+tSlx/Z79l1JZuU541RoHKnO1j6frsTqrnyFY2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164369; c=relaxed/simple;
	bh=uvlwP5DdsqwCcFE5KQoKdqQeWKg7y0n1Xd/N0N11WZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxfOIrxrAj4nCDxP446tb03mUFziDuTPKjDN67AK0knH19D0ZFAp4f2SW80KyxUY7LSmkJbAjI9q/tGfWIMHyZr8L8HGwVXLDoThTjM9sE3M6rMBYqVYf03rYzj2rr2doS5cHukmeSKJx0EYzzCGyGMr93PSjPvj/i0yZ201kP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 6BC314D0BE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:31:25 +0100 (CET)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7B090B0054C;
	Tue, 10 Mar 2026 18:31:14 +0100 (CET)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>
Cc: gitster@pobox.com, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v1] diff: document -U without <n> as using default context
Date: Tue, 10 Mar 2026 18:31:14 +0100
Message-ID: <5973423.DvuYhMxLoT@piment-oiseau>
In-Reply-To: <20260309172719.125419-1-cat@malon.dev>
References:
 <xmqqh5qswo45.fsf@gitster.g> <20260309172719.125419-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 9 March 2026 18:27:19 CET Tian Yuchen wrote:
> The documentation for '-U<n>' implies that the numeric value '<n>' is
> mandatory. However, the command line parser has historically accepted
> '-U' without a number.
> 
> Strictly requiring a number for '-U' would break existing tests
> (e.g., in 't4013') and likely disrupt user scripts relying on this
> undocumented behavior.
> 
> Since we are retaining this fallback behavior for backward compatibility,
> update the documentation to explicitly state that '<n>' can be omitted
> for the short option '-U'.

In this case, isn't the long option also changed to optional number, such as:

`--unified[=<n>]`

?

> 
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  Documentation/diff-context-options.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/diff-context-options.adoc
> b/Documentation/diff-context-options.adoc index e161260358..655496ec3a 
100644
> --- a/Documentation/diff-context-options.adoc
> +++ b/Documentation/diff-context-options.adoc
> @@ -1,4 +1,4 @@
> -`-U<n>`::
> +`-U[<n>]`::
>  `--unified=<n>`::
>  	Generate diffs with _<n>_ lines of context. Defaults to 
`diff.context`
>  	or 3 if the config option is unset.




