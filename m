Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899405464F
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508653; cv=pass; b=PowmJZcuJxKmu6g5icND2j9qNEnmV3TnAQ+CoQ2JeaVAqTzK5v3MEeCfv+mGQ8Y4zqy9q/jveWss6aDR3lTjxVTteSp9lYSfFj/a3+sPXbhK4gNSXayuydnp/cPRuxMNIpLWIxGfydSWuvOUEnjHVlFFLWMf+ncCBJ4EpjLGCB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508653; c=relaxed/simple;
	bh=RJdwynF+C9+c6Ctxu1+v2V01u8WycHL9d4ZnScI7tMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHNy8d3mEzR4OoqkB50vMpQqLQzbSOeJIsS3qbRUvVAlE6q7NgiFlfb+sFaKhcC2OuUy+TVByqmZrC165RsJ1L275gs6/ZGHKtCK6hj6KK5sbOp4hGqLO0eThoxZ7g/5cGEg1GAi6IPgVKz/SqWhxQ80l0IunPXiUx1YDSeeRYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bFfpb8hb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bFfpb8hb"
ARC-Seal: i=1; a=rsa-sha256; t=1769508636; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B9wOvoC/obZmBCnVauRny7M3LFm5qy/XtXjxmRml0fN1XXJ8OyDmWNpbxa0ep7bnRd5iCEuZppq4DZkTsS77T3WluwibNbsrNUe3NroagtdupgX54ul8xrTekb0sfLgZvta4Q77SngBgswmf5kAW2y+KxN7cYdZrkDSMo4ZiV8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769508636; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z95ZLM2By/80IU3Jfe/JBUQGIGkFVHzwLuI0CMUw5Vc=; 
	b=H4YfLVhfG9OPdHQv5bXih4aFj3PcvNkClrL9YaBgXHqGcOCOMKy99u6+su41E0vXm5q53iJbgzWFwcjXTpe7kXRJyh9KMOtRWIgQoICCx9qHszgyCZodtIIBEg8HmDSWFD9wyeJU1rLJeZaapovG1Z0FLiTx6bvLHbcMSSiAFJY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769508636;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Z95ZLM2By/80IU3Jfe/JBUQGIGkFVHzwLuI0CMUw5Vc=;
	b=bFfpb8hbJPzfqKaxl0StJYYhn6ZNZq/gXUxpEMZ4fgoq9hDk/HwZrfExws9ya5H9
	UZxbuh1nHK00bfamLsuQc0nMEcTP73lGRLKA9FeVi4zVhD3Rmd7jIgAMXsXVLcKh4lv
	p8UkiYecSkl+TQxhLyYNhLyL7Dys8C0Ftfv7x1dE=
Received: by mx.zohomail.com with SMTPS id 1769508634248610.6829600598626;
	Tue, 27 Jan 2026 02:10:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, Jeff
 King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to
 stdout
In-Reply-To: <xmqqms1zhq3s.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-11-adrian.ratiu@collabora.com>
 <CAJoAoZn9Y1xqtc1hWDvM+_rmcANkGUtfSA1HGTaHjtw0DuXyAw@mail.gmail.com>
 <xmqqms1zhq3s.fsf@gitster.g>
Date: Tue, 27 Jan 2026 12:10:29 +0200
Message-ID: <87ecnbmkmi.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 26 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Emily Shaffer <nasamuffin@google.com> writes:
>
>>> +       /* for each potential child slot, prepare two pollfd entries */
>>> +       for (size_t i = 0; i < opts->processes; i++) {
>>> +               if (child_is_working(&pp->children[i]) &&
>>> +                   pp->children[i].process.err > 0) {
>>
>> I only had the one tiny nit on this patch, which was to wonder if
>> checking for pp->children[i].process.err is something that should also
>> be behind a conveniently-named helper like child_is_working().
>
> We already have
>
>  - child_is_ready_for_cleanup()
>  - child_is_receiving_input()
>  - child_is_working()
>
> What should the "child is working and process.err is positive" be
> called?  child_is_spewing_error()?

Thank you Emily and Junio for the suggestion,

I think "child_is_sending_output" is a good name because:

1. It matches the previous naming convention nicely.

2. all hooks except one (pre-push) have redirected stdout to stderr by
default even in the ungroup/serialized execution case (not relevant for
this code path).

3. all hooks without exception do the stdout -> stderr redirect in the
parallel execution case, so run-command can buffer/deinterlace output.

In the current design, this codepath is taken only in the parallel
execution case, since there is no polling/buffering for serialized
execution (it's real-time like before).

If you do not have any objection to the child_is_sending_output() name
or another suggestion, I will send v8 using it shortly with a comment
explaining why we're only polling the err fd.
