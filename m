From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clean --exclude broken?
Date: Wed, 24 Aug 2011 14:23:23 -0700
Message-ID: <7vliuio65w.fsf@alter.siamese.dyndns.org>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Todd Rinaldo <toddr@cpanel.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:23:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKv7-0002rK-1y
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab1HXVX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 17:23:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830Ab1HXVX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 17:23:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4FCC4A19;
	Wed, 24 Aug 2011 17:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FJ/gX8Y5BtokebL5I8oF7ccB+mE=; b=eOfJ3Q
	B3zPs0J1EJM3lrxm31TgC/KZ0nbeJwnLWK7Z1eG2o8ss+B1pomUlYcW6ES3YXdmR
	jXDBVMi1PJ3Nt8ZmsdZx3BufFoikhdvjrVSntRqrPFfttjPLmO8GhNK//BVKGwDF
	yjp4PEhQQV8MFAuP8xsS1tzfzth7zs0rwIPhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQVt4YxXaBSOhimnuGAqnw+D1wkN4+b/
	/bLUmQjRFHy96rV2FZmxDk7Dpe/SHoLensZ1D755eEUf2Oz6zjKRrO3Geag5SQHI
	Cb7e1pWRG5YRg8o5yOZVbBrhNH/8GAn/uWyMie12uUlwHcAZHf7X/db//vYr95yS
	3W0z2iYyRrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A45474A18;
	Wed, 24 Aug 2011 17:23:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AE4D4A17; Wed, 24 Aug 2011
 17:23:25 -0400 (EDT)
In-Reply-To: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net> (Todd
 Rinaldo's message of "Wed, 24 Aug 2011 14:15:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D3FCD9E-CE97-11E0-946B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180042>

Todd Rinaldo <toddr@cpanel.net> writes:

> I think I have found a new bug in 1.7.5:

My quick check indicates 1.7.3 behaves the same way, and 1.7.2.5 didn't
have --exclude option, so this does not seem to be anything particularly
new in the 1.7.5 release.

> # The problem (Why is foo/ removed?)
> $>git clean -dXf --exclude=/foo
> Removing bar/
> Removing foo/

Why is this command line giving -X that tells us not to use the ignore
rules, and --exclude option at the same time?
