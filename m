From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull.sh: Fix call to git-merge for new command  
 format
Date: Wed, 02 Dec 2009 08:45:36 -0800
Message-ID: <7vws15jpe7.fsf@alter.siamese.dyndns.org>
References: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl>
 <7vmy22qmgp.fsf@alter.siamese.dyndns.org>
 <4B163B49.4070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsKw-0003m5-2x
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbZLBQpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbZLBQpl
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:45:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbZLBQpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:45:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D30E384ADB;
	Wed,  2 Dec 2009 11:45:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NVWNyoHsoWXNNJKv5wkGg51E5nQ=; b=qFbM0/
	2Y4EQchr9HYnCLxw7BqG9EF/pljikmREveCdnu2RmpHIlgKtlFbJMB+rM9K/MoiQ
	EfBRD8H+H5b6VOwk9LB5czRQ4Zk4zleYLT8lYN9+WO04I5vOapDkHhGVMjv+Wgyb
	1AztPMWMNC+gxlX333M9xZVLha1qooYVnn2e4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O3M83RmL4z+2Cq7iTCfUMGl2ccHSRIf3
	IxSmsvhET1ely7BUGQldq/+6a7Le/r8jrYFMayztx12CAwkzda7VkDZoTAt77vmn
	KWcPiymcLrvX/Nt5ubS4FWqhfPVQUF2DeN62dYQZJ/nOjANsISxBVscd49i2lvcq
	o85a+OsfHnQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CE2084ADA;
	Wed,  2 Dec 2009 11:45:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FA5084AD9; Wed,  2 Dec
 2009 11:45:38 -0500 (EST)
In-Reply-To: <4B163B49.4070606@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 02 Dec 2009 11\:02\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21A8E498-DF62-11DE-92B3-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134347>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This made me wonder a bit: Do we have a policy regarding the use of
> "git-command" vs. "git command" in git shell scripts such as this one?

Yes.  Anything that sets GIT_EXEC_PATH correctly can use git-foo form.
