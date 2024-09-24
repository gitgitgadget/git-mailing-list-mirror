Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761217557
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214108; cv=none; b=RuX4zichZ43oK+rWxd7tK9dhOu4uucbcnFydQ8lyd4pG2kWqTQ5A2w1NVlNSyx/By/EIRmXUYcNf0R7jZCGtrUcVQje5D3oqB4HJXW4O8MW/9FqL82RD4m+Mf4ucQXVhcEbCV4q5fDX6cwLhN7hA4uXh6l38O/nPRrVP7/rAtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214108; c=relaxed/simple;
	bh=Mku+7n7nfe1lOVcsOdnSgBuqyU1h9T/ycL7CCXHYbTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/rllTF/WoKoQNoibNS51j4iEW6CpbmUmxQ6FG29jbxT6jA2T5vVU5aRUOpKS0lr3WnAmL4zew7FYtGWr5t0rCYXOVPK9Hyh6eJhEFAVziklPyRoFJym1/2PWdDhS8ptI5A6RHhLICZKoK2Q0wwyx9wJ0Vy4QdnJKLBGxYKwWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WnFDq2OU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WnFDq2OU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DB451E25E;
	Tue, 24 Sep 2024 17:41:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mku+7n7nfe1lOVcsOdnSgBuqyU1h9T/ycL7CCX
	HYbTU=; b=WnFDq2OUCmwCWjXXiSsVXEtoF32HfEgKUDl+U0vMp1QF5ws8/P/Fqp
	tXG+0dOOpf9AHJKMqMvTIrJYjOqnF0b16Bj80O1NRivD8p/TFeH5txRdv58+7uEh
	OCvL7xE0oiHsvIebUiHmNLKhgyD+2V3z6GmR0KUbnIXgqvtmhhwwo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 439C61E25D;
	Tue, 24 Sep 2024 17:41:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4A2A1E25C;
	Tue, 24 Sep 2024 17:41:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-email: document --mailmap and associated
 configuration
In-Reply-To: <20240923222429.4102405-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 23 Sep 2024 15:24:28 -0700")
References: <20240923222429.4102405-1-jacob.e.keller@intel.com>
Date: Tue, 24 Sep 2024 14:41:43 -0700
Message-ID: <xmqqr098rap4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB1E3490-7ABD-11EF-A46D-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> +sendemail.mailmap.blob::
> +	Like `sendemail.mailmap.file`, but consider the value as a reference
> +	to a blob in the repository. Entries in `sendemail.mailmap.file`
> +	take precedence over entries here. See linkgit:git-mailmap[1].

No such documentation page git-mailmap[1] exists, hence this breaks
"make check-docs".



