Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D893D69
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735317373; cv=none; b=OdaVjT+tPUpMa0jVN4YmjWXkMZmZreJW8lWygdMrQwUW6nX/dSCGTqE3vSs92PlI7v5cJIIYYOBkmqVs6xO51RxD2AJzL98TyEaHHW/jmz9ZxSrTMnMo+QXPD1ZfN81naOTesA8QzLCJGJk3C8mm9+bxEc1/3qNpNcXfSaPcs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735317373; c=relaxed/simple;
	bh=DS1c15fluYb327r+Dk7pR2Vg4OVlJHtN+JSME8kESNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/InJAgCNklJYPBUOZoZ1MzqUg1gYVP1twoF5B/FfTr11tD7InqQfFnpTmN5ax6mkwrQvdoO8xWNaZcaMakL03mcgH+MP1EI/7B1eN5DxQa6fARTo2/ugZOaIYbKyDI0QbdB6cZOyndbauAr4V6nYYrn8gShGBWQfB4171GnCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=Tug8d2RR; arc=none smtp.client-ip=195.4.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="Tug8d2RR"
Received: from [195.4.92.122] (helo=sub3.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tRDJi-00EsbY-2r; Fri, 27 Dec 2024 17:36:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sNqyiEW2rz5kIvzIC0NGbG7/GXostn5EkutDuWGoUKc=; b=Tug8d2RR7eleuYPumr384kZg/s
	KRMciC5rvAaZrizoOq3Ce5qYH0ctkVRm/vCxMnVIDeyaa9vGeX+TidKJ3dETVPzDOwgmSzFr5wIvY
	4uppNwcrZ/tYrhcHj+hkkAXV5n8aBG0e9j5mtYSVhOMsHgr3nqI/afbxPdLIllBSYjiNchQmfBprH
	nt92iSLkoLQuNhv6qxYABVEWApZOFEXzkHQM3kUHkmVoEm3KVPV7BWlTX9KhvmaZLEtiWOes9WA4Y
	GMZMxx12tvDZc26ToszAeOg93zJqkPOQtdOdl4fmNK0QIdVNwuiEcJLLMTLs2SlMmQfiS8PVqjXsn
	PW/VZT5g==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:44466)
	by sub3.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.94.2 #2)
	id 1tRDJh-0028r4-QF; Fri, 27 Dec 2024 17:36:01 +0100
Message-ID: <965ac9bd-7340-4dbd-88da-2daa88c126c4@freenet.de>
Date: Fri, 27 Dec 2024 17:35:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20241223110407.3308-1-soekkle@freenet.de>
 <20241223110407.3308-2-soekkle@freenet.de> <xmqq34iaxh7r.fsf@gitster.g>
 <e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com> <xmqq5xn5urhv.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Autocrypt: addr=soekkle@freenet.de; keydata=
 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
In-Reply-To: <xmqq5xn5urhv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1735317361F3C8BF77F8ACO
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!44466
X-Scan-TS: Fri, 27 Dec 2024 17:36:01 +0100

Hi everyone,

If I understand your comments correctly, it would be preferably to 
switch to a data type like uint32_t or uint64_t so that the behavior is 
consisted on all platforms?
Also add a test if the input overflows the data type.

Best regards,

Sören Krecker

Junio C Hamano writes:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>>    struct hunk_header {
>>>> -	unsigned long old_offset, old_count, new_offset, new_count;
>>>> +	size_t old_offset, old_count, new_offset, new_count;
>>> These are not "size"s in the traditional sense of what size_t is
>>> (i.e. the number of bytes in a region of memory), but are more or
>>> less proportional to that in that they count in number of lines.
>>> If ulong is sufficient to count number of lines in an incoming
>>> patch, then turning size_t may be excessive---are we sure that we
>>> are not unnecessarily using wider-than-necessary size_t in some
>>> places to hold these values for which ulong is sufficient, causing
>>> compilers to emit unnecessary warning?
>>
>> That's my thought too - I think something like the diff below should
>> fix the warnings by using more appropriate types in expressions
>> involving the hunk header offset and count. Our internal diff
>> implementation will not generate diffs for blobs greater than ~1GB
>> and I don't think "git apply" can handle diff headers that contain
>> numbers greater that ULONG_MAX so switching to size_t here seems
>> unnecessary.
> 
> Yes, exactly.
> 
> Of course, when filling old_offset and friends by parsing an input
> line like this:
> 
>      @@ -253,7 +253,7 @@ struct hunk_header {
> 
> it would be a bug if we did not check if "253" overflows the type of
> old_offset, etc.  And I would very much welcome patches to fix such
> a careless input validation routine.  But replacing ulong with size_t
> would not make such a problem go away.
> 
> Now, I would be a bit more sympathetic if the patch were to use
> integers of exact sizes, in the name of "let's make sure that
> regardless of the platforms we handle patches up to the same limit".
> But size_t is not a type that is appropriate for that (and of course
> ulong is not, either---but the original did not aim for such a uniform
> limit to begin with).
> 
>> @@ -1626,7 +1628,7 @@ static int patch_update_file(struct add_p_state *s,
>>   			else
>>   				err(s, Q_("Sorry, only %d hunk available.",
>>   					  "Sorry, only %d hunks available.",
>> -					  file_diff->hunk_nr),
>> +					  (int)file_diff->hunk_nr),
>>   				    (int)file_diff->hunk_nr);
>>   		} else if (s->answer.buf[0] == '/') {
>>   			regex_t regex;
> 
> I skimmed your "how about going this way" illustration patch and
> found all the hunks reasonable, but this one I am not sure.  Is
> there a reason why hunk_nr has to be of type size_t?
> 
> When queuing a hunk (and performing an operation that changes the
> number of hunks, like splitting an existing one), the code should be
> careful not to make too many hunks to overflow "int" (if that is the
> more natural type to count them---and "int" being the most natural
> integer type for the platform, I tend to think it should be fine),
> again, that applies equally if the type of hunk_nr is "size_t".
> 
> Thanks.

