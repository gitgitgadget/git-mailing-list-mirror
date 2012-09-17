From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 13:21:28 -0700
Message-ID: <7v4nmwv1rr.fsf@alter.siamese.dyndns.org>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
 <7v7grw2qcu.fsf@alter.siamese.dyndns.org>
 <505722DD.3000806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Mestnik\, Michael J - Eagan\, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:21:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhp8-0002Zg-Go
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab2IQUVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:21:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125Ab2IQUVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:21:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 649DF9D4C;
	Mon, 17 Sep 2012 16:21:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qa+7gZHppZ0tZG7CAhS9Zq2Bhls=; b=vdRU4k
	Y/AYYJjjT3bwT8ufbmvXiMbeik9ohmYIp1IFUcyd2eElGHSxZZPGyOydWOak9YKa
	daSxzj3fQoM8pGe7Mu9JW9FJv1AfMnuKhkMC/3CZkL2gwmKWep1CCACuyMHHonm9
	7TYLl7xq2Ond6z7YrItNsrd2QFutfAK/Hs/A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MynyYKNYwA6rTYedtDo+NTbidSCk65bx
	iAq+NsB06t2qAku0sk8VYdjbg6/epT4fAIWzz724mpMu4yBQEcjZcAmLmjc38MNw
	XDPfv1lB8sAhozn32IkIc4e6sYJzFklmqoDrLQihP7DHznEcZFh4p30phwUVEOJ/
	I221kk+RDS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AE59D4B;
	Mon, 17 Sep 2012 16:21:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A894A9D49; Mon, 17 Sep 2012
 16:21:29 -0400 (EDT)
In-Reply-To: <505722DD.3000806@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 17 Sep 2012 15:17:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43B5C1B0-0105-11E2-849F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205738>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 15.09.2012 00:26:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> 
>>>> you need to "rm file && git checkout file"). If the user has to
>>>> update $Id$ to match the current sha1 (by remembering to do a
>>>> more forceful checkout than checkout -f) then one half of that
>>>> feature is useless.
>>> 
>>> As if there is any value in "$Id$" _feature_.  It's a checkbox
>>> item, nothing more ;-).
>> 
>> Having said that, I think you could do something along this line (I 
>> am thinking aloud, so there may be leaps in the logic below).
>> ...
>
> You've convinced me not to try this in-core...

Quite contrary, I think the approach outlined is a reasonable way
forward.  I do not care about a checkbox feature like $Id$ that is
incomatible with the fundamental concept in Git, but the approach
would help people who started their history with wrong CRLF
settings, tweak the attributes and then scratch their head trying to
repeatedly run "checkout", "reset --hard", etc. and still never
seeing the right thing to happen.
