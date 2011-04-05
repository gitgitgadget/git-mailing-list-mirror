From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 05 Apr 2011 14:51:01 -0700
Message-ID: <7vzko4l64a.fsf@alter.siamese.dyndns.org>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com>
 <20110405194005.GA32427@elie> <201104052315.54375.j6t@kdbg.org>
 <4D9B8862.1050605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7E9j-0005r1-1T
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab1DEVvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:51:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1DEVvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:51:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FB604D52;
	Tue,  5 Apr 2011 17:53:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=icQ2XGBVjaymouDgxOBIzEBEzDE=; b=BPSvRz
	rolKiS5StCt7hyPFipiNpxjZY+vyJWYBbIrPAeVcezIWeofzTiTHOiJLRdeqeyrK
	V/ms8oOGzVWeNj59VZEFm/MxBA0Tm+j3VEVKLf2BG0jJ7GZ6+D9mVNIjjXS/mWz9
	/E+kHg8RKqnD4b3wtk9ojXk+VSjZqinHjFm3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pmMCGi+yuKWgsE4sNGcdLzkYUmR02FEs
	W+ByGuYD20j2h9isCWbRpqrHFyDm2fM32wQGKF0d33Xyl9c2tHOERCoarCBFtAm4
	JiT4RSz1QTb12D5ZdxdDM8bkp9MdrEfmZ+jqs11w7+sSbzabgswc8NPoBihZ3Acs
	M2RON16z0sI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25CEE4D51;
	Tue,  5 Apr 2011 17:53:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77CE34D50; Tue,  5 Apr 2011
 17:52:56 -0400 (EDT)
In-Reply-To: <4D9B8862.1050605@redhat.com> (Eric Blake's message of "Tue, 05
 Apr 2011 15:23:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 140F5A1C-5FCF-11E0-AB3F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170923>

Eric Blake <eblake@redhat.com> writes:

> On 04/05/2011 03:15 PM, Johannes Sixt wrote:
>>>> @@ -87,7 +89,8 @@ PATTERN FORMAT
>>>>
>>>>   - Otherwise, git treats the pattern as a shell glob suitable
>>>>     for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>>>> -   wildcards in the pattern will not match a / in the pathname.
>>>> +   wildcards in the pattern will not match a / in the pathname,
>>>> +   and do not ignore files with a leading . in the pathname.
>> 
>> I don't think this is correct. * matches .gitignore. I tried it.
>
> That was my point.  * _does_ match .gitignore, even though for normal
> shell globs, FNM_PERIOD is set and * does not match .gitignore.  That
> is, while in the shell 'dir/*' only matches non-dot files, in .gitignore
> it matches all files including dot-files.
>
> Any ideas for a better way to word that?

Instead of "and do not ignore files with a leading", say "but will match
a dot '.'".  You are talking about the rule for wildcards to match or not
to match the pathname and there is no room for the word "ignore" to come
into play in this sentence.
