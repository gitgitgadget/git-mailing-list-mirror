Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9017167D
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765551; cv=none; b=NngSCZXILQCvBOVLM7xtncjft6U05gireVSTh1T+N+VIoIZbEETe23R5IpVkUg6BjzHaKSHkgOIKP6SAforTpZHkdMHDlkDj5XGOXu8sSrykjUuxE/o2W8F6v13yYvn0qN3Q3ZMGPq0SXnNntHyt5pKE1qswOvtMDotyMWSBkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765551; c=relaxed/simple;
	bh=h6hdYHuV8rzA4+U+NnrMkaLwvzlJs49RSdYMokixkNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2O+SmFymAh306U2HcULxfvZ114T7yAr4tctJjZMd+FZ4uSYwyCL9O4SQ06faJrpvleVKTyO+tn6uJk+rCtHz0mzytl7xF92xGztUCUA5fe6B9TV3oeY1Zl9n+JknSTfZ2GQq3b+mECDYpKjbrhShap82BENyob4AcFrOlWEgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WXjQd+D2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WXjQd+D2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E3632F487;
	Wed, 10 Apr 2024 12:12:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h6hdYHuV8rzA4+U+NnrMkaLwvzlJs49RSdYMok
	ixkNU=; b=WXjQd+D2j9InKWcr6iCFkXeHIUqYIQxTxZkcktJjlIDHUhna24bPe6
	97JC9t8dCIH3Qusa00vu/900tVevl0SbamW4tbMz82AGe3WmFUfA2BN2c6yuZ+rS
	4wUEKOuCP862PV+JLKSEcHBflpR2HyY9llLyuL9M1vgOvfB3RsjjI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 568292F486;
	Wed, 10 Apr 2024 12:12:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24BE82F485;
	Wed, 10 Apr 2024 12:12:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v6 1/2] send-email: move newline characters out of a few
 translatable strings
In-Reply-To: <29ea3a9b07bf1aa17b5d6a1e41325379c494bcb2.1712732383.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Wed, 10 Apr 2024 09:01:29 +0200")
References: <cover.1712732383.git.dsimic@manjaro.org>
	<29ea3a9b07bf1aa17b5d6a1e41325379c494bcb2.1712732383.git.dsimic@manjaro.org>
Date: Wed, 10 Apr 2024 09:12:23 -0700
Message-ID: <xmqqr0fdw61k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E8908C2-F755-11EE-8E3D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Move the already existing newline characters out of a few translatable
> strings, to help a bit with the translation efforts.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  git-send-email.perl | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Looking good.  Thanks for spotting similar issues and fixing them at
the same time.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 821b2b3a135a..f0be4b4560f7 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1664,9 +1664,11 @@ sub send_message {
>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
>  	}
>  	if ($quiet) {
> -		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
> +		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
> +		print "\n";
>  	} else {
> -		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
> +		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
> +		print "\n";
>  		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
>  			print "Server: $smtp_server\n";
>  			print "MAIL FROM:<$raw_from>\n";
> @@ -1686,10 +1688,11 @@ sub send_message {
>  		print $header, "\n";
>  		if ($smtp) {
>  			print __("Result: "), $smtp->code, ' ',
> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
> +				($smtp->message =~ /\n([^\n]+\n)$/s);
>  		} else {
> -			print __("Result: OK\n");
> +			print __("Result: OK");
>  		}
> +		print "\n";
>  	}
>  
>  	return 1;
