From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 09:12:45 -0800
Message-ID: <7vtyg6tu9e.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net>
 <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net>
 <buod3muswq7.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 18:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp1z7-0007AT-Ae
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab1BNRNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 12:13:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab1BNRNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 12:13:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAE95300A;
	Mon, 14 Feb 2011 12:14:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uZxgemzHKbCuMC4Mbn1GWkoj2V0=; b=dr5f+a
	BzBZjF9v8P/OX3lK+hTgk4kzvcUmPELoumdS8Bsz4HcqqHMqG4R7sngJMegPAFwZ
	bnKEYZFBZHpbPuv4Kyq3kqT8Szt3Oe+njv5s0iMF28iR0hJG1cEsF3AQUbf3YeNE
	w+Wi/FXdfi4rg5aQKLRgeYbMep5eCG1UwEX2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Md8ZAiMCsgfoWvIl3RFIKNzaOo3gV8SX
	5mYyMWZFzbkFarbae4g4liQMJRbkfnsN2h0+3iNGWB1TWWIGaUtxd/kaydq7SqEK
	FdMJdBIGkZZKD0UbZkp7/RU+rHoIR8Tuj6kR5Ws3VUwN7xR9r+6DUVRAcFB3PF/E
	fyAl9WYEF+4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C75D3009;
	Mon, 14 Feb 2011 12:14:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A0CEA3005; Mon, 14 Feb 2011
 12:13:53 -0500 (EST)
In-Reply-To: <buod3muswq7.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Mon\, 14 Feb 2011 20\:04\:48 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D13211B4-385D-11E0-AFEB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166736>

Miles Bader <miles@gnu.org> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> Short options should really not be "wasted" easily. "-s" named after "to
>> stage" is really problematic, as outlined in this thread.
>
> Er, but the point is that this is _such_ a common operation, that a
> short option for it would not be "wasted" at all.

True, but I am afraid "-c" is not it, as it would certainly be confusing
to users who know what "diff" does before they learn "git diff".

And I'd like to also keep "-i" open for "ignore case", which I actually
wished the other day while reviewing a topic.  Unlike "-c", I might
implement it myself not in a distant future when I find time.

Using "-I" (as an abbreviation for "index-only") is tempting, though.

Both "-i" and "-I" are GNU extensions, and the latter traditionally was
useful primarily to ignore cruft left in the file with use of "$Id$", but
we actively discourage its use in git controlled projects, so taking it
over might not be such a big issue.
