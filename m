Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAED29403
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259638; cv=none; b=Wh5Sw3vBar5319+KKIU1+/TlowFu3M9kLyyks03w5+G3w49LQKvTbq+ApSKu06Z/bOQty5XeHAL2yivDETbN+DDZIsyQs1Z0pXAoAsNT5I+zAC218uLV87zpluxtPWMtLurTJ3xcJUlMlJNZguzakccvN+dxOMlvBYJ+AdFf4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259638; c=relaxed/simple;
	bh=eLoVUZjkvSgYBlkpVoncbP/2SnOZfepyOqTN89gBM14=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tutYxGyHZvqyrUWgSzxOLoFUOpSlIKWWFqvcdmXjAd3IC3kMzjDpTWIWHocCdvgobms9dK036uTZAJ3ngKcQz5U/V44m+EH8QbmERyP9i+3f6+ER+hXy5OzL93oDmPgHa9wME2gShp/es4FD4L9r8R4VKhaJAtnX0VYTAm+e44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VAoZvuOI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VAoZvuOI"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712259632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7R7B1CSGjfliKyZgsFfycSEQNHYSL+Q/WXeC2UYiQr8=;
	b=VAoZvuOIEV2Ov4qEtJsKRvg/L5j/QfviBVkW82H2bbQWZHi00hEHLUng9OWP8PeHKlLOaV
	1xvClosxao+S/cPvwTmCz++EOvsF04gLf0EGcWnrqsqlD5faVTowvK4HcJq3vBgg6PZ7Fs
	SOQpmDrFIozPNEaNUK0+vwErpaTB91oTQOXgfaXF/4/iVqb8MYhCm341nkJ/5RxMIZ9pyd
	vJ68zqg/V6Zzz4ydJ+EZNpBohqK6ry7sYZ6ehZhqjP+liL2B31nptjmd1O7U8qmXZqOu/G
	AkcnRRQmVfkTYpgTsY1iXygI0MZyMznCc5LNUFNlDKbwA011b7l9b/JsBBgUqw==
Date: Thu, 04 Apr 2024 21:40:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RESEND] send-email: make produced outputs more readable
In-Reply-To: <xmqqy19tylrm.fsf@gitster.g>
References: <62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org>
 <xmqqy19tylrm.fsf@gitster.g>
Message-ID: <44ed7af52e2968993d9b2b99faec1f64@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-04 21:23, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Notes:
>>      * send-email: make produced outputs more readable by separating
>>        the result statuses from the subsequent patch outputs
>> 
>>     This is a resubmission of the patch I submitted about a week and a 
>> half
>>     ago. [1]  The patch subject in the original submission was 
>> selected in
>>     a bit unfortunate way, which this submission corrects, and also 
>> improves
>>     the patch description a bit.  There are no changes to the patch 
>> itself.
> 
> I tried to cram a bit more information than "output more readable"
> that lacks in what way the result is easier to read.
> 
>     send-email: make boundaries between messages easier to spot
> 
> perhaps?

Looking good to me, will use that as the patch subject in v2.

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 821b2b3a135a..62505ab2707c 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1576,7 +1576,6 @@ sub send_message {
>>  		print $sm "$header\n$message";
>>  		close $sm or die $!;
>>  	} else {
>> -
>>  		if (!defined $smtp_server) {
>>  			die __("The required SMTP server is not properly defined.")
>>  		}
>> @@ -1686,9 +1685,9 @@ sub send_message {
>>  		print $header, "\n";
>>  		if ($smtp) {
>>  			print __("Result: "), $smtp->code, ' ',
>> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
>> +				($smtp->message =~ /\n([^\n]+\n)$/s), "\n\n";
>>  		} else {
>> -			print __("Result: OK\n");
>> +			print __("Result: OK\n\n");
>>  		}
> 
> It would be nicer to instead add a single separate
> 
> 		print "\n";
> 
> after these if/else alternatives, without touching the existing
> message lines, I would think.  That way, existing message
> translations do not have to change.
> 
> If we were to change the translatable string anyway, it would be
> even better to remove the newline from the translatable part of the
> message, rendering the thing to:
> 
> 	if ($smtp) {
> 		print __("Result: "), ..., ($smtp->message =~ /.../);
>   	} else {
> 		print __("Result: OK");
> 	}
> 	print "\n\n";
> 
> Strictly speaking, that is an orthogonal clean-up, so it may have to
> make it into two patch series, one for preliminary clean-up "to
> excise terminating newline out of translatable strings" patch that
> adds a separate print that adds a single newline, plus the "make it
> easier to spot where a message ends and another one starts" patch
> that makes the new print statement that adds a single newline to
> instead add two.  In a patch as simple as this one, however, I think
> killing two birds with a stone, i.e., directly go to the "if we were
> to change the translatable string anyway" final shape in a single
> patch, would be fine.

Thank you very much for such a detailed review!  I also think that
putting everything into a single patch is a better option, because
the changes are rather small.  Will do that in v2.
