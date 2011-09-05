From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable
 variable expansion
Date: Mon, 05 Sep 2011 01:11:18 -0700
Message-ID: <7vehzvcst5.fsf@alter.siamese.dyndns.org>
References: <8762l73758.fsf@elisp.net>
 <7vbouzxy7g.fsf@alter.siamese.dyndns.org> <4E648031.6050607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Naohiro Aota <naota@elisp.net>,
	git@vger.kernel.org, tarmigan+git@gmail.com,
	David Barr <davidbarr@google.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 10:11:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0UH9-000496-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 10:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab1IEILX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 04:11:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64199 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab1IEILV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 04:11:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDCF8155F;
	Mon,  5 Sep 2011 04:11:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MbHmBJDsLXTbG2HRKlj5L2LZK1I=; b=OoskvN
	nY9YFyKpCeivHgxn4JRQ0QZNJhTL5XQyOWa4GA3GjDloPT3E27ZhNmJ7Q8DJvOEE
	nUtUXn2+ERmDs8yGAHgX79YD8bW4bAeNoaUUXuks1v7zq+Ahe3JdTLnARQN8FT1v
	AUbj6rmgt6W+o9rPeHDxO9Y17SWbFYXfVorEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ex7LbbU6ifk+QU2ZIBkxdNL39VcXGIyQ
	GBsfOExzI2DkUj3OJrnDrsv/Nu8FBMo4qb2MlX+PGPTHoNWNaP9JkP4KS6GURhW3
	K8Jzkm1PW0FHqBqfJsl1cUsaI77TSmn0E2WQvLgGpy0QTNg2+5JqNPDPeWNn0D8L
	2NioezB8Yt8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4FDB155E;
	Mon,  5 Sep 2011 04:11:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E514A155D; Mon,  5 Sep 2011
 04:11:19 -0400 (EDT)
In-Reply-To: <4E648031.6050607@viscovery.net> (Johannes Sixt's message of
 "Mon, 05 Sep 2011 09:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2EF8D94-D796-11E0-820A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180726>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/5/2011 9:09, schrieb Junio C Hamano:
>> By the way, t9010 uses ${#parameter} (strlen) which is bashism we forbid,
>> and it needs to be rewritten (David CC'ed).
>
> Actually, no. It is perfectly valid POSIX. So we would need this patch.

I know it is in POSIX, but not in the subset we allowed so far. I do not
recall the details offhand, but we must have seen some shell that lacked
it or something.
