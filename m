From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is anyone working on a next-gen Git protocol (Re: [PATCH v3 0/8]
 Hiding refs)
Date: Tue, 05 Feb 2013 08:03:11 -0800
Message-ID: <7vfw1avjcw.fsf@alter.siamese.dyndns.org>
References: <CACBZZX7G=V9L+zEA2MQFjQW8tRA0i1Gk3nUYdg5dDy35v74SEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:03:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2kzj-0004T4-Le
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab3BEQDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 11:03:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab3BEQDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 11:03:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B1AACC50;
	Tue,  5 Feb 2013 11:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MG2vxjytKvDB
	ywjmnIVP5XArq0o=; b=L2tuK4NcGNY5Rf11uD57prYQwL1Bzkaku4qQM6FAIevO
	TAutqZVnUVXqB4SSmCqyWPdtHeYOQgudh6wqVrBBhn64eOy3QQK0YhYC3NZaIcQR
	KNMlsgfKGT25TxzW16hKwOeOJo7NElDXyIHMSAgc0V/xEVKeMmFwfSPh9lfHGGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FjRk02
	a6I4JRJh/yshLckbE9DgtqMXHa5aEb5FgwpzOxMQbCATKwFvYBSXaLmWDVhOzDXO
	oc7IOQsb0PvKV333+aBklhmKYT7FaO5cQPZoMvXHd5YymaCSAcDrfs9rWgdW9kCm
	KuoqNPwfeFU+Warfxj1bEqRawN66K2XG3cwgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F0EECC4F;
	Tue,  5 Feb 2013 11:03:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE0D1CC4D; Tue,  5 Feb 2013
 11:03:12 -0500 (EST)
In-Reply-To: <CACBZZX7G=V9L+zEA2MQFjQW8tRA0i1Gk3nUYdg5dDy35v74SEw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Feb
 2013 12:14:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B276FB4-6FAD-11E2-AEF3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215509>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Do you have any plans for something that *does* have the reduction of
> network bandwidth as a primary goal?

Uncluttering gives reduction of bandwidth anyway, so I do not see
much point in the distinction you seem to be making.

> Is this what you've been working on? Because if so I misunderstood yo=
u
> thinking you were going to work on something that gave clients the
> ability specify what they wanted before the initial ref advertisement=
=2E
> ...
> 4. http://thread.gmane.org/gmane.comp.version-control.git/207190

"Who speaks first" mentioned in 4. above, was primarily about
"delaying ref advertisement", which would be a larger protocol
change.  Nobody seems to have attacked it since it was discussed,
and I was tired of hearing nothing but complaints and whines.  This
"hiding refs" series was done as a cheaper way to solve a related
issue, without having to wait for the solution of "delaying
advertisement", which is an orthogonal issue.
