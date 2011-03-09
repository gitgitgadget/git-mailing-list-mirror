From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Wed, 09 Mar 2011 12:17:53 -0800
Message-ID: <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPpm-0003IN-0c
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab1CIUSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:18:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1CIUSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:18:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A664F3C1F;
	Wed,  9 Mar 2011 15:19:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DwzlRzXzqZc6Jbys4phb0XOark=; b=jidSS3
	zJjxRF1UxOFBDxRbIEMFeB8budcStsxsCv0jAasoygYbJiL7hETYRP4osDeCjudM
	5kOW38O1lVX/Jcib9SgImMdIMQWHSv7ITUrTkDg2Y0UawJXmP7cmhwa87i+bForR
	h8Yo9M+BTkf9f0f1vW2SgabB3gSDM2GaDseM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SITcvTHwQ7YKPgbkIXsojz+OLGz/Um8U
	fD3atKY1QP1eoXz3FCYokf5x3+W8iynMk+FjO6izLzMea6xM8k9d0CnEwnNdREdw
	ZPw/bhHur0oMoVPPAOtML/8Yvx4ei7dookUGB2M+j6rd59kMCKzeqR4UFV8tSkml
	WLtC00uXFWs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 61BE53C1E;
	Wed,  9 Mar 2011 15:19:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 025223C1D; Wed,  9 Mar 2011
 15:19:23 -0500 (EST)
In-Reply-To: <4D773570.4010803@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 09 Mar 2011 09:08:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89746658-4A8A-11E0-9634-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168753>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Just kidding!
>
> (Jeff is the 2nd main f-e-r author, but Junio created it.)

Thanks for bringing this up.

In the very early days (like back when the project was only 12 months old)
it made sense to record that this and that command were primarily done by
that person.  But I don't think it is a good idea anymore.

For example, format-patch was my invention and all the code was mine back
when it was a script.  Later it was reimplemented in C by Dscho based on
my earlier work.  But a large part of the actual implementation was done
by using the generic revision traversal machinery, whose primary authors
back then were Linus and me.  The silly original UI design everybody hates
("format-patch <upstream>" is not similar to 'git log <upstream>..'") is
"owned" by me, the user facing main() implementation is "owned" by Dscho,
and the backend machinery is "owned" by Linus and me.

Who should we list, and more importantly, does it make sense to keep the
list up to date as the system evolves?

As the project and the community grew, and also as the internal machinery
infrastructure got more modularized, I think ownership at the individual
command level has become almost meaningless concept.

Same reasoning applies to the "Documented by".  I think it's time for
these two sections to go from most (if not all) pages.
