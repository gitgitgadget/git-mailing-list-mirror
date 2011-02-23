From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Wed, 23 Feb 2011 09:45:20 -0800
Message-ID: <7v8vx6abm7.fsf@alter.siamese.dyndns.org>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
 <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
 <AANLkTinf6P-erY-9p5WPWbK+uAf1hozvAutV0zPSpHGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: xzer <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 18:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsImR-0004Gv-Me
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 18:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab1BWRpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 12:45:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab1BWRpa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 12:45:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 110A83C2A;
	Wed, 23 Feb 2011 12:46:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jt4dPIc3fjxs
	BSlSSgXIqpxbzo0=; b=Dnxt8VGXPpAFFBsiH6kbxztrX91enT6oQGx24SU1YBVm
	9SzPoWLmmJWkOxVIE3CInU9AQEHtQv1j890TV+TlqNz4a+4NY3ReJIWNnD6r3Y0M
	rgOB2BEKWq+ca0YeE36CskktIP0LMA/ei4tWg8VJRDn+51SW1iPEvB7aPmuuX8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rdIjRg
	nib2s75IyRus/dSCfH0B9IMgaz4NfxnUHURLEQZSR3QTTZEiAiotvca9N/LAnuFM
	cGGZk4+KnB4Gadvo0JZ02ycsOjwl0GyRmXvrgKiB5VnMGjKrYEcWERuLTYpegRN/
	4U9oXg2abD7McSEdyt/8Iatq8txcXJeZAjMY4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEDD33C29;
	Wed, 23 Feb 2011 12:46:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A58AB3C26; Wed, 23 Feb 2011
 12:46:34 -0500 (EST)
In-Reply-To: <AANLkTinf6P-erY-9p5WPWbK+uAf1hozvAutV0zPSpHGQ@mail.gmail.com>
 (xzer's message of "Thu\, 24 Feb 2011 00\:34\:54 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDA94782-3F74-11E0-A474-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167708>

xzer <xiaozhu@gmail.com> writes:

> 2011/2/23 Junio C Hamano <gitster@pobox.com>:
>> xzer <xiaozhu@gmail.com> writes:
>>
>>> Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi=
-line subject.
>>
>> We prefer to have "[PATCH] subsystem: description without final full=
-stop" here.
>>
>>> There is still a problem that git-am will lost the line break.
>>
>> What does "still" refer to? =C2=A0It is unclear under what condition=
 the
>> command lose "the line break" (nor which line break you are refering=
 to; I
>> am guessing that you have a commit that begins with a multi-line par=
agraph
>> and you are talking about line breaks between the lines in the first
>> paragraph).
>
> Yes, that is what I am refering, the line breaks in the first paragra=
ph.

Hmm, I gave a suggestion and asked three questions, and only get one
answer back?

>> ... After all we know in this static function that
>> the caller is feeding the contents from a strbuf, which always have =
a
>> terminating NUL (and that is why it is Ok that get_one_line() is not=
 a
>> counted string interface).
>
> I am not sure that who will call this function in future, I think sin=
ce there is
> a argument as len, so I'd better to obey the function declare.

If that is the case I would have preferred to see you give get_one_line=
()
that is a function static to this file an ability to read from a counte=
d
string, instead of making an extra allcation.  But I think you will not=
ice
that all the callchain that pass a pointer into the message around know=
s
and relies on the fact that the buffer is NUL terminated if you look
around in the file, and that was why I made that suggestion.
