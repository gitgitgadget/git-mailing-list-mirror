From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in
 incremental blame
Date: Wed, 25 Nov 2009 16:34:18 -0800
Message-ID: <7vpr76m8dx.fsf@alter.siamese.dyndns.org>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
 <200911252155.59318.jnareb@gmail.com>
 <7vd436s2r8.fsf@alter.siamese.dyndns.org>
 <200911260028.19383.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSJe-0005zQ-Bt
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbZKZAeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759731AbZKZAeX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:34:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbZKZAeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:34:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9E25A18EF;
	Wed, 25 Nov 2009 19:34:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=FM3bJjQtE91dKBmu7nS0Ni7D+Ak=; b=hopkJt
	dkk79yxwIf2IULODXBrhMYoHAxFkG9UTveMhyLA1AtVZTCNqunTGAUbGPzPMUcRR
	fdtn2GqmbXSwNFonw22dY6ECggYeqK6xiiChjlFurz1GfCd2RsspUUSgvP87J6MT
	MmSv9Lc2XCvAXyV3EDasRSYruTzCtmMie7i2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkGvUeb49zDLOTell2vs8kWn6Mt/dkZm
	bNiUW56Q6DTOJRkECDjX6i1eEjyh9dqCJ9eLx3vsFTywSlK+zMF+tbpqlSpafdGZ
	jGVnOTrX9O4NKOCwl2oFNIYF6VIcLwUCQ9yk5QBi+Nf/E270gIGMeKyqdra5SkPz
	5rJr8o/W+uw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AA06A18EE;
	Wed, 25 Nov 2009 19:34:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21840A18ED; Wed, 25 Nov 2009
 19:34:19 -0500 (EST)
In-Reply-To: <200911260028.19383.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 26 Nov 2009 00\:28\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7301E3E2-DA23-11DE-ADD9-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133716>

Jakub Narebski <jnareb@gmail.com> writes:

> Below there is request-pull with reordered series, unless you want me
> to resend this series as a set of patches, as reply to this email.

It is too late for that, as they are already in 'next'.  I do not think it
is necessary nor desirable, either.

With the "Create links" commit, you are _adding_ a new link that leads to
a new feature with known breakage, not _replacing_ a link that leads to an
existing working implementation with one that does not work for some
people, no?

Merging everything else but not merging that commit does not make any
sense.  It won't give any wider exposure to the feature, and is no better
than carrying the entire thing in 'next' (or 'pu') post 1.6.6.

A follow-up patch to add a gitweb configuration switch that disables the
non-working view by default but allows site owners to enable it in order
to help improving the feature would be a sensible thing to do.  As long as
that patch is solidly done we can merge the whole thing to 'master' in the
upcoming release.
