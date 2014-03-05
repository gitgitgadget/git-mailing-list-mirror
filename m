From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Wed, 05 Mar 2014 12:24:23 -0800
Message-ID: <xmqq4n3cgzrc.fsf@gitster.dls.corp.google.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
	<xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
	<20140305185212.GA23907@sigill.intra.peff.net>
	<xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
	<20140305192837.GA11304@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:24:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLIMk-00010R-V6
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 21:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaCEUYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 15:24:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbaCEUYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 15:24:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63D077003E;
	Wed,  5 Mar 2014 15:24:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KOoqnmcT8NZaft/Fb+PiKRjXZ+M=; b=asWsnW
	vsxTBwnu1K3ZtbhoibMXDXb5tfIDruxBBQw0ZEUa16Qrfbcyxp2wyqwryCB7xWqr
	Vc+sr3Msz4vy0+Jkm2CYFkhzqX9+DAyO7a/GqMivYN02kFY/VOrKBSOWilLWI5dH
	bu9IyGIaCUTMcBNcRxQCmNgGyz6eLcFzwxp00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tkv2ngrVyXi+m/rxPHYFK7/xOACUk0nm
	2ZkXvxruu/KF2JkqWD2dsy8eMbBG+8HV7BMpQG3WIM4IdH+QJ1uaZQqpuqBeJtJu
	Ft2cgAkdOBaBtHdzacnYXxoQLIUtIMKJeRu1dXpMVo7BNIQsiDmyrlo3KQdK55Qi
	FJRzjHO0zRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C4B7003D;
	Wed,  5 Mar 2014 15:24:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7878870034;
	Wed,  5 Mar 2014 15:24:26 -0500 (EST)
In-Reply-To: <20140305192837.GA11304@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Mar 2014 14:28:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 25AE7754-A4A4-11E3-BC82-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243476>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 05, 2014 at 11:18:17AM -0800, Junio C Hamano wrote:
>
>> Given that we discourage "grafts" strongly and "replace" less so
>> (but still discourage it), telling the users that biting the bullet
>> and rewriting the history is _the_ permanent solution, I think it is
>> understandable why nobody has bothered to.
>
> Perhaps the patch below would help discourage grafts more?
>
> The notable place in the documentation where grafts are still used is
> git-filter-branch.txt.  But since the example there is about cementing
> rewritten history, it might be OK to leave.

Thanks; I agree with the reasoning.
