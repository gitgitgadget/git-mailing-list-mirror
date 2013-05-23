From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 17:08:43 -0700
Message-ID: <7vvc6ah81g.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 02:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfJ5V-0007Z5-UW
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 02:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab3EWAIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 20:08:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab3EWAIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 20:08:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE2212650;
	Thu, 23 May 2013 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xgdb30k4ScVwxQTa7YAoD8qtIi8=; b=FdAtNk
	Cs02KOZRNAI+UDhILsb9rkRbAWj38ZWefNF/VkZDIu+VoSyGuUIrWgv0qDBFbzm1
	6oNu+zxMzEvn89oHQCxs7yCibMRls5rARH1CU9fLpshWxXCcrRIOnRxihOAsN7va
	8DqpDy2Mu7MFUtmC0tbUQnO/YTWYIqwpgSjNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YRyyaYSTJcuYXAq3jBK2KI3Pns8ogNUB
	JMyyXliI+M6B6kr1rloX0OcePT2AHJywiyPf+PErTYACwQxtxLfM161Nqtrj/bAl
	MXyuqP1UT0z9gN88d7X0ekvjUDnR3uirTpsF3ps97DZJIK+UxTPeY8YG/nKIU0cC
	RWjrppKLnHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE6812649;
	Thu, 23 May 2013 00:08:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 918F812644;
	Thu, 23 May 2013 00:08:44 +0000 (UTC)
In-Reply-To: <CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 22 May 2013 18:57:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEC7C9B4-C33C-11E2-9ED2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225207>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> IIRC, git-gui runs two blames, one without any -C and one with (I do
>> not offhand recall how many -C it uses) to show both.
>
> 'git blame' is a very expensive operation, perhaps we should add
> another option so users don't need to run two blames to find this.

Yes, you could add a "struct origin *suspect_in_the_same_file" next
to the current "struct origin *suspect" to the blame_entry in order
to represent the origin you would get if you were to stop at a "move
across files" event, and keep digging, when you are operating under
"-C -C" or higher mode.

That would make the result just as expensive as a single run of "-C
-C" (or higher mode) [*1*] without having to run an extra "git
blame" without any -C (even though that mode is much cheaper).

Representing the result for a terminal with reasonable width might
become unwieldy, but for --porcelain output format that should not
be a problem.


[Footnote]

*1* It would make it slightly more expensive than the current code,
    as it is very likely that you have to split a single blame_entry
    into many separate pieces.
