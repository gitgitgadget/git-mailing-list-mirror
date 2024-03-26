Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7C130A65
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438381; cv=none; b=ty6LnnJEa4RiowBfuaKHIDUPoSUneRdqI8bJsYjVDNFVmaG7XCFVYuPq8eiTupsYvvqIdpJf6o11Y8cHA3sfpLeo6sTykKTcgB52vJiWc5XbLWssXcRvCfgGhYg/8eE2pf9880rQ78kpK2a6Vlp/69iVYg2T+ACGuW13eTgLzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438381; c=relaxed/simple;
	bh=WW0Y8viedcXtddIq9iSWlCrF/VTah4KDj2wJgGmf5wE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rerkQGj0e/CpM+/j9dJAeRr6+VHA86+igXXiEMI3HKni2C23ZZ+yzkDU72SYa2th3wUF/kEWsHdfj5AvhPc4SWwJ3KqIJJyGLqm077Yf+HTood7jfFlfwz9v3IKPVRqkBj9DjkvlZIlOE7niZP2ezpTnh5ZB5TGxEYS++LvE9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YdQXlGl2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YdQXlGl2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E6F61EC9CB;
	Tue, 26 Mar 2024 03:32:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WW0Y8viedcXtddIq9iSWlCrF/VTah4KDj2wJgG
	mf5wE=; b=YdQXlGl2kOGBv4BvzbwYUZ1RakgEuTwH6VnpYzryB9eBMwi/PlEYel
	8XDAtWiK+sJZt+oKg6LqspEzt2CZqsGLuDYohIMSENujrEgQ7omlfaP9k1SuZtjX
	+jWADYZyZLk5HIxIymNeIXO+2s2avINUZOX0Ps9Do5ztEMBKjw/PI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 157CF1EC9CA;
	Tue, 26 Mar 2024 03:32:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FAD91EC9C9;
	Tue, 26 Mar 2024 03:32:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>,  <phillip.wood123@gmail.com>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: [PATCH v2] SubmittingPatches: release-notes entry experiment
In-Reply-To: <17c0263586f87125.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Mon, 25 Mar 2024 23:37:49 +0000")
References: <17c0263586f87125.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Tue, 26 Mar 2024 00:32:51 -0700
Message-ID: <xmqqplvhe9cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E019ADC-EB43-11EE-8257-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

>> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
>> +paragraph summary that appears in the "What's cooking" report when it
>> +is picked up to explain the topic.  If you choose to do so, please
>> +write 2-5 lines of a paragraph that will fit well in our release notes
>> +(see Documentation/RelNotes/* directory for examples), and make it
>> +the first paragraph of the cover letter.  For a single-patch series,
>> +use the space between the three-dash line and the diffstat, as
>> +described earlier.
>> +
>
> One very minor grammar note: "you can propose *a* one paragraph
> summary".

Oh, yeah, of course.  Thanks for carefully reading.
