Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278879D3
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866635; cv=none; b=W+5LSjLgmv8cbInYXO+gJXU2N6Ye0HsrJWjsY82lRFvAvCOo0jpaOkWaMrn5hI2UTWbI/ds6DhvqU7rb/SORVDYBa//hh0fz9prHTcruJ5CYpEMAfldROJ/mmafFmOEu1uoub1UpZ97qSNRmvYmySmljfs7PHWA0OtaIrAb+l3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866635; c=relaxed/simple;
	bh=xu8nVgEGtU0i36MlK5ubcE2YZqkXHr3EfcSd4sBoCEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deKWmVQ0lf262Mtc+WjepD0JEcnVHqROz9+d1IV4osXMRYN4kzp+4G6RoU7GEFiK0mg5+Yc/3nAnziKLGqN6vv/Q2ITLEWqsMz2GdxVKWE1FhHEroiIUnte05hmQzDBSCvvCi5i3B8QOWephG3SNPdKxhpU7zKnSBViLif3NwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gVPHo7il; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gVPHo7il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708866624; x=1709471424; i=tboegi@web.de;
	bh=xu8nVgEGtU0i36MlK5ubcE2YZqkXHr3EfcSd4sBoCEg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=gVPHo7ils1R1zDx501Km2ODhL8H62Yxsnpda57FnCTSKsNnaYVJuJUub7gp0ZcD+
	 qn8BvyziqCgaQBkETOSTUMeR76dZiGYB4FHcRLfyVFI/rxhcUAu9yFS7VmVY9KwGp
	 05C2YMRLfXVxMAWDkFiBfONpckvVx/A9MA0TU4UkEM+do2Vq3XfAsYsQFaEO8TyK1
	 4ibyZAsOkD+ZdlTZOaFRCVZgg8M1YLDFr0kvVBnJRPDP/IfmybjxwXB7hObEr0z6p
	 cdwODR+2zc7VnV4v9oLmZiahGfQuzZrmvDXsYxjAoj3VGh8WlQAxi0p1qjvblWghg
	 ufLhTSJX9RVAijnWDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1rkEpO0y54-00Balc; Sun, 25
 Feb 2024 14:10:24 +0100
Date: Sun, 25 Feb 2024 14:10:23 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Jeff Hostetler <git@jeffhostetler.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 14/16] fsmonitor: support case-insensitive events
Message-ID: <20240225131023.GC1952@tb-raspi4>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:LjoRTJTqSRxIeh4riDFd7IHgZ4NU9z278t12isfrkiECFzdXjGp
 QvpQyuxVmlrE3KcOf2yqkQEttW5n7PwH7rTfT+7VBL+GosbMuRlChoKm2MIpnm7OfRYVPAd
 4VboZd967u2AMOXeJ/inoVGmqUvdgN6VO/NUkCkkoPWM+iNOFiqBAOWHqa0JQL2qe6arqNu
 F3sKppT+HYF7EOO3XAOkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hW5FOISHiwM=;Sg3sSYXcg6X0OJVDcFrpgy59A6V
 OAc949KeuU9g/eTnlA+krIJsX9/BFn3EctFqe4Wdsi9GJT7ef7zLbiBH5zvdU588+3do1soSC
 YMWI6rokbMobj7i8fJ/FzGhQK0N5VlKsjY5/1PZFYOXgoSDcX8f3jyl6Xi0pRj7leeubh35Kl
 VkS/ZK8Z0maRBSjn2gUXzJoj719PIzFE8vZdScEqiAtH/7ZHVlQSBdkstDzT6aFBCgatSv7JO
 Kw1yfXL5XVr5gQeGVEhakputL1Vws4JwbZ83i20f79GaMveDXwKy4zuu2cID3bgM+s2UJCTG/
 fdm6EeCrjZetxLY89ynx5t8He9zSr33lgqB4/xEXEMcAj9cb7dL+0CWgwOXn7+GPeWJCm4VFA
 7pSxLbTDufKwnIlRhe4H/BEs9o21485PAEJJoD9n5SsYwrAMOhMwbHIoWjyTKJhS2IDUtpMQV
 PepGiV49YDweqmolxXFknhPggc2Eb6aAivMLiSds+JJuFg6XUS7J2BD5MfOHjqB3aAyZc3/dc
 VYEFD1QQAz0BxtieFKa08Xg81YcmtozZnwxZSj1vNsHgvSmKSy/RqhQ22GpsePklS/5wPCro0
 5TqrBmM2f5l2U/EAOF6ChuArpCMFBe4YfGzm6pYBgNPVSN0hJNyX+z3l9jgjsyGK4+iHa2sGo
 QmvmBNFF7SQDGnqaZ/9cUcHZGYnYVrxMOp5uaj7PVVqJm8K4ecp2JocOD9aFVJ7VMf4zWFy41
 ML0xLWgCOmL3NwCtjw5585KXZxdoKdEd9iSOvy451SD2W4Oz39R4P8IQE22c7T9dTr3IwyuZ8
 t73UZ3qzvOzAHLej5PWHLkL0DCq/eR1G9m3kUw88vYe28=
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:18:18AM +0000, Jeff Hostetler via GitGitGadget =
wrote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Teach fsmonitor_refresh_callback() to handle case-insensitive
> lookups if case-sensitive lookups fail on case-insensitive systems.
> This can cause 'git status' to report stale status for files if there
> are case issues/errors in the worktree.
>
> The FSMonitor daemon sends FSEvents using the observed spelling
> of each pathname.  On case-insensitive file systems this may be
> different than the expected case spelling.
>
> The existing code uses index_name_pos() to find the cache-entry for
> the pathname in the FSEvent and clear the CE_FSMONITOR_VALID bit so
> that the worktree scan/index refresh will revisit and revalidate the
> path.
>
> On a case-insensitive file system, the exact match lookup may fail
> to find the associated cache-entry. This causes status to think that
> the cached CE flags are correct and skip over the file.
>
> Update event handling to optionally use the name-hash and dir-name-hash
> if necessary.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 739ddbf7aca..ac638a61c00 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -5,6 +5,7 @@
>  #include "ewah/ewok.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-ipc.h"
> +#include "name-hash.h"
>  #include "run-command.h"
>  #include "strbuf.h"
>  #include "trace2.h"
> @@ -186,6 +187,102 @@ static int query_fsmonitor_hook(struct repository =
*r,
>  static size_t handle_path_with_trailing_slash(
>  	struct index_state *istate, const char *name, int pos);
>
> +/*
> + * Use the name-hash to do a case-insensitive cache-entry lookup with
> + * the pathname and invalidate the cache-entry.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static size_t handle_using_name_hash_icase(
> +	struct index_state *istate, const char *name)
> +{
> +	struct cache_entry *ce =3D NULL;
> +
> +	ce =3D index_file_exists(istate, name, strlen(name), 1);
> +	if (!ce)
> +		return 0;
> +
> +	/*
> +	 * A case-insensitive search in the name-hash using the
> +	 * observed pathname found a cache-entry, so the observed path
> +	 * is case-incorrect.  Invalidate the cache-entry and use the
> +	 * correct spelling from the cache-entry to invalidate the
> +	 * untracked-cache.  Since we now have sparse-directories in
> +	 * the index, the observed pathname may represent a regular
> +	 * file or a sparse-index directory.
> +	 *
> +	 * Note that we should not have seen FSEvents for a
> +	 * sparse-index directory, but we handle it just in case.
> +	 *
> +	 * Either way, we know that there are not any cache-entries for
> +	 * children inside the cone of the directory, so we don't need to
> +	 * do the usual scan.
> +	 */
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
> +			 name, ce->name);
> +
> +	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
> +
> +	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +	return 1;
> +}
> +
> +/*
> + * Use the dir-name-hash to find the correct-case spelling of the
> + * directory.  Use the canonical spelling to invalidate all of the
> + * cache-entries within the matching cone.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static size_t handle_using_dir_name_hash_icase(
> +	struct index_state *istate, const char *name)
> +{
> +	struct strbuf canonical_path =3D STRBUF_INIT;
> +	int pos;
> +	size_t len =3D strlen(name);
> +	size_t nr_in_cone;
> +
> +	if (name[len - 1] =3D=3D '/')
> +		len--;
> +
> +	if (!index_dir_find(istate, name, len, &canonical_path))
> +		return 0; /* name is untracked */
> +
> +	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
> +		strbuf_release(&canonical_path);
> +		/*
> +		 * NEEDSWORK: Our caller already tried an exact match
> +		 * and failed to find one.  They called us to do an
> +		 * ICASE match, so we should never get an exact match,
> +		 * so we could promote this to a BUG() here if we
> +		 * wanted to.  It doesn't hurt anything to just return
> +		 * 0 and go on becaus we should never get here.  Or we
> +		 * could just get rid of the memcmp() and this "if"
> +		 * clause completely.
> +		 */
> +		return 0; /* should not happen */

In very very theory, there may be a race-condition,
when a directory is renamed very fast, more than once.
I don't think, that the "it did not match exactly, but
now it matches" is a problem.
Question: Does it make sense to just remove this ?
And, may be, find out that the "corrected spelling (tm)"
of "DIR1" is not "dir1", neither "Dir1", but, exactly, "DIR1" ?
Would that be a problem ?


> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
> +			 name, canonical_path.buf);
> +
> +	/*
> +	 * The dir-name-hash only tells us the corrected spelling of
> +	 * the prefix.  We have to use this canonical path to do a
> +	 * lookup in the cache-entry array so that we repeat the
> +	 * original search using the case-corrected spelling.
> +	 */
> +	strbuf_addch(&canonical_path, '/');
> +	pos =3D index_name_pos(istate, canonical_path.buf,
> +			     canonical_path.len);
> +	nr_in_cone =3D handle_path_with_trailing_slash(
> +		istate, canonical_path.buf, pos);
> +	strbuf_release(&canonical_path);
> +	return nr_in_cone;
> +}
> +
>  /*
>   * The daemon sent an observed pathname without a trailing slash.
>   * (This is the normal case.)  We do not know if it is a tracked or
> @@ -319,6 +416,19 @@ static void fsmonitor_refresh_callback(struct index=
_state *istate, char *name)
>  	else
>  		nr_in_cone =3D handle_path_without_trailing_slash(istate, name, pos);
>
> +	/*
> +	 * If we did not find an exact match for this pathname or any
> +	 * cache-entries with this directory prefix and we're on a
> +	 * case-insensitive file system, try again using the name-hash
> +	 * and dir-name-hash.
> +	 */
> +	if (!nr_in_cone && ignore_case) {
> +		nr_in_cone =3D handle_using_name_hash_icase(istate, name);
> +		if (!nr_in_cone)
> +			nr_in_cone =3D handle_using_dir_name_hash_icase(
> +				istate, name);
> +	}
> +
>  	if (nr_in_cone)
>  		trace_printf_key(&trace_fsmonitor,
>  				 "fsmonitor_refresh_callback CNT: %d",
> --
> gitgitgadget
>
>
