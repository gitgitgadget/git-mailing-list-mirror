From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Sun, 14 Mar 2010 19:02:53 -0700
Message-ID: <7vljdul4tu.fsf@alter.siamese.dyndns.org>
References: <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <20100309223729.GA25265@sigill.intra.peff.net>
 <20100309230931.GC25265@sigill.intra.peff.net>
 <7veijsmza0.fsf@alter.siamese.dyndns.org>
 <20100311071543.GA8750@sigill.intra.peff.net>
 <7veijns96t.fsf@alter.siamese.dyndns.org>
 <20100314204459.GA31564@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 03:03:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqzeE-0000I0-9F
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 03:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759493Ab0COCDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 22:03:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759019Ab0COCDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 22:03:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3ACA139C;
	Sun, 14 Mar 2010 22:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w/AzwwBW8Germ03R1DmwLc2c6wQ=; b=vGa+k2
	X4HLVQ8A3ONjm3nX1Oa3OHy0hB54349VekjXatn8tIG6Ah8Ja6d4P9b3dSZ/8v35
	OXCt5y2sRNg2qo/8t3toL6b+qO6YcAs0wLG89xVdWA2rBpH/0K5Lc0EpxdLXAXso
	LQY5U3GTIh2Pl7F6ShTYeCai1EEMy/NDofoLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLPncnyoEKGa/z706rsL8E6QNidEJX3P
	OrkVBelUQ29VzztSWMDjFL6I83ZIgeQiWc5XxHZkESR/sgcOo56QZKb/rZTh8pdT
	0JxU4bfTJ+sNVFP/mBcG739X7Vu56p2oI8xui9by7YJzSD7frPl23aT6MfGcFpcP
	dMAMHKMcjVQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 172ECA139A;
	Sun, 14 Mar 2010 22:03:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49F8FA1399; Sun, 14 Mar
 2010 22:02:55 -0400 (EDT)
In-Reply-To: <20100314204459.GA31564@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 14 Mar 2010 16\:44\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1B4DE8A-2FD6-11DF-A0FA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142164>

Jeff King <peff@peff.net> writes:

> In which case, I think we perhaps actively _don't_ want to complain
> about ignored globs at all.
> ...
> So if that reasoning is sound, I think we want to just leave git-add's
> behavior as it is currently (with my patch from earlier in this thread
> applied, of course). You get different error messages for "git add *.c"
> and "git add '*.c'", but that is only natural. You also get different
> _behavior_, and that is intentional.

Yeah, I think that makes sense.
