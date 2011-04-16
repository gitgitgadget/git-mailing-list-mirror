From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: store format option as an int
Date: Fri, 15 Apr 2011 23:14:57 -0700
Message-ID: <7vy63abu3i.fsf@alter.siamese.dyndns.org>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net> <20110416004544.GA5628@elie>
 <20110416013723.GA23105@sigill.intra.peff.net> <20110416052704.GA10807@elie>
 <20110416052959.GB10807@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:15:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAymr-0000Tq-Ua
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab1DPGPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:15:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1DPGPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:15:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E74E22A39;
	Sat, 16 Apr 2011 02:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vl8E4ypohC6jDauxammK1oHQ9u4=; b=DrVpYX
	7GgHrGOMrthmpuh62Ljzp2sUO8p1S/ihRyqam7zlMcvLMjBY6jnKBJdbMuKGGUpL
	LIGyeBbloN9txcUBASpNfooxwrVy6gMPHaHshqQiGFRjAQt8sqJp4mc89ig5AOOc
	tmeZxypsg2z4CavU6oGNzMQtD56wRueP9GLTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nh30a9WGZvntj7eLFtO1BU9lh7VYIHLA
	ZgatdnXSTKkDY00ZmYvY9GC70KM0vMNaCIKfI/jKiNS5YDKSNyx4n666XTFEA6be
	HvNTUwFe+ccyz4rcqZ0UiRnkWVkipzJGjYiSNC59bG+cDiC7xFWh3rRiAUD7Agbl
	Ma6GOPqGyrc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A230A2A37;
	Sat, 16 Apr 2011 02:17:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 517D52A32; Sat, 16 Apr 2011
 02:16:58 -0400 (EDT)
In-Reply-To: <20110416052959.GB10807@elie> (Jonathan Nieder's message of
 "Sat, 16 Apr 2011 00:29:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 258B35D4-67F1-11E0-A923-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171660>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> It is unsafe to pass a pointer to a value of enumerated type to
>> OPT_SET_INT (as v1.7.0-rc0~137^2~14, 2009-0905) does, since it might
>
> Agh, proofreading fail.  For the confused, this is supposed to read as
> "(as v1.7.0-rc0~137^2~14, status: refactor format option parsing,
> 2009-09-05) does".

Still ECANTPARSE.  Perhaps the "does" at the end should be inside the same
parentheses pair as "as v1.7.0-..."?
