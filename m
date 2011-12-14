From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] use constants for sideband communication channels
Date: Tue, 13 Dec 2011 20:56:35 -0800
Message-ID: <7vk45zsqd8.fsf@alter.siamese.dyndns.org>
References: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
	"Dave Olszewski" <cxreg@pobox.com>
To: iheffner@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 14 05:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RagtW-0003Jj-S5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 05:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab1LNE4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 23:56:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab1LNE4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 23:56:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45EB367F6;
	Tue, 13 Dec 2011 23:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9E9zHUu+WLuDsB6UAUtxQYq6d2M=; b=v1Vvtn
	aum9d575Bg+CLmiCqO8yNGKxLma5RKbKdMsrCb50NGCoV6MFjYXszFmUcYfb5gaV
	YP8spQQJM0FjcKgaLZOcbTuKD308lko+cM4KNneuTv97MgPiMHEzQtcjtXOdoZY/
	D0EiRcCe1KmmN3CF6XEPtNR2CfhAATewGmktk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h8jMExNSawmLCVlyxCGhyFQKyAPLiz49
	yy1XuzpH4ccbBSSfb5JZhMeCSFhn0MCYvfwKZF73OxEKP7Xh0ANJ1+Ijfpl+nxVQ
	8ZhQtaDy7KCw6AE3WJvfhSc/WQmKSD5Pjntc48gTDe5Otu2HoDoW7As0ZZ3NspUh
	Nxc4ARuRWeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CF1D67F5;
	Tue, 13 Dec 2011 23:56:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8CC267F4; Tue, 13 Dec 2011
 23:56:36 -0500 (EST)
In-Reply-To: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
 (iheffner@gmail.com's message of "Tue, 13 Dec 2011 10:28:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00780E10-2610-11E1-BA92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187094>

iheffner@gmail.com writes:

> In order to make more clear how the different channels in sidechannel.c
> are to be used, I'm proposing some macros/constants which can be used in
> place of the "magic numbers" that mean little or nothing to someone not
> familiar with the protocol.

I am not fundamentally opposed to the stated goal, but the posted patches
make the resulting code way too wide for comfortable reading. Can we use a
bit shorter symbols?

Perhaps a good way to start would be to first refrain from using these
symbols, but give a prominent comment near the API functions that are used
to send and receive sideband data to explain which band is used for what
purpose, which should be enough for people who are writing the code to
link with these functions.
