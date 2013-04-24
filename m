From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Wed, 24 Apr 2013 11:20:18 -0700
Message-ID: <7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<1366821216-20868-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4It-0000Dd-DK
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab3DXSUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:20:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676Ab3DXSUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:20:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0EBC15E13;
	Wed, 24 Apr 2013 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CmPecxFnQqDl2VmClbrZqSnpCcs=; b=Ouzl4D
	6akzvm+1hgvqJCkzX+T+DxrEPXuIi0CbAvc0eNeV7xChC/T6USKmPSVR4mqjmsts
	oxXQcUI4Wo+lhQ5At66+6X2dwlYvi16i+ueANST6Wa2YYRMSgd98BVZKaPbJMcp3
	4V99EOZ7JBQ42QxKaZ+ZSvlERVAlvOzuw8LoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=amZOR4tyRpJ2ycBepCwTM6me4oDHhm7G
	rmq4APWkcwSg74gyF64NDo1Mj2wubdOnDHzpipnHMseItWLZUZ9977mRmb5+PJ2H
	L+HulGu1NIsq2fGrtESchdCfEHMSxcxHIlFZFk7ds4dGKG2K3uYvHYWeaC+YsqZK
	wXGrfWCjg9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B74D815E12;
	Wed, 24 Apr 2013 18:20:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EAB515E11;
	Wed, 24 Apr 2013 18:20:20 +0000 (UTC)
In-Reply-To: <1366821216-20868-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 24 Apr 2013 22:03:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F415A46-AD0B-11E2-82CE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222285>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> -'git diff' [options] [--] [<path>...]::
> +'git diff' [options] [[--] [<path>...]]::

You can say

    "git diff A B --" without any path
    "git diff A B pathspec" without any double-dashes
    "git diff -- pathspec"

and all three of them are expressed by versions before or after the
patch, so there is no change in the semantics introduced by this
patch.

While the update might be logically more correct, it looks to me
that the only end-user visibile effect of it is to make the end
result harder to read.
