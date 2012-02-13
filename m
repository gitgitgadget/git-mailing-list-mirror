From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] fetch-pack.c: rename some parameters from "path" to
 "refname"
Date: Sun, 12 Feb 2012 19:47:01 -0800
Message-ID: <7vhayvids1.fsf@alter.siamese.dyndns.org>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
 <1328941261-29746-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Feb 13 05:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwn5J-00083N-2K
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 05:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2BMEAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 23:00:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097Ab2BMEAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 23:00:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C692A6E3A;
	Sun, 12 Feb 2012 23:00:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=FCt89NyA5D09YC5KAohXiJKlxHI=; b=rvsh4ApdlEEbH1kQxzLA
	YcS5Pez+KFZEfr2WL9jLqlyomA2ZzxWSbwqv/3XjZReSTMh3MSFdlqtmlydTGEMf
	3j303c6ooVr+nenf/10ABNPitVO9B0nSk5SRkcGGB7xKRxAh2XlegLiRjhw7Df9Q
	6nzMydUpeYH3nLA5C2zktXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=D4HAqfv71+bWQaeyBiBAjdhYxMrFxfMuuhEcXGcEX7+sKK
	NB273z1FHg42i+bi7mqsw61EmT0WKzvilSMQ9W8R5ndlmP+ooG+XnH2X0ZJlsurS
	2sIvNR7o2AqAhvHUGSXC68G4B8Z638WKRmScZLsMq4oMCsq9yJOtXIWw8IUbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCF3D6E39;
	Sun, 12 Feb 2012 23:00:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0206F6E35; Sun, 12 Feb 2012
 22:59:59 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33160F18-55F7-11E1-9B88-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190603>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> The parameters denote reference names, which are no longer 1:1 with
> filesystem paths.

These three functions are only used as callback from for_each_ref() so
they always get the full refname and nothing else (like a partial refname
like tags/v1.7.9), so calling them refname makes perfect sense.

Even though I generally try to stay away from this kind of naming churn
patches, but hopefully there is nothing in flight to cause horrible
conflict with it.

Thanks.
