From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 15:18:46 -0700
Message-ID: <7veho0erax.fsf@alter.siamese.dyndns.org>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com> <20120724182700.GI2939@burratino> <CAOeW2eHyLHGs3-Sd6X0b2Of1mFa1U8dCBU7L85_MJc4BY=BJmA@mail.gmail.com> <20120724212506.GA15798@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= 
	<pclouds@gmail.com>, Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:18:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StnRP-0004co-KB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 00:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab2GXWSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 18:18:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab2GXWSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 18:18:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C25D8A36;
	Tue, 24 Jul 2012 18:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9sNwPzuE1ZpB3fgphRKg8ngvQyE=; b=k7Wayc
	2Dv6taFNzIi4E8Vyze3be2LUi994sa7YGn2wHPuRAKjbY2+Oal0WdT8i1Y51Zds+
	XPhYQ7MOJSC1WtkdRfJL0D0QW0FCARZtpaaCqt7B95WpsSYkk+R7ZcAcNwInOfgn
	gRii6/+PM2jQOdL+vGeeqd6gr0PH5aOmnMyK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cVOs/mcTQusCwDtVqzeh5wSR2raeBMvp
	A+sF1gPhHCfnOGGZBiso5pveO+e7ywQonNFFJEwyJFURb9S4lLNJQgd8KCoe8SSY
	rA4tjUKIPqCwC4k6fWA6dUg3nJ1PkdobuVu4FUo9njwKwEuCu0pEAKKJJka6/ps0
	q9fD5gvLBxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB2F08A35;
	Tue, 24 Jul 2012 18:18:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68B198A33; Tue, 24 Jul 2012
 18:18:48 -0400 (EDT)
In-Reply-To: <20120724212506.GA15798@burratino> (Jonathan Nieder's message of
 "Tue, 24 Jul 2012 16:25:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A6C2C8C-D5DD-11E1-A7DF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202078>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I guess that means the intended justification is the following?
>
> 	The git am -d/--dotest option has errored out with a message
> 	since e72c7406 (am: remove support for -d .dotest, 2008-03-04).
> 	The error message about lack of support was eliminated along
> 	with other cleanups (probably by mistake) a year later by
> 	removing the option from the option table in 98ef23b3 (git-am:
> 	minor cleanups, 2009-01-28).
>
> 	But the code to handle -d and --dotest stayed around even though
> 	ever since then it could not be tripped.  Remove this dead code.
>
> 	Noticed because the error message starts with a '-' and
> 	xgettext does not cope well with that.

Looks good.
