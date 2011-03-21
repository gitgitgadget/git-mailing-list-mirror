From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Mon, 21 Mar 2011 07:28:32 -0700
Message-ID: <7vfwqgtunj.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
 <20110321111643.GE16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 15:29:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1g6L-0004pA-3Y
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 15:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab1CUO2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 10:28:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab1CUO2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 10:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9F9B45B5;
	Mon, 21 Mar 2011 10:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pno83Be08fTZolW8UIKBW4VOna0=; b=khkrhC
	uxPFdr0UHquzT8d9sucLukjZ+Sfi8ZHEC5mWjTdxqwBHclFNloLegGuHMIMz7coK
	YzoDrQDQxaTIUYy872rcKiR9ItflwxxEdvnOqws6xb0gKK4l2S//MIcwWdeAhJeZ
	Lfay9WL+lMxwQUpqcSpa7OWLFLpY1vLIsP6ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fQjjhbx2kiDYKtgQS2iF8q+KjG1C7jCX
	O4rM+5p3eD2wBzMJbTKBFZb8lWR+vQ6aLtUP0L3IXCQvDB2C5D3yTwD/VH8V9tFU
	1Buq/lqvqlCCNXtxI5q6nNGqLbsEQU66bFp2r/G2oShSj1r5lbNVoEd3rPP5gPaE
	tkpKiIchWms=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 965CB45B4;
	Mon, 21 Mar 2011 10:30:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B28545A3; Mon, 21 Mar 2011
 10:30:11 -0400 (EDT)
In-Reply-To: <20110321111643.GE16334@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Mar 2011 07:16:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C08F79E8-53C7-11E0-A3CB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169597>

Jeff King <peff@peff.net> writes:

>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> 
>> > Junio C Hamano <gitster@pobox.com> writes:
>> >
>> >> Unfortunately
>> >> we do not have a good way to let people who have already heard
>> >> about the transition to squelch it yet.
>> >
>> > How about an advice.addWithoutPath config variable to disable it?
>> 
>> I don't think it is worth it; I'd rather see :/ magic implemented earlier.
>> 
>> Another possibility is to error out on "git add -u" without pathspec in a
>> subdirectory as an error in 1.8.0, and then make it full-tree in 1.8.X in
>> a distant future, but that wouldn't be as pleasant.
>
> I thought we cared about giving fans of the current behavior a way to
> keep it (without having to use additional syntax). Script-writers
> already need to use "./" to be portable to old versions of git, so it's
> not hurting them (unless you want to count N years into the future, when
> we can discount such old versions).

So you would rather have "addu.relativetocwd" configuration variable that
will warn when unset but the behaviour defaults to true for now, and later
flip to false?

I'd be in favor of that (the variable name can be painted in any color).
The patch series was an illustration of the logical conclusion of Duy's
patch that punted on the migration path, and if it showed it would not be
pleasant, it served its purpose ;-).
