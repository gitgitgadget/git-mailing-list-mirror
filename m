From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout -t -B
Date: Mon, 27 Aug 2012 10:03:39 -0700
Message-ID: <7vk3wks1w4.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
 <7v8vd1v6q2.fsf@alter.siamese.dyndns.org>
 <CACsJy8A=GooUesw0hJ7AiDO7M3v1Ybbox8+rwWJfn6urJQUUFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:03:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T62j7-0005UO-Me
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 19:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab2H0RDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 13:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab2H0RDm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 13:03:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC7369E6;
	Mon, 27 Aug 2012 13:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AxR6th0lfSNu
	NwaJJIMSm3sQkHg=; b=GgvDwWXKcDYKd+UXGCCG6ghkf05/lxhPK+wZXMcGurlz
	BFnAW+nnEdtnv7O8VeGzB+NWASNzrYwY3N3DHgVzDVRDhTt/R3jFjJbe0oJQZM8i
	TD13u816BS1ZLRGb34DXuA0CN5HE7roWf9SYFQinCAdLilyDte8OjiVhDhpBkAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KafEUy
	mOawff2E1BTHeCiQcQmNgRAzQJNogy0t8XWXopfhotV3uZj3MZgKEzZ+BHRozXJr
	bdyMdDNCr0iF9ZihncLlmRPIFF7wMURwbBKu/4gFTHsN8K0nzdIVtcoBQPNqU0VA
	vNYtDRiRjiWxru4vW4ZSY57F6piFf0xuTR3b4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D1E669E5;
	Mon, 27 Aug 2012 13:03:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6DE869E4; Mon, 27 Aug 2012
 13:03:40 -0400 (EDT)
In-Reply-To: <CACsJy8A=GooUesw0hJ7AiDO7M3v1Ybbox8+rwWJfn6urJQUUFw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 27 Aug 2012 19:20:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26AC3718-F069-11E1-AA41-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204357>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Aug 27, 2012 at 1:38 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>>
>>> git checkout -t -B origin/abcde
>>> works
>>>
>>> but
>>> git checkout -B -t origin/abcde
>>> does not.
>>>
>>> Could you document the order of parameters or fix the behaviour?
>>
>> It is crystal clear that -b/-B/--orphan must be followed by the name
>> of the branch you are creating from the SYNOPSIS section of the
>> documentation.
>
> Yet it's not very clear from the error message:
>
>     fatal: git checkout: updating paths is incompatible with switchin=
g branches.
>     Did you intend to checkout 'origin/abcde' which can not be
> resolved as commit?
>
> I wonder if we should reject -t as a value of -[Bb] by adding new
> parseopt flag to reject values starting with '-'.

You should be able to cope with other invalid branch names in the
same codepath, but your approach would not help at all if the user
said "git checkout -B q..f origin/abcde".  Futzing with parseopt is
not a reasonable answer to this one.

Ideally you would want

	fatal: "-t" is not an acceptable name for a branch

in this case; if it is cumbersome to arrange, at the very least,=20

	updating paths is incompatible with checking out the branch "-t".

would be clearer.
