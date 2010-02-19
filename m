From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug Report ( including test script ): Non-Fastforward merges
 misses directory deletion
Date: Thu, 18 Feb 2010 22:23:42 -0800
Message-ID: <7v3a0xwxox.fsf@alter.siamese.dyndns.org>
References: <loom.20100218T104300-858@post.gmane.org>
 <loom.20100218T113103-602@post.gmane.org>
 <20100219055721.GC22645@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Thiel <byronimo@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 07:24:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMHV-0006w5-5F
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 07:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab0BSGX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 01:23:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab0BSGX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 01:23:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE299BC86;
	Fri, 19 Feb 2010 01:23:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HCbs4/AkLxx3qoaeasmGszXwxtA=; b=RxarwV
	5rW9GYNFYNuy6Czv5H78zQNHv5lsUdWLtDDt/edZ9WLKBfxhTC8c1PbT7yy9TVbg
	Jj025SOsq1str346QCHFYgmUCLkcYCPNicbgVWQAgNejwQneEzEG7o7b165YA562
	Olhc8Vsa9zotaSJiTmdo64xV+wYGrvletYznc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZErSrt3Un4G6c9ehy3rzpLqUG7k0lhJu
	SHzjsTq+56w0NayYcrpfqMXCP/hoIu7bF6ym1zCCXIpjgYoLz+zOXjrFMKPb5G1C
	nbBhsSUHw/S89UFllj8Fk//ezyaECR6RXo7/JwcdFEiX8oBT7r+ks+Tc3H4A1xhm
	x8Pk+/zxrIc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6A319BC85;
	Fri, 19 Feb 2010 01:23:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 921829BC84; Fri, 19 Feb
 2010 01:23:44 -0500 (EST)
In-Reply-To: <20100219055721.GC22645@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 19 Feb 2010 00\:57\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58394C5A-1D1F-11DF-B1A9-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140413>

Jeff King <peff@peff.net> writes:

> This was introduced by Alex's 4a92d1b (Add remove_path: a function to
> remove as much as possible of a path, 2008-09-27), which ironically
> complained about bugs in the code it was replacing. :)

Good catch.  I wish all bugs are this easy ;-)

Thanks.
