From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7800 readlink not found
Date: Mon, 30 May 2016 22:51:37 -0700
Message-ID: <xmqqzir67p1y.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
	<xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
	<CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
	<xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
	<CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
	<20160527041944.GA17438@gmail.com> <574CDA24.1020906@googlemail.com>
	<574D1BEA.5020409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 31 07:51:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7cah-0008DK-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 07:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbcEaFvl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 01:51:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751283AbcEaFvl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 01:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD01921CB5;
	Tue, 31 May 2016 01:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NZOnoQYflpFC
	pAlPTmwN9mRQ/As=; b=f/dgLcM9ln3OwIgg0gfeGqUNuV3NCiGNDLJ2Oz2I4b5H
	tgVeiUYdhRrQG6DorlP3KteiNQqmq5EV25KAsaizwQdBcJ0zbNv23FC1Gt0kACMT
	iaN6GtsvHDj3t1jJDSTCFEkykPIQCYoTFY6dsx/LLQA9DB33+G8fa2mumE8nnHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jUNe/M
	qEpUosudT+b7YO2ef6AZnG8AzoU7SSDBRU2nzVwlLw58kmiAJHRJiuiuEoEupaOr
	u28xOaRCGgSW9YdVkDCDcYMkPByW4+Nhh0YZ2gkZi/l5g+8MK1kUbpelb+BTbI8L
	geFw1n4pJr8sH/tgjBU74Mxm2z0vYAULbyjfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C570521CB4;
	Tue, 31 May 2016 01:51:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5354E21CB3;
	Tue, 31 May 2016 01:51:39 -0400 (EDT)
In-Reply-To: <574D1BEA.5020409@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 31 May 2016 07:06:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE5E7C28-26F3-11E6-87B7-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295952>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> index 7ce4cd7..905035c 100755
>> --- a/t/t7800-difftool.sh
>> +++ b/t/t7800-difftool.sh
>> @@ -446,7 +446,7 @@ write_script .git/CHECK_SYMLINKS <<\EOF
>>   for f in file file2 sub/sub
>>   do
>>   	echo "$f"
>> -	readlink "$2/$f"
>> +	ls -ld "$2/$f" | sed -e 's/.* -> //'
>>   done >actual
>>   EOF
>>
> I don't know how portable #ls -ld" really is.

The parts with mode bits, nlinks, uid, gid, size, and date part do
have some variations.  For example, we have been burned on ACL
enabled systems having some funny suffix after the usual mode bits
stuff.

However, as far as this test is concerned, I do not think "how
portable is the output from ls -ld" is an especially relevant
question.  None of the things we expect early in the output (the
fields I enumerated in the previous paragraph) would contain " -> ".
And we know that we do not use a filename that has " -> " (or "->")
as a substring in our tests.

We don't have to use readlink, even on platforms where we do have
readlink.  Building the conditional to be checked at runtime and
providing a shell function read_link that uses "ls -ld | sed" or
"readlink" depending on the runtime check is wasteful.
