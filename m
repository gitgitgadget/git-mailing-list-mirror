From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Wed, 06 May 2015 10:16:56 -0700
Message-ID: <xmqqwq0lbp87.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
	<xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
	<CAMbsUu6=U92TRo-UeOL1qtaTipMQFzD+m+wM7sn1o-AjD6LJBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:17:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq2wV-0002h2-5n
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbbEFRRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:17:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752479AbbEFRQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E104F4E433;
	Wed,  6 May 2015 13:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALZA8AGQeLr9u+FGKzgo18NZigc=; b=g24DVX
	HULXBPlJwK3C6BI7A9Bgrd37GQtV1IILyjM22/VxKEf+XAvJ/olMWYDgv1c74nLP
	ysNiV2lwqn94Th6jWRJDFELxXRz48vEkf7OSk0Kck7rxi9TUGYTwFF91F5h/5uGL
	bgPUQwGhIJbGIVyxYOXenNOYbiU4Ptim/xl04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aIBIvnPp91mIbA1s3YGuGgtSOsFs629j
	uURvX2V4hvI7ZzRUXc2yGFJn69orG4SKRrPlmPo0OmiBo58C8NDqzXSwCsol4GhJ
	Gtp6Snz9sGwOo1cF3QuXnO1fpmfJ7Wuv9uBSHjmd0LoqDKMdkGIeImWegO6ltTL5
	06oYnlNDGNI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9EBF4E432;
	Wed,  6 May 2015 13:16:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5299C4E430;
	Wed,  6 May 2015 13:16:57 -0400 (EDT)
In-Reply-To: <CAMbsUu6=U92TRo-UeOL1qtaTipMQFzD+m+wM7sn1o-AjD6LJBw@mail.gmail.com>
	(Danny Lin's message of "Wed, 6 May 2015 17:57:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B30D87F6-F413-11E4-BE0E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268469>

Danny Lin <danny0838@gmail.com> writes:

> If I run with:
> printf "Hello, world1\r"
> printf "Hello, world2\r"
> printf "Hello, world3\r"
> printf "Hello, world4\r"
>
> I get this on the screen:
> Hello, world4
>
> I don't see a problem in 'git fetch' or 'git checkout'
>
> Maybe using printf is the way to go?

Yes.  Thanks.
