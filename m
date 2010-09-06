From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Determining commit reachability
Date: Sun, 05 Sep 2010 23:47:27 -0700
Message-ID: <7viq2jv05c.fsf@alter.siamese.dyndns.org>
References: <4C83FEC3.3040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 08:47:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsVUe-0000Xb-DT
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0IFGrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:47:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab0IFGre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 02:47:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0873DD3CBB;
	Mon,  6 Sep 2010 02:47:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ATmGcJI/lThcwXmQ/IH+NtIvhE=; b=kErtJY
	Kz+HcpRYKuZ6nM0ZMDc733I08/z1zG0gr1QwrokKCf7+rUxCwBcdOdZGOHfCdlky
	sKTESEOmmDh1ARMvYwojW2r39bdlFzYWHxOFsWSeUdczTFPYKJu/T0mms07oVMhC
	XFDpUY5YOlVpvGdQ6Vwrxr9vYIne2gJybsfF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvxD2fb07ADYkWIWd9uWKA6BGo+C2Kya
	E7lNdS1L/4pq83dfOlj8KeLaligrfaOaxdW2z1Vs5ciw+ManKGNS1mrOUXrBClbN
	c67S/wAMXl98xG8lWsGhRBzpEL0xS99/gv2yHJK8Lazfs/Bb65Fggh4o67i36pJ3
	YWwlcAgF3Og=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D843AD3CB8;
	Mon,  6 Sep 2010 02:47:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FE88D3CB6; Mon,  6 Sep
 2010 02:47:29 -0400 (EDT)
In-Reply-To: <4C83FEC3.3040101@gmail.com> (Artur Skawina's message of "Sun\,
 05 Sep 2010 22\:34\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F944E10-B982-11DF-81BC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155538>

Artur Skawina <art.08.09@gmail.com> writes:

> Given commit C, refs (branches) R, S and T what would be the best way
> to test whether 'C' is reachable from any of the heads?

Depends on the definition of "best", but I often find myself typing

    git branch --with C

where C often is somewhere between 'master' and 'ko/master' (the 'master'
branch everybody else has already seen on k.org).  When I have second
thoughts sometime after applying a patch directly on top of 'master', I
need to see if I have built a new topic branch forking from the faulty
commit before rewinding it, as such a topic branch also needs to be
rewound.
