From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add a setting to require a filter to be successful
Date: Fri, 17 Feb 2012 23:27:49 -0800
Message-ID: <7v4nuor47e.fsf@alter.siamese.dyndns.org>
References: <7vobsywck1.fsf@alter.siamese.dyndns.org>
 <4f3daaf7.e302440a.02ba.fffff463@mx.google.com>
 <4F3DFCD0.6070002@viscovery.net> <7vd39dqa1i.fsf@alter.siamese.dyndns.org>
 <4F3EF43D.2040102@orb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 08:28:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyeiA-0004NX-AC
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 08:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab2BRH16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 02:27:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab2BRH1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 02:27:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7E947EC8;
	Sat, 18 Feb 2012 02:27:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a8kKENyWVimZhDpWKyQPddXerF8=; b=uHrUk4
	4nyjF6RLiuhTqzE5X36kYg8O9P/ztunr8h+fxoeP8xwSO6cG/z5CKVld5Jcm+40N
	zhHA4VBjprgcDr+1CLx3Jbeyn1SFyvxSStjW9N3WGSg7uB1O0sideteDsCxi6q9S
	UZf21g4sL2hviT7WnKz1dLYLMddZF9iKj50gE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNCWB2OoZDIkR11aFydYzLwsQBFmBPya
	4+pWhK9PQDRPF8Th0VxjDOGH0Le43avdqsRF5XrYd1o92DFsmQXp9w2tZrQax4Qj
	N7ikuVrc800KPpZJnWtMNtEgoXRMBDF/kjhim4/24P9elZ1B/Pc8/vMwiZyVtsnX
	O7W9Yi7ZMrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFE3C7EC7;
	Sat, 18 Feb 2012 02:27:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 583767EC6; Sat, 18 Feb 2012
 02:27:50 -0500 (EST)
In-Reply-To: <4F3EF43D.2040102@orb.com> (Jehan Bing's message of "Fri, 17 Feb
 2012 16:43:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 100F9C8C-5A02-11E1-B1FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190996>

Jehan Bing <jehan@orb.com> writes:

> If I understand what you're saying, current version of git already
> have the problem: if a filter fails without reading anything, git will
> die instead of using the unfiltered content. My patch has only made
> the issue apparent by testing with a failing filter.
> Am I understanding correctly?

Yes.
