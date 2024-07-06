Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D941C6A3
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305357; cv=none; b=se4UNHEic5y8LYEhm0gbq+kAHEbqLYuoKe8u8zxJVjpekPplV8IEB/Z7dL3kwGMbLdTtiCTo6He5octAqvqmoCvqZdXcXLgcbUn/ITV10P9fh6qH1V1QLcVgBBluuW4qTAoNk+FcUF4zVzeYFC8k/C05AjuvBeeINF0uFu/DQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305357; c=relaxed/simple;
	bh=FVIasHqFsmv6bfpGon0cQu+tArfmghmqlUsa/9QdNkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwwQFlqfmQujLMuiFJLAeV1WNiEDtxXJ6OgFZDy1LeilM8nEkZqLVgHqK0orfkPsG4ieI+cIrBIb2VxLhB0moZlg2q49abFtOUQvnPgOOPytKUb/wJudbGFO/obW2JRxh1FqhtBafEg1jcQFZQyJJFYHZjwgN5FBZZsWFaRw+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iYqW1F79; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iYqW1F79"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E55B27CDB;
	Sat,  6 Jul 2024 18:35:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FVIasHqFsmv6bfpGon0cQu+tArfmghmqlUsa/9
	QdNkQ=; b=iYqW1F79TpbAxyvAcL3lX1MoTSHiJ/cQ2nhnqsIBng1Lg2oxua0hDP
	k8E9naVgMUuXP/KpMyhioPd0sCKoyem3RYChsGePcLWKHlFJrYrIGTscISts0W0b
	eJ/hy5SOSCZRUJON2H3V2ahgPrmQ1EAYHMWGw/m8mETuWgzT6Xhxo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 798AE27CDA;
	Sat,  6 Jul 2024 18:35:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB0DA27CD9;
	Sat,  6 Jul 2024 18:35:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ariel Cabello Mateos <080ariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] gitweb: rss/atom change published/updated date to
 committer date
In-Reply-To: <xmqq8qyenpsz.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	06 Jul 2024 15:01:00 -0700")
References: <20240704164547.94341-1-080ariel@gmail.com>
	<CALRJROB7gGWok-YPGTjPe+TXkU5Y_MhqcPSiCGoPDzJ=WGHoKA@mail.gmail.com>
	<xmqq8qyenpsz.fsf@gitster.g>
Date: Sat, 06 Jul 2024 15:35:49 -0700
Message-ID: <xmqqle2em9mi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1901C60A-3BE8-11EF-8F95-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Ariel Cabello Mateos <080ariel@gmail.com> writes:
>
>> Currently the value used is the author date. Change it to the

It is left unsaid what "the value" is used for.  Let's rewrite the
first sentence like so:

    The author date is used for published/updated date in the
    rss/atom feed stream.  Change it to ...

Another thing that is curious is why the mention of author_epoch is
left as is before the hunk.

Shouldn't we use the same committer time for loop cut-off and also
for display?

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..c1151544cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8324,10 +8324,10 @@ sub git_feed {
 		my %co = %{$commitlist[$i]};
 		my $commit = $co{'id'};
 		# we read 150, we always show 30 and the ones more recent than 48 hours
-		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
+		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
+		my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
2.45.2-899-gfb4fe62777

