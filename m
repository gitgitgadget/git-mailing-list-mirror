From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 06 Apr 2012 10:41:58 -0700
Message-ID: <7vk41s21w9.fsf@alter.siamese.dyndns.org>
References: <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 19:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDAm-0005O4-U8
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 19:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578Ab2DFRmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 13:42:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756666Ab2DFRmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 13:42:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16BED7EC8;
	Fri,  6 Apr 2012 13:42:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mx0zkUJBZDkBFqfhHbrHBbj7k4k=; b=i5c0EP
	1ywS+/X7TElFjOJV+VGCsauxHfEC3ahH9q0146V5A8rv9mI9TKoSTrtB30ModcEP
	WAZGoQbW2RO9p4YDWQAJ4n1f1NKtTMyZ/iz4UcmKKAEv8T7+VZk5dap83FH8CFOt
	mC4Ha7M5aWODHSn0aayBMT67XYZ7k8CajvkcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dPSYabrPGY4Ctuo16FDHjvTaIzDFqfOY
	XJBl3TrZAuTHmYYgKWG/uSdXD82ZkTo54j0tcJmD4y3IgZQskUEAut9gGBRlejfN
	QNRcKbXkFFy3V4yBqakY8A8loGnJMoKuh/ccXt1iCaVPIswo1MH9ENqnjDvI/q3T
	tlFexwQolrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D5617EC7;
	Fri,  6 Apr 2012 13:42:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A83A7EBB; Fri,  6 Apr 2012
 13:41:59 -0400 (EDT)
In-Reply-To: <20120406080004.GA27940@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Apr 2012 04:00:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFBA79AC-800F-11E1-AD2C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194886>

Jeff King <peff@peff.net> writes:

> I would say without hesitation that fast-forwarding the upstream is more
> likely to be disastrous than creating a new branch. However,
> push.default=current can also fast-forward an existing branch (although
> if you have a local "foo" and its upstream is _not_ the remote "foo", I
> find it extremely unlikely that a remote "foo" also exists).
>
> On the other hand, one thing we have not talked about is how one gets
> into the "topic push fast-forwards master" situation. Which is running:
>
>   $ git checkout -b topic origin/master
>
> I'm not sure if that is something totally clueless people will run. And
> maybe by the time people are intermediate enough git users to run that,
> they will have figured out how upstream works. So maybe my concern is
> overblown....

I already said that I do not deeply care either way, and it appears that
only you two are the ones who deeply care *and* have things to say that
are worth listening to (we've seen many "me too wants upstream" without
deep thought a few weeks ago against the RFD).  Whichever way you two
agree to go eventually, could you come up with a (hopefully) small summary
of caveats that can be pasted in the future release notes that switches
the default away from the matching?

E.g. "The new default is now 'upstream', which does mostly what new people
do, but the user should not allow the default kick in in these situations:
A, B, C..."  It might end up saying "The new default is now 'current',..."
but the point is that either semantics would need to come with a warning.

Thanks.
