From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git mergetool ignores configured command line
Date: Sun, 23 Oct 2011 02:52:19 -0700
Message-ID: <7vaa8s592k.fsf@alter.siamese.dyndns.org>
References: <CAARCrw6D7CKy2Jn43zUZ3EefyqdY6Tk4A39ZQ74H6hySA5eCBQ@mail.gmail.com>
 <m21uu4hzmq.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Vladimirov <alexander.idkfa.vladimirov@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Oct 23 11:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHujC-0001ac-Fd
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 11:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab1JWJwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 05:52:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab1JWJwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 05:52:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE513347;
	Sun, 23 Oct 2011 05:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QxGIOUP5M5K4CmAb+2q+sDOOoJo=; b=H4LC74
	pr+if+KbAYBrACvfO1oIDcTyPf038QMTZlG/asTkiUetH4Tc7tRq5P3ojqcHZsoQ
	C/oOmjsFkLoRfrYKzYV0cWC9UlPvrHxt2QE/qZ0jK8CXCMS40xKOhva0i5PlqSd7
	WTx2HSjehM+4/AW6eWTQRsh6VJIZNMR73C6Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvKVJIR5aXjN578V7Dd0lKIehpD5Xg5l
	iSv7NsPkcNgVW+FAhSt2KzsKmBg+KeUkZ05RIbrq6/UOgwaw9mCuXK78H31ZtJUH
	gTPVr6XDn6pz9jxV4RmbzQMw3cJ0pmMj4PxzQGQ92LQLLKDjUeb+sMj9lcOA0GF9
	iG/fJhbqPn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 383F83346;
	Sun, 23 Oct 2011 05:52:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9C973342; Sun, 23 Oct 2011
 05:52:20 -0400 (EDT)
In-Reply-To: <m21uu4hzmq.fsf@linux-m68k.org> (Andreas Schwab's message of
 "Sun, 23 Oct 2011 10:37:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B347348A-FD5C-11E0-9CF8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184132>

Andreas Schwab <schwab@linux-m68k.org> writes:

> diffuse is already a predefined merge tool, so mergetool.diffuse.cmd is
> ignored.  Try using a different name.

I wonder if we can improve this, though.

It is nice that we give canned definition of argument order to so many
obscure tools, but instead of ignoring mergetool.<tool>.cmd when the user
told us to use <tool>, couldn't we simply ignore what we have internally
as canned definition?

Even if such a change were too intrusive (I didn't check), could we have
a decency to at least warn that we are ignoring the configuration?
