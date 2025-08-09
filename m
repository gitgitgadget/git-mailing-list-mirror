Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54918FC92
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740404; cv=none; b=KCVPs+6o5SEKn+UTt+b6tzZI0zhktonSojvCuGSzJpkm0F2r8r/HTdfUf3QojAPa5zbB56pm45Qh8Ze3d+WOB0D6znW3E3qruDRnuQ6AY3syvbwgVb+qlNO4azdpvlYu2BZItY1/8oxrfXhCNmHQIZ/+UVn02ZUOMpE2fEfMzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740404; c=relaxed/simple;
	bh=GoepqQJ9e6PTl/JFtkVLybsNTA7SSgOnfbIU3wtm8kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajMmfXTQtaiueLjuBkx480ZRmny4ILwbStc6KOknqcMMLptq0y2RoQnXN43Rx2uDoGi8Klo+gIuNSX2/ns4h+5um5GTFVWlqVhD06+TbAufsEb4tlI8qq1DvZqrzn6EMEH/6NkbEIFb28UvX+m/xRUSVV3+FTJphZEEmQRoZn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=UXB7Iy5A; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UXB7Iy5A"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id ki5Su8yMTZgItki5TuIbXU; Sat, 09 Aug 2025 12:50:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1754740212; bh=CXoGjHAWG54nQJB5kOzpq0AEyPVnBhbmWYEpu7Ez4wI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UXB7Iy5A/gtXHxTTEr+EbaFOpXGgbvknYqG4/96CMCufaYvcOd9SDQkWA7KN0S0Py
	 stLjEh6d0Rpi1F9ob4HPCJvzzHLRDaqhV5Wyq8IOKeOrUJu0g+nVawlSJxZRBs7+Pg
	 KcoCiNJ4Hk1mx6GhGpfWZmxnJhqyWfT/LlfBvq7EEG5oJOmyWl9WjcdO8sQQ4AUqmt
	 8Yh2feWGSU1A3SjAIJIu5J8UNj73E6fdZ5A/+QNNbrW0DdapU8UW7wvChgHvZiv6zo
	 S14HTMwivvOD+1ui3/yBxNsEALsoTEygdmLSA1yudK2hcNvNdDeIkCikBspemkIRen
	 qp+po/QaJEhhQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NdZF1HD4 c=1 sm=1 tr=0 ts=689735f4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=l2arV1HgC4bPXGbwRJgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8f3e6afc-4dce-420e-a6a4-d54b0409aa2f@ramsayjones.plus.com>
Date: Sat, 9 Aug 2025 12:50:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t6137-*.sh: fix test failure on cygwin
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
References: <5514f2fd-3307-42c8-97ac-bc2147a7ba41@ramsayjones.plus.com>
 <xmqq8qjth7um.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq8qjth7um.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKxTU+NhuBhjqmKsxZIoA90Cxjlb/I0QNgBgzGl3jEmg7Br04RR8eNy5cIxmUQq20AHVFJ0dascOlq0uM6uaZ61jF63CeLB1Z+hL902I+j5sSl51Iilg
 puCWwDkWn8Ra73USToDuSgg3Xq8na/3O9PoGLAvHge7Vn/FPNAnU/lrGZtyZtwPAsuWf2YdqjmZOqq19iLCfyXaxTnrbh3Bf/mQ=



On 08/08/2025 21:33, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> [Hmm, I have just noticed that the 'skip_all' message could drop the
>> redundant 'skipping: ' at the beginning - oh well! ;) ]
> 
> Yeah, I see skip_all="# SKIP $skip_all" in test-lib.sh
> 
> Let me squash the following in, to further match the message we give
> when the test environment fails a test prerequisite.
> 
>  t/t6137-pathspec-wildcards-literal.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/t/t6137-pathspec-wildcards-literal.sh w/t/t6137-pathspec-wildcards-literal.sh
> index 17a03085ef..e582378181 100755
> --- c/t/t6137-pathspec-wildcards-literal.sh
> +++ w/t/t6137-pathspec-wildcards-literal.sh
> @@ -4,7 +4,7 @@ test_description='test wildcards and literals with git add/commit (subshell styl
>  . ./test-lib.sh
>  
>  test_have_prereq BSLASHPSPEC || {
> -	skip_all='skipping: needs BSLASHPSPEC (backslashes in pathspecs)'
> +	skip_all='missing BSLASHPSPEC (backslashes in pathspecs)'
>  	test_done
>  }
>  

LGTM. Thanks!

ATB,
Ramsay Jones


