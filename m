From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Threaded grep
Date: Mon, 25 Jan 2010 17:20:39 -0800
Message-ID: <7vpr4x1x20.fsf@alter.siamese.dyndns.org>
References: <20100125225139.GA3048@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 02:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZa6w-0008K0-PA
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 02:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012Ab0AZBUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 20:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892Ab0AZBUu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 20:20:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab0AZBUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 20:20:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C56942D9;
	Mon, 25 Jan 2010 20:20:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xHR7jte9ceEaruTsWeF1wym65fk=; b=J8FVOq/+2xldMgj/89HNh+e
	OW9IdxmOT3/u2+LrFHyeO2rNE4VSrQjiHeZdhis9L+PN3ieOyHcAxM0wh8rCEccj
	6DnX1gLAFIm5fhMKW21NXfjFLOm0moq79o2nIhjQfAUL4lwiro7P0IQkAEtopYJO
	rlbXITPt1XoIIokgqVWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Sa2rP/y9Aj8+91FN7rEUPCP6lmttBu2DnH6gZ3SW3QeZYrbFJ
	+zaVu+uZtgwaCS7GjA3R00bfB58sAvlWY4BCszcAgf+7gpZMV2+/XsLj4Fou1qd+
	eICy91od8Wgp4FUuS+eNO5qcQ0YazK44bT2AHZ5ptlqO8sCKBJ3iHCbDhg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84B91942D5;
	Mon, 25 Jan 2010 20:20:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACF1A942CE; Mon, 25 Jan
 2010 20:20:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 072B513C-0A19-11DF-BE3F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138017>

Fredrik Kuivinen <frekui@gmail.com> writes:

> The patch has been rebased on top of next.
>
> Additional changes since v3:
>
> * Fix some issues with Git's native pthreads implementation on
>   Windows (pthread_cond_broadcast is still used though).
> * Fix style issues.
> * When greping in a tree, allocate memory for the data buffer as
>   late as possible.
> * Return void from grep_sha1_async and grep_file_async instead of
>   always returning 0.

Thanks; I've fixed up a few old-style declaration header and queued the
result to 'pu'.
