Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB14146D5A
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617889; cv=none; b=tzjIEZ5cm120Bhy1UsDm41tnPDIMlu7Rv0DkcQwjzpeTLA9LLEFUZUZLhxzIwlB4o6tX7dFoMrWhRwkqDlDe7+u2TsjlCCUk3Yrg+k0Y8TyhnGqjRpWqdgrmpQXVXpwJYiWAIfSPhi4hD6YBSUsTV5AKKnliot4+n66r9J/K0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617889; c=relaxed/simple;
	bh=C6+sDjOcgr035yELybKls+u8Wp67BgdY7oBc+AF1j5U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kxJVR1MUyLjz8IidlTennn4vyj2L+hLJpSjQpz1Y/DyR7wWEAssMYH40+2TLxtThMuj1U3Q7IYXsA4kjm7Kh80jseX3UmT6iSHMwCGzctVV2w6jJQUVvrqav/H/pjJh/2gM8yqKBnx0nPJk6oZpzAWEOeoK9avj6wZU4b1oGzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jlULeR0m; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ILG1UYGl; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jlULeR0m";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ILG1UYGl"
DKIM-Signature: a=rsa-sha256; b=jlULeR0mTAeSGb+27bn9NFuCfybECiXKe3rYJBYJdlgkrM5w2UXNnttDs2jIKf8VT1HRRH3KBSF61W93/iE1/4wbc0mgKrJY2c/UWyNHZyMGD5LOM/UfKI0wvdtpr9bWtUWIe1NXGquPEUL0J2/F7y9YoUA7y2qeOUFP4RFweJ5yvI9Ns4Sn+EJ1ZWDk8KIQZPuhqy4Wvln1BHoEhgs7CWGkRlpKgQn4qG629AgEPkhiRqqFBRhH1s+wnFJWdY9oyQrsdlHIiNrZVh/8PQQMj10vNitHKW0U+YdAolGUfxQKJ8hYERLhM/TohoxFmI+sq2YP79BVy69CC1QArQW8tg==; s=purelymail2; d=malon.dev; v=1; bh=C6+sDjOcgr035yELybKls+u8Wp67BgdY7oBc+AF1j5U=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=ILG1UYGldylIf7Jp1n0T4Nq5sa8ImkT7zOm5JzL6irMCr3zqwJTNja/gZ1hvW79+XOnBA6zsduDnP4D5TvVDMfsLhMGHgvp4/bTho0fN3i3afc1nFMe3GXaTOt44XabzKKkubrKQM7LKHbpKiVx00SjdBEHXAVp4guM7qiFwS0GzzRSD55SNoKERRH/WcoJr5DHvdCPHf5QSnuuFWchrFlIBgEtSlcRWuPvsqublMcm4wrOlBqYt9BwKJGoxSJm++I7zpSQzpfngqTyn5O7dCfJw1dsW16jx3gI+0DnzkMWFvgwRU2/9MqV1vMIo1xpUnp0wfuTOH/LkjweFjahGRQ==; s=purelymail2; d=purelymail.com; v=1; bh=C6+sDjOcgr035yELybKls+u8Wp67BgdY7oBc+AF1j5U=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 300401963;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 28 Jun 2026 03:38:04 +0000 (UTC)
Message-ID: <ef7f76d9-52f4-45c0-af0e-b7f3372b652a@malon.dev>
Date: Sun, 28 Jun 2026 11:38:00 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev>
 <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev> <xmqqv7b34snt.fsf@gitster.g>
 <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev>
In-Reply-To: <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/26 11:19, Tian Yuchen wrote:

>  Let it be noticed by repo_config_values() function to
> catch offending callers for now, and once the codebase becomes ready
> to use one repo_config_values per repository, this function does not
> have to change.

And

> Wouldn't we rather want to try to be more strict and say
> 
> 	if (!repo || !repo->initialized)
> 		BUG("repo must be an initialied repository");
> 
> here?  Aren't all the callers of this function supposed to be
> dealing with an already initialized repository?

In my opinion, these two suggestions are not entirely consistent, and I 
think we need to determine the most appropriate approach.

Regards, yuchen
