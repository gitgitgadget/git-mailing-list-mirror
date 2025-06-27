Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27B1DE2D7
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050440; cv=none; b=Ybg87vNZVMCCdTbaXwrr5jniZ5Uk2SptWsoA6mBeZDXUWk8nVaXZNzbK+uTTyOOPiMr9pL/ZpJlXAng/DfM3IN6JMfMrCnCwK3ankwxpcurPulo6F5zoAI0zWVmB8r0xj4+iSUO+3yKzX841GK+aJZfUcsGwYgpgZ81wc2oMsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050440; c=relaxed/simple;
	bh=a9tcikyR+0mvK89ZYqs/cfRt9HeBrz+Yv5ioRSaxgoI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WEVVQ8LDkOm7wCBZDdc4ZAfPSgjkaECnE/3okjf4MMHia6/0ojV7lO4KUFU8t3mRRMFIulO1F34fRBnZtS0ZqC5gEZIMSilRedhhD0G9DEEjSWH48BfkqrZT9PsnlGUx0hm5XzayBP0hg97oUS7ry5yXhs9Uh/9KLggISEZzq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=dFa6QoKF; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="dFa6QoKF"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 667F44292CC
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 20:48:09 +0200 (CEST)
Received: from [IPV6:2a01:e0a:d1:f360:8a25:727a:25ef:a4a3] (unknown [IPv6:2a01:e0a:d1:f360:8a25:727a:25ef:a4a3])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 868612003DD;
	Fri, 27 Jun 2025 20:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1751050081;
	bh=a9tcikyR+0mvK89ZYqs/cfRt9HeBrz+Yv5ioRSaxgoI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dFa6QoKFOERnGi4ZSjHh2MlNUWLOiCBGWgy/eY8QNi38f+Xw2AJ2JtvK9i24QtdYY
	 G2NNymFbNSqFtntEuj24xw1SIQGyXkVyUpZ4BoGBK/bAI3xsZOTp2ta6xXnzt00aVn
	 LL2JONeq35F7sq6GEItysKX9cDUMm47vHJ9pB5mQ6MQ13yjd+oQZzvGmmh6JFo/oFG
	 HMkQuN24JYUh+3XEcGbiVAI8V9FuKdQ0jy2BAnThLnQx4w3VAjpP0cx70Jja/zH3Fd
	 8wPlCG1h35jHI7uBVhMtKKF5Zf9dkwDr70S0dKBSzgWLfkdr2L4LWAcZvsdtcCZFYW
	 CiffAuVI2ULCw==
Message-ID: <c49d73de-568a-4584-aa8f-9a9ffd68e4ce@free.fr>
Date: Fri, 27 Jun 2025 20:47:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: Re: [PATCH v5 2/5] promisor-remote: allow a server to advertise more
 fields
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Christian Couder <chriscool@tuxfamily.org>
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250625125055.1375596-3-christian.couder@gmail.com>
Content-Language: fr
In-Reply-To: <20250625125055.1375596-3-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 25/06/2025 à 14:50, Christian Couder a écrit :
> For now the "promisor-remote" protocol capability can only pass "name"
> and "url" information from a server to a client in the form
> "name=<remote_name>,url=<remote_url>".
> 
> Let's make it possible to pass more information by introducing a new
> "promisor.sendFields" configuration variable. This variable should
> contain a comma or space separated list of field names that will be
> looked up in the configuration of the remote on the server to find the
> values that will be passed to the client.
> 
> Only a set of predefined fields are allowed. The only fields in this
> set are "partialCloneFilter" and "token". The "partialCloneFilter"
> field specifies the filter definition used by the promisor remote,
> and the "token" field can provide an authentication credential for
> accessing it.
> 
> For example, if "promisor.sendFields" is set to "partialCloneFilter",
> and the server has the "remote.<name>.partialCloneFilter" config
> variable set to a value for a remote, then that value will be passed
> in the form "partialCloneFilter=<value>" after the "name" and "url"
> fields.
> 
> A following commit will allow the client to use the information to
> decide if it accepts the remote or not. For now the client doesn't do
> anything with the additional information it receives.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/promisor.adoc    |  22 +++++
>  Documentation/gitprotocol-v2.adoc     |  59 +++++++++---
>  promisor-remote.c                     | 134 ++++++++++++++++++++++++--
>  t/t5710-promisor-remote-capability.sh |  31 ++++++
>  4 files changed, 221 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 2638b01f83..beb8f65518 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -9,6 +9,28 @@ promisor.advertise::
>  	"false", which means the "promisor-remote" capability is not
>  	advertised.
>  
> +promisor.sendFields::
> +	A comma or space separated list of additional remote related
> +	field names. A server will send these field names and the
> +	associated field values from its configuration when
> +	advertising its promisor remotes using the "promisor-remote"
> +	capability, see linkgit:gitprotocol-v2[5]. Currently, only the
> +	"partialCloneFilter" and "token" field names are supported.
> ++
> +* "partialCloneFilter": contains the partial clone filter
> +  used for the remote.
> ++
> +* "token": contains an authentication token for the remote.
> ++

This kind of text structure calls a description list instead and you can
already use backquotes:

`partialCloneFilter`:: contains the partial clone filter
> +  used for the remote.
> ++
> +`token`:: contains an authentication token for the remote.

> +When a field name is part of this list and a corresponding
> +"remote.foo.<field name>" config variable is set on the server to a

Please no space in placeholders: <field-name>

> +non-empty value, then the field name and value will be sent when
> +advertising the promisor remote "foo".
> ++
> +This list has no effect unless the "promisor.advertise" config
> +variable is set to "true", and the "name" and "url" fields are always
> +advertised regardless of this setting.
> +

More generally, I am a bit annoyed by the usage of the "will" auxiliary
when not expressing a true future. For an international audience, this
can be misleading. The plain language[1] philosophy mandates to not use
auxiliaries other than where they are required (no convoluted sentences).

Would it make sense to start a style guide to help writing consistent
documentation that targets people whose first language is not English?
Being an non native speaker, I often find our docs too literate, with
lengthy sentences.

[1] https://en.wikipedia.org/wiki/Plain_language

>  promisor.acceptFromServer::
>  	If set to "all", a client will accept all the promisor remotes
>  	a server might advertise using the "promisor-remote"
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 9a57005d77..0583fafa09 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -785,33 +785,59 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> -promisor-remote=<pr-infos>
> +promisor-remote=<pr-info>
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~

Be careful to adjust the length of the underline to the one of the title

>  
>  The server may advertise some promisor remotes it is using or knows
 >  about to a client which may want to use them as its promisor
remotes,> -instead of this repository. In this case <pr-infos> should be
of the
> +instead of this repository. In this case <pr-info> should be of the
>  form:
>  
> -	pr-infos = pr-info | pr-infos ";" pr-info
> +	pr-info = pr-fields | pr-info ";" pr-info
>  
> -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +	pr-fields = field-name "=" field-value | pr-fields "," pr-fields
>  
> -where `pr-name` is the urlencoded name of a promisor remote, and
> -`pr-url` the urlencoded URL of that promisor remote.
> +where all the `field-name` and `field-value` in a given `pr-fields`
> +are field names and values related to a single promisor remote.
>  
> -In this case, if the client decides to use one or more promisor
> -remotes the server advertised, it can reply with
> -"promisor-remote=<pr-names>" where <pr-names> should be of the form:
> +The server MUST advertise at least the "name" and "url" field names
> +along with the associated field values, which are the name of a valid
> +remote and its URL, in each `pr-fields`. The "name" and "url" fields
> +MUST appear first in each pr-fields, in that order.
>  
> -	pr-names = pr-name | pr-names ";" pr-name
> +After these mandatory fields, the server MAY advertise the following
> +optional fields in any order:
> +
> +- "partialCloneFilter": The filter specification used by the remote.
> +Clients can use this to determine if the remote's filtering strategy
> +is compatible with their needs (e.g., checking if both use "blob:none").
> +It corresponds to the "remote.<name>.partialCloneFilter" config setting.
> +
> +- "token": An authentication token that clients can use when
> +connecting to the remote. It corresponds to the "remote.<name>.token"
> +config setting.
> +

This list can be turned into a description list.

> +No other fields are defined by the protocol at this time. Clients MUST
> +ignore fields they don't recognize to allow for future protocol
> +extensions.
> +
> +For now, the client can only use information transmitted through these
> +fields to decide if it accepts the advertised promisor remote. In the
> +future that information might be used for other purposes though.
> +
> +Field values MUST be urlencoded.
> +
> +If the client decides to use one or more promisor remotes the server
> +advertised, it can reply with "promisor-remote=<pr-names>" where
> +<pr-names> should be of the form:
> +
> +	pr-names = pr-name | pr-names ";" pr-names

Here the syntax used is not compatible with synopsis. Would it make
sense to uniformize it, or is BNF ok?

>  
>  where `pr-name` is the urlencoded name of a promisor remote the server
>  advertised and the client accepts.
>  
> -Note that, everywhere in this document, `pr-name` MUST be a valid
> -remote name, and the ';' and ',' characters MUST be encoded if they
> -appear in `pr-name` or `pr-url`.
> +Note that, everywhere in this document, the ';' and ',' characters
> +MUST be encoded if they appear in `pr-name` or `field-value`.
>  
>  If the server doesn't know any promisor remote that could be good for
>  a client to use, or prefers a client not to use any promisor remote it
> @@ -822,9 +848,10 @@ In this case, or if the client doesn't want to use any promisor remote
>  the server advertised, the client shouldn't advertise the
>  "promisor-remote" capability at all in its reply.
>  
> -The "promisor.advertise" and "promisor.acceptFromServer" configuration
> -options can be used on the server and client side to control what they
> -advertise or accept respectively. See the documentation of these
> +On the server side, the "promisor.advertise" and "promisor.sendFields"
> +configuration options can be used to control what it advertises. On
> +the client side, the "promisor.acceptFromServer" configuration option
> +can be used to control what it accepts. See the documentation of these
>  configuration options for more information.
>  
Thanks

Jean-Noël

