From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call to
 callers
Date: Sun, 29 Apr 2012 23:15:18 -0700
Message-ID: <7v1un5iw3t.fsf@alter.siamese.dyndns.org>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu>
 <20120429115831.GC24254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 08:15:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOjtP-0001qo-03
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 08:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab2D3GPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 02:15:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab2D3GPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 02:15:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D408835C8;
	Mon, 30 Apr 2012 02:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V0ELKDQUZodCKpMKhRkqHfqez5Q=; b=vH+Hfl
	JxP21a9r3cuRkD4FybpGuMI6xpSEtitEyOglaRISLXExsHx68PU8tGZ4rcM4IEyo
	/+05lfj897NrkqPPwGHHMj4+uQMXcJRRKMaMKBiNUIF5CIoFzmKXo9c3dzYMV8j5
	Rwc82OVRlcUhUKun/xL9dM9bcmITCGkrMJL4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uCJAyai4FEY5ew2haBThSM/PURQ40HP5
	q2ORKwug1L0F6DYlmrNXavtsyKmdhrPqDb2eXiB091KPil+lu6wEXronHuUtRMA0
	nXYbyP4O0A0xkotoQBOBa7tsmcUM8at03bCN1OKEvE0c5JX0Bj5n5dixRzlRivx1
	OKmuf1f01M8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9A7A35C7;
	Mon, 30 Apr 2012 02:15:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6147B35C6; Mon, 30 Apr 2012
 02:15:20 -0400 (EDT)
In-Reply-To: <20120429115831.GC24254@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 29 Apr 2012 07:58:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD05FC88-928B-11E1-BC8B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196541>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 29, 2012 at 08:18:08AM +0200, mhagger@alum.mit.edu wrote:
> ...
> It seems like the create_ref_entry code paths should _always_ just be
> issuing warnings, as they are about reading existing refs, no? The die()
> side should only come when we are writing refs.

That matches my observation.  Michael, are we missing something?
