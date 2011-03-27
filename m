From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reproducible crash in git merge
Date: Sun, 27 Mar 2011 11:01:09 -0700
Message-ID: <7vr59s1lzu.fsf@alter.siamese.dyndns.org>
References: <AANLkTimxHn_fwMKh9cbp9i5LkShUi=HK44nv2KJ7ENaQ@mail.gmail.com>
 <m3pqpcv5ph.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Gilman <davidgilman1@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 20:01:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3uHT-0006Wg-W9
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 20:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab1C0SBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 14:01:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab1C0SBV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 14:01:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57F254FF9;
	Sun, 27 Mar 2011 14:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D3nk6R2IrL4QEBIrY724pVJD3iY=; b=XmH0Bq
	D4d9LrmaImSY+i0BDyHMaDnfhJVtm7P9gFKXnzZ+mWsQr/inV9qbeMKqDu8OrWbM
	pnfgAtgnui4LNQe5Mby2Wu5CdJvgz/0WiYVawenLFZWVf8YtoxRAuFri9Dsoxsfg
	af7Ags/cr1J+bSdkGa3b1Nzkvzbb0geYViJZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MV1ACvr3c7KJQSyLQLIDKVpi802Jcsih
	JE0j0u2bSlLLifI2ldOzSuHkLrpGTZn/95PwNosl0WGCnycruL93Rw/EKNVS+7D2
	yBG3lbsSWKT0Uht1sClfn8r4T9AabgAaKpLBk/+rWf2/nYOR7rbi1Tc4g9nKIDT6
	yUsWOGjYWNs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 217A04FF5;
	Sun, 27 Mar 2011 14:03:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 094AF4FF3; Sun, 27 Mar 2011
 14:02:55 -0400 (EDT)
In-Reply-To: <m3pqpcv5ph.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 27 Mar 2011 10:23:13 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73B39792-589C-11E0-A654-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170086>

Jakub Narebski <jnareb@gmail.com> writes:

> David Gilman <davidgilman1@gmail.com> writes:
>
>> Unfortunately I can't share the repo itself because of its contents.
>
> Does anyone remember the script that can be used to anonymize contents
> of repository that cannot be made public for debugging purposes?

That might help in certain narrow other cases, but I suspect that it is a
way off tangent in this case, after looking at the stack trace.

The process is dying inside pthe latform implementation of memcpy of
inflate from zlib; unless the bug is reproduceable independent of the
contents, any modification done by contents anonymizer is very likely to
make this particular issue go away, don't you think?
