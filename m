Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E217C74
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712988763; cv=none; b=NHliVHq35f2Az6cfOz1UfudF/9vqfy61kE+ZQKF3we5wAIyTDTT8clnfWlIagPZAIsjE4Yi/LcSlgbPvMlvOx1w6TJ431ofqVqYXJkoe+sJdMOEQABKuvVmY3eT3M/4scAr7yDOJoTSD2icEcdAS56oKJ88C1S2YISbUbwPzDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712988763; c=relaxed/simple;
	bh=Fv2j3/W/bBfTsRl2jcf2UdshhBARzHZKFUA29DJlho4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qFI843h5tiocSQKztHJVGJoFtSUhxROwVJzrt3bvvTYbdUBKR+SXMjNi1/DqDJh21kj9im+JGIGe9jsMfa9zoQmObX5E0cUSn2CIsYsoQZiAyAnZT2rX8C3QVKXij5e0J+aTPWfHX+NBF2J5N2SOoQZY6hOxyasEmFsbdq5nJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fo17F1rw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fo17F1rw"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712988759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3cjrs7ZVYrFM1V3neduOdY2Jjm9YDEcnkZ31HpaXig=;
	b=fo17F1rwLJMEdMmBlb81SoveA7q15jPPeov5gc/tMGpW3H6K2ZrTW2ZLpjmL/3dvMuaxvm
	UZKTtycFLpciaR5eLTo+k66ngpa+l+V81kVCCmvlkeDt0qRUQHNcWvWmLyJyY885d/fUD1
	5ELLRYjJh0/2lX6+xcIy3Wl9r+oSFn6+fGVU6o8ezqnEA0Ou3I8Y2X43hv6Rn3M0pvpINS
	zKfMlWmRKawHqolotD552nk2JtMaoimggum7qSwf8SrNcUK6qMDYN2Xqyybj9pxARoFFC+
	dq86jBp9pcWxkHszi8ojMkKS3gYn7WJRKi42ZOOln6WpaLK21eKBbNTSh9OqiA==
Date: Sat, 13 Apr 2024 08:12:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v6 1/2] send-email: move newline characters out of a few
 translatable strings
In-Reply-To: <xmqqr0fdw61k.fsf@gitster.g>
References: <cover.1712732383.git.dsimic@manjaro.org>
 <29ea3a9b07bf1aa17b5d6a1e41325379c494bcb2.1712732383.git.dsimic@manjaro.org>
 <xmqqr0fdw61k.fsf@gitster.g>
Message-ID: <5e3e714dcbbcd0d44a035e34b922e01a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-10 18:12, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Move the already existing newline characters out of a few translatable
>> strings, to help a bit with the translation efforts.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  git-send-email.perl | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> Looking good.  Thanks for spotting similar issues and fixing them at
> the same time.

I'm glad that you like it.

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 821b2b3a135a..f0be4b4560f7 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1664,9 +1664,11 @@ sub send_message {
>>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), 
>> $subject).$smtp->message;
>>  	}
>>  	if ($quiet) {
>> -		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
>> +		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
>> +		print "\n";
>>  	} else {
>> -		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log 
>> says:\n"));
>> +		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
>> +		print "\n";
>>  		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) 
>> {
>>  			print "Server: $smtp_server\n";
>>  			print "MAIL FROM:<$raw_from>\n";
>> @@ -1686,10 +1688,11 @@ sub send_message {
>>  		print $header, "\n";
>>  		if ($smtp) {
>>  			print __("Result: "), $smtp->code, ' ',
>> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
>> +				($smtp->message =~ /\n([^\n]+\n)$/s);
>>  		} else {
>> -			print __("Result: OK\n");
>> +			print __("Result: OK");
>>  		}
>> +		print "\n";
>>  	}
>> 
>>  	return 1;
