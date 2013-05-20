From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Doc rebase: Describe rebase as excluding merge commits
Date: Mon, 20 May 2013 15:29:05 -0700
Message-ID: <7vwqqtthe6.fsf@alter.siamese.dyndns.org>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
	<1368964329-1600-2-git-send-email-philipoakley@iee.org>
	<20130519180804.GE3362@elie.Belkin>
	<7v1u92xnuw.fsf@alter.siamese.dyndns.org>
	<2F59222ECBA14673815BF42E6A7CE5A5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue May 21 00:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYZt-000329-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab3ETW3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:29:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172Ab3ETW3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:29:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68CEB20616;
	Mon, 20 May 2013 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nyi2DAx7ut5GJOh1jA7tfU5WZcE=; b=gJkeBs
	ncyIaFgDxlhH2x+J9vBzcqQSgpKTuh+VLPuuk9tdpjJRpgP70DbC3zOv2JZ8t+Ej
	VG9IEOjcRGyHQtljzuf+mVQRP+1plq1SxRC/oMxGdsj74atRTb1Ul3dYVjkzJch7
	K52OFzA9WnMlknO+YWdReWU0EZFdl64N9ZNpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrKxCdDcCVk/F6UOPpEKK8bVOmdf7wqw
	Xyi0fFNTlofugtWXbwo5o3MEWrsS3R2hd2HSYCXXazZ9BZRXMCWo3pGw/h9By/Ar
	4NObioL79euQEj4VV5lwJUOuvqwExKyAt3cLqw4WhOMCE/OGF6dLoZ0+NPMpHtEE
	C3xIXkSyPvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5EA20615;
	Mon, 20 May 2013 22:29:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF4B420612;
	Mon, 20 May 2013 22:29:06 +0000 (UTC)
In-Reply-To: <2F59222ECBA14673815BF42E6A7CE5A5@PhilipOakley> (Philip Oakley's
	message of "Mon, 20 May 2013 22:55:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEE65A00-C19C-11E2-8BDF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224988>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Monday, May 20, 2013 5:43 AM
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Philip Oakley wrote:
>>>
>>>> Describe rebase in the description section.
>>>
>>> It already does that. :)  I think you mean "start with a summary",
>>> which is a valuable improvement.
>>
>> It indeed is a good idea to give the "high-level introduction" at
>> the very beginning, but I do not think it should describe only one
>> of the three major modes of "git rebase" (i.e. no -m, no -i), like
>> the proposed patch text does.  We should instead say what it is used
>> for and why the user would want to use it that is common across
>> these modes at a very high level.
>
> That would repeat the NAME issue (of trying too hard to be exact &
> precise). This introductory text is that "summary".

If that is "summary", it should never talk about "skips merges",
which only applies to the mode without -m, no?

The highest level view of what the command is for (the motivation
why the user would want to consider learning how to use the command)
is "You have a history built on top of some commit, and you want to
rebuild the history on top of another commit, e.g. you earlier built
on the tip of a branch that has some other work, and you want to
rebuild the history on top of the updated tip of that other branch".

The details of how the history is "rebuilt" can differ while using
various modes of operation.  Some may skip merges, some may try to
preserve the topology, some may even let you insert new commits by
letting you tell it to stop in the middle.  That is not "summary"
but is part of mode specific description.
