From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Tue, 13 Mar 2012 10:41:14 -0700
Message-ID: <7v7gyoxuth.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <vpqy5r44zg7.fsf@bauges.imag.fr> <7vehswljxi.fsf@alter.siamese.dyndns.org>
 <4F5F60C5.6020900@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 13 18:41:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Vit-0004Vh-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839Ab2CMRlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:41:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757562Ab2CMRlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:41:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF7D7E9F;
	Tue, 13 Mar 2012 13:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kv37+fnH8KMaQ/uIiuVkDRCU1DI=; b=S9m587
	2/gHYuiQVeXjvt/Fd4Th0v/GyEFJuf90ayxI4jxZ2d+KsXMe2ZgY9lWksR3RXIUb
	9jQR1qjseVYAW5Cu7sILkkSBrMw3859SOwJ05CYdHsH06jNq4DC6woFMPdfa0w0I
	0YIwHqXonzq3KA9cKXBM82oSY1g5iJ1Mlq/dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bvNQRRMABQ82fcezbfytgKXiFmuDwz+D
	rpAbk4RYHrNtWbXIiKUthsP1F3auCdjfKR5KPJM1v+6NYXX7zWsVhZnxcVx904R/
	kH2TFkVaHtjkSI3Jc6mr74AzlLnXSI6PVjlnMRxVWKFIaVVuy0cOPxiRYrjRIIS0
	TYWA7yZSrF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E378F7E9E;
	Tue, 13 Mar 2012 13:41:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FDC37E9C; Tue, 13 Mar 2012
 13:41:15 -0400 (EDT)
In-Reply-To: <4F5F60C5.6020900@ira.uka.de> (Holger Hellmuth's message of
 "Tue, 13 Mar 2012 15:59:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB8B0490-6D33-11E1-A1CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193040>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> On 13.03.2012 14:17, Junio C Hamano wrote:
>> that is required to understand it is greater.  Also the current
>> implementation of 'upstream' has some weird semantics (or undesigned
>> bugs) pointed out by Peff, which would make it even more confusing.
>
> If Peff's "push to same branch in a different remote" is a bug (and
> IMHO it is) it should not count as a reason for what should be the
> default.

I may phrased it poorly, but I don't think you mean "if the bug is fixed,
then the behaviour of upstream is simple and easy to understand".  The
very reason the bug exists in the first place is that the semantics that
mode wants to give its users is complex enough that even the people who
should know (i.e. those who implement it) overlooked that there is a
corner case their implementation was not handling. It is a demonstration
that upstream is not an easy-to-understand choice to throw at new people.

> By the way, the documentation is very confusing in its description
> what git push without parameters does. For example it is not really
> explained in the description or options part, the only explanation is
> in the Examples. There "git push" points to "git push origin" and:
> -------------
> "git push origin
>            Without additional configuration, works like git push origin :.
>
>            The default behavior of this command when no <refspec> is
> given can be configured by setting the push option of the
>            remote.
> ------------
>
> Now the refspec documentation never says anything about what '.' means
> (the only docu about refspecs I could find is in pull-fetch-param.txt

That should read:

	... works like "git push origin :".

That dot you see after the colon is a full-stop for the sentence, not a
part of any refspec.


> Is this patchworthy (in that case I'll try to make one) or did I just
> not read at the right places?

It is patch-worthy; you already know that it made you waste time looking
for ':.'---the documentation shouldn't have done that.
