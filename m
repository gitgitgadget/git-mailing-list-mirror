From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5570 - not cloned error
Date: Tue, 05 May 2015 15:01:05 -0700
Message-ID: <xmqqr3qud6qm.fsf@gitster.dls.corp.google.com>
References: <013701d08769$a5bbab80$f1330280$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	"'Joachim Schmitz'" <jojo@schmitz-digital.de>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed May 06 00:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypktv-0004jY-KW
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 00:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbbEEWBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 18:01:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374AbbEEWBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 18:01:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D25DC4DDD8;
	Tue,  5 May 2015 18:01:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K/GGIZMF+ABpVWqn7iJcvJ1CNQc=; b=C+4xLq
	p5Ub/DUVwzZxFvl/dupFfy1erPJ7CFivhRil084zai8e6srTIUJDBJ4ZMjUqN6H8
	PMZX4rWYIxt+XS0T9qViK3Q1CozzHYh9+htzlUiCPlgWca3PhxA8ZOk63MxF+xip
	K9ddehVKMhJnfgCSV53taT8NPWLrX1XWpHVVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iQ8My7nu4zrkdS4YBa4KEVnaboty42g7
	1FShRfB4jevXUcN6M8zKhI/EVLNrh1fr7IIQwDygOgjOTvomhTfBN0lY14xL4Jv9
	4PCdZX5GL9TlNn7PERo7dPMVYL2HypiXubD8ZSBJbgnuqp4vMQUqxInCQU9Z3On5
	9vEamtNhBuE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C92DB4DDD7;
	Tue,  5 May 2015 18:01:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A38E4DDD4;
	Tue,  5 May 2015 18:01:07 -0400 (EDT)
In-Reply-To: <013701d08769$a5bbab80$f1330280$@nexbridge.com> (Randall
	S. Becker's message of "Tue, 5 May 2015 15:28:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B2C331E-F372-11E4-A42C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268427>

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> We definitely have an issue with localhost. When forcing the DNS resolver to
> return 127.0.0.1, we pass 1-16 then 17 fails as I expected to happen based
> on my DNS futzing. Heads up that this test is not-surprisingly sensitive to
> DNS problems. My environment is still in a messy state where I can reproduce
> the original problem so it might be a useful moment for me to find a way to
> modify the test script to harden it. Any suggestion on that score
> (as in where and roughly how it might be made more reliable)?

I do not think this counts as a useful "suggestion", but is this
"resolver does not work for local as expected" case even worth
protecting our tests against?
