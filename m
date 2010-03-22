From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Sun, 21 Mar 2010 18:55:47 -0700
Message-ID: <7veijd3ysc.fsf@alter.siamese.dyndns.org>
References: <45CD9D1B-6774-46F2-A444-654B1DEF7F69@wincent.com>
 <20100322003915.GA3212@coredump.intra.peff.net>
 <7vwrx56tet.fsf@alter.siamese.dyndns.org>
 <20100322014100.GA7717@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 22 02:56:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtWsN-00023d-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 02:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab0CVBz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 21:55:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508Ab0CVBz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 21:55:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 878AEA4E3C;
	Sun, 21 Mar 2010 21:55:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=raNqTjFoqI++5Dh+3tFvq3HJtQ8=; b=qnhDPa
	FMiai5PQCTqubovy+kAeFVke1iLcSuile8Zk39ijQUnMS56912qtaTqpjGz9E+5u
	gdF7DRTbiVLyvoo2oWKfMp6/4pCPjhqVt76S3aJnzeJYOcfANCdBePN+BgbzmxGJ
	6jsZFu/yWcAgMJjSgPvpLxtcY57vcUuBzBtzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T34TKEOyhsm1rwo3zxxl09LXz5AD0qcx
	z8CbzzQwsSvArxmVHFaqEG34IJ+oBM8+Vw6JOSf+PziqwO19ViPPB8u+hnhw8UMw
	PNlBl3ld/L9Fl4/x6MgI+9zaJd22BxGy+xb7urw4NABR6sQg+1rxVxMU4F/oESyt
	2s3Xoo4aQUY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC145A4E3B;
	Sun, 21 Mar 2010 21:55:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9C55A4E38; Sun, 21 Mar
 2010 21:55:48 -0400 (EDT)
In-Reply-To: <20100322014100.GA7717@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 21 Mar 2010 21\:41\:00 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0BDE5C02-3556-11DF-AA41-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142882>

Jeff King <peff@peff.net> writes:

> Is type (2) exactly fnmatch?

It calls fnmatch(3) but without FNM_PATHNAME nor FNM_PERIOD, which makes
me sometimes wonder if it was a historical mistake and go to "git log" to
check, but it is more-or-less deliberate choice, as illustrated by the
'arch/i386/*.[ch]' example in 5be4efb ([PATCH] Make "git-ls-files" work in
subdirectories, 2005-08-21).
