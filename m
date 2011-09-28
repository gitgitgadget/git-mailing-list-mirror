From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes_merge_commit(): do not pass temporary buffer to
 other function
Date: Tue, 27 Sep 2011 20:10:25 -0700
Message-ID: <7vty7xs6ou.fsf@alter.siamese.dyndns.org>
References: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu>
 <7vd3elyl8t.fsf@alter.siamese.dyndns.org> <4E828B6C.1010707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 28 05:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8kXZ-0005pS-Ls
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 05:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab1I1DK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 23:10:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab1I1DK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 23:10:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF8B5DB6;
	Tue, 27 Sep 2011 23:10:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fx4TiKBtU/N0iYelSi3lFt95WDU=; b=tF17Ok
	79DTQ4asGFlnLSvCqxO7oSShk7B6L8hxidmw8emGwklMDBB0/uCapcWWX2g7GOzb
	QiAgNLit2VZv4yNyxtHAlp8S8RVfOwMplnMhmMrpSmoLDs5Xq/DOJl8E5pDDVjNc
	qTJVs68+uA6MWkQCXv1hCXiAfe1UxNMQKjre0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSenCqEI4T2lUG3rIH45h/BDi+Y5gmqS
	pu3ygyp/uwDZntLcZCZ60Rt+RODsnpK+8iw9AmKpmMbSJ0CtjZpzK8roKA+XfC5j
	DcxYQNS+cga9Qq6wXjD1lzGX5Mnilz+6c5I/PG18uU0KG/MAwqnX2qDx1aW1dSYx
	cCma+/VQpLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E095DB5;
	Tue, 27 Sep 2011 23:10:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EEDE5DB1; Tue, 27 Sep 2011
 23:10:27 -0400 (EDT)
In-Reply-To: <4E828B6C.1010707@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 28 Sep 2011 04:50:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A1AECF2-E97F-11E0-A28F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182286>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> diff --git notes-merge.c notes-merge.c
>>> index e1aaf43..baaf31f 100644
>>> --- notes-merge.c
>>> +++ notes-merge.c
>> 
>> It is Ok to play with -p0 yourself but please don't do that in the public.
>
> Sorry; I had set diff.noprefix=true, not realizing that it would affect
> things like "git format-patch".  It also confused emacs' magit mode, and
> probably some other tools.  It's now set permanently back to false.

Thanks.

It is nothing catastrophic (I applied it with "am -p0 -s3c" just fine),
but everybody here sends -p1 format, so...
