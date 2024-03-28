Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D55136E13
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650762; cv=none; b=GDLwg8f4b1buKTd3QRgeDS8lLWJ5JBVgcR7RzqpAe3OyOGJYO01f/lnf6pI+6Qkm3C4f5fecR0hk+0wNAz9cZu+CvjwqOtf2tSs27LUnLQLC9ExovHpLUUSrjmEyvcwVveS+mGyV1rVblH0rKjCycHTwh+tSfmWAT31vB9iapUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650762; c=relaxed/simple;
	bh=xOgc/PHF7EmFZ+IxufaJZ8XSp9MHT3/6105Z6Xcb+iU=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NUegRKhV8tUiMebJMTJLJAtv9n1bPTmErj2kL2ggdZ/DmWFezA2tgKnZxMgxWyXI2lOxXBlSEdp1bJpg23rU7pF3UJk4v/kxZuwa81J1F+nDHekiLWl1he4wmeEvmmoCgtpOX96TgC6FLqCW9AnOI/riJii6b5LonmCt/dWJuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rC7KyDZt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rC7KyDZt"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711650757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kliu97t6o7J0+DPkPq8SpSiAMlp4EBIISj1BRRXwxO0=;
	b=rC7KyDZtO8HMAV/EqwOiKS2/AJAFjKyNgc4ooKH1kx9CqItn2eFWosTdWP3bvjjylajrgh
	uJwko9gkrU9oJKKTrBtxrzwsxzrciacKEBeTG3Hu7vTCovofhbsvoQWeIV6jz4JF+QjkWX
	sM/HOep1gp1/pP199ju3DId45QQP+Pj7aNC7yJwY0yYOvrGHSRKcSrmmyuXEzRFObwzZ2q
	gwAr1+b/ls5nhbK4B0epe5ltqMOW+fBfB2fzKhzS0y8iOA0FXVru6sfw1s7L2yxk+1D4xm
	9IlfwObQQEcD0sXsvppaotYfyum5AV3GdhzCIVA+NO4T6LwgZ39FUmHIfn61mg==
Date: Thu, 28 Mar 2024 19:32:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Subject: Re: [PATCH] send-email: add newline for improved readability
In-Reply-To: <6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org>
References: <6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org>
Message-ID: <6f2cef522326b692d7c4795dcb2676fc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-26 11:04, Dragan Simic wrote:
> When sending multiple patches at once, without confirming the sending 
> of each
> patch separately, the displayed result statuses of sending each patch 
> become
> bunched together with the messages produced for the subsequent patch.  
> This
> unnecessarily makes discerning each of the result statuses a bit 
> difficult,
> as visible in the sample output excerpt below:

Just to clarify, this isn't about making code "neater", :) but about 
making
the outputs more readable.  Perhaps the patch subject could've been 
selected
better, to be more descriptive.

> 
>     ...
>     MIME-Version: 1.0
>     Content-Transfer-Encoding: 8bit
> 
>     Result: 250
>     OK. Log says:
>     ...
> 
> Let's add a newline after each displayed result status, to make reading 
> the
> produced outputs much easier, as visible in the sample output excerpt 
> below:
> 
>     ...
>     MIME-Version: 1.0
>     Content-Transfer-Encoding: 8bit
> 
>     Result: 250
> 
>     OK. Log says:
>     ...
> 
> This change also adds a newline after the last produced result status, 
> which
> may be seen as redundant.  Though, it doesn't look too bad, and making 
> that
> last newline not displayed would make the code much more complex, which 
> would
> not be worth neither the time and effort now, nor the additional 
> maintenance
> burden in the future.
> 
> While there, remove one spotted stray newline in the code.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  git-send-email.perl | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 821b2b3a135a..62505ab2707c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1576,7 +1576,6 @@ sub send_message {
>  		print $sm "$header\n$message";
>  		close $sm or die $!;
>  	} else {
> -
>  		if (!defined $smtp_server) {
>  			die __("The required SMTP server is not properly defined.")
>  		}
> @@ -1686,9 +1685,9 @@ sub send_message {
>  		print $header, "\n";
>  		if ($smtp) {
>  			print __("Result: "), $smtp->code, ' ',
> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
> +				($smtp->message =~ /\n([^\n]+\n)$/s), "\n\n";
>  		} else {
> -			print __("Result: OK\n");
> +			print __("Result: OK\n\n");
>  		}
>  	}
