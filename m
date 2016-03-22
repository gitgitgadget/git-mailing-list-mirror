From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 4/7] submodule init: redirect stdout to stderr
Date: Tue, 22 Mar 2016 10:15:17 -0700
Message-ID: <xmqqshziigd6.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-5-git-send-email-sbeller@google.com>
	<CAHGBnuMs4D0LeMvdcS0yzKoQgmE+UTb+QFfOkSy7T20PbH86UQ@mail.gmail.com>
	<xmqqd1qmjxrl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:15:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPtu-0008GV-0w
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbcCVRPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:15:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751068AbcCVRPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:15:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B2804E1DD;
	Tue, 22 Mar 2016 13:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+xDUTn/U89Cit9TNEBnXGv/33Q=; b=KZlD1V
	FyRVDU25vjl+ntXJBqpGNF1jyjN8z7WESSi5b9KzEjov6quegA6+gdFqg8qOpNYj
	ezofnNEbH4tv5xA1EljzTIsF8WFW40XVWa4C8U3wPZZBxyTQEuJyUBboDwy3+zfq
	7H6pUVKx73dQ41ACz5phJteX24wWXUw4PDEdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BjEI8HykaZDwR6VakZcegSLtPpsmPRuC
	FPOoEa2HBECkXuCZUpVRE/S6gxS8zC5mRvmBRQJ3+9sUBwmT6uxd7V1+HBSj9tQE
	IXTTS1QXYdnigGfhxai0UgzPjM5ErF850Yiwi5DJOM1u/DYzMaH+9A3rkB6dG5Dm
	+aSDYxts9bw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90F074E1DC;
	Tue, 22 Mar 2016 13:15:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 112A64E1DB;
	Tue, 22 Mar 2016 13:15:18 -0400 (EDT)
In-Reply-To: <xmqqd1qmjxrl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Mar 2016 09:14:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A714D07C-F051-11E5-9013-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289521>

Junio C Hamano <gitster@pobox.com> writes:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Just wondering, what's Git's policy on this? This message is neither
>> an error nor a warning, but just purely informational. As such it
>> semantically does not belong to stderr, or?
>
> Some people believe that a clean execution should not give anything
> to stderr (Tcl is one example, IIRC), but I think the core part of
> Git takes the opposite stance (probably unix tradition?).  Anything
> that is not the primary output of the program should go to stdout.

Ehh, "should go to" is obviously "should not go to".

>
> We may not have been very strict in code reviews to enfore it, and
> especially on the fringes of the system it may be easy to find
> violators, though.
