From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Tue, 14 Aug 2012 08:47:04 -0700
Message-ID: <7va9xx8ohz.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 17:47:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1JL8-00034R-OH
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 17:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab2HNPrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 11:47:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab2HNPrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 11:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA9C676B;
	Tue, 14 Aug 2012 11:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FLEMOVJFk6R8rbQzMu26kg5av6s=; b=Uu9TiN
	LlE+ybffhbePpjPw4gHWZZkPWYbwjp1o2+afUIKdE/jy7ibOIqe0F+hL6JqllE61
	HcJJ4xn3wYpPQXH7Xwv2YfETA69ubjViZMw/8dxGLBW5xlWjTw23yCQpKjsXM9hl
	vNBnjJgS+MCmM0zmAR+M46nHDtHaVZKRkgviA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w39g98T+HZvL6M7BokgE+4TSXCIjJRkd
	UnADLG8MdyLfpGIcSzY2gxpTM9PpDeQiny+WmCT42IRUzm6NBDjDzovWleyK7lSI
	7fwI/PphI4F0IHTx0/x2nHHz0OcY5D+XRsWrHMmwp56j0Mt59cubxTZLLXpXHefl
	Tl3wF1VCq9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97B4A6769;
	Tue, 14 Aug 2012 11:47:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 138456766; Tue, 14 Aug 2012
 11:47:05 -0400 (EDT)
In-Reply-To: <87sjbpa5m8.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 14 Aug 2012 16:51:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C96D0D8-E627-11E1-AF21-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203405>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> So the --topo-order switch *ensures* that we process commits in
>>> topological order even in the face of skewed clocks.
>>
>> Yes, I *think* that I attempted to show with the illustration.
>
> But then the new description is wrong.  It claims that children are
> always before parents, which is not true in the face of clock skew.

Ah, you are talking about the "even without this option" part.
Yeah, that does not hold true.
