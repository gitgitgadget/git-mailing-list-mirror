From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540: skip under NO_CURL=NoThanks
Date: Wed, 06 May 2015 11:49:36 -0700
Message-ID: <xmqqvbg5tubj.fsf@gitster.dls.corp.google.com>
References: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
	<20150506173200.GA7985@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 06 20:49:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq4OA-0003Hv-J7
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 20:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbbEFStk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 14:49:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752493AbbEFStj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 14:49:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDE064FF72;
	Wed,  6 May 2015 14:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ELcd/g4h1Nu+A5hblsF3AplZ+fI=; b=EhmvTF
	ECvnysBLvQmIajpjwK1ELjF4BTZBYwx5bSx9+WV2QNYQOQol50teINlt9BFtvt+M
	R2OU58iYlHHpTuGHQoHOkVvcEsU2ARBdM3on2whhBB0tJ3UsZNNUn8/G2vCTnymn
	2m2voTQQxPCG2pq/aoG0xLakPwQhRCZgwfvZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aA/ACiJSTQXrKdS2s+4VFC+xmI5az2wz
	5+9Pdnochg4QjB8kYh5KQApc3WmOM8ybK51loW0odDMCue7QFqP8c7zN1WLoYG0f
	sVt03pfA4UHaz94ZPMkWCKP5UsHcdPblFySqq6W5JJjjbQXi7I6idnHrew9nS9Y+
	crI2ewK0gTo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5DBE4FF71;
	Wed,  6 May 2015 14:49:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75C0D4FF6E;
	Wed,  6 May 2015 14:49:37 -0400 (EDT)
In-Reply-To: <20150506173200.GA7985@peff.net> (Jeff King's message of "Wed, 6
	May 2015 13:32:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A527E3F4-F420-11E4-81FD-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268479>

Jeff King <peff@peff.net> writes:

> On Wed, May 06, 2015 at 09:58:06AM -0700, Junio C Hamano wrote:
>
>> All the other tests in t5xxx series that require http support check
>> NO_CURL and skip the test, but this one forgot to do so.
>
> Makes sense, though I wonder if this check should just get pushed into
> lib-httpd.sh. Surely we can't do anything useful with a web server we
> started if we have no curl support? And this seems to support the case:
>
>   $ comm -23 <(git grep -l lib-httpd.sh) <(git grep -l NO_CURL)
>   lib-httpd.sh
>   t5540-http-push-webdav.sh
>
> After your patch, there is literally no script which includes
> lib-httpd.sh but does not respect NO_CURL.

Makes perfect sense.  Thanks.
