Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98046313E07
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568608; cv=none; b=JCPbxbFaXdp0NM9iQ87nkq3XC9BKimLzjYoD7QD+oATIVxSwvb5EtPkOoIQG34Is6fNSYfVuvk9E+3Rdx+HH6L0mMLHgFAZvdyp19aZjYvJQJfvonz57aQHW4+Xfv9/ESDPQQJZYzeU9MHE8Mc8BdVbEuJ2rmeF132dbwdwT88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568608; c=relaxed/simple;
	bh=xGGDKZWGzCbRWaCxXoJXYIGu5ELNci15ncgH8O1UqnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1Qbf7UlH28dCLAMkWvCUSXbvw+1kAZPN5PjqZ1MjA5u7g7cEcPdYAUGVk173C8IFA42H2Q6vBOn6oNPaMBGEwvqIahsH0/QODvB2uqzIllFFh6ZP5u+igX/xoJWiNBkM75xWy7AxpWzVxHxl7HqDlsF119NA7QJXENwE0rD+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=UYQnAgEH; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cPgC+q+H; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="UYQnAgEH";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cPgC+q+H"
DKIM-Signature: a=rsa-sha256; b=UYQnAgEHHi8/ctDip0HHmvMFeZZ0CK6aNGLEURHZD4t9kUZaFzt748kD5CQpovvfJoo2koIbH9ms902/sOqujnWxls4PpdDaDk16ntWUOd+nxyhuis9Y9yiKvSUVqUUHsFR5tEWwBIeWJAi7ysKdjDRVBLvp/pjWXckRkNrOCEHFLeCuNYyyOyf3ITfG1SnOmdYY6gIp6kkYmtdYx32f1qdpiQgKld6CSUEZlPluhlQ+ulxxqLdJYaHjA6+CBiAYhhs50JT0g7toetu7JzMe2ptIuc3v4yReh3vpJiUJPwRxI7ADLRE7yjBfhNcBZ2OhvTGvsxmGzuZSp8QJY89iwQ==; s=purelymail2; d=malon.dev; v=1; bh=xGGDKZWGzCbRWaCxXoJXYIGu5ELNci15ncgH8O1UqnI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=cPgC+q+HHLPXAfyfkLK6e62RCyPvK3/43n4WtWdKm5thiLaq8YN0+Cbg1SYoOYH+GQWjBY7uVHHFPF3tEA4MaeHHlmGZ8pmXdGF0X5pzoVwvNMeWceWMk8Y2jV7g2f+O/e1YRP6tA7VT+PiiJMdl1rqmcX9pPdH4CdeEB8GcEf0E1BHuu+FOq0ZU2PUu30vUwE5DdhlE+QHBMhS27DtLW/YgaNQXgsqP6TRrXL1NwpUix0zsP1kBGMfOEiIsytlhd8Ul1f81wQNYleYFBAYCC596GLj0hKNKoVmdBwvq40QH2obOALmnkZsDA3c8T6QZzzDDsMyNcRRjhdPWJYhKaA==; s=purelymail2; d=purelymail.com; v=1; bh=xGGDKZWGzCbRWaCxXoJXYIGu5ELNci15ncgH8O1UqnI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2111804901;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 13:56:37 +0000 (UTC)
Message-ID: <73c52aeb-238b-4028-85c1-65ba05aa9b95@malon.dev>
Date: Sat, 27 Jun 2026 21:56:30 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <xmqqh5mp9uke.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqh5mp9uke.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/26 23:42, Junio C Hamano wrote:

Sorry, there was a problem with my Thunderbird client... so the my 
emails didn't send without me noticing...

> Tian Yuchen <cat@malon.dev> writes:
> 
>> This series continues the libification effort by migrating the global
>> string variable 'excludes_file' into 'struct repo_config_values'. Since
>> this is a dynamically allocated variable, the migration requires proper
>> heap memory management.
> 
> This appears here:
> 
>    https://lore.kernel.org/git/20260626075037.532164-1-cat@malon.dev/
> 
> and as you can see, there is no linkage back to the previous round.
> 
> The lack of In-Reply-To and References headers unfortunately delays my
> automation in marking topics with newer iterations available to be
> reviewed when I come back to the keyboard, which happens overnight.

Regarding this, I forgot to bring --in-reply-to. I'll remember next time.

Thanks, yuchen
