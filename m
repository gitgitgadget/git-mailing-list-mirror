From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH ld/maint-diff-quiet-w] Windows: redirect
 fopen("/dev/null") to fopen("nul")
Date: Thu, 25 Feb 2010 12:16:16 -0800
Message-ID: <7vfx4p2hrj.fsf@alter.siamese.dyndns.org>
References: <4B86399E.3090508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Larry D'Anna <larry@elder-gods.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:16:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkk8P-0003q1-Es
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 21:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627Ab0BYUQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 15:16:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933299Ab0BYUQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 15:16:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 118409DDD2;
	Thu, 25 Feb 2010 15:16:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9FcWoCHNs4JvMzymeOmxYmbQLjQ=; b=E2s029
	DtI0jTG85C9R0N3HvTHn+fQAWtSpybty4vSwkGE16qTwgoAUrMpRJiWnvsn/9MNW
	x99RXw47BmV5ioWKIc+n0ln6LXRB1SoExHDHrCsLD/LkJ4gDjlMcyvvFP0SzVKr2
	DZCNK5Q2eP0Fp5wDBor9sE5G6E2gm15mvU54Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E/5NgGJs/wxw9XLSN2VGdrxITL8YG4nV
	5ynvbgMzaXLHEbKyS3wt9SqZ4pRfVXLvbBxDGPsgfikX48oIw/7qfPd9US5fulK/
	FOKYPQKBCzF0Oq/mlC2JANbe09niekBsS1kZ2Bf+QQRd8NIRGfRdXt7zMBAUebwo
	T/hMnA7Lejg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0F249DDD1;
	Thu, 25 Feb 2010 15:16:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 744D19DDCF; Thu, 25 Feb
 2010 15:16:18 -0500 (EST)
In-Reply-To: <4B86399E.3090508@viscovery.net> (Johannes Sixt's message of
 "Thu\, 25 Feb 2010 09\:49\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4842BAE-224A-11DF-AF15-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141066>

builtin-merge-file.c and daemon.c use freopen() on /dev/null; would it
also need to be wrapped?
