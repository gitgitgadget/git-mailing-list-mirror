Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624061;
	b=L7EJZlkprwOhSG7fVUZX/TRwEt/cUlizkN2/3b/8bru7owsi3nyq+T9EUQ/PZLSwaDNF
	 3KuiUHXinnc/mUT8DyhTTC+hUTkqbmdPhReN3mOodZxmg5X5bnT+72YiaahsLDP99Y4Sb
	 0+COeuaUdejgVvVx8PPa6qJySHZAXozaq9VdXiZn7dnOqcICzqtXjLhwK5PvhMOQCln2a
	 d9hDXjoHrMLM86DLYs6qSRYgPIzp3X6pOPVyvnp2McHYqhbbzDqgnMF183fDQ02ZxVj/6
	 f4rYM1OU6L01j+q8pXmpAEy1L+XV5jWLGj9OddUnyv4M42v76a5NLVA7gwuzlVWOKBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i7V3z3yAHU8bd12iRL3ed1ewrTMkxv5znPhNMWvOJKQ=;
	b=Bl1rYI5u8c1K4oj5uyjbGBbH7KJsGlu7OAFyKp+cOgg1ikrgDMVQVSl7ZV2EN9lSlHu+
	 pXWiyGlssIjlLCbr8mrL9CJhOFheEYRNhu5loklbWfyjcOt8vpj9C7+s7nCPmm35jj44l
	 TCudxGptcGnbFlxloa94AhPpKBsi4XS9diK0vqcwveXC2l6qXBZK1CPiuNpDQb/lxQhGj
	 Rtr9W5muj3KUM3MPtPOvN8U681u7mp00UO6UO7AFMr0mhaZkXWbLwGLw9rgQzG0uZeZjQ
	 VU4msDnO8y+JFzWeOc2VJBRIcg3483YmGTrJYgNhyCTL9xy1dsYoGBaXD0jF99J1jLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EE+ZtzaV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b5PKvaQX;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14A606A329
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 16:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC14A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EE+ZtzaV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b5PKvaQX
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AF656EC0B40
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:27:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Nov 2026 11:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795624059;
	 x=1795710459; bh=i7V3z3yAHU8bd12iRL3ed1ewrTMkxv5znPhNMWvOJKQ=; b=
	EE+ZtzaVwk7fQ5P8mF6duWhTfEQUSeL8F+8oWnAdgnUMsV6+HjDFqXOBWk9WhxpX
	1wz7/go/YZlr3+6qwEjrOG+2EUt458OtWYE7d+7LsLDMGxsNayJYNyUc9C/4hOXY
	1zuU9uIIn45XZh5tQjVfyBkwmltxHFPUJCm0/Qm7MQ4Flnz0KArykedyzwEdzrfb
	ljdPqTPyePMuxP8EQjH8hoD9DHhs7nfBt/hb74wXwEfWUVxWlq/ZqteKddYSTFsB
	dltXB585ie9j+qOYj1Yshjb9hThaBbgEPHwrroZc0DzjyR81nFMdECLrRDumYphm
	gC1CUNytMe3xFCmduNlC1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795624059; x=
	1795710459; bh=i7V3z3yAHU8bd12iRL3ed1ewrTMkxv5znPhNMWvOJKQ=; b=b
	5PKvaQXKGJsY1o6I+6XDz5hkAmzzjSeWixmGlruleIdcKY3mhvPk/c7qNO6cb5t5
	mIfvJHWajk+UI39S8iIrHwl5Nz9HUnQBYcVptJ7pzFFgw/0QFjcEqUmyahzFJalW
	CP3tuwf59l7Od7+0u/HH8W7EdhlKcCtiGjOOYp87gK/ry8szQ9qBVFd1fHLipB3h
	/03GNz5HwVFoUzEfqlu6RFj2BhvvVmI1VsT3C4yoebRGiE2S5NU7hY2351VMnlHg
	zZ3IUTgninPGWdEVuQ/QUACVmVtlx5ynUrwJRtgyH67Z0bsy+iVbZLz+uQs24TXB
	elO81JDkoe8JTcFktq51Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795624059; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:G4UycY2zFyGBEwLBZ16hnx1Tw0SH7jOqbgEq5lcPY3DZ4FL
	4pY78Ty0peU4OOv8XRHU9MtId2TEUt1HwEtLpVYlqfBDFy+a/jY4c2/FbbRiWs1D
	CDJH0/hf1tpYpQQeWdE03RuIW7xytP6czznTp2h9HGdzTwKZGIvY9rpTGm/uzWu4
	+YdiKuQKz2uvxqTr4XMfy4I3AfWs1bmFOfHR4Ri+QIzP0T/9uENM221CNqoxg1Vt
	2CVF0v+hp82zSxDnAGExOE6JvZmB8DnJiyh/8RIlTeo1kVUUtH1A0t8T5wy2HBoK
	UD3O0joYvzoE3SCzUQ4da+/A22ct0zWgYEsaOkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:QQFqV3fpSgvUEWGPlv021IJs5W2d11csPmVr+xPzcFM=:FqctsgcJ1qPMaqt3Rm1nlgKxBOdox2P21AIVKzS3ckk=;
X-ME-Sender: <xms:ewwHa9Lys_gvv_CfEb3BN2PlleX1L20NYM4_nxSnsRDucl6xKeb25Q>
    <xme:ewwHawLQjekSt7bLWHo6ocLhw24TcPj7DduQ22NBK0cyKX-6ZfehlPGy-hAyG8WRN
    N6CQTVeY3I66bIQDKTtWCqsci03-aZLqSGyQhr2pKeWfWxLpJjnqQ>
X-ME-Received: <xmr:ewwHa6tqBcbgVpytuIWWoVxuYYyEUBJOevt9WI-1OAw5scq9um9cHqKAnVGTTD5XYnRxLm8USAQD9E09aiqZH73PlDr6GQeB8lhrS8M>
X-ME-Proxy-Cause: dmFkZTEH8o8sjUdmc55tznRNBEtT0CnG4JFlk0p3c6nLupzsINmGG1oKWKEKBNp4d8UOrG
    YsIXuuxKPmvEPULxR32pVcMER5HsfZQPMZV01ftcdaUZcBqvCA1Ei8XTDLWsyQx1xPUNkA
    zIrfGneI9C94F3TjwKlQNq5v2hfTuYzv2WTFGdPq7cOvQLPtjEhK1YaYpu811N6dMSSmIA
    +YkbJ46Woy381WcoalnXg8qfKauWdbwNwqvAV8hfrbxg7f08hWz3uEwOxB6VjiMV0bjV+Z
    IGN8bspA5Gq9i+RXGPhOsnwbcP1IpgkztLhfjpUcm+SZ2ym3DAwO6QdaQJkAKKu9WNw8sL
    hZbAqSovVJ/s7hfEvXSsi+fJk7h9WIZEZ9jI2ycypCWZB7y94CIltI7NghaZMkpu177hl8
    j1DBzyBFdXaaP3polYrNcnifj/Gb7PZPCrAhXvRojLemEr/lmJaP16dbxv8kY5FKWRE2Rm
    JON4FpnkKxXZobuxv7sqDjURDCo95jSnoNViX02J25l00antWzjNwWam2ZvaJjfmcECusg
    fosdyZFEpplyaB7t+6KgvtCZNCoFAu8VijZst3MVALoDdXWyDBFC/jhdNTYMoZMgWjr5RH
    h0njRd1Z2zuCfbhR/NgB8mUEewF0zXKWyJPc39i96opCdCoPRxh3Wlv4lpzg
X-ME-Proxy: <xmx:ewwHa9Qa6KZW3Sp_tg3SwvW23fa9pq3Kwdmnw6o4x66EO4iFc3dhHQ>
    <xmx:ewwHawMan9mLp79FiXZ0zclcmbiwobjzHvnjjPTkAFjBFH6NOXRVJg>
    <xmx:ewwHayYTd30wYi49KImnUBq1YnHFCA2uzvHTxxucDbDzzUaKCMQTuQ>
    <xmx:ewwHa6xe2olL_r6tVE5f62NOSzXYoYH56nx4zo1ZHytgdp41IRNKxA>
    <xmx:ewwHazuZT4-Cw7hv469s1zDombsNcyNTlLOhOoacsN1si6YGCGJW5dbZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 11:27:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/4] doc: apply synopsis style conversion with git-svn
In-Reply-To: <7d5ab0faa0ac5c2c0c97090ff17999cdcadaad55.1795556940.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 24 Nov 2026
	21:48:57 +0000")
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
	<7d5ab0faa0ac5c2c0c97090ff17999cdcadaad55.1795556940.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 08:27:38 -0800
Message-ID: <xmqqv75k98qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -'rebase'::
> -	This fetches revisions from the SVN parent of the current HEAD
> +`rebase`::
> +	Fetch revisions from the SVN parent of the current HEAD
>  	and rebases the current (uncommitted to SVN) work against it.

Changing "This fetches" to imperative "Fetch" makes the verb on the next
line disagree ("Fetch ... and rebases").  Changing "rebases" to "rebase"
fixes that.

> -[verse]
> +[synopsis]
>  config key: svn-remote.<name>.commiturl
>  config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
>  +

The [synopsis] attribute makes the AsciiDoc/Asciidoctor filter highlight
command tokens inside the block, so prose words like "config", "key:",
"overwrites", "all", and "options" end up rendered as literal code.
Elsewhere in this patch you removed [verse] and backtick-quoted the key
instead, e.g.,

    config key: `svn.rmdir`

Doing the same here and in the svn.pushmergeinfo entry under --mergeinfo
would keep the rendering clean and consistent, wouldn't it?

> --F <filename>;;
> ---file=<filename>;;
> -	Take the commit message from the given file. This option
> +`-F <filename>`;;
> +`--file=<filename>`;;
> +	Take the commit message from the file `<filename>`. This option
>  	disables the `--edit` option.

A few days ago I was referring somebody else to your earlier series [*]
and noticed that you would have said _<filename>_ not `<filename>` in
running text.  I am not quite sure about the differences, but as I
noticed the use of `<filename>` here,...

	[*] e9a99ef2da (doc: convert git-format-patch synopsis and
	options to new style, 2026-07-23), appearing as a part of
	bf6bc2ae42 (Merge branch 'ja/doc-synopsis-style-yet-more',
	2026-08-11)

> +`-r <arg>`::
> +`--revision <arg>`::
> +	Fetch the given revision range for partial/cauterized history.
> +	Only used with the `fetch` command.
>  +
> -This allows revision ranges for partial/cauterized history
> -to be supported.  $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
> -$NUMBER:HEAD, and BASE:$NUMBER are all supported.
> +`<rev-num>`, `<ref-num-1>:<rev-num-2>` (numeric ranges),
> +`<rev-num>:HEAD`, and `BASE:<rev-num>` are all supported.

Shouldn't the left hand side of ':' be <rev-num-1> instead of ref-num-1?

> ---authors-prog=<filename>::
> -	If this option is specified, for each SVN committer name that
> -	does not exist in the authors file, the given file is executed
> -	with the committer name as the first argument.  The program is
> -	expected to return a single line of the form "Name <email>" or
> +`--authors-prog=<program>`::
> +	Execute `<program>` for each SVN committer name that
> +	does not exist in the authors file, with the committer name as the
> +	first argument.  The program is
> +	expected to return a single line of the form "Name _<email>_" or
>  	"Name <>", which will be treated as if included in the authors

The reference to author ident "Name _<email>_" or "Name <>" differs from
the backticked "Name <email>" form used in patch 2/4.  Not clear to me
which one we want to standardize on.

>  	file.
>  +
> -Due to historical reasons a relative 'filename' is first searched
> -relative to the current directory for 'init' and 'clone' and relative
> -to the root of the working tree for 'fetch'. If 'filename' is
> -not found, it is searched like any other command in '$PATH'.
> +Due to historical reasons a relative `filename` is first searched
> +relative to the current directory for `init` and `clone` and relative
> +to the root of the working tree for `fetch`. If `filename` is
> +not found, it is searched like any other command in `$PATH`.

The same comment on `<program>` in the first sentence (vs _<program>_).

Because the option parameter was renamed from <filename> to <program>,
the second paragraph now refers to a filename that is no longer in the
option header.  SHouldn't it be "a relative _<filename>_ is first ..."?

Thanks.

