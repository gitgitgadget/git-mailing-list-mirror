From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.7.2] Please cherry-pick "upload-pack: start pack-objects
 before async rev-list"
Date: Thu, 26 May 2011 09:58:19 -0700
Message-ID: <7voc2pxutw.fsf@alter.siamese.dyndns.org>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
 <20110406213333.GA18481@sigill.intra.peff.net> <20110526064547.GA18777@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:58:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdtW-0005GI-CA
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab1EZQ6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:58:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab1EZQ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:58:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 660DA52BB;
	Thu, 26 May 2011 13:00:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ucE54t2t+0x/yYax5Huy5pMqSNc=; b=Ms/Fbc
	eNrB44QBYuj+wvuyPlvyd1Cd2KzwBlrnHzGlaOwXcQLjwqCN/wzQJ4C167Zr4Bk3
	vhsJLJVk4GxWNVQVDIHIIaIB5R9FylHXLqDXmBTYCNjSJmMuIpHCAaWRa3fWw/iI
	9mHOwquoQ0mQafczrHnyDVdT92FVYYjKtQLu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ylnd5S7tVm5AHZ0n+nS2UoGGTrph1jHN
	J+Q4qoA21axNcJ0lGEPpDMmwJtbL/LdzuvmwqPWvlaR5i5GezsxX/+4SGuSFPOWU
	G8CaGhGIn7XY7F8NvWbPJxrstR6O20AK3Gm0+3AnNGbz9g2L43s7mg4QapUdoXQT
	JCAiMqn+t8o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 044B252B6;
	Thu, 26 May 2011 13:00:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5397352B0; Thu, 26 May 2011
 13:00:28 -0400 (EDT)
In-Reply-To: <20110526064547.GA18777@elie> (Jonathan Nieder's message of
 "Thu, 26 May 2011 01:45:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACD295E0-87B9-11E0-AEE7-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174547>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This server-side deadlock started being triggered by shallow clones
> when sv.gnu.org upgraded to v1.7.2.5 a couple of months ago[1].  So it
> might be worth thinking about how to help upgrade-averse server admins
> to fix it.

Upgrade-averse people can be fixed by keeping them closer to the tip, no?
I don't plan to issue any more maintenance release on 1.7.2.X track beyond
what is already released, unless there is a high priority security fix or
something.

Placing it on 1.7.4.X and newer maintenance tracks is a separate matter.
