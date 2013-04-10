From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase : knowing where I am...
Date: Wed, 10 Apr 2013 12:28:02 -0700
Message-ID: <7v4nfembi5.fsf@alter.siamese.dyndns.org>
References: <1124759476.1420642.1365583233806.JavaMail.root@openwide.fr>
 <7vvc7umey0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0h1-0002cx-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934746Ab3DJT2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:28:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932924Ab3DJT2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:28:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 678E215ACB;
	Wed, 10 Apr 2013 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BN7Z4Hls9MCfIX1A6FmZ+dddYEs=; b=iBtem4
	5EQE4mL1RMdoVkgK3lhwCxe3tXwl6WaGK83M1h84c95+Q1D2W7crt4Ar7ObeATb8
	EymI3ehsJomQzINJ/s+aPyQoI9wVDP0edszW/TxLD47k2OjXgV9PAK5wBKXTbr4v
	1BAhsgp54Jgv5A6p1IcNbs5gVgm+TGjACdOMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8trFEkgiTQ6qIY2GlTpd1cYzIVG6I1X
	O3RJ7o00ZDMgDzpZqQhvuPsknHNI+D4/GE6DCIOLQKfRPnm8ozo+PyTZ5MROYVhS
	PR5tmAgLZk279/UBZzvDV0PTwypRLQVtbldy9LsNqXl/nsurIrWEXtNgAgD9KGST
	cLKQv1mqOLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F22A15AC9;
	Wed, 10 Apr 2013 19:28:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0BA615ABC; Wed, 10 Apr
 2013 19:28:03 +0000 (UTC)
In-Reply-To: <7vvc7umey0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 10 Apr 2013 11:13:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C37302B8-A214-11E2-983D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220732>

Junio C Hamano <gitster@pobox.com> writes:

> Jeremy Rosen <jeremy.rosen@openwide.fr> writes:
>
>> is there some way to know how far you are within a rebase when the
>> rebase is interupted by a conflict other than the message given by
>> git rebase when it was interrupted ?
>
> I do not think there is a "git $anything" command to do that, but in
> the meantime you could "cat .git/rebase-*/git-rebase-todo" or
> something.
>
> Recent trend is to teach "git status" more about these internal states,
> so with time the command may learn to include this in its output.

I actually often do this myself, not "cat anything" as I mentioned
above:

	git show-branch $branch_I_am_rebasing HEAD
