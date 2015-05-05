From: Junio C Hamano <gitster@pobox.com>
Subject: Re: forcing a user@ into the URL if not present
Date: Tue, 05 May 2015 10:45:45 -0700
Message-ID: <xmqqmw1iex4m.fsf@gitster.dls.corp.google.com>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
	<CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
	<20150430202342.GC5015@vauxhall.crustytoothpaste.net>
	<CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>
	<CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>
	<231730bb9947a6ddbbd8f3bda36c89f2@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Langille <dlangille@sourcefire.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 05 19:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypguz-0001yR-1C
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965532AbbEERp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:45:58 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965493AbbEERpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:45:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E2804D24C;
	Tue,  5 May 2015 13:45:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YJZik8RffEEO9W3PoekO7LJJw6w=; b=NAXUNB
	2cGx7mMCc0lf7l2MHXw6nnUmlwNDh1kEhFXEUueUbsGrr+uzz9m8qA51LZNG+VfV
	ViGz3CvLtWcAqW6hoxvMcAofwbgy0MsOXLe1tUZD1hpfjgHBN34YTHSRfr5ePGIu
	2BdpmoaBfYchADetcaA06XePLZYm56wrV4sL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbwJHtO1/v05uS33H2RrYGe60RsHzdO1
	JCPAFvCXTQWZXpo6VdLUvwSZuL6ZD+y36+ghAvzfWVJBXcwEvL/fw3Q+qcex8YKE
	196oNu/Ch44nnv/ULD825nkzk2IcuH0KoA8vHe/sZZqvn/5Du/wOZOzyqXZk5JV2
	gwc7D1/eJns=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18C4A4D24B;
	Tue,  5 May 2015 13:45:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8572A4D243;
	Tue,  5 May 2015 13:45:48 -0400 (EDT)
In-Reply-To: <231730bb9947a6ddbbd8f3bda36c89f2@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 05 May 2015 15:59:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9085B804-F34E-11E4-914E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268407>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Having stumbled over [this
> ticket](https://github.com/git-for-windows/git/issues/92) recently, it
> appears to me as if the following should work for you:
>
> git clone https://:@repo.example.org/

Wow.

Is this a windows-only SSPI thing, or is this a widely accepted URL
convention?  I haven't seen anybody use such a URL but I would say
that is a natural thing to expect to work, as both username and
password are missing so they should default to some sensible values,
in this case "current user, shouldn't need password", just like
"scheme://site:/" is "port missing so it should default to some
sensible value, appropriate for the scheme".

I think Torsten recently added a bit more test for our URL parsing
code, especially for "scheme://site:/" (missing port), but I do not
think we have "scheme://:site/" (missing user or password).  Perhaps
we would want to have additional tests to cover this shape of URL?

Thanks.
