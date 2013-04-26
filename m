From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/11] Add new git-related helper to contrib
Date: Fri, 26 Apr 2013 16:01:02 -0700
Message-ID: <7vhaisvqvl.fsf@alter.siamese.dyndns.org>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
	<1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0nvWvicFAJEqe0jC+zT3ZvA=Qx3MWXK36zYb2-uYV-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 01:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVrdf-0003FG-D6
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 01:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab3DZXBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 19:01:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab3DZXBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 19:01:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2B61AC62;
	Fri, 26 Apr 2013 23:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OjIxqxVQxKAIaqKRNO4KoG1HqBk=; b=RZad64
	LMV4VAPTXV7VPzLdKR5cho0LmSFb86O3OmcK+HkXT50bL9nC9Gv7Pmnfzdlf0a+7
	l8Kf+59DhrqhL6zUkAUvbI4k/QkF1xzB3zt2k5NR0+4EdWQB1hcqr4K1vbGQDtZC
	UZg8ecGRxOFqqnt5/jBlA0MUvKJMnYNVVPO9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HA5QsbxYY+1AbvTmT/0Lfc4h2sEnUsm5
	v8yJs8gA4KwNLFYO9IA/wiy4rCcJnif7pKvGVxEVO1U6G2J5RieU05ihHw/55J/E
	5Rj5R44vANcl3NRJLWSHbY/fWkXXhEjBHXWXkL+++PjakHSxbx8fW3YEQF1YZAAE
	aWIwUrGp95w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3345E1AC61;
	Fri, 26 Apr 2013 23:01:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC3E21AC60;
	Fri, 26 Apr 2013 23:01:03 +0000 (UTC)
In-Reply-To: <CAMP44s0nvWvicFAJEqe0jC+zT3ZvA=Qx3MWXK36zYb2-uYV-aA@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 17:52:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B8FC4DC-AEC5-11E2-B9B5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222603>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 25, 2013 at 2:59 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This script find people that might be interested in a patch, by going
>> back through the history for each single hunk modified, and finding
>> people that reviewed, acknowledge, signed, or authored the code the
>> patch is modifying.
>>
>> It does this by running 'git blame' incrementally on each hunk, and then
>> parsing the commit message. After gathering all the relevant people, it
>> groups them to show what exactly was their role when the participated in
>> the development of the relevant commit, and on how many relevant commits
>> they participated. They are only displayed if they pass a minimum
>> threshold of participation.
>
> Is this patch still not understandable?

Among the people who review patches here and give usable feedback,
earlier this week Peff said he is away from his mailbox for the rest
of the week, and I am not reviewing any new topics that are not in
'next', being busy in preparation for -rc0, so I wouldn't be able to
answer that question.

I do not know about the others, but it is understandable from time
to time there is a period a series is not being reviewed by anybody.
