From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: replace an echo command by printf
Date: Mon, 17 Mar 2014 12:22:36 -0700
Message-ID: <xmqqa9coeikj.fsf@gitster.dls.corp.google.com>
References: <20140314235642.GA6917@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Uwe Storbeck <uwe@ibr.ch>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:22:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPd7g-00063i-DK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbaCQTWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbaCQTWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:22:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93BC76647;
	Mon, 17 Mar 2014 15:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nz5fhnqzL9hzxcyybSvBvKVb6SQ=; b=R+zdKK
	qoHiavnSeP7Qbh6imMeOqjM3PgaM1/095cF+5lyz34iqeivIi8WW2izLeOzo8xzX
	Q6BQBa1ywDzUqWM8R2FVYk+CBDxChUuoSmK18PKTnafb0tQ4RZ/47/2WIIkovHIC
	TaS2yVjIEMYoMU3wqP2xc99RmDCZ4tckP/hHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KHhI8G56yUqsfnVh0N7PCZ/6jovP4CEg
	7VQzar3kAYIsVllsJY1VPJBl9+eHMM4SkgeWZU89H6fcFT43zQidJsuD05QoZpSE
	PV/UKqpZ1MnNzYPIINvt2CTAmblITuo2pyBBVNV3hNEEdTd175S2iZFQE5V01ldO
	DSpYpUu29vA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C70B876645;
	Mon, 17 Mar 2014 15:22:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8A057662F;
	Mon, 17 Mar 2014 15:22:49 -0400 (EDT)
In-Reply-To: <20140314235642.GA6917@ibr.ch> (Uwe Storbeck's message of "Sat,
	15 Mar 2014 00:56:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 874A2AA8-AE09-11E3-AD85-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244270>

Uwe Storbeck <uwe@ibr.ch> writes:

> to avoid shell dependent behavior.

Please do not start the body of the log message half-sentence.  The
title ought to be a freestanding "title", not just a beginning half
of a sentence that needs to be read with the rest to be understood.

Something like this, perhaps.

    Subject: [PATCH] rebase -i: do not "echo" random user-supplied strings

    In some places we "echo" a string that come from a commit log message,
    which may have a backslash sequence that is interpreted by shells
    (POSIX.1 allows this), most notably "dash".

    A commit message which contains the string '\n' (or ends with the
    string '\c') may result in a garbage line in the todo list of an
    interactive rebase which causes the rebase to fail.

Will tentatively queue with the above rewrite, but if you feel
strongly, please send an replacement.

Thanks.
