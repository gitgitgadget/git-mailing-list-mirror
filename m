From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: support python3 in the tests
Date: Mon, 25 Apr 2016 15:07:36 -0700
Message-ID: <xmqqzishibpz.fsf@gitster.mtv.corp.google.com>
References: <1461420826-4416-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auofQ-0004Og-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 00:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbcDYWHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 18:07:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965020AbcDYWHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 18:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D81015588;
	Mon, 25 Apr 2016 18:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCmkduzXY7DkCv+EsmYFgKw6A7c=; b=d4L2Pp
	qeAdjoFhyyd7IisV+qhtcnYleaRvyM6haNeZcWdbvp+zgzNZjlwaInPbwT5GI4qm
	1YsI76M4thq00sIejomPpegkrpNUAyR4gRvY3jRNTsXLMpMELIda1LUUAvoy9AHn
	wZtKAQ8r/vzW05wFn5Lbd31qvH0qIS3w43REg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROU22cLdyFn2zmjnza+L3JwMbEs8kyqF
	Zb2HAkfL27/LSeo1AgqKKti+ArSdZfq6XduofcdTcrHnnw998AoSnBki7j6iiaRS
	bRAUTI8CZt5xlh+mBrCQuRv78RmZ38HfXHsPto4ySyiN/ZykgYlqV3YyrJsR8Ikd
	GYzDHceQXnw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 939EB15587;
	Mon, 25 Apr 2016 18:07:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03F8815586;
	Mon, 25 Apr 2016 18:07:37 -0400 (EDT)
In-Reply-To: <1461420826-4416-1-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Sat, 23 Apr 2016 15:13:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F27A2BA-0B32-11E6-8982-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292575>

Luke Diamand <luke@diamand.org> writes:

> This patchset updates the git-p4 tests so that they work with
> either Python2 or Python3.
>
> Note that this does *not* fix git-p4 to work with Python3 - that's
> a much bigger challenge.

We use Python outside p4 tests (e.g. remote-svn test), and the way
they invoke the interpreter is to say "$PYTHON_PATH" and avoid
saying "python" which picks whatever random version of Python
interpreter happens to be the first on $PATH.  Shouldn't the tests
touched by this series be doing the same?


>
> Luke Diamand (2):
>   git-p4 tests: cd to testdir before running python
>   git-p4 tests: work with python3 as well as python2
>
>  t/lib-git-p4.sh            | 7 ++++---
>  t/t9802-git-p4-filetype.sh | 6 +++---
>  2 files changed, 7 insertions(+), 6 deletions(-)
