Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2341C71
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743887840; cv=none; b=rkepDzaCLZIj9mghkeBfC7I9a/EpBYldN8PhycSmYpLcB/uZkliebJoFPk+P65qKE9zqdJS/0kKnUkUTIR5uW5qNpEi9oK4z3EQJpeZ1RbNq4F0ntgwa4KjZK8tGdcujHBO/+5eKAZ6hrLpV3Bhft9qnMHpxO7nILHkrWvwhzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743887840; c=relaxed/simple;
	bh=g1ZmjRQ8YdLEZQxahIrsm45m//HKDIUXpc815NmrRqg=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Lja61IGXNfpgGVsGEmypRPFWDhWoESN462h6xOQszTkIjRfkpv32zBd+oVFa4QK/PfUGuG59PsTYorC6xSU1e9XyKPR6vFp4LfYugi/mUCps3ngrNjTmCThR9AE6I0vtZkCLaXEfIxCGr42X97HRmyB2koBSoh4lGowoLKqFY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=SldjG01g; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="SldjG01g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=qGhKq9zy5lRKtrOya6CClYFagdGa/xRW+znnkro/c68=;
 b=SldjG01gt1PDEmk9AQDll1Dfd9AecC8s0RhamKPC/q/flfWQ6hjD3S4At0JYqDo0+BViD0WUcHm6
   YhNkEv6p8Y5xbLvy7topbUZRqQVl4d2MApPrkbyQF/tCYF0WkmyU2FXqGdxMsYTg3E0iTEFNt/fn
   gqUkxRGc6vKzDWmvZ0RDdpjNbW21rx1FVFX3SZLGsFOHjesXlscpMkL3F2HPZWL+b1e33n5ZsLLW
   u8bjuP5Bf6yxply8UvYk2hMGjzZFXRRGbHDEqDhWgnbyL9TpAJqFmZX98VtHM+UqIXOlioVeX2IX
   XW+etY/kRmQDV+6MWxgiaq/KzmUHDwNU5/Xtaw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20250311 64bit (built Mar 11
 2025))
 with ESMTPS id <0SU900J03K88IN30@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 05 Apr 2025 21:12:08 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 05 Apr 2025 23:11:26 +0200
Message-id: <D8Z0IRH55LVQ.3BORI2G7KD8Z2@ferdinandy.com>
Subject: Re: jk/fetch-follow-remote-head-fix,
 was Re: What's cooking in git.git (Mar 2025, #07; Wed, 26)
Cc: "Taylor Blau" <me@ttaylorr.com>, <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <xmqqiknwhsdz.fsf@gitster.g>
 <20250404085812.GA772404@coredump.intra.peff.net>
In-reply-to: <20250404085812.GA772404@coredump.intra.peff.net>
Reporting-Meta:
 AAG4bpmy2ck2LPqIYq5SkBv3GVhlRr2SE1Fs3azhJ6+LsyBrxshOv4heNhdyEfFb
 JJISXoVLjMqhQxqd8ZytnbW6uQxNrp9+aawWYrI0VdcbxG2OLWO0iVM+V6Qp+x18
 yK+SgDPn0r29f88didgFnBd0VA8zUVYWhrLlyHMpE+XenVcPmhW6B9YklMdf87VT
 SROIZv2cIz0aTG6uuTYFL3u2d4fdRJaWyxsDVbs64noDTXdrAStKnInbhubaohmv
 84VdckaygbPSoC1VaTWOmjDrk3a2Uwx7Fu4nnfYVBnnzAP88jc0L5xsxyDX3iIkF
 ZfByELdigZJ8J+u7pwlwfzb+YVIDLFBbhJRb/6W8bvE+0U7FfWB9xT7jSp9bUO+H
 vBlaw0OTyu1lrM/0Ne8B/A08jG6W+F9aVOc9/H9QwPr+rS9M6WdvA+xfA95mOY0T
 kTEbWc5nttP6xaytaDFZZgqx/6uWGNw8qRQQNGRJCdBUdjOG7vl5znM=


On Fri Apr 04, 2025 at 10:58, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 26, 2025 at 05:46:00AM -0700, Junio C Hamano wrote:
>
>> * jk/fetch-follow-remote-head-fix (2025-03-18) 3 commits
>>  - fetch: don't ask for remote HEAD if followRemoteHEAD is "never"
>>  - fetch: only respect followRemoteHEAD with configured refspecs
>>  - Merge branch 'jk/fetch-ref-prefix-cleanup' into jk/fetch-follow-remot=
e-head-fix
>>  (this branch uses jk/fetch-ref-prefix-cleanup.)
>>=20
>>  "git fetch [<remote>]" with only the configured fetch refspec
>>  should be the only thing to update refs/remotes/<remote>/HEAD,
>>  but the code was overly eager to do so in other cases.
>>=20
>>  Will merge to 'next'?
>>  source: <20250318053905.GA2051217@coredump.intra.peff.net>
>
> I think so. The design was based on our discussion, and it seemed to get
> positive comments from you and Taylor. It might be nice to get an ack
> from Bence, since this is his feature I'm modifying.

Thanks, I saw the patches, but got swamped. I think it's perfectly reasonab=
le
to only update remote/HEAD when we're getting the entire remote, and not ju=
st
bits and pieces. For bits and pieces update of remote/HEAD there's still re=
mote
set-head -a. I'm not sure if I should formally send an Acked-by on the patc=
h?

And thanks for cleaning up the bugs this feature introduced!

>
> Taylor did note one place where the resulting code is a little hard to
> read.  That could be addressed by adding this on top (or it could be
> squashed into patch 1):
>
> -- >8 --
> Subject: [PATCH] fetch: make set_head() call easier to read
>
> We ignore any error returned from set_head(), but 638060dcb9 (fetch
> set_head: refactor to use remote directly, 2025-01-26) left its call in
> a noop "if" conditional as a sort of note-to-self.
>
> When c834d1a7ce (fetch: only respect followRemoteHEAD with configured
> refspecs, 2025-03-18) added a "do_set_head" flag, it was rolled into the
> same conditional, putting set_head() on the right-hand side of a
> short-circuit AND.
>
> That's not wrong, but it really hides the point of the line, which
> is (maybe) calling the function.
>
> Instead, let's have a full if() block for the flag, and then our comment
> (with some rewording) will be sufficient to clarify the error handling.

It also makes it more transparent that the comment belongs to the set_head
line, so definitely tidier.

Thanks,
Bence

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fetch.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3658509740..dbf741ef5b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1903,12 +1903,13 @@ static int do_fetch(struct transport *transport,
>  				  "you need to specify exactly one branch with the --set-upstream op=
tion"));
>  		}
>  	}
> -	if (do_set_head && set_head(remote_refs, transport->remote))
> -		;
> +	if (do_set_head) {
>  		/*
> -		 * Way too many cases where this can go wrong
> -		 * so let's just fail silently for now.
> +		 * Way too many cases where this can go wrong so let's just
> +		 * ignore errors and fail silently for now.
>  		 */
> +		set_head(remote_refs, transport->remote);
> +	}
> =20
>  cleanup:
>  	if (retcode) {




--=20
bence.ferdinandy.com

