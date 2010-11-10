From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 09 Nov 2010 16:18:06 -0800
Message-ID: <7vlj52jakh.fsf@alter.siamese.dyndns.org>
References: <20101109083023.783fad9b@chalon.bertin.fr>
 <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
 <20101109102428.5ba8dc13@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:18:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFyOP-0000K1-Vw
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab0KJASV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 19:18:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab0KJASU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 19:18:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9BEAC3CED;
	Tue,  9 Nov 2010 19:18:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VEjSyCicaUViwMZivyfIoLh6dfk=; b=C8UbvD
	KhHHt5oP2gkUlR/cI0oWjy6KUxfyS3d/q759W/nz7h/rSXCthxoOgXEvsbzN+P+D
	PliaVqtDuJKwlQsCJ1L8owTTJRDLYN32Dpgue75rfvFb6eEwOQ3ujaQjWbfAC75Q
	TFd0FK96iqyKoASTUSADuJDge3sqUg9+J6yXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VlzhAX9Zf2eZ+iME2hzBhAq5k1CSV/QP
	74whMEjV4m3lmvgoBtmFH0nhTSvj1eFrtaDhgXE4eItFFGqxkFfRWsTJrs3ix0HG
	N2UDmbUdUQyE40//7wKKq8TzwNKOWjHIPTrzw+odQfyvfEdMooqE3oG1hiep8mZZ
	kyUrYlhgOf8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A7553CEC;
	Tue,  9 Nov 2010 19:18:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4865D3CE8; Tue,  9 Nov 2010
 19:18:11 -0500 (EST)
In-Reply-To: <20101109102428.5ba8dc13@chalon.bertin.fr> (Yann Dirson's
 message of "Tue\, 09 Nov 2010 10\:24\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04A35728-EC60-11DF-B79B-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161111>

Yann Dirson <dirson@bertin.fr> writes:

>> > Syntax like origin/pu^{/Merge 'kb/blame-author-email'}2 would be
> ...
> Another idea: origin/pu^{:2/Merge 'kb/blame-author-email'}

What are these "2"s?

You need to question how you figured out the commit you want is the second
one reachable (in whatever traversal order) from something in the first
place.  Didn't you use "git log --oneline" or something to find that out?
At that point, you have the object name already, so I doubt such a
"counting" feature is of much practical use.
