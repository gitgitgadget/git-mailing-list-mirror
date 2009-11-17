From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 15:46:45 -0800
Message-ID: <7vskccaf4q.fsf@alter.siamese.dyndns.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
 <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
 <7vd43gerak.fsf@alter.siamese.dyndns.org> <4B032AC8.4@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sylvain Rabot <sylvain@abstraction.fr>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAXlH-0002aj-Ng
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 00:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZKQXqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 18:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZKQXqw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 18:46:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZKQXqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 18:46:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF03C80BAA;
	Tue, 17 Nov 2009 18:46:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v6LpOyH97w9EHp8EIptWwzlebok=; b=lZgpB7
	RcDENnpwqSG0crpa9E4eWVxxQVNiNnEYuPEmKbSPBuNBFHSfdaIY4IOhp1CtvK6d
	AB0iG0knsx8dQ7yTYfxikZWuQ2M2Tf8sQ1W6vQN94ljZzHBtbQB7bIedI7KPgx8h
	4liGNMXmMATrHbLgnehzDZs26zcwuwrfW37VY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RWvKkToebjkllSm3cVmn7vSomRHiN3gT
	etGGjeam3olSOcFLMiwp0KV+a0aCnpU/C6gXj9YDbTFCaTRthjSCenaVf4IW9xyL
	I+PHn92Z1BxMrbZwtgrUM3hOnMsROXOAbJRdh6FDHp1JpOCsT7aKIzQCLBF+hMMs
	2OCc7hqn6/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B44D180BA9;
	Tue, 17 Nov 2009 18:46:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEB0380BA8; Tue, 17 Nov
 2009 18:46:46 -0500 (EST)
In-Reply-To: <4B032AC8.4@eaglescrag.net> (J. H.'s message of "Tue\, 17 Nov
 2009 14\:59\:20 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B40D8AC-D3D3-11DE-9573-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133112>

"J.H." <warthog19@eaglescrag.net> writes:

> For starters I think overriding the /~<user> (specifically the ~ here)
> is going to be a bad idea no matter what you do and gives the wrong
> impression about what / how the request is being responded to.  You
> might want to try and pick a different delimiter or re-work the rule
> so that you could have something like:
>
> 	http://git.kernel.org/<gitweb urls>
> 	http://git.kernel.org/user/<gitweb urls>

I am not objecting but showing my ignorance, but why is it a bad idea to
allow

	http://git.kernel.org/~junio/git.git

to map to /home/junio/pubilic_git/git.git when

	http://www.kernel.org/~junio/index.html

maps to /home/junio/public_html/index.html already?
