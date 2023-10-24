Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CE27EDD
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sRQa7WW2"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23F12C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:19:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5AB32C479;
	Tue, 24 Oct 2023 13:19:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cZszeQXrTIsYj0kXiHCSRBqFW1Rte9HQvFILS9
	pEZ0U=; b=sRQa7WW2SOfWha3ch8CmYaCgAHN5DowK0P3/Wk8i3prPCZMZ/lx6l5
	BdJYCJ+FRLnA6LBQcdANNLcieGkGZpD7EUc1ITlc/8Cq3uSIiBYlrpY2J/fJCPAZ
	oFnYasV4BhwJpAfY2W2Zknte0o5Xooj3xQUd4L3Y2LUnclBHRcrS4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD8A02C478;
	Tue, 24 Oct 2023 13:19:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 58B852C475;
	Tue, 24 Oct 2023 13:19:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Christian Couder
 <christian.couder@gmail.com>,  Charvi Mendiratta <charvi077@gmail.com>,
  Marc Branchaud <marcnarc@xiplink.com>,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
In-Reply-To: <b2b76344-11b7-4f21-8658-f18ffcca2dea@gmail.com> (Phillip Wood's
	message of "Tue, 24 Oct 2023 10:22:17 +0100")
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
	<a85c80eb-65ab-4b8c-ba94-de71516da5ef@gmail.com>
	<ZTayxB0Nm7AEyafp@ugly>
	<b2b76344-11b7-4f21-8658-f18ffcca2dea@gmail.com>
Date: Tue, 24 Oct 2023 10:19:19 -0700
Message-ID: <xmqq34y0546g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78936CB6-7291-11EE-B520-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I agree there is an argument for improving the implementation of
> --autosquash but until we do I think it is counterproductive to change
> the documentation like this as it will cause users to wonder why
> "rebase --autosquash" generates a todo list that is incorrect
> according to the documentation.

That's a good point.

> I do think it is a good idea to document where the authorship of a
> rebased commit comes from.

Yeah, sounds like a good idea.  As to the authorship information, it
might be nicer if the "rebase -i" insn language supported an option
to trigger --reset-author (or even better, --author=...) action for
a single commit, but I presume that it is rather a rare event, and
as long as people understand that they can stop the sequencing
(e.g., an "edit" of the commit would do) and run "commit --amend",
it should be OK, so it probably is OK to leave it as-is.

Thanks.

