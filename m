From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Import git log into a spreadsheet
Date: Tue, 24 Feb 2015 12:08:08 -0800
Message-ID: <xmqq7fv7qdhz.fsf@gitster.dls.corp.google.com>
References: <54ECD9A9.4090507@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 21:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQLmE-00080q-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 21:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbbBXUIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 15:08:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbbBXUIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 15:08:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6793E39F48;
	Tue, 24 Feb 2015 15:08:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VjoNJmfzHvAn325tjlqLU5O2bJo=; b=pdUwJH
	kX35KfKOOvrrfvrudyju8EY40qLqNxRXd13Rcl8JlSKwSFQOCjrhndOXOWZtNMs4
	rH0QNF2EBaRN8s6FRlEQ+x2032J/DiEK//x5Kc4Ki/uqv++e0EkI3qpKJscWgGU7
	/7b5QqHWc6XcW+VuFcYsq6EdC0KWHh0XA9aMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kjYnEnWFF7wMjm4v/lSoSCZm6U4X1lwX
	Idi4QyWHagYK/sWRfjXpcfxpb7cmwHvoAAAA55d8OwH7fDQFqyT1086bqzfVrMUR
	un7STIf8ok+03WDMXFW2ZhVgD5NEu2yRaWnxMYB8f3Z7PcV+TQtUQ+t1SbYteadX
	L6mLdPDf8Y4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EF1A39F47;
	Tue, 24 Feb 2015 15:08:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2A1039F46;
	Tue, 24 Feb 2015 15:08:09 -0500 (EST)
In-Reply-To: <54ECD9A9.4090507@ubuntu.com> (Phillip Susi's message of "Tue, 24
	Feb 2015 15:06:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA953642-BC60-11E4-9C4D-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264342>

Phillip Susi <psusi@ubuntu.com> writes:

> I'm trying to import a git log into a spreadsheet.  I used a simple
> --pretty=format: switch to select the fields I wanted and separate
> them with commas to generate a CSV file that can be imported.  The
> message body, however, is presenting a problem.  The first problem is
> that it contains newlines itself, which normally signal the start of a
> new record.  It turns out that even when quoting the field, MS Excel
> still fails to import it properly ( good grief MS ), but openoffice
> calc does.  The second problem is that the body itself may contain quotes.
>
> I can't figure out a good way to deal with these quotes.  It seems
> that replacing them with a pair of quotes should make the CSV valid,
> but how can I replace only those quotes internal to the field without
> replacing the quotes that actually bracket it?  Is it possible to have
> git log use a NULL terminator between records instead of a new line?
> Or is there a better way of going about this?

I think --pretty=format: (or --format) gives you a way to specify
the literal NUL.  Also perhaps look at the -z option?
