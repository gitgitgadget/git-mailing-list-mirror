Received: from mail-108-mta162.mxroute.com (mail-108-mta162.mxroute.com [136.175.108.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF232573F
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700388; cv=none; b=FQox81LyL2ckEJSkz7AfaTDAIZJkHweomw22wUKQa77UWiAbu4yhiukjnQipxkpcm7WPw6CEkQwDz7mEx7aq2kCC/ikOs9vYisK0xYaM2UP3bj5h8SmjmFbcXEplUU9MIc5Dt/qqwr0B96xnnqSuq2VXpLbtbLXtx++6FonUH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700388; c=relaxed/simple;
	bh=DX7pgNwJeSUI9zBITFaPjROWqJiKqnQSfvGv9LYffEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUnZLocFGpBd6ue6RI+J4pzRP6hwTY6ElFDypzyKoxbMg6ytAZeK1TyLkkw4CoRLIeC9ChbgkwJepe5lO9QlgK7FBx/Q5l8mt61YAhSHXNCGvBQdiuTLKx/1BNDmH8OkZTH4sZJEdM6m4IsQLn5/klSp22CxGst58ScrgPbGvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=PHgn46q+; arc=none smtp.client-ip=136.175.108.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="PHgn46q+"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta162.mxroute.com (ZoneMTA) with ESMTPSA id 19b93228f440004eea.003
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 06 Jan 2026 11:47:54 +0000
X-Zone-Loop: 2b44bcd4cfd137a71ca0d52ecd1020badf4d91fab04a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:
	To:Subject:MIME-Version:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rvhbhkmlB1Skt6QQ4TrFucV+saxvRk0+TyhsTvcRxpE=; b=PHgn46q+7pfOqZWxLI5PIl6eKU
	eskC25EuY5kW5LqH5ug/0zXHJ+MxsTgCs2oM8AMSz5RuExq0JqGbHpBFWKcbScwXUE3uRziI5DNM8
	0hwjgl/oXrT9/Rq9R8pYJegkhjFpYiTcw6GPeahr9zd/e2y96ZRImXIajogP06S6xd04IT7KEOgjU
	1KuT0ug97oiuO4Q2YJuE6zott+84OZt3As048NIUfNZgIfHw+Vi+aUYXHoWQk1gKi6unSbnzJtWXQ
	UQt5OxPme3rIwlUBZDP9Hyl4MU0ZIOkEHO7wCu7OrnbwW2CA9VKmPbiQfFAS6y11Dcc48Mn/1Z8Ui
	gI0LCZVw==;
Message-ID: <168f4c53-4f33-42e3-b3c9-b44ab101da94@ashlesh.me>
Date: Tue, 6 Jan 2026 17:17:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t5550: add netrc tests for http 401/403
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
References: <20260106093451.748761-1-git@ashlesh.me>
 <xmqqjyxvjb4c.fsf@gitster.g>
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <xmqqjyxvjb4c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: info@ashlesh.me


On 1/6/26 15:50, Junio C Hamano wrote:
> Ashlesh Gawande <git@ashlesh.me> writes:
>
>> Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
>> ---
>> Sending netrc test patches as suggested in: https://lore.kernel.org/git/aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net
> At the conceptual level, I am happy to have tests for features that
> we claim to support.  It is a different matter if we want to support
> netrc, though ;-).
>
> There are some nits.
Thanks for the quick review!
I think Brian also suggested getting rid of netrc in the future.
I have sent v2 to address your comments.
>
>> +set_netrc() {
> Style.  SP on both sides of ().  I.e.
>
>      set_netrc () {
>
>> +	# $HOME=$TRASH_DIRECTORY
>> +	echo "machine $1 login $2 password $3" > $TRASH_DIRECTORY/.netrc
> Style.  No space between the redirection operator ">" and
> redirection target.
>
> Style.  Enclose the redirection target inside a pair of double
> quotes if it involves variable interpolation.  I.e.
>
> 	echo ... >"$TRASH_DIRECTORY/.netrc"
>
>> +}
>> +
>> +clear_netrc() {
> Ditto.
>
>> +	rm "$TRASH_DIRECTORY/.netrc"
>> +}
> Should this fail if .netrc did not exist in the first place, or is
> the primary purpose of this helper to ensure the file does not exist
> after it returns (in which case it would be desirable not to fail if
> the file did not exist when it was called, with "rm -f")?
Yes, the primary purpose is to just clear the file as it might 
potentially break other tests (added -f in v2).
>>   expect_askpass() {
> Ditto.
>
>> +test_expect_success 'using credentials from netrc to clone successfully' '
>> +	set_askpass wrong &&
>> +	set_netrc 127.0.0.1 user@host pass@host &&
>> +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
>> +	expect_askpass none
>> +'
>> +clear_netrc
> We try not to run random shell functions outside the test_expect_*
> blocks.  A clean-up function like this is better called at the end
> of each piece, arranged with the test_when_finished helper.
>
> 	test_expect_success 'do random thing' '
> 		test_when_finished clear_netrc &&
> 		set_askpass wrong &&
> 		set_netrc ... &&
> 		...
> 	'
>
>
