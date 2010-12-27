From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Mon, 27 Dec 2010 12:58:35 -0800
Message-ID: <7vipyfx79g.fsf@alter.siamese.dyndns.org>
References: <m2wrnktcl2.wl%dave@boostpro.com>
 <20101208175324.GB5687@burratino> <m2oc8wt0xc.wl%dave@boostpro.com>
 <20101208220514.GA8865@burratino> <m2d3oo9cwr.wl%dave@boostpro.com>
 <20101227093729.GB1201@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 21:58:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXK9d-0000tu-1r
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 21:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab0L0U6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 15:58:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab0L0U6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 15:58:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C3F42431;
	Mon, 27 Dec 2010 15:59:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0R7g7WPMmJvrlWibPATxn4m9lH0=; b=H9rcGu
	sG8ouqjxwBNjaI8V8TFFPUkBgMdKjpsKwDsvbAYRpFHPbRhRS8t3XWrOqiScZ/D+
	CyEyHO5yXgtjNTFyAb+3D2QGLP6uBO0yM8IR3wfk32qQxp54XVX/6WmLqQYxLqYa
	ukNCe1gtvu+KCL0FAsd3almjWbYeIF7UxtEy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oY7VZWHLU1LoWZMa2OiuhRIkb4wCFCe6
	BgMoQG7RoH4bGcNwI7QKQ0okWTslUPPleuyLAfaI91Vox5FRtw0LBrA1YxibbnyU
	8QxakOwfSDHa7OOfuQfFnXwSjhq+4HlbYnDX3H+pSUSa72ocp6tgtQauOLwkcpIK
	XvU9NAKcnH0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16EF02430;
	Mon, 27 Dec 2010 15:59:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0163A242E; Mon, 27 Dec 2010
 15:59:09 -0500 (EST)
In-Reply-To: <20101227093729.GB1201@burratino> (Jonathan Nieder's message of
 "Mon\, 27 Dec 2010 03\:37\:29 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 291BB0C0-11FC-11E0-A89F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164222>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Dave Abrahams wrote:
>
>> if you're going to have a "pre-commit hook" concept,
>> but not run that hook for some kinds of commits, then that fact needs
>> to be documented.
>
> True, and thanks for a reminder.  Suggested wording?
>
> The current githooks(5) says
>
>  pre-commit
> 	This hook is invoked by git commit, and can be bypassed with
> 	--no-verify option.
>
> and leaves the question of whether it is invoked by git cherry-pick
> unanswered.

Huh?  Isn't it very clear that "git commit" calls it and "git status" or
anything that is not "git commit" doesn't?
