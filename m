Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD602568
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B7wYZdqJ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1AF211B
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 22:05:01 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DCA61D36C3;
	Sun, 12 Nov 2023 01:05:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6J0P6Xmc+Vgl8mUUUaHfJy+GKjdf4C1KbCiyas
	LTguI=; b=B7wYZdqJe63nXyhiJ2RxwQD4wHN5kBwNK5XzL//wXJtmS5/sr91la9
	ezorFkZdepe+Z4iQ0XAwV92SP6MXBv6XZRr6i2OxIplQdkEGRlc4AOjbP6sHNrCk
	6A5lxrtt0BWxrOYbge7VCSKHBbpHLyFhlnPGrPdOctjdVBZ78rY3g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EBEE1D36C1;
	Sun, 12 Nov 2023 01:05:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B4651D36BE;
	Sun, 12 Nov 2023 01:04:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  pclouds@gmail.com
Subject: Re: [PATCH] checkout: add config variable checkout.autoDetach
In-Reply-To: <20231111224253.1923-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Sat, 11 Nov 2023 22:42:46 +0000")
References: <20231111224253.1923-1-andy.koppe@gmail.com>
Date: Sun, 12 Nov 2023 15:04:57 +0900
Message-ID: <xmqqbkbzo6ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6946D3C6-8121-11EE-A874-25B3960A682E-77302942!pb-smtp2.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> The git-checkout command without pathspecs automatically detaches HEAD
> when switching to something other than a branch, whereas git-switch
> requires the --detach option to do so.
>
> Add configuration variable checkout.autoDetach to choose the behavior
> for both: true for automatic detaching, false for requiring --detach.
>
> Amend their documentation and tests accordingly.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---

"switch" was meant to be an experimental command to sort out this
kind of UI ideas, and I think the fact that it requires a more
explicit "--detach", where experienced users might just say "git
checkout that-branch^0", has established itself as a more friendly
and good thing to help new users.  I do not know how others react to
this kind of proliferation of configuration variables, but I do not
mind this particular variable existing.

