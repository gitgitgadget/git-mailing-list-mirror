From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Tue, 12 Jun 2012 07:46:20 -0700
Message-ID: <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSMV-0006IX-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab2FLOqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 10:46:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab2FLOqX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 10:46:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75DE192F5;
	Tue, 12 Jun 2012 10:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XrMJ4awoGdKH
	GHXlZLe2MSpNkBY=; b=U4QWyNXZDYKlV7wW155rydDjIB+IyDQdTpyC7HBjHEL3
	sRRgu3LYCtqK8rerayrDWRC4F64Ue+Ch/PEpcaU/3MzPQjbTcJUJfjYoTclOGVmw
	LvYLSAMHjvsM1qoZ0pj0Amiz9UEvf8NPFOBdWZv7Qn0Sni8LGxLxq3vI/drmfRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iw+JfR
	wDYNA/5YbSKOKMhkxxiaEKfXdlo/jffUsXlPLB2ucXK0h3vPUISGAp+36HimiJ1Y
	4MwHHrx2ZSdidmegHL4kEhQPkGAJKh74HfmEkIwkIPfIAiE9s1dG9qsGj+lmZeMd
	A6S/DZwXi/FoDr9bJs+HUSNw1/9Kbjsue6Ud8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B15292F4;
	Tue, 12 Jun 2012 10:46:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E223C92F3; Tue, 12 Jun 2012
 10:46:21 -0400 (EDT)
In-Reply-To: <4FD70A8E.7050502@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 12 Jun 2012 11:23:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 607EA6FE-B49D-11E1-B5DA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199795>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> On 06/12/2012 10:05 AM, Lucien Kong wrote:
>> +-x <cmd>::
>> +--exec <cmd>::
>> +	Append "exec <cmd>" after each commit application line. <cmd>
>> +	will be interpreted as one or more shell commands (see
>> +	INTERACTIVE MODE below).
>> ++
>> +This option has to be used along with the `--interactive` option
>> +explicitly.  You may execute several commands between each commit
>> +applications.  For this, you can use one instance of exec:
> Hi,
>
> this is still grammatically fishy, and has "between each commit
> applications", which was corrected above, but not here.

Not just grammo, but "between" is not correct, as there will be the
final test after the last "pick".

>> +	git rebase -i --exec "cmd1; cmd2; ...".
>> ++
>> +You can also insert several instances of exec, if you wish to only
>> +have one command per line. For example:
> s/instances of exec/instances of --exec/

Not just that, in the explanation part, we tend to spell `--exec` to
make the part that needs to be literally typed stand out (also we
want to see dash-dash, not em-dash, in the formatted output).

>> +	git rebase -i --exec "cmd1" --exec "cmd2" ...
>> ++
>> +If --autosquash is used, the "exec" lines will not be appended for =
the
>> +intermediate commits, and will only appear at the end of each
>> +squash/fixup series.
>> +

Same for `--autosquash`.

I do not think it is worth another round of resend at this point, so
please eyeball the version I fixed up and queued in 'pu' when it is
pushed out.  I also moved the '-x <cmd>::' option description to
where it belongs (iow, not at the very beginning).
