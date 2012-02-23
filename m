From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Thu, 23 Feb 2012 09:37:44 -0800
Message-ID: <7v4nuh5u3b.fsf@alter.siamese.dyndns.org>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com>
 <7vipiy8m5q.fsf@alter.siamese.dyndns.org> <4F460D45.7000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org,
	davvid@gmail.com
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 18:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0cc5-0003n9-12
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 18:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab2BWRhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 12:37:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087Ab2BWRhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 12:37:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C11F7F98;
	Thu, 23 Feb 2012 12:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5wyG3+QvhHSpPSLX/McjMwIHUIQ=; b=k7TiAz
	GVljr8CJj/RphsDV6IEjenxSDb9DE7+3cY3rf99GCmoitXlOTYjgcuMWt+bqR1Hf
	RoMBYBLAxdtqAjzElI937W5ODAl0/DDjgxqJqiqitqFU/SbLD2m3RnlSbkt+2kXO
	Go6nrF9hbbLbaPtm9B4A16jJhJ3KDSrhjS39A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GDd6xufTN3tRWPLra0BFtEmF7x6HFTtH
	s2oYE7zZX+NBfZVWYG/EFvNl/JRwr9MdEOVm6HQJFxasOHySiiam5UZ+G9Q3zmHw
	h6vXPt4gUiL5EkRQc5GrV6CukXA0JWXTYzuDFZj4IAV+a5fQw6AKSIsbBSR70G46
	qavYLgB3PkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 237777F97;
	Thu, 23 Feb 2012 12:37:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97E3E7F95; Thu, 23 Feb 2012
 12:37:46 -0500 (EST)
In-Reply-To: <4F460D45.7000804@gmail.com> (Stefano Lattarini's message of
 "Thu, 23 Feb 2012 10:56:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1932DC10-5E45-11E1-8440-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191380>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

>>> +# mktemp is not available on all platforms (missing from msysgit)
>>> +# Use a hard-coded tmp dir if it is not available
>>> +tmp="$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
>>> +	tmp=/tmp/git-diffall-tmp
>>> +}
>>  ...
>   # mktemp is not available on all platforms (missing from msysgit)
>    tmp=$(mktemp -d -t tmp.XXXXXX 2>/dev/null) || {
>        tmp=/tmp/git-diffall-tmp.$$
>        mkdir "$tmp" || fatal "couldn't create temporary directory"
>   }
>
>>> +mkdir -p "$tmp"
>>
> At which point this should be removed, of course.

Good eyes; thanks.
