From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 09:01:09 -0800
Message-ID: <7v62tw7kx6.fsf@alter.siamese.dyndns.org>
References: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Mark Levedahl <mlevedahl@gmail.com>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 10 18:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcL7Z-0003iM-M6
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab1AJRBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 12:01:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab1AJRBX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 12:01:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9B5D36CC;
	Mon, 10 Jan 2011 12:02:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OjN4Cx0A6yOV8tJH9+05usyyQMQ=; b=JfzgaS
	QL+6ZK9CdMwHO40DidRUKWy17MzdqT6+jTjJU4YxXJj4iw2KQf+YLJ+nd+Qry+N1
	5HmyKcOQvgxZiBrq3+EUbmgetg8dIymdzjz98xPNPSttps1howc+l9u+ecamQ+ur
	MloZbcxia2SYH0DO2b2bFdfMkGn++PjOI32fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n9cKY7EsiKoABNNXjPm4KnclII22QLKJ
	sIgRb/l/OdIo7EgaIEeUmnHkn+YC3/2LmnKc3+e8ZBwOYl81J/vgdqXxkUc35/hB
	/plACCAVZw7EXmddsCSuw8np1LGBGjnjsr4lC7VwD3+GGcwcuUDbcqr/J7YdHUJs
	mLajjCKC91w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8ED3036BE;
	Mon, 10 Jan 2011 12:01:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A35E36BD; Mon, 10 Jan 2011
 12:01:52 -0500 (EST)
In-Reply-To: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon\, 10 Jan 2011 11\:37\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 554A2D0E-1CDB-11E0-9423-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164882>

Thomas Rast <trast@student.ethz.ch> writes:

> The function resolve_relative_url was not prepared to deal with an
> scp-style origin 'user@host:path' in the case where 'path' is only a
> single component.  Fix this by extending the logic that strips one
> path component from the $remoteurl.
>
> Also add tests for both styles of URLs.
>
> Noticed-by: Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> If Mark agrees with the fix, I think this should go in before 1.7.4
> since it's a pretty annoying bug.

Seems obvious to me from a cursory look; thanks.
