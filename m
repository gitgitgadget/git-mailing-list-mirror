Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D313D502
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472466; cv=none; b=YOe/djY0CNnWHT2czRmX+SuUFl+/RK9YrVkF2IiKn/JcxtikeBEkugosR8rk8NTm2O5bffs/4kcxRvrWwzYCkl2vgqXTAc/NwJiRriAWmTN+KNLV6MBT8jMeK1O/O2Y9cuBJVJT1xU+44qVQc6kZ4yBnSpIlUgBV2T5pu23kt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472466; c=relaxed/simple;
	bh=dQClXk2Zu+Wnvj5r41qqfb37ySH1COhyj48DZCc2iaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJynYGM626S2F3WGEwWogltUZVMBOvS5Gve3+0m0h35b7eBRzam2h4xHZVY+Kz/f4JOPTWL28Kc3vdFk0ubvtuaAQrirQX2Jr+Z3AsA/PhQYWwUJITa8YlDKhHfIHQt4kENxCtwJQu9i3UwIgGWn5keWFdLEAosGtlGB6LC3TGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jjgvaDVT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jjgvaDVT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D822837AFA;
	Tue, 26 Mar 2024 13:01:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dQClXk2Zu+Wnvj5r41qqfb37ySH1COhyj48DZC
	c2iaU=; b=jjgvaDVTzdLnCe/Mhj00/IZpx817/T7rZVoOnDA9xb1l5/Rsj8nSiH
	Dcq7s6wmtnY7zJmguEAEsJmsHYq7SpMmF6Vz7VQ+YG6bEVsPiWRixuiSKK8h1fOG
	f7xXmHKNpPZCQPHUkuv44Sen914GOMG+v7fBisICy4yPWEpdD+rTg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CFE1637AF9;
	Tue, 26 Mar 2024 13:01:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50B0537AF5;
	Tue, 26 Mar 2024 13:00:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v4 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <20240326130902.7111-5-dirk@gouders.net> (Dirk Gouders's message
	of "Tue, 26 Mar 2024 14:08:39 +0100")
References: <cover.1711368498.git.dirk@gouders.net>
	<20240326130902.7111-5-dirk@gouders.net>
Date: Tue, 26 Mar 2024 10:00:56 -0700
Message-ID: <xmqqo7b1apx3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6ABB3A54-EB92-11EE-8EAE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index a06c712e46..6901561263 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -754,10 +754,12 @@ points to the same tree object as its grandparent.)
>  === Counting Omitted Objects
>  
>  We also have the capability to enumerate all objects which were omitted by a
> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
> -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
> -object walk does not perform any better than an unfiltered object walk; all
> -reachable objects are walked in order to populate the list.
> +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
> +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
> +able to populate an `omitted` list.  This list of filtered objects may have
> +performance implications, however, because despite filtering objects, the possibly
> +much larger set of all reachable objects must be processed in order to
> +populate that list.

It may be just me not reading what is obvious to everybody else
clearly, in which case I am happy to take the above text as-is, but
the updated text that says a "list" may have "performance
implications" reads a bit odd.  It would be understandable if you
said "asking for list of filtered objects may have", though.

Are you contrasting a call to traverse_commit_list() and
traverse_commit_list_filtered() and discussing their relative
performance?  

Of are you contrasting a call to traverse_commit_list_filtered()
with and without the omitted parameter, and saying that a call with
omitted parameter asks the machinery to do more work so it has to
cost more?

Other than that I had no trouble with this latest round.

Thanks.
