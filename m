From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8] ls-files: Add eol diagnostics
Date: Wed, 30 Dec 2015 13:45:42 -0800
Message-ID: <xmqqsi2jd309.fsf@gitster.mtv.corp.google.com>
References: <5683D49D.2010509@web.de> <5683E8B4.7040005@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOZB-0007n4-7A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbbL3Vpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:45:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751017AbbL3Vpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:45:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08BB035CE3;
	Wed, 30 Dec 2015 16:45:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yLucgdw/GzSJ41A7xvMol97scGI=; b=Ll42Ka
	k7T2RzohX2Z2bRn6SDPgigJiIXyvhHfywFeTc+khkBHY5Oz+6pZWzo+MoMSCWcyc
	s4Z0/A8Mfk15ttuqz8QKXMrH+y2o3lmWFcq0V0q5lKh/1p1Ql3c3t/5UipLnQ3Vv
	Y/yCzsrAubBLsGdcjMrM6PCSnHP+Oo/x2X1I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BWQjlfiec9Kqvfoq+Qz25Jjac/9kUsQW
	s4ZgMiNNX9+HQZdyfYBfK7Bz7il9hp+KSqlwDrDkDBQl5PHnunPfXYlUyO1T8I98
	4k2xyz9MloSvrMQJfk56a/jnheMzj40CqAzxRA9aGqaXOdEPqb46yfZ6VKpKmEZ0
	ZUbwULnko5A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00FE435CE2;
	Wed, 30 Dec 2015 16:45:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 789FD35CE1;
	Wed, 30 Dec 2015 16:45:43 -0500 (EST)
In-Reply-To: <5683E8B4.7040005@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 30 Dec 2015 14:22:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD4DED88-AF3E-11E5-AB11-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283205>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> +	Show line endings ("eolinfo") and the text/eol attributes ("texteolattr") of
>> files.
>> +	"eolinfo" is the file content identification used by Git when
>> +	the "text" attribute is "auto", or core.autocrlf != false.
>> ++
>> +"eolinfo" is either "" (when the the info is not available"), or one of "binary",
>> +"text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".
>
> <bikeshedding>
>
> Again, I think this list reads better as: binary, none, lf, crlf and mixed.
>
> If you prefer to have 'text' in there somewhere, how about:
>
>    binary, text-none, text-lf, text-crlf, text-mixed.
>
> :-D

Yup, these shorter ones, especially without "text-" prefix, read
easier to humans; scripts won't mind either way, so I'd prefer that
shorter version.

Thanks for reminding the thread.
