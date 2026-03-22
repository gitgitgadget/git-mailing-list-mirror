Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FA1B4156
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199919; cv=none; b=fzgPjZ0PFmrl8DAGhNsSPSK1s9dCKMSOJ+eXrfKkqgEf25UfbdysqzSMBPfV2yuUM29uDW9H3xqmMORghmeu1sSEyimTOWxw8rZTv1GcVOEZkm9V4YBCJjVBriMtWpH4QJyLiJrYU0vqs+GuKRAXbb8DuOwvtvhnpw2Am/fHEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199919; c=relaxed/simple;
	bh=cwGDo5ovVJuUpHyTploEPwjMAf0JaqXkk/YfiuqvrSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpSNovotE8f9+Lsn3agaXGzwwDlrTUIHvealFT2Y5Iw/knxxoPOn8lIGRer2dhQvAVq5FF3PaQ2fCKl+EYsajEbvr/abzJOLsaLdcOB8XkHCgdoyRJYw9OK4wSJFNju15zIPRfX1RB4zxD37gRoCZJ4UQhMjB9V0gVj9z+JTX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=fhlZ0qa3; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NysrkxWN; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="fhlZ0qa3";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NysrkxWN"
DKIM-Signature: a=rsa-sha256; b=fhlZ0qa3fytH5TUAtzFI4tLWHw/Ud7vUX0xqJyaEQ7IkhFPlkYhaEmqw/PJ9vTWnw8iiu5RGaHybc1pbCe/LHXj/w0Ex+X9Lpe0oQ4CVUkDGDfEjeO5sAZOdNnGRfuGGBTxdmfVS2xmKDMyutUjaewqusuOgG+K/5+i9u+hHAujKtvEl2OYU7ApQnZfipFrzbpkvfMw8zGo2lEg57sO0Wqrqb7vCHyAbOmEEgxhOmJk9gnMteDDYo/4YioyzybLSr/3NqG2pBDq24oJ6b6L3erNUURpBJOXmFOyJvQ6I6JsXHfqA7wjysTex6U6xtErKLSqHYnN8xzlsKP3OytUgzw==; s=purelymail3; d=malon.dev; v=1; bh=cwGDo5ovVJuUpHyTploEPwjMAf0JaqXkk/YfiuqvrSY=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=NysrkxWN/B9L1QWObMC9E4lHpJLI6XnLCXS6gZC883YbqL528PITzYNbuuhXpr+hoarWVCWj5w7JDa/v9rchN0fdxBnHuBKjWWWubPiar9h7P5tf/XY7fr3O85bbwT7PEc9aaZMCaquhD6V95qY///dqdQcr6npqCcARUwk6iNiKu3z9K1hN7TIIOSf/CKbyahJP99djzZvd0X+KKIpKQw7eMEbZ8rAe/ppH9jLi1xrwU8GoeqrgkaRc/81vT75dd3SXaDw6FAHu9s4+mq+EpJECM/2T9E2LPvGu4DcfV62lLfvVE8uRnp8WCCGv4ep9933umVjAaUemQ2NFqmzrig==; s=purelymail3; d=purelymail.com; v=1; bh=cwGDo5ovVJuUpHyTploEPwjMAf0JaqXkk/YfiuqvrSY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 209374793;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 22 Mar 2026 17:18:33 +0000 (UTC)
Message-ID: <9d3633e4-6413-4932-a29d-e0347546ede8@malon.dev>
Date: Mon, 23 Mar 2026 01:18:30 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] diff-highlight: fetch all config with one process
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004856.GH3654226@coredump.intra.peff.net>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260320004856.GH3654226@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

On 3/20/26 08:48, Jeff King wrote:
> When diff-highlight was written, there was no way to fetch multiple
> config keys _and_ have them interpreted as colors. So we were stuck
> with either invoking git-config once for each config key, or fetching
> them all and converting human-readable color names into ANSI codes
> ourselves.
> 
> I chose the former, but it means that diff-highlight kicks off 6
> git-config processes (even if you haven't configured anything, it has to
> check each one).
> 
> But since Git 2.18.0, we can do:
> 
>     git config --type=color --get-regexp=^color\.diff-highlight\.
> 
> to get all of them in one shot.
> 
> Note that any callers which pass in colors directly to the module via
> @OLD_HIGHLIGHT and @NEW_HIGHLIGHT (like diff-so-fancy plans to do) are
> unaffected; those colors suppress any config lookup we'd do ourselves.
> 
> You can see the effect like:
> 
>    # diff-highlight suppresses git-config's stderr, so dump
>    # trace through descriptor 3
>    git show d1f33c753d | GIT_TRACE=3 diff-highlight 3>&2 >/dev/null
> 
> which drops from 6 lines down to 1.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   contrib/diff-highlight/DiffHighlight.pm | 26 ++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index 96369eadf9..a22ba7a851 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -131,8 +131,20 @@ sub highlight_stdin {
>   # of it being used in other settings. Let's handle our own
>   # fallback, which means we will work even if git can't be run.
>   sub color_config {
> +	our $cached_config;
>   	my ($key, $default) = @_;

$key...

> -	my $s = `git config --get-color $key 2>$NULL`;
> +
> +	if (!defined $cached_config) {
> +		$cached_config = {};
> +		my $data = `git config --type=color --get-regexp '^color\.diff-highlight\.' 2>$NULL`;
> +		for my $line (split /\n/, $data) {
> +			my ($key, $color) = split ' ', $line, 2;

...another $key. I think it would be better to change the name here. 
What do you think?

> +			$key =~ s/^color\.diff-highlight\.// or next;
> +			$cached_config->{$key} = $color;
> +		}
> +	}
> +

...

> +	my $s = $cached_config->{$key};
>   	return length($s) ? $s : $default;
>   }
>  

Something doesn't feel quite right here.

If the user has not configured color.diff-highlight.*, the expression 
git config --type=color --get-regexp=^color\.diff-highlight\. will not 
find a match and should not output anything. In this case, 
%cached_config->{$key} becomes undef, length() returns 0, and a warning 
is issued.

But we have "use warnings FATAL => 'all'". This situation will result in 
a fatal error, which I don't think is what we want.


> @@ -172,16 +184,16 @@ sub load_color_config {
>   	# always be set if you want highlighting to do anything.
>   	if (!defined $OLD_HIGHLIGHT[1]) {
>   		@OLD_HIGHLIGHT = (
> -			color_config('color.diff-highlight.oldnormal'),
> -			color_config('color.diff-highlight.oldhighlight', "\x1b[7m"),
> -			color_config('color.diff-highlight.oldreset', "\x1b[27m")
> +			color_config('oldnormal'),
> +			color_config('oldhighlight', "\x1b[7m"),
> +			color_config('oldreset', "\x1b[27m")
>   		);
>   	}
>   	if (!defined $NEW_HIGHLIGHT[1]) {
>   		@NEW_HIGHLIGHT = (
> -			color_config('color.diff-highlight.newnormal', $OLD_HIGHLIGHT[0]),
> -			color_config('color.diff-highlight.newhighlight', $OLD_HIGHLIGHT[1]),
> -			color_config('color.diff-highlight.newreset', $OLD_HIGHLIGHT[2])
> +			color_config('newnormal', $OLD_HIGHLIGHT[0]),
> +			color_config('newhighlight', $OLD_HIGHLIGHT[1]),
> +			color_config('newreset', $OLD_HIGHLIGHT[2])
>   		);
>   	};
>   }

Regards,

Yuchen

