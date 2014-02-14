From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 11:10:50 -0800
Message-ID: <xmqqha81ik79.fsf@gitster.dls.corp.google.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
	<87d2ip3ac9.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOA8-00056o-5g
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbaBNTK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:10:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbaBNTKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 14:10:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2F26C19D;
	Fri, 14 Feb 2014 14:10:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6+yPiv1xh2BqsVjCrMOY7wmrU58=; b=GuBuv3
	eixyU1/nICtna3VX7XVe77OOrUGVB7glRgINIYlcV122tl0dBsbbuSJ7H15ecQdo
	l4rqderSCRXXedMMPIvFyN/SceJh42h/agx9VKtaHF/kNaIOO2NXZKmseGElK0Il
	Cj06J+XMLrdvqyawN47DxhkrAPqeFeaXtrgYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bmm3CXVVMQe/TKgmI9+tP2jB2gbtO5ua
	XVSU3hVXhT0mYhboR5miyKdOjKGEK9gNoG4+LaM8MLGl0d4f1Y+HGEfqH2m8NFBh
	mu9G41MaSJKxGKsVvFsReukyzj+XgdSju/OxIxhFOdbFne4kUSth7YPn7DL1F2+H
	w2RUejNDg7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DDB46C19A;
	Fri, 14 Feb 2014 14:10:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F7C46C197;
	Fri, 14 Feb 2014 14:10:53 -0500 (EST)
In-Reply-To: <87d2ip3ac9.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 14 Feb 2014 17:52:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B989565E-95AB-11E3-A7A3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242122>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>>  A. Because it will confuse you.
>>  B. I know what I am doing.
>>  A. ???
>
> A. But maybe Git will no longer know what you are doing.  Its standard
> way of resolving references will mean that once a branch
> refs/heads/wibble exists, referring to a branch wibble will become extra
> hard.  For example, stuff like
>
> push origin HEAD:refs/heads/wibble
>
> will maybe create or update a new branch wibble, or maybe it will just
> push to the existing branch refs/heads/wibble.

I suspect that is a bad example (do refs on _our_ side influence how
RHS of the colon that names refs on the other side is interpreted),
but I think I know what you are trying to say.  But Git never knows
what you are doing---it just does what you tell it to, so it comes
back to "It will confuse you to the point that you would not be able
to guess what Git will do matches your expectation".  Whenever I
tell them that, a counterpoint B. makes is still "I know what I am
doing.", which is stubborn, rather obvious, and unfortunate.

How much of the namespace are we willing to carve out if we were to
go this route anyway?  Things we use, i.e. refs/heads and refs/tags,
would be no-brainers, but do we also forbid refs/review, which we
ourselves do not use but some people may have in their repositories?
Anything that begins with refs/?  Anything that begins with refs/
and has more than two slashes in it?
