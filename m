From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 broken under Mac OS X
Date: Thu, 15 Jan 2015 16:04:24 -0800
Message-ID: <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
References: <54B68D99.2040906@web.de>
	<xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
	<54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershau?= =?utf-8?Q?sen?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:04:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuOt-00065j-KK
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 01:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbbAPAE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 19:04:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755602AbbAPAE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 19:04:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE4D72F00D;
	Thu, 15 Jan 2015 19:04:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z0u6sBjl19vjH7MNB9RuUBk5m+4=; b=OmU7gN
	45ycQCPwCGkrQK8/HL0dUscjjUNm74mbXuyIidUw+XD/HTHVCoh99ErpzuwIri3i
	+63n8voom9ha6GpF61uxeXVt6pBAzCy5RQNf9XIR1rEZ7xkq/0baNSOHx0tR1Gbe
	BEDgnrjJ+DOa0OZa2o9ksIgajIPtJqZoJLefI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtWWVjxQ6tMdKEjgnovaBXVNks/d+0t2
	vQhLZLRqGF2HLR1YaSXfbWBMsdMNK91CUnbDH8NyDk3P8fsu/XR94hie6NDe8DNa
	5Liz9bYMb8wL2qUlNniUzL4xbZ3akKo9pOvge8PdDNq1nQ8uNJ9W1t0kOssA08UZ
	QlN0k+QMNZc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5C3B2F00B;
	Thu, 15 Jan 2015 19:04:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EC722F006;
	Thu, 15 Jan 2015 19:04:25 -0500 (EST)
In-Reply-To: <20150115235752.GB25120@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 18:57:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B732450-9D13-11E4-869F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262529>

Jeff King <peff@peff.net> writes:

> Exactly. I am happy to submit a patch, but I cannot think of any
> mechanisms besides:
>
>   1. Calling `id`, which I suspect is very not portable.
>
>   2. Writing a C program to check getuid(). That's portable for most
>      Unixes. It looks like we already have a hacky wrapper on mingw that
>      will always return "1".
>
> Is (2) too gross?

Not overly gross compared to some existing test-*.c files, I would
say.

I wondered what 'perl -e 'print $>' would say in mingw, and if that
is portable enough, though.
