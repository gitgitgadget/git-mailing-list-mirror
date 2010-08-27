From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell: Display errors from improperly-formatted command
 lines
Date: Fri, 27 Aug 2010 10:28:30 -0700
Message-ID: <7vlj7shsn5.fsf@alter.siamese.dyndns.org>
References: <1282887373-25618-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Aug 27 19:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2jO-0001AX-Bb
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0H0R2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 13:28:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab0H0R2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 13:28:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EA06D0184;
	Fri, 27 Aug 2010 13:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=x0i4s1ZdxX4WTHzIa5IG/KyTNa8=; b=wjnZYbi44GfmO8kLuofHn4c
	u8NhxwiM2kJ9umWt44x0KxbAcUpLnFpZGYCMpqC1cK/feFnTS8CRwGvGRLFqdpnR
	MrU+QICf/X6HttI9KDVP4yJ3PUmr0hVy8VNQ+UV/WxlNNirzvRegJYoreaitaQoE
	eyNq3+WRyyzjJj8Wrcto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nVA01LRmbV6yBAxEq70sdpE7pmBhVG68F6YHHBCQ3AV2CwKMc
	yy/ExyZqy2f4PxTbOyNnYCod1lCTMHWTjcFdWi4XqLumNWh4IwweuRIrtqGTyPnm
	eJWZ4GFcoH6G+GuRZoYz7N4HJ1rb03uClgEYr41R4xTov6F81mlm7lO5Sw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A571D0182;
	Fri, 27 Aug 2010 13:28:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4A20D0180; Fri, 27 Aug
 2010 13:28:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84D61EAC-B200-11DF-8DCF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154607>

Greg Brockman <gdb@MIT.EDU> writes:

> The interface for split_cmdline has changed such that the caller holds
> responsibility for printing any error messages.  This patch changes
> the git shell to print these error messages as appropriate.
> ---
>  shell.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)

Forgot to sign-off?

> The error behavior of split_cmdline was changed in the patch  'split_cmdline: Allow
> caller to access error string'.  This updates git-shell to deal with printing out
> split_cmdline errors itself.

Thanks for being careful.  I'll merge gb/split-cmdline-errmsg topic (which
already is in master) to gb/shell-ext topic (which is cooking in next) and
then apply this on top.  With this update I suppose the topic is ready to
be in the next release?
