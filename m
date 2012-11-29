From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4049: avoid test failures on filemode challenged file
 systems (Windows)
Date: Thu, 29 Nov 2012 08:13:12 -0800
Message-ID: <7v38zss7zb.fsf@alter.siamese.dyndns.org>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
 <50B71B33.1090000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te6k1-0004y0-Vq
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab2K2QNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:13:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781Ab2K2QNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:13:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7E179D7E;
	Thu, 29 Nov 2012 11:13:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r+vi6hYXdtRp41JdOUxLX7vnxCg=; b=XVHsoz
	bVo/MPGLp9dviwhcJdwrpgHiD7BZgR/rcQUaH+C/f6NgtYyc/wc5OYO1m2XTWb41
	JhFxJh1wfRHtrEEbqcsxtmXLKgjpFH2wxAn4GMEQrcyTidzBVcej7auiWK4/r8Sx
	loovAeY9O26xHcCrKWSqzjMFx8W3FEc7sMBUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiQGt8Kdwl2/rX0g55PQWjrZKVdQIrmp
	0awZ60rWpQsOfje+cDSO1BNsRzidZVh6s2A+vqK2QjVZzPrH8EgNNVIkSfsk0KGY
	L30GPfXTBDAb9nNtDKwYy28tYMf9uVJXJesm8H4GlYTt+yt/Apf9vIbQO/DQxCm/
	/MMSNf+rtPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BD29D73;
	Thu, 29 Nov 2012 11:13:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CE159D69; Thu, 29 Nov 2012
 11:13:13 -0500 (EST)
In-Reply-To: <50B71B33.1090000@viscovery.net> (Johannes Sixt's message of
 "Thu, 29 Nov 2012 09:22:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD5FC0FC-3A3F-11E2-A90F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210840>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> It turns out that there are at least two bugs in the diffstat
>> counting code.  This series comes on top of the earlier 74faaa1 (Fix
>> "git diff --stat" for interesting - but empty - file changes,
>> 2012-10-17) to fix them.
>
> The tests still fail on Windows. I am not sure whether there is a
> difference in comparing the file system against the index or a commit.
> If there is, then the updated tests might not test the same thing.

The hunks in the patch look fine.  The last one that tests unmerged
entries do not have to have "chmod" if it gives you trouble (you
would need to reduce number of files from 4 to 3 if you go that
route, I think).
