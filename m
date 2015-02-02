From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Mon, 02 Feb 2015 12:12:03 -0800
Message-ID: <xmqqbnlct6ng.fsf@gitster.dls.corp.google.com>
References: <54CA3611.1000804@statsbiblioteket.dk>
	<1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk>
	<20150130230516.GA7867@vauxhall.crustytoothpaste.net>
	<a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqmw4x85bw.fsf@gitster.dls.corp.google.com>
	<8103CEFD-4160-4C03-B58B-A3CCCA52748B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git mailing list <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:12:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINLz-0001JG-SA
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbbBBUMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:12:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754917AbbBBUMF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:12:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2855A35198;
	Mon,  2 Feb 2015 15:12:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yMEhXTJNPOxiOF4MqNIGbzQgXfw=; b=H4gYoE
	SZxUSE/rBY5H1pf6F/ckGCWg1dRkbw+DDx63ZhwGqTJfbDFuOo/XKuTuFObH326R
	edFdQUcLms3vpgCam5C4zWU+0WyZRad4R0FxnGxFSfNEuA+p71/cyyettZZ7NXeP
	1w+kb314nMDo3L3opHG7IhBixSSiZyo8rw6lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AuqGZ2rMKL3+glZYzGkpVpMeFwzTOmaf
	3+JiM9AQFMl1di+VWg/0ZJkYJTFZK500WdJI1cjP2xGdTk0YKFJquXGGnVCkcFMu
	NZ0jJaL/lVFWbx4BnkSB+sniPx7JWfQZuuFXhGxjq/JbU7ON5lMa0vLMcgp5/FMM
	F9kQfDpQQxs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D2CF35197;
	Mon,  2 Feb 2015 15:12:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90BC235196;
	Mon,  2 Feb 2015 15:12:04 -0500 (EST)
In-Reply-To: <8103CEFD-4160-4C03-B58B-A3CCCA52748B@gmail.com> (Kyle J. McKay's
	message of "Mon, 2 Feb 2015 08:11:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C17230A2-AB17-11E4-B71C-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263285>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Feb 1, 2015, at 17:33, Junio C Hamano wrote:
>
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>>> use 5.008;
>>>
>>> So either that needs to change or the code should properly deal with
>>> the version of Getopt::Long that comes with 5.8.0.
>>>
>>> Since it's really not very difficult or invasive to add support for
>>> the no- variants, here's a patch to do so:
>>
>> Doesn't that approach add "what does --no-no-chain-rely-to even
>> mean?" confusion to the resulting system?  If that is not the case,
>> then I am all for it, but otherwise, let's not.
>
> No.  You have to append the '!' to get the automagic no prefix
> alternative(s), so while 'chain-reply-to!' means support chain-reply- 
> to, nochain-reply-to and (if you have a new enough Getopt::Long) no- 
> chain-reply-to, just using 'no-chain-reply-to' without the trailing
> !' means that nono-chain-reply-to and no-no-chain-reply-to remain
> invalid options that will generate an error.

Ahh, I missed that ! suffix (or lack thereof).

Thanks.
