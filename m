From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Mon, 12 Mar 2012 12:33:10 -0700
Message-ID: <7v7gypsjgp.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <7vfwddskon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:33:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Aze-0003Tm-D0
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab2CLTdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:33:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851Ab2CLTdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:33:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF23B7DFA;
	Mon, 12 Mar 2012 15:33:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R8sqeXNaKkZpexczfKUAEH1n8KA=; b=mH8x/M
	mgGcVQ0g47J7BPSQh+33GdKa6HIXfG+ICRlIs/aRPibqXHxrxw5ViKcV6/NItM4I
	cKHqVodvhuQxQ2MFWa5ZOWz0jdfIP4esdXu/dlxkQrhqSqIvwzNtujOI6onGNKxN
	Y+Kasa7rZRUb+b6KkmN9+EEF8sLN8kSy94TIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X606Tvoz1WwgAo/j6X3wQyVVUmLaS15b
	xTFmR9bEzOtzxQQAru5BRffyFar7P4pHC1yWniQPvdofov0YZ3Uj5Ggz66nXE/zj
	G0BdJRdjo9i5K7gbF6dXYN3Qe5vFQFDwptaUpL3jEVE1mBPumGF8t5cyVOFW6j/6
	7TQ3juVYqyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D661D7DF9;
	Mon, 12 Mar 2012 15:33:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66A757DF8; Mon, 12 Mar 2012
 15:33:12 -0400 (EDT)
In-Reply-To: <7vfwddskon.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 12 Mar 2012 12:06:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34BB409C-6C7A-11E1-8D0E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192931>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ... This is not a push.default issue,
>> but I think it is somewhat related, and maybe worth discussing along
>> with the topic of asymmetry. ...
>> I've mostly trained my fingers to type "git push
>> <my-publish-repo>", but I do occasionally forget.
>
> In an assymmetric set-up, you would typically push into one place
> but update from one or more places, so it might make sense to make
> it easier to say "git push" and "git pull $there".  But that does
> not solve the fundamental issue, I would think.
>
>> Do other people with
>> asymmetric workflows find this annoying? Do they not care? Or are many
>> fewer people doing asymmetric things than I think?
>
> I think it is not "they do not care", but "they do not have a good
> solution".  I do not think of anything offhand, either.

Actually, we could introduce branch.$name.pushRemote that overrides
branch.$name.remote only for pushes.

Before anybody makes an ill-conceived comment, remote.$name.pushURL
is not to be used for this purpose.  It is only about how to get to
the named remote repository, and git still considers remote.$name to
be logically the same remote. "git push" into the named remote will
still update the remote tracking branch that we would update if we
were to immediately turn around and run "git fetch" from that same
remote, and abusing remote.$name.pushURL for triangular setup will
not give us a correct behaviour.
