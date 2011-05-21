From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/11] sha1_object_info_extended(): hint about objects
 in delta-base cache
Date: Fri, 20 May 2011 18:49:49 -0700
Message-ID: <7vtycozute.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-4-git-send-email-gitster@pobox.com>
 <4DD6F3AE.6070007@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 21 03:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNbLF-0001w6-Ir
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 03:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab1EUBt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 21:49:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1EUBt4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 21:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C64A349F3;
	Fri, 20 May 2011 21:52:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=IkTbE78Esb4wFomYuBj6S6MLr
	FU=; b=hecROpl2wmK5tlx8i0lLTl+BVFvKi+rRFma1TufiXc2aQKk5/NWx5Ks9Q
	yuS8pBxXW1tThV1RGh8aAoexJdXwouxIg7azu/9YRs5g87EZGErAZWpb6//QJGzy
	GkjPscU5Cv9Hm75vlMcVU/Nixw1OcoVvmfy/zDpZGPw73f+q70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ihRwiXE/2KgQVXzwQVM
	VgubbaRq21deR76afy6d+9wobQS2Dm38miOHFgvrNzY0Xz3f5jNmu0SAgMiryZBJ
	zri78+Oq/bUXSUWlTxg/PzU+iCaVzs0ET3BBiEesITLnnfWZJO55IKMVsx1zuXKO
	+F6G65yBO/Sy/c1o3CUo24fo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 986C149F2;
	Fri, 20 May 2011 21:52:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BBBC249EE; Fri, 20 May 2011
 21:51:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB0C83AA-834C-11E0-A4DF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174087>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 19.05.2011 23:33, schrieb Junio C Hamano:
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1030,7 +1030,8 @@ struct object_info {
>>  	enum {
>>  		OI_CACHED,
>>  		OI_LOOSE,
>> -		OI_PACKED
>> +		OI_PACKED,
>> +		OI_DBCACHED,
>>  	} whence;
>
> Some compilers don't like trailing commas in enums.

Right; thanks.
