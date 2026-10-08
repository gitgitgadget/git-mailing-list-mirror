Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340243D515
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459715; cv=none; b=LFBqOafiCqz6VC0Hyi26o80FCZf9pdmkVETMYKy6ju9jnxJsiht1TZB5A/aWCuw00IoxZ7PZzUrHfMegjtW7PO9+6Js7l70f+JDUOeVcvvGxFpL7m2CqDCf+NXAl3mCyHl7eOjqYEpcajLXVx+adpzxDoSlwSvVx/MzJBxDQmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459715; c=relaxed/simple;
	bh=mZFXTeLO9hEGeAAtmNCytTKaJ2sTw8mSUKCOnwkd1KY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERuTa+54mBQI9XmD2hQkNfdvD7cgxDJ3csb8IR6n4KIr/XfDg9fFLVd9dUCVX/QkkJgmsrwBmuy9HlT4PAjOMi+P819iBGSGv2UmrSbhka3osbYO7sRx1Y//SJlf3I0/ZTdsofTs9wGgR10gEO4w3KoShcJjTiK2vXrPU+9oaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4lt+/v5m; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4lt+/v5m"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mZFXTeLO9hEGeAAtmNCytTKaJ2sTw8mSUKCOnwkd1KY=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791459708; v=1; x=1792064508;
 b=4lt+/v5mHiWxRPL9c96bggqrck/QhuxsJ1zudRBxtaKDZA+ZyuuZFu2ZLor7tiPKIBghgVav
 UgVJFqKPgWIXvLgBEBMx1H2w0XEncs6TyMS/mZSOdhyoNj/1p4HhEJCWL3rkJQqslSbRh5W56hU
 eN4qG3lOhIPHZufXNekFjKbI=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id ea5dc282b00e83ed;
	Thu, 08 Oct 2026 11:41:46 +0000
X-Mizu-Trace-ID: ea5dc282b00e83ed
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] packed-refs: use `fwrite()` when passing refs verbatim
In-Reply-To: <asYyhHB8DROQpkBB@pks.im>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261007-kn-speedup-packed-refs-v4-1-79a411026596@gmail.com>
 <asYyhHB8DROQpkBB@pks.im>
Date: Thu, 08 Oct 2026 13:41:23 +0200
Message-ID: <87cxtkfmho.fsf@dev.null.iotcl.com.invalid>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 07, 2026 at 01:20:16PM +0200, Karthik Nayak wrote:
>> Changes in v4:
>> - Modify the commit message to state the issue with the previous
>>   approach.
>> - Modify the comment for `record_start` to remove ambiguity around its
>>   setting.
>> - Remove `write_packed_entry_raw()` and inline the call to `fwrite()`.
>> - Link to v3: https://patch.msgid.link/20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com
>
> Thanks, I'm happy with this version.

Also no further comments from me.

-- 
Laters,
Toon
