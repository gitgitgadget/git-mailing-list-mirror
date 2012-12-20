From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 10:49:52 -0800
Message-ID: <7vbodo5zjj.fsf@alter.siamese.dyndns.org>
References: <50CF039A.7010800@gmx.de>
 <20121220150408.GD27211@sigill.intra.peff.net>
 <50D33409.1050309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:50:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TllCL-0003Ri-Oa
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab2LTSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:49:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab2LTSt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:49:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B860AEFB;
	Thu, 20 Dec 2012 13:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YfkprS/xjzL6AoCUTcUzwappOoI=; b=v3LDil
	p/t3Gf1w48l0yRi5CqXL4vr+scyhvG2P8N0XHvWQHbWaFsP/HNPFBLqZy1IMpBuA
	PICvqi3NDbJmuiBWBbh7BR6WmEtx3U0UJ4WLAtvqhWL+rQvBWSC1XxVcqd9kGvi/
	AxeQLxl4XEWl8NsrTh2CeaN40Oln//HA9P4Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uq3Ry8VXqFPX3H69YX9kEddmI0+SKIFN
	SQwlaI7x067X+bSi8mX1R9ULAtt0OfRtR72xkE6iqEabNcaV5C1gkoSdV7NymJSs
	QAesosf56RNE1lN89V6YKUgAvw9x5IeftXvAD8utRCfKp4xYk7/56LvoFQLSBDfI
	0NbK+6KDA+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A8DAEFA;
	Thu, 20 Dec 2012 13:49:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB134AEF8; Thu, 20 Dec 2012
 13:49:54 -0500 (EST)
In-Reply-To: <50D33409.1050309@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 20 Dec 2012 16:51:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B63627A-4AD6-11E2-98B0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211917>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think the problem is yet another step earlier: why do we build tools
> that encourage people to store passwords in plaintext in a configuration
> file that is by default world-readable?

True.  This particular one mentioned in the thread predates
credential helpers, so it is not faire to say "encourage".
We didn't and we don't.

Care to do a patch to deprecate sendemail.smtppass (i.e. give
warnings to users when it is used) and perhaps replace it with
something based on the credential store or something?
