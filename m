Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF91A71B
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WTB/Q96X"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71676D46
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:20:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B44781A50AD;
	Fri, 20 Oct 2023 19:19:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=71p/MJQKW+JgIqTvaNAd+t3rL25HwF4Gt2fkmJ
	R3t6Y=; b=WTB/Q96XWsssWoe44CmtrCFW8fk5qgKafiDhz3S5pRmwNfY3wY4dUu
	Uin2Yc2Pp20yW5j/NbaAAoAPzT3Qc7njTIUuL5pNYWpUeeXnFOUXqWnpM/4gl5E0
	1vTmC4h3PcbRZq2t4zfI7ziLBQmkEWxeDdI+Q4dSreRX3pmPz9b/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB7F81A50AC;
	Fri, 20 Oct 2023 19:19:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 202EE1A50AA;
	Fri, 20 Oct 2023 19:19:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: [RESEND] git-rebase.txt: rewrite docu for fixup/squash (again)
In-Reply-To: <841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com> (Marc
	Branchaud's message of "Fri, 20 Oct 2023 17:40:01 -0400")
References: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
	<841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com>
Date: Fri, 20 Oct 2023 16:19:58 -0700
Message-ID: <xmqq1qdoq3tt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3009A09A-6F9F-11EE-842A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Marc Branchaud <marcnarc@xiplink.com> writes:

> [1] Makes me wonder if rebase should also support "squash -c"...

How would it be different from "fixup -c", though?

A "pick" followed by either "fixup -c" or "squash -c" will have the
same effect on the contents (i.e., apply the changes both commits
want to make to their respective parents) and present the end user
an editor buffer filled with the commit specified by the "-c"
option, right?

Or am I missing something?
