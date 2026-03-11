Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB93C661B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224689; cv=none; b=rxQVyyAKOWaQ7jccz0RbG0CZbJGSwMqsfyAIKbKSqY+qhWCMME2jOsNNO0d0V531e6AWSux9eiaekZCGbcaTI8z9YhO/p1gV1kXOlJrc9BYhccQgU+RxbmCjaE1/+KeWsfUmda0ErwMQMNAyzBW245kCWD2JEwHL+Pq7w8KmJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224689; c=relaxed/simple;
	bh=whRwJQeIkL3KT2mTGY96g1xhAYLremiBQ3gk5otZsiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE5kQm1KDegrJJDOaYN0lga2/BQvgHUCS6xUdE3hSMWH6oIyvtb+60pIOihsceXsZCgrR0u9/nuA2Ld9/o8Fdv/7p9wzPRak7iW1FPeoSJbtaFtcGKm8sWTw2tv+GLYPtAOfEV2l03gITur1Gnsv2pIBO+i5qJUMd+fGOGbYeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SvZBt34k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xrghqwhn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SvZBt34k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrghqwhn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 57C551D001CA;
	Wed, 11 Mar 2026 06:24:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 06:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773224687; x=1773311087; bh=2Bnn7g3Q9r
	FOVO4XbGdBKJwvSRLFQcy0JuvOTDSWtWE=; b=SvZBt34k1e3hpf5gPedpfT/gjl
	/KOsEiALCuazVpgwzVKvkmImF4IkwygsTO9dXiT6OdkQK6gySBCW4cgGBJVCz8Zx
	HCGYvDgMyArlv8d7v/ueAZDpw2x5IqJiAi/RxET4gPY1coMqL20KCOjjBaP+Qxe/
	ZC4aGNF1aGEtm/LNV6xvm5Oj6y4/zCbs2g5hRQjnBeRfuiVWRcj/leFheITHhftu
	27bN0RjaFQy1fNkYW4OQ7y2Ayz9DRLw47Un1HSAvrTv6ksdVH9+R2kQI36zvyCLu
	4lkN7bFlfifR+luxN7jYQz1Y3fl8Tgu3gXSiwyB+U9xRT6R96X9IkmLwO9lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773224687; x=1773311087; bh=2Bnn7g3Q9rFOVO4XbGdBKJwvSRLFQcy0Juv
	OTDSWtWE=; b=xrghqwhngUzKIL17AfW2ZBJso4h3dvE6VwdozqzbZc9mwboajuf
	5sCKvbI3V1GauxMgQWjuutwwE1LnKhpsNa4N6BAq0JdKOEMHEIjvTuEjoL0bri1g
	B92JU/eC7HaB7ojPPwOKG69wZe1+eP/LqZOfZcefcGTDZWMwpYSLGuKENqfPlEft
	lH9AaycZowYGBCuuAxWQNQtBNmoXCdT+ZdeB4/59zI+BNBXZZFJLf6ssCmQj9ecC
	UlkOacpZBlJsNX87tSyHA6rwqfc/XQDZ/TdhjLpD0FIJXxroycca3PfnR8RKuur+
	NjYyZ84zL/ZF6PSrehuaoJHbn6hjAwQHflA==
X-ME-Sender: <xms:70KxaX-mZfRyrvViM3NIVTRy8QAnIJ-i76_yRbU5sVr8WTVW9iSBqg>
    <xme:70KxaankHh1t86civetUn-qAQD6msPI8eaXvaeU-chmvJ7OJnN8lRwo1bz9WsqTW6
    WZ-jvpuo9O_KKGgxiz7-saOCXsYuaoWsShVHW53V6PRE3g5nuQ>
X-ME-Received: <xmr:70KxadXEdST6PAFVrhhrtclMoNsn7AJjL8RLoIzmpsq9wOE6c-G4nyu1_T0HN3pVRK77q3D0pZzkH4gujo5bHJG27lSDokmO6Tx54pWumQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhrrght
    ihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvth
X-ME-Proxy: <xmx:70KxafFW-QRsouMZL3wdXUaxLa9-QF4aPpZOSwH2qieS6gcfLQPnvw>
    <xmx:70KxaZdHiHsYjNxR0Wk0K4ZYrvshE9HpeoyydfKN_q9Y1RMW7DezJQ>
    <xmx:70KxaQJ_iP6HJ21GLVBndG69OMaJFO4iFb0Ip3WQfGsn8z4N_ybvfA>
    <xmx:70KxaeEnSyo-aE7s1eL0pEcKZjCcH9BkCnN4ZMei0GQJANxvhGGSbQ>
    <xmx:70KxaYY9q7ASZiJ6l_-SpzoEg2_cRctO97RzB25V666Av9ByBoLOeZwA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 06:24:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f5557a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 10:24:45 +0000 (UTC)
Date: Wed, 11 Mar 2026 11:24:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 10/10] hook: show disabled hooks in "git hook list"
Message-ID: <abFC6pEEmicjG6a9@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-11-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309005416.2760030-11-adrian.ratiu@collabora.com>

On Mon, Mar 09, 2026 at 02:54:16AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/hook.c b/builtin/hook.c
> index c806640361..ff446948fa 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -72,16 +72,20 @@ static int list(int argc, const char **argv, const char *prefix,
>  		case HOOK_TRADITIONAL:
>  			printf("%s%c", _("hook from hookdir"), line_terminator);
>  			break;
> -		case HOOK_CONFIGURED:
> -			if (show_scope)
> -				printf("%s (%s)%c",
> -				       h->u.configured.friendly_name,
> -				       config_scope_name(h->u.configured.scope),
> +		case HOOK_CONFIGURED: {
> +			const char *name = h->u.configured.friendly_name;
> +			const char *scope = show_scope ?
> +				config_scope_name(h->u.configured.scope) : NULL;
> +			if (scope)
> +				printf("%s (%s%s)%c", name, scope,
> +				       h->u.configured.disabled ? ", disabled" : "",
>  				       line_terminator);
> +			else if (h->u.configured.disabled)
> +				printf("%s (disabled)%c", name, line_terminator);
>  			else
> -				printf("%s%c", h->u.configured.friendly_name,
> -				       line_terminator);
> +				printf("%s%c", name, line_terminator);
>  			break;
> +		}
>  		default:
>  			BUG("unknown hook kind");
>  		}

Hm. This starts to feel less and less like an interface that can easily
be parsed by a machine, even with "-z". I guess this partly comes from
our insistence to reinvent the wheel in Git instead of just using
something like JSON :/

> diff --git a/hook.c b/hook.c
> index 2c03baeaac..4f4f060156 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -119,6 +119,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>  struct hook_config_cache_entry {
>  	char *command;
>  	enum config_scope scope;
> +	int disabled;
>  };
>  
>  /*

Is there any reason this is an `int` and not a `bool`?

> @@ -217,8 +218,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
>   * every item's string is the hook's friendly-name and its util pointer is
>   * a hook_config_cache_entry. All strings are owned by the map.
>   *
> - * Disabled hooks and hooks missing a command are already filtered out at
> - * parse time, so callers can iterate the list directly.
> + * Disabled hooks are kept in the cache with entry->disabled set, so that
> + * "git hook list" can display them. Hooks missing a command are filtered
> + * out at build time; if a disabled hook has no command it is silently

What exactly does "build time" refer to? To me this reads like invoking
make :)

> + * skipped rather than triggering a fatal error.
>   */
>  void hook_cache_clear(struct hook_config_cache *cache)
>  {
> @@ -268,21 +271,26 @@ static void build_hook_config_map(struct repository *r,
>  			struct hook_config_cache_entry *entry;
>  			char *command;
>  
> -			/* filter out disabled hooks */
> -			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
> -							hname))
> -				continue;
> +			int is_disabled =
> +				!!unsorted_string_list_lookup(
> +					&cb_data.disabled_hooks, hname);
>  
>  			command = strmap_get(&cb_data.commands, hname);
> -			if (!command)
> -				die(_("'hook.%s.command' must be configured or "
> -				      "'hook.%s.event' must be removed;"
> -				      " aborting."), hname, hname);
> +			if (!command) {
> +				if (is_disabled)
> +					warning(_("disabled hook '%s' has no "
> +						  "command configured"), hname);
> +				else
> +					die(_("'hook.%s.command' must be configured or "
> +					      "'hook.%s.event' must be removed;"
> +					      " aborting."), hname, hname);
> +			}
>  
>  			/* util stores a cache entry; owned by the cache. */
>  			CALLOC_ARRAY(entry, 1);
> -			entry->command = xstrdup(command);
> +			entry->command = command ? xstrdup(command) : NULL;

You can use `xstrdup_or_null()` here.

>  			entry->scope = scope;
> +			entry->disabled = is_disabled;
>  			string_list_append(hooks, hname)->util = entry;
>  		}
>  
> @@ -401,7 +411,16 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
>  int hook_exists(struct repository *r, const char *name)
>  {
>  	struct string_list *hooks = list_hooks(r, name, NULL);
> -	int exists = hooks->nr > 0;
> +	int exists = 0;
> +
> +	for (size_t i = 0; i < hooks->nr; i++) {
> +		struct hook *h = hooks->items[i].util;
> +		if (h->kind == HOOK_TRADITIONAL ||
> +		    !h->u.configured.disabled) {

Is the first condition required? I would expect that `disabled` would
always be false for traditional hooks.

> +			exists = 1;
> +			break;
> +		}
> +	}
>  	string_list_clear_func(hooks, hook_free);
>  	free(hooks);
>  	return exists;
> diff --git a/hook.h b/hook.h
> index 0d711ed21a..0432df963f 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -31,6 +31,7 @@ struct hook {
>  			const char *friendly_name;
>  			const char *command;
>  			enum config_scope scope;
> +			int disabled;
>  		} configured;
>  	} u;
>  

Same question here regarding the type of the struct member.

Patrick
