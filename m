From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 15:18:41 -0700
Message-ID: <7viq3bfrjy.fsf@alter.siamese.dyndns.org>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino> <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
 <87tymwzjbk.fsf@catnip.gol.com>
 <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
 <7vr5hzg1u1.fsf@alter.siamese.dyndns.org> <20100815194913.GB1856@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 00:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OklXm-0007qj-Ka
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 00:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab0HOWTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 18:19:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab0HOWS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 18:18:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DD45CD37B;
	Sun, 15 Aug 2010 18:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wh/oSnj14nz8
	GUesB7v3AREuuGA=; b=PgNtlQyDhveUEaRkoqfILQ1VzkjyyunYfzLEYxLI/rdV
	uIDv+OZxRUPRPacYkpnx8ZIBDBQr8IWaiKluxxEGFfnT1iW14CkoGLDIX2uiFX5F
	ZAiAbmihvrsruLYoyCW4HX8Z46lT58zlVeCRQgIG9Si7azOhh01eVzxL3Qs92Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fXLC0V
	ZIqF7n+E73N3b81ASXwKf9EvftR3ZqbeCTsCtj0WO0H121EiV8Poc8UqKg5QmirD
	3zC5RhtEpD3V7n7FsCmz/U8F8E/6NrwewohpB47I79k/p9r8IDdCQdjOrMksG4FT
	2dUK+yJ2RN547ni3M4M/roqvNTD58o7Q3eCSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41BC8CD374;
	Sun, 15 Aug 2010 18:18:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C5CFCD371; Sun, 15 Aug
 2010 18:18:45 -0400 (EDT)
In-Reply-To: <20100815194913.GB1856@burratino> (Jonathan Nieder's message of
 "Sun\, 15 Aug 2010 14\:49\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1531C2FC-A8BB-11DF-ABDC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153624>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nothing major.  It would be the same inconsistency as we currently ha=
ve
> between "checkout <commit> -- <pathspec>" and "checkout <commit> --":
> one updates the HEAD (or rather, for "reset", the current branch),
> while the other doesn=E2=80=99t.

What do you mean by inconsistency?  One is checking out the whole branc=
h
to work on the named branch, while the other is checking out individual
paths out of branch to work on them in the current branch.

They are entirely different operations.
