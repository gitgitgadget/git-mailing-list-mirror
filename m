Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB337F737
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775523; cv=none; b=HL1DSKq0jOf9UmSy+asYROvvhBWAZ6Ja82OrB4Fh+GuvWOK8GO3QDu2boCyRvrutpIcwjqkMCOL6h/EqBRtNnRs2luSE4c1NRwqd7M4WgaA/OmKhI6Lhh2nfUY/M6AgXLZPj9PDzMdwVB59nfYsVbVMSbtFMQiRPiByPzGsS7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775523; c=relaxed/simple;
	bh=vvsZF5efx7KNXSwc1N5NB+Do5H1bx+//CABB8WYZuME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l92Xcf+o4Gz1uv1jwAREckcecx8/YRJdZLqwBhsNr2Vi7B8y36/TcGE5toyBG9lKuIqGZI0XnMNf2ybpmMRFgvnhBdaL8LZbs3I3Td86xM5fE1sQYkmfkXuZXWTD2iWtj+zgHQlBwPnqN+MhIdCIt1tBTu0uUlw7cRtjAEnXQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=arDBiloV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=qTnuPZ4H; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="arDBiloV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="qTnuPZ4H"
DKIM-Signature: a=rsa-sha256; b=arDBiloVyCYh4LNNNHvsi+mkPps69AVrrbqQOl2VVK9d8wipTCnoqG8CFghg9/sk9O+Rn4IrT4nr4JiBACg1EY5BaWf7/fUs35DsHyBLoY2Rls2cNR/NaHZ1YItatcSMZsVdWmgP6+2bgWGonfkP6Ll2fktUwoSh/SRBzJIi+dXo+kIL6K+Ycmq+rYJLT6q4iJg2Pq8rDIQ3PmofwpVI0A4Bw3KFiysuyKyW+9yxLoFdXGD6JRey/vpKjvmcxn09E1tSUdOl9YCysT4Xe5OXnZ0KufB5oOojREpuptwgy/P2fkREv6FsM5RQy/JJ0dBr3zG1tzf9cNbZIGqaMdTB9g==; s=purelymail3; d=malon.dev; v=1; bh=vvsZF5efx7KNXSwc1N5NB+Do5H1bx+//CABB8WYZuME=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=qTnuPZ4HLPecAKg5PTJnG9fLr+3QGIJlIPK6ARCigjqNDUke+PUKdfA3qli+VHhaCeesMi3bG07mKYLUvB4LDEFLeiy4K4Y45v3CkPa1/ljEnP0FfMr+d2m3fd9KT0fLo5Gwu5mmCGXk31A1IxP3r8CY3wd+Ad1FHXPwLCuNWG0KLVCJ23e6yygHMl6x8iSt16QG8+GJDf8lfshKIeihapnOJTesaESHhck+h7pv7YfBje4qqBfUvAI0y82rhlz2jZpp+8EhwTfZFC6HicFsxDPvVJA9ziagIyM9APsJWEON1elRnsDYD2CKuxdCtTo3C6oCxDIcbTNQ/h86mSdu2w==; s=purelymail3; d=purelymail.com; v=1; bh=vvsZF5efx7KNXSwc1N5NB+Do5H1bx+//CABB8WYZuME=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1816418279;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 15 Aug 2026 06:31:58 +0000 (UTC)
Message-ID: <0b5e76c2-4fa6-47ae-982c-f138cf343bd7@malon.dev>
Date: Sat, 15 Aug 2026 14:31:54 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] pack-objects: give fetch_if_missing call sites
 access to 'repo'
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260813061125.1089553-1-cat@malon.dev>
 <20260814072419.1666358-1-cat@malon.dev>
 <20260814072419.1666358-2-cat@malon.dev> <xmqq7blsrclt.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqq7blsrclt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 22:38, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> 'option_parse_missing_action()' is registered as an OPT_CALLBACK, so
>> its signature is fixed and cannot easily gain a 'repo' parameter of
>> its own.
> 
> Is that true?  OPT_CALLBACK takes (short, long, value, arghelp,
> help, callback), but the value parameter, which typically receives
> the location to store the parsed value in, is NULL for
> "--missing=<...>" option, like so:
> 
> 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
> 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
> 		  option_parse_missing_action),
> 
> And "value" does not have to be the exact location; we can pass
> the address of the repository instance there, and the callback can
> dereference it to reach repo->fetch_if_missing member to make an
> assignment, if it wants to.
> 
> Am I missing something?
> 

Oh yeah indeed, 'value' can be used for passing repo. My mind went blank 
at that moment :(

>> Let it only record 'arg_missing_action'. Instead, apply the
>> side effect right after 'parse_options()' returns in
>> 'cmd_pack_objects()', where 'repo' is available.
> 
> When I review a new iteration, I first apply and look at the
> difference from the previous iteration before reading the new
> iteration of patches or their proposed commit log messages, and I
> did notice this business about "arg_missing_action" and wondering
> what it was about (which by the way is precisely I read the patch
> before the log message to ensure that the log message explains what



> I find unclear in the code).  Thanks for describing this.  But if we
> use OPT_CALLBACK() to pass the location of the variable, this may no
> longer be necessary, no?
> 

Will change, thanks!

Regards, yuchen

