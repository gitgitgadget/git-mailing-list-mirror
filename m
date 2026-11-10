Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301449;
	b=uKLEEyDHoojLJ2pn4Kq611fNU9eeTlZw4XKT1RPXLH1vfr2NWTs3JGogcw40FU1bnTnB
	 A2g5uWBHlq06hfWy45/PuZ9fJfmlAafz9YPI4iVgxVcHWOSyQbNzJNB6fBKYigkWx1L44
	 +/Gb/341MuSJG7ZlMcUooF5nUAn7gvcGzSHl9T668tySUt5Nx9Y0ck4gLgCeENeYnmHTm
	 PjlN5Y9TphwSBPIZNSC19pczqhorqGHBQ09DoNLSiY54eYZn1p+3zi7zd12QarL172MRm
	 WZ5m6YRJdTrJ6XrtFfWCOPsX04ml/hq4dg0Pig/zYBhjuv6PVxrI+mYvjP3U0zUxnQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NpadUpuYyDat4XBxGyIYg5fQOBkJ5iSRqNWBOKNhrkk=;
	b=XGVkNbDYGYQVHwiS1kj/PrlURz9jiIPK4UoOva0LGS9GsKgUuKUESe5v2YhkzfhSA11H
	 rQfErI5lDlD6ytWdsrkr7ya2eNYCqkm12xL3q1ULQKFUFK8qwWDF8t13h271FsDbb1h/1
	 50PRx4S54wyWjCKcV0OG0EuBclmHtjEmhP3xR3ILfyyDMFrV0RZoJ7JS/YBG5t5fwQQ7P
	 GWRlyAeNZlrwL/Q24MHO28dEtDOUFeDMrqpWG6eHS0wszAG8EbG/aCCVt/d/ffZQGXPAd
	 msi4knwWJ/Rx6Q3VZfrGkhZlBIoKZFqVSJjI5LQNZsQwCdVHSs90/df2XUR99EIxXaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXpxvIvI;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7F606A32E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 09:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE7F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXpxvIvI
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so2624468c88.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794301447; x=1794906247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpadUpuYyDat4XBxGyIYg5fQOBkJ5iSRqNWBOKNhrkk=;
        b=KXpxvIvIY4OVXp5f/uznnEETZ/zMvg/M9srdjkoO/C+9ovIV1G6DrI7WbE6bsOZsTh
         iqnNNdrxXMlvnPL9zhm68ZEli/bFnxbAoo1y5yPiu87Oe8PM/dUgQYXj0ZmV0ilKEDEm
         X8YGJc+3y59wBqCnazft9rIQDyM+SmUzwbv/XLlXBmNe+noJHjBJ9tZ5R6FiiTIyCeyN
         Rzgf4bJNp563nNslcK2sYwY1n1Aauv68W8RbgPT8UMKkl50jI3XkqDyCTP6Gc22Qzz4x
         lgJ0rGN2UyE1PhKOHA4/v8NK0bhVQ4uRc1NpnpSU4IEJHwCfJpVG4AEk8UANhLV/zOIK
         yTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301447; x=1794906247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NpadUpuYyDat4XBxGyIYg5fQOBkJ5iSRqNWBOKNhrkk=;
        b=tyoVF/iuZhHaDRx9lGHNr2LIe7NVOngBwNCASVcDBN5fUkcNfqRTYpVaAapLB2oU/9
         n7PMND2CDmtTE69ToPWZk5w0BHZzq/22mkuxf3ch+taHt+w8EPAb66iS9qY03OFdYOag
         zRrmgrTuNj/Obj1M5yXvVDbQoSEz97dygysUVhLJGPDj4ZssJnHj+2cgbfsbvtU6a52d
         Hn6M9JvPHtXjXa1NrzMBNbLz7zxTCztk3ZiwNju7pytX3CHGTNMJAo4grOsM8Gdbipfp
         2qW1Nb7bkmjxZjXu/lh4PG8ZNs8uU/fj9nNrMw3T2Hsm8vbzLP2bwcY4aJRk+/893mrc
         TGwQ==
X-Gm-Message-State: APuU4Z8ROM1Goufi5q4ygiz41watR6tU1PZhR3k50ONdtLTQfriugph4
	5ACJEiemG+dDHE+dA6JeANOTc17PlUWL9tP4zZfHZnJJqIkLmj+GJq1O
X-Gm-Gg: AYBFou0WsEt6HGc7TyBELtDsoU9o5ShS+dLz7QZs59V9XGL4FYITt9mLQckLp/DK79B
	iW/8cLXHDKF7jAdtMkNT710g5p4Lo73m8qpjVUe5ifQlHtHhf+OnV8WqHUlV40RKjf7yZnHHmij
	S2yt3r/Ojo4TnCCjBO+sTb/rPpjOQ8YLrZ6vmhqB+TtdEUqjX2qUx7Sr13UIVTf622V1P3tnzGA
	MsQxltzyESOCf18ETy1fB+ojCE+NjF06n8c/X3XKJ/r2cKsR+AGBewbYmMJ3cOY2q7ywh7Khqay
	z7ZJxcBaLRW1rwgHhhkmXiwEN9Dg+50/kh8is+O8eXqDYfbK5bfj7N/LPwNwKFyIhn1WILp7nVk
	wkUM8FL87UvmstDPB2OOoC5Hn6xFa+7kUQFzuuLBg+s0G4B1V8xwu3qjzFFf4b81kei1U+LiatZ
	GgiA8VUlG77waTWFEK34PRtbNIAdSSe6KCNl7GYONZpRmP2DvNPTFhyvqS7zNGL/7uh2Zy0m25h
	FEiqpP/XXZlUjPweUu6DCPnPA4fSpFqTL/Pwx0GW6fCq+kXHjt8UHcnHwbTGDRZG3RZEX9eSf5L
	sGSAAk5ti+apjIkO7GlSUASeGRZ/9Sikae/Wfm18WnJX
X-Received: by 2002:a05:7023:a44:b0:19d:6484:869f with SMTP id a92af1059eb24-1b3b605b6ccmr2460540c88.7.1794301447376;
        Tue, 10 Nov 2026 01:04:07 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm6936684c88.11.2026.11.10.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:04:06 -0800 (PST)
Message-ID: <4c7c44df-4eca-4abf-a825-1bb3b16015c2@gmail.com>
Date: Tue, 10 Nov 2026 14:34:02 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
References: <20261103212410.1389988-1-jltobler@gmail.com>
 <20261103212410.1389988-3-jltobler@gmail.com> <xmqq8q38yz5i.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqq8q38yz5i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 04:36, Junio C Hamano wrote:
>> @@ -1487,24 +1487,24 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>>   		child.in = pack_fd;
>>   		child.err = err_fd;
>>   		child.git_cmd = 1;
>> -		status = start_command(&child);
>> -		if (status) {
>> +		if (start_command(&child)) {
>>   			strbuf_addstr(err_msg, "index-pack fork failed");
>>   			return -1;
>>   		}
>>   
>> -		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
>> +		report_err = read_index_pack_report(repo, child.out, &pack_name, NULL);
>>   
>>   		close(child.out);
>>   
>> -		status = finish_command(&child);
>> -		if (status) {
>> +		if (finish_command(&child)) {
>>   			strbuf_addstr(err_msg, "index-pack abnormal exit");
>> +			ret = -1;
>>   			goto out;
>>   		}
> 
> OK.  A slight simplication that does not change any behaviour again.
> 
>> -		if (ret) {
>> +		if (report_err) {
>>   			strbuf_addstr(err_msg, "index-pack failed to report pack name");
>> +			ret = -1;
>>   			goto out;
>>   		}
> 
> I guess this also does not change a behaviour?  We used to relay the
> error status returned by read_index_pack_report(), but now we force
> the error code to an explicit -1.
> 
> Personally, I somehow find that the original "unless we positively
> declare success, default to 'ret = -1', and if we may have detected
> more specific error, return it back, and reset ret to 0 when we see
> a success" easier to follow, but that may be subjective preference.
>

+1. I too have a slight preference for the old flow of having ret = -1 
and resetting it when there's no error. It may not be worth a re-roll, 
though.

Otherwise, both patches look good to me.

-- 
Sivaraam

