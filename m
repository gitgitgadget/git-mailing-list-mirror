From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 18:37:46 -0700
Message-ID: <7vljcogot1.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
 <20100415163607.GA4279@coredump.intra.peff.net>
 <7vhbnck618.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1004151545240.7232@xanadu.home>
 <7v7ho8ibi3.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1004152059100.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 03:38:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2aVh-0002Ab-8E
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 03:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397Ab0DPBiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 21:38:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab0DPBh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 21:37:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E79AB701;
	Thu, 15 Apr 2010 21:37:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xqmq1OxIEW6+t/QZHBLyCQvp5oA=; b=wdZiPZ
	on3pZb4+VEwVuyGffW21p4qkqJu2ZDq4EuKQUm8SuLnrQ4RqLQhmpazXrVFR3EVy
	mhGgVzlSG44yO6+uBT6CDON2UGksto0eT4Isx5oD18nqteEUMGq+4TuwgowE25R+
	LnXoRy3T3kvt+/Fyaxico5OPX1NgoUswUj288=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9WjWvHzD80p7J3Fan9OoWkxLOCTFqgf
	wgVpe0ZtVgs+xBkZZpLVNc/mO+oaRMwD6emrsJOKNJPl22pAqWCuSMp7/RxWfGy/
	XbLXDvqfXCIGlgp+TlxmewqgPWedfoNZ0sf24G9RQ35abxeA2judCcrMXNCHdiMV
	4mCa+kokdxs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45799AB6FF;
	Thu, 15 Apr 2010 21:37:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74062AB6FD; Thu, 15 Apr
 2010 21:37:48 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1004152059100.7232@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 15 Apr 2010 21\:11\:02 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACCC3A8E-48F8-11DF-91B6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145045>

Nicolas Pitre <nico@fluxnic.net> writes:

> Again, keeping reflogs 90 days for stuff that is _already_ reachable 
> through existing refs is much less useful than keeping otherwise 
> unreachable stuff 90 days.  So I still don't see the point of this 
> eagerness to prune deleted stuff faster.

Hmph, I honestly cannot care about this very much without knowing where
this is going, because the distinction between the two has been with us
practically forever, since the day one of "reflog expire".

Is there any constructive conclusion you are aiming for?  For example, is
a proposal to update the default value of both to 90 or 120 days coming?

FWIW, I have this in my primary repository.

    [gc]
            packrefs = no
            reflogexpire = '2005-01-01 00:00:00 +0000'
            reflogexpireunreachable = '2005-01-01 00:00:00 +0000'
