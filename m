Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2534C123
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425540; cv=none; b=XTtVIwkNEwHJso5m4+KxKYg72O1HuPCv3MpfQTN2XAUdHyXhnyIKznSi2+xkyS9vpqcRdVFx5Ldw7nq62EvA7ZZ7x48mQHbV0LM5ALysjEhIF0zBQMSgHqrItPqtDjZvI9JyndPe3BouKwqXuBZldi5Uuy7aUS/s9NVtHjuXucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425540; c=relaxed/simple;
	bh=AM74oC5Pz2fUJiZHEhwmBhQ/qlHSKNZ/QvNq/FhvLN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zjn+URDlZX1I3KqWeRhRE3ZgtBPu6zjcP7VRmtp9unvLlEUriAgg7GY4zm9WmH4LvXV2kUMY6MAya/BcWuhMy3hJFjeoohXQBMn6bFBfF/UwGe9jMf0WASJUgg5eocu4uIYTI3H14L7a4TSVZeeDW1+2burjrpwqkc7Wv/3cjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=KjH9IUBh; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=IMDd8Mzr; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="KjH9IUBh";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="IMDd8Mzr"
DKIM-Signature: a=rsa-sha256; b=KjH9IUBhbn/1mvZMGa1aZgFpZ60iEWl85Goi6mhBe3vSQSPCiQgy4W4V452Y3E9ApfycYfozWBt7Va5Dwykvjpog/J32QO/NXPbKcN3QfbV/HQ2poXdV45UPQN69J9wNW3/YgAMfBmyg84PeCM5OXYhH8U4Jwg+bCNezlY8GutBmhNUR/LAR7VlbUTuY3sjg9LSa31UPCnBNRjGYx4xPjk6odkIyw3c24uST141OKQKkRC6005OnzSaYN4nYMwA3++mKQRg+o2UP47rTJjUjmHrAPAvL6Qq4jApISuueTmW5ZgX8/ZhAiWTzSxgRKeePVMqlAnSdnKm3s+oAZaqUdA==; s=purelymail2; d=malon.dev; v=1; bh=AM74oC5Pz2fUJiZHEhwmBhQ/qlHSKNZ/QvNq/FhvLN4=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=IMDd8Mzrv6g3N9WuMsskHVPVtQIM7GWIhcJeKqkXlby1c/F1CuLG3PB182OoV8KIfu+U8/98iaHbOrFSb5tlc0Z+m3+xLeP59dA8ckFmX00kLLR5kUhmH05nyjSm9anxNLAS5NlaQVV6rsRTeyvatuLSCyVl45bbfKaHG2hlyNwz6I7P1h1VTcfKcp3MPMXWvOdFp7g/8L6gD4bp8fyih0BSentF12v4hW+39w6m2rHRkXzqYUQW/FU8t3HHtC0rlNi3cznxr8zx4pSsuHjDq7wC36nnO+eU8oVU+FXZ+Q/QhDeZxBf4uOVDg4HYxDTOecG35lOcOgtyRXAnmAIGLA==; s=purelymail2; d=purelymail.com; v=1; bh=AM74oC5Pz2fUJiZHEhwmBhQ/qlHSKNZ/QvNq/FhvLN4=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1932714853;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 13 Mar 2026 18:12:12 +0000 (UTC)
Message-ID: <e448f98d-58be-409d-9ff2-ae45442dbded@malon.dev>
Date: Sat, 14 Mar 2026 02:12:07 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 karthik.188@gmail.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
References: <20260311181704.958509-1-cat@malon.dev> <abJjYNq_sxeH8yLQ@pks.im>
 <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev> <xmqqpl577m3y.fsf@gitster.g>
 <4fb9c915-7246-4c55-b7c6-b4ef7ca91230@malon.dev> <xmqqzf4b4ntq.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqzf4b4ntq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/26 01:54, Junio C Hamano wrote:

> I strongly disagree your idea that 'z' is more business logic than
> 'h' is.  Both are equally relevant.

Perhaps I didn't explain myself clearly :(

I do understand that *currently* both are part of the business logic. 
However, what puzzles me is: why is it written this way? Why isn't -h 
intercepted at the outer global level, but instead handed off to a 
function like parse_options() for interception?

Is this due to historical reasons?

Please forgive my slowness. I would appreciate it if you could offer 
some guidance!

Thanks,

Yuchen
