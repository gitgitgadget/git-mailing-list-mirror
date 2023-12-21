Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302591401C
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TxZryTo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703143837; x=1703748637; i=l.s.r@web.de;
	bh=PF5sBD1vMW614UZSqgxaRJUTaoOILrxy0d/N6zWlI/o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TxZryTo+SW3RvnmDK32rEbu+8bZ/mnBaAJlvH4cgkPrcK5zhmSmMugqgukKT/btf
	 tipxLpTalntj7LIiDuJfYh3xvIvk6yAHUJ0gDCkzRPHtmx7JxA9jVLHy8nPsPKBWo
	 /7SmhFLPeuBexKPCsHBP1HakvllszUjuyIINq4zlp/XYIxbG6c1DXqZBS0CLgysFO
	 ewtUOzO7c+ilMLf1H7CG2lwpNVnnSvwxXyyJrYK+Cl0mbKNRRa55a4FSwzr4CkWUZ
	 nm3sR5eQfy3otUWj/biiTxU2SEPK+eCQJAa3YGemxMIHCj7RAFNWHD29qY4Q+Fdiq
	 hp3FZ6nY+C2dA1Lhqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc4g-1qnUOb3DUu-00fvLi; Thu, 21
 Dec 2023 08:30:37 +0100
Message-ID: <296e8d69-c1d7-4ad2-943a-dfc54940abc2@web.de>
Date: Thu, 21 Dec 2023 08:30:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] archive: "--list" does not take further options
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g> <xmqqttocp98r.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqttocp98r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lBA3l0TmEp90ZdQtkzLP8ajdxk03tc2l5voasdM0D1TYRQfPcVi
 YRsmW5KdAlx0iSkbjReTUD1oMfdgF9o2Ep70rMZ9gMowl1Dl/9H6ExyqclsoEP4ueF9uOO/
 JKvWiaFDUOe/q3r/wAn8beu7N3gmmzi9PNOs1ld/gUCcYFkar3FxppH53x8+Ok/JeajEEnm
 GRZep7Ygsb/it56Sa1GRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C4PmpUM4g0g=;QCZx+frimukV3PDUjMOjeaA4jji
 +XlbmrNCDQ9qH/q/gGkFEQnF1ihsGSh/RmpnbE6yuBmGQj6AYMkjJ6ccvB3QBKnYsmWCT1gMs
 6/3e3/EYuabWxSg1xJzB77pRfB7ifYjzdSRkXTs4Ei3Gdgxl0UdsAQExkDsbIKECHOlauZEGQ
 Bc7uqb0ZZDhvumXH9k0DQPhDl1jYEiwRudw1Ki68iOfDb5nq5wA3K5JRGBDD/L+V00cMDUpT0
 K8qVxbx4aP7hqn06bFPD6bHtWjXOnSiEsZE+c55BHLpb3ZpLatjQAK7qYcgM85kjGdOqX4F5A
 aJH6qRJJMcLzY4tP7WoUUZiAj35/1QE0lmidIgzS6qFVzcoJmjOeXDjn1Hmzw9i6PGPAAHoB8
 +QYi4TiR8zNL4vOXh2LVtZxCTZrvh3ZxDKrMip1qvIGGSTDciq0IEl2D+KWdmtE3sXQRU4yqs
 gwVIm3YIVyf63I+Pz5tKGCneWJUDcusK/+r+1OOxj0jKyObUWEcakYSJC4aOh9g/oPtdl/t3j
 HtSrfYb3Z2I0WKGxqGOg1OEzAX1mVgJqZwLx8VVvA5sVRqkSuQO+cZUuDpSuK2p6U86ZBGXNj
 /lTqxlfkBDhDEYnGFaVfuQIRHvHg3twHe8Ru8z9NQgaoZ+stsL4Z/Y7CaNv0Yk787Y4cB6UCX
 wzNxty/edKPkrGBQM4zNyI61saLAe/n/wHYXGqfqHmXc82KxyplWCaoom0M+5Ec4JFVCiLqq0
 vco7JBVQp7JYStuYeD+yWW40Df6B8SDAdAHV6R7pD5FjHOrmSLGb+Y1o3br3ULnV+tGLs9/Wc
 JpnBLuUe/QAEaBlGqNEozKUWGJ1Zy9TcXelyBNQBzfUZzxuc0FvCyLFhoQkDuT6+6YJx1/VyX
 orNs2qso4xfsVrm+LGKtFGrKiFkJ0bCH3vnOZX0N2bB51BhuLyDIXquRsp5JEo+9cjrcjk6/h
 UW0/WA==

Am 21.12.23 um 03:41 schrieb Junio C Hamano:
> "git archive --list blah" should notice an extra command line
> parameter that goes unused.  Make it so.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This was done to convince myself that even though cmd_archive()
>    calls parse_options with PARSE_OPT_KEEP_UNKNOWN_OPT and then
>    uses the resulting argc/argv without apparent filtering of the
>    "--end-of-options" thing, it is correctly handling it, either
>    locally or remotely.
>
>    - locally, write_archive() uses parse_archive_args(), which calls
>      parse_options() without KEEP_UNKNOWN_OPT and "--end-of-options"
>      is handled there just fine.
>
>    - remotely, run_remote_archiver() relays the local parameters,
>      including "--end-of-options" via the "argument" packet.  Then
>      the arguments are assembled into a strvec and used by the
>      upload-archive running on the other side to spawn an
>      upload-archive--writer process with.
>      cmd_upload_archive_writer() then makes the same write_archive()
>      call; "--end-of-options" would still be in argv[] if the
>      original "git archive --remote" invocation had one, but it is
>      consumed the same way as the local case in write_archive() by
>      calling parse_archive_args().
>
>    I do not like the remote error behaviour this one adds at all.
>    Do we use a more proper mechanism to propagate a remote error
>    back for other subcommands we can reuse here?

Don't we have one?  It would affect other unsupported options as well,
and this seems to work just fine, e.g.:

   $ git archive --remote=3D. --format=3Dfoo HEAD
   remote: fatal: Unknown archive format 'foo'
   remote: git upload-archive: archiver died with error
   fatal: sent error to the client: git upload-archive: archiver died with=
 error

>
>  archive.c           |  7 +++++++
>  t/t5000-tar-tree.sh | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git c/archive.c w/archive.c
> index 9aeaf2bd87..3244e9f9f2 100644
> --- c/archive.c
> +++ w/archive.c
> @@ -641,6 +641,13 @@ static int parse_archive_args(int argc, const char =
**argv,
>  		base =3D "";
>
>  	if (list) {
> +		if (argc) {
> +			if (!is_remote)
> +				die(_("extra command line parameter '%s'"), *argv);
> +			else
> +				printf("!ERROR! extra command line parameter '%s'\n",
> +				       *argv);
> +		}

So just call die() here?

>  		for (i =3D 0; i < nr_archivers; i++)
>  			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
>  				printf("%s\n", archivers[i]->name);
> diff --git c/t/t5000-tar-tree.sh w/t/t5000-tar-tree.sh
> index 918a2fc7c6..04592f45b0 100755
> --- c/t/t5000-tar-tree.sh
> +++ w/t/t5000-tar-tree.sh
> @@ -124,6 +124,20 @@ test_expect_success 'setup' '
>  	EOF
>  '
>
> +test_expect_success '--list notices extra parameters' '
> +	test_must_fail git archive --list blah &&
> +	# NEEDSWORK: remote error does not result in non-zero
> +	# exit, which we might want to change later.
> +	git archive --remote=3D. --list blah >remote-out &&
> +	grep "!ERROR! " remote-out

... and use test_must_fail in both cases?

> +'
> +
> +test_expect_success 'end-of-options is correctly eaten' '
> +	git archive --list --end-of-options &&
> +	git archive --remote=3D. --list --end-of-options >remote-out &&
> +	! grep "!ERROR! " remote-out
> +'
> +
>  test_expect_success 'populate workdir' '
>  	mkdir a &&
>  	echo simple textfile >a/a &&
