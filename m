Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22423236
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229465; cv=none; b=KUITxmpojc7RiCvfAT7KF5oZhYB+qjZzAvuAbZoydgbOD3kaGqqOvmpQW1cYJX+d6vn9SGH6he2eIKmonoOBgLXvAhl1GswByMSJgClzp9E1swlWH525jFjXQQ2LIVeL7GH4dJdlZnVhTOLR1/GnnpwPwaD5q6s8jZzwpMt4PPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229465; c=relaxed/simple;
	bh=MUxhQ580SRDwblDOJd5RiO6SGwOagXA6yQLe5rBdGW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXn7gg8aDJhA4DjspnkN1U2Y2ZQlVogVVwS71BukCJi3bjkJAjIC9d/g9YEFA/+hkP5tucSystPvQsJDh+8EZx9FLKq4S8kvRi4ZcZSHb0P5567y7khCDdaOabCXsD/+x8Q6Ui7cQfEycQgzSp9AHOmlT8YT9H4CVT+uUlaoU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWOqvlqn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWOqvlqn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FE2F32F56;
	Tue, 12 Mar 2024 03:44:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MUxhQ580SRDwblDOJd5RiO6SGwOagXA6yQLe5r
	BdGW0=; b=cWOqvlqnAx7JHQWvoRUKKWuKKxHQ8zFlYgTlDagMyIzmjeozATAzX4
	ss5njP9STdoWSq/wbDdfsS53hpq+3NHChiLdD3XbULWYC+yyAoIpIunW/hf409Ru
	AhKEq0clEuZQoraIXybKMtw5kJYPOgGM/JFoSXI2NtOBEOS1FvY1U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 089E632F55;
	Tue, 12 Mar 2024 03:44:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9781532F54;
	Tue, 12 Mar 2024 03:44:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ralph Seichter <github@seichter.de>
Cc: Chris Torek <chris.torek@gmail.com>,  Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <877ci7lxid.fsf@ra.horus-it.com> (Ralph Seichter's message of
	"Tue, 12 Mar 2024 08:28:26 +0100")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<xmqqy1apudvv.fsf@gitster.g>
	<9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
	<cf21edb2-7681-42a9-8b58-beca5d04c179@seichter.de>
	<CAPx1Gvd4FjCTSn4oUWNDtLS2G4V3yrddggafX0WHfHEdojtCNQ@mail.gmail.com>
	<877ci7lxid.fsf@ra.horus-it.com>
Date: Tue, 12 Mar 2024 00:44:17 -0700
Message-ID: <xmqqmsr3lwry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 552B1DB6-E044-11EE-8254-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ralph Seichter <github@seichter.de> writes:

> * Chris Torek:
>
>> You must use a literal line feed, e.g.:
>>
>> LF='
>> '
>
> Of course, silly me. Easily done in a shell script. I was too focused on
> trying it in an interactive shell. Thanks, Chris.

;-) 

I think I've already given you that in my first message that
mentioned multi-line input.  In the test suite, we already have that
$LF defined so your tests can use it without defining it yourself.

> Do you perhaps know of a function in the Git code base which could be
> used to sanitise strings? It is quite a lot of code to sift through if
> one is unfamiliar with it, so I'll gladly take hints.

Don't silently butcher end-user input; instead do something like
this to make it clear that you do not support it.

	if (strchr(comment_message, '\n'))
		die(_("multi-line comment not supported: '%s'"),
			comment_message);

